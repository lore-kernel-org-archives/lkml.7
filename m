Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D74C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04BFA20854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfCSGTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 02:19:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:20205 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbfCSGTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 02:19:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 23:19:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,496,1544515200"; 
   d="scan'208";a="328537480"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga006.fm.intel.com with ESMTP; 18 Mar 2019 23:19:09 -0700
Subject: [PATCH 3/6] libnvdimm/security: Drop direct dependency on
 key_type_encrypted
From:   Dan Williams <dan.j.williams@intel.com>
To:     keyrings@vger.kernel.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 18 Mar 2019 23:06:30 -0700
Message-ID: <155297559082.2276575.2158004875457450595.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155297557534.2276575.16264199708584900090.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155297557534.2276575.16264199708584900090.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lookup the key type by name and protect libnvdimm from encrypted_keys.ko
module load failures.

Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/security.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
index f8bb746a549f..7f9e412f743a 100644
--- a/drivers/nvdimm/security.c
+++ b/drivers/nvdimm/security.c
@@ -48,12 +48,17 @@ static void nvdimm_put_key(struct key *key)
 static struct key *nvdimm_request_key(struct nvdimm *nvdimm)
 {
 	struct key *key = NULL;
+	struct key_type *type;
 	static const char NVDIMM_PREFIX[] = "nvdimm:";
 	char desc[NVDIMM_KEY_DESC_LEN + sizeof(NVDIMM_PREFIX)];
 	struct device *dev = &nvdimm->dev;
 
 	sprintf(desc, "%s%s", NVDIMM_PREFIX, nvdimm->dimm_id);
-	key = request_key(&key_type_encrypted, desc, "");
+	type = key_type_lookup("encrypted");
+	if (IS_ERR(type))
+		return (struct key *) type;
+
+	key = request_key(type, desc, "");
 	if (IS_ERR(key)) {
 		if (PTR_ERR(key) == -ENOKEY)
 			dev_dbg(dev, "request_key() found no key\n");
@@ -88,7 +93,7 @@ static struct key *nvdimm_lookup_user_key(struct nvdimm *nvdimm,
 		return NULL;
 
 	key = key_ref_to_ptr(keyref);
-	if (key->type != &key_type_encrypted) {
+	if (strcmp(key->type->name, "encrypted") != 0) {
 		key_put(key);
 		return NULL;
 	}
@@ -452,3 +457,5 @@ void nvdimm_security_overwrite_query(struct work_struct *work)
 	__nvdimm_security_overwrite_query(nvdimm);
 	nvdimm_bus_unlock(&nvdimm->dev);
 }
+
+MODULE_SOFTDEP("pre: encrypted_keys");

