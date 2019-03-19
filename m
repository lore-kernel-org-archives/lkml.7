Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF26C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A332720854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfCSGTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 02:19:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:8988 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfCSGTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 02:19:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 23:18:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,496,1544515200"; 
   d="scan'208";a="126620568"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008.jf.intel.com with ESMTP; 18 Mar 2019 23:18:59 -0700
Subject: [PATCH 1/6] security/keys/encrypted: Allow operation without
 trusted.ko
From:   Dan Williams <dan.j.williams@intel.com>
To:     keyrings@vger.kernel.org
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>, vishal.l.verma@intel.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Mar 2019 23:06:20 -0700
Message-ID: <155297558061.2276575.9485856950730059730.stgit@dwillia2-desk3.amr.corp.intel.com>
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

The trusted.ko module may fail to load. In the common case this failure
is simply due to the platform missing a TPM. Teach the encrypted_keys
implementation to lookup the key type by name rather than having a
module dependency.

Fixes: 240730437deb ("KEYS: trusted: explicitly use tpm_chip structure...")
Suggested-by: James Bottomley <jejb@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 security/keys/encrypted-keys/masterkey_trusted.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/security/keys/encrypted-keys/masterkey_trusted.c b/security/keys/encrypted-keys/masterkey_trusted.c
index dc3d18cae642..7560aea6438d 100644
--- a/security/keys/encrypted-keys/masterkey_trusted.c
+++ b/security/keys/encrypted-keys/masterkey_trusted.c
@@ -19,6 +19,7 @@
 #include <keys/trusted-type.h>
 #include <keys/encrypted-type.h>
 #include "encrypted.h"
+#include "../internal.h"
 
 /*
  * request_trusted_key - request the trusted key
@@ -31,9 +32,15 @@ struct key *request_trusted_key(const char *trusted_desc,
 				const u8 **master_key, size_t *master_keylen)
 {
 	struct trusted_key_payload *tpayload;
+	struct key_type *type;
 	struct key *tkey;
 
-	tkey = request_key(&key_type_trusted, trusted_desc, NULL);
+	type = key_type_lookup("trusted");
+	if (IS_ERR(type)) {
+		tkey = (struct key *)type;
+		goto error;
+	}
+	tkey = request_key(type, trusted_desc, NULL);
 	if (IS_ERR(tkey))
 		goto error;
 
@@ -44,3 +51,5 @@ struct key *request_trusted_key(const char *trusted_desc,
 error:
 	return tkey;
 }
+
+MODULE_SOFTDEP("pre: trusted");

