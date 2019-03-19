Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E72DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A9E2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfCSGTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 02:19:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:55771 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfCSGTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 02:19:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 23:19:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,496,1544515200"; 
   d="scan'208";a="152984724"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga002.fm.intel.com with ESMTP; 18 Mar 2019 23:19:21 -0700
Subject: [PATCH 5/6] security/integrity/evm: Drop direct dependency on
 key_type_encrypted
From:   Dan Williams <dan.j.williams@intel.com>
To:     keyrings@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        vishal.l.verma@intel.com, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 18 Mar 2019 23:06:41 -0700
Message-ID: <155297560193.2276575.1761562049509563946.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Lookup the key type by name and protect evm from encrypted_keys.ko
module load failures.

Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: <linux-integrity@vger.kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 security/integrity/evm/evm_crypto.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index c37d08118af5..5c65c3aef427 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -354,10 +354,15 @@ int evm_init_hmac(struct inode *inode, const struct xattr *lsm_xattr,
 int evm_init_key(void)
 {
 	struct key *evm_key;
+	struct key_type *type;
 	struct encrypted_key_payload *ekp;
 	int rc;
 
-	evm_key = request_key(&key_type_encrypted, EVMKEY, NULL);
+	type = key_type_lookup("encrypted");
+	if (IS_ERR(type))
+		return PTR_ERR(type);
+
+	evm_key = request_key(type, EVMKEY, NULL);
 	if (IS_ERR(evm_key))
 		return -ENOENT;
 
@@ -372,3 +377,5 @@ int evm_init_key(void)
 	key_put(evm_key);
 	return rc;
 }
+
+MODULE_SOFTDEP("pre: encrypted_keys");

