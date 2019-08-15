Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4041FC32753
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 01:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2D22084F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 01:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbfHOBem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 21:34:42 -0400
Received: from mga02.intel.com ([134.134.136.20]:19753 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727659AbfHOBel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 21:34:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 18:34:41 -0700
X-IronPort-AV: E=Sophos;i="5.64,387,1559545200"; 
   d="scan'208";a="179234967"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 18:34:41 -0700
Subject: [PATCH 2/3] libnvdimm/security: Tighten scope of nvdimm->busy vs
 security operations
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org
Date:   Wed, 14 Aug 2019 18:20:23 -0700
Message-ID: <156583202386.2815870.16611751329252858110.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156583201347.2815870.4687949334637966672.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156583201347.2815870.4687949334637966672.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The blanket blocking of all security operations while the DIMM is in
active use in a region is too restrictive. The only security operations
that need to be aware of the ->busy state are those that mutate the
state of data, i.e. erase and overwrite.

Refactor the ->busy checks to be applied at the entry common entry point
in __security_store() rather than each of the helper routines.

Cc: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/dimm_devs.c |   33 ++++++++++++++++-----------------
 drivers/nvdimm/security.c  |   10 ----------
 2 files changed, 16 insertions(+), 27 deletions(-)

diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index 53330625fe07..d837cb9be83d 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -424,9 +424,6 @@ static ssize_t __security_store(struct device *dev, const char *buf, size_t len)
 	unsigned int key, newkey;
 	int i;
 
-	if (atomic_read(&nvdimm->busy))
-		return -EBUSY;
-
 	rc = sscanf(buf, "%"__stringify(SEC_CMD_SIZE)"s"
 			" %"__stringify(KEY_ID_SIZE)"s"
 			" %"__stringify(KEY_ID_SIZE)"s",
@@ -451,23 +448,25 @@ static ssize_t __security_store(struct device *dev, const char *buf, size_t len)
 	} else if (i == OP_DISABLE) {
 		dev_dbg(dev, "disable %u\n", key);
 		rc = nvdimm_security_disable(nvdimm, key);
-	} else if (i == OP_UPDATE) {
-		dev_dbg(dev, "update %u %u\n", key, newkey);
-		rc = nvdimm_security_update(nvdimm, key, newkey, NVDIMM_USER);
-	} else if (i == OP_ERASE) {
-		dev_dbg(dev, "erase %u\n", key);
-		rc = nvdimm_security_erase(nvdimm, key, NVDIMM_USER);
+	} else if (i == OP_UPDATE || i == OP_MASTER_UPDATE) {
+		dev_dbg(dev, "%s %u %u\n", ops[i].name, key, newkey);
+		rc = nvdimm_security_update(nvdimm, key, newkey, i == OP_UPDATE
+				? NVDIMM_USER : NVDIMM_MASTER);
+	} else if (i == OP_ERASE || i == OP_MASTER_ERASE) {
+		dev_dbg(dev, "%s %u\n", ops[i].name, key);
+		if (atomic_read(&nvdimm->busy)) {
+			dev_dbg(dev, "Unable to secure erase while DIMM active.\n");
+			return -EBUSY;
+		}
+		rc = nvdimm_security_erase(nvdimm, key, i == OP_ERASE
+				? NVDIMM_USER : NVDIMM_MASTER);
 	} else if (i == OP_OVERWRITE) {
 		dev_dbg(dev, "overwrite %u\n", key);
+		if (atomic_read(&nvdimm->busy)) {
+			dev_dbg(dev, "Unable to overwrite while DIMM active.\n");
+			return -EBUSY;
+		}
 		rc = nvdimm_security_overwrite(nvdimm, key);
-	} else if (i == OP_MASTER_UPDATE) {
-		dev_dbg(dev, "master_update %u %u\n", key, newkey);
-		rc = nvdimm_security_update(nvdimm, key, newkey,
-				NVDIMM_MASTER);
-	} else if (i == OP_MASTER_ERASE) {
-		dev_dbg(dev, "master_erase %u\n", key);
-		rc = nvdimm_security_erase(nvdimm, key,
-				NVDIMM_MASTER);
 	} else
 		return -EINVAL;
 
diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
index 5862d0eee9db..2166e627383a 100644
--- a/drivers/nvdimm/security.c
+++ b/drivers/nvdimm/security.c
@@ -334,11 +334,6 @@ int nvdimm_security_erase(struct nvdimm *nvdimm, unsigned int keyid,
 			|| !nvdimm->sec.flags)
 		return -EOPNOTSUPP;
 
-	if (atomic_read(&nvdimm->busy)) {
-		dev_dbg(dev, "Unable to secure erase while DIMM active.\n");
-		return -EBUSY;
-	}
-
 	rc = check_security_state(nvdimm);
 	if (rc)
 		return rc;
@@ -380,11 +375,6 @@ int nvdimm_security_overwrite(struct nvdimm *nvdimm, unsigned int keyid)
 			|| !nvdimm->sec.flags)
 		return -EOPNOTSUPP;
 
-	if (atomic_read(&nvdimm->busy)) {
-		dev_dbg(dev, "Unable to overwrite while DIMM active.\n");
-		return -EBUSY;
-	}
-
 	if (dev->driver == NULL) {
 		dev_dbg(dev, "Unable to overwrite while DIMM active.\n");
 		return -EINVAL;

