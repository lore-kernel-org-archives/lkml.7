Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E07C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DEA12146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfCSGTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 02:19:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:8988 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfCSGTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 02:19:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 23:19:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,496,1544515200"; 
   d="scan'208";a="123843229"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007.jf.intel.com with ESMTP; 18 Mar 2019 23:19:04 -0700
Subject: [PATCH 2/6] security/keys/encrypted: Clean up request_trusted_key()
From:   Dan Williams <dan.j.williams@intel.com>
To:     keyrings@vger.kernel.org
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>, vishal.l.verma@intel.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Mar 2019 23:06:25 -0700
Message-ID: <155297558570.2276575.11731393787282486177.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Now that the trusted key type is looked up by name rather than direct
symbol there is no need to play games with detecting the build
configuration. Make request_trusted_key() a static facility internal to
the encrypted-keys implementation.

Suggested-by: James Bottomley <jejb@linux.ibm.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/key.h                              |    1 
 security/keys/encrypted-keys/Makefile            |    3 -
 security/keys/encrypted-keys/encrypted.c         |   32 +++++++++++++
 security/keys/encrypted-keys/encrypted.h         |   12 -----
 security/keys/encrypted-keys/masterkey_trusted.c |   55 ----------------------
 security/keys/internal.h                         |    2 -
 security/keys/key.c                              |    1 
 7 files changed, 34 insertions(+), 72 deletions(-)
 delete mode 100644 security/keys/encrypted-keys/masterkey_trusted.c

diff --git a/include/linux/key.h b/include/linux/key.h
index 7099985e35a9..e7bfd037d26f 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -270,6 +270,7 @@ static inline void key_ref_put(key_ref_t key_ref)
 	key_put(key_ref_to_ptr(key_ref));
 }
 
+extern struct key_type *key_type_lookup(const char *type);
 extern struct key *request_key(struct key_type *type,
 			       const char *description,
 			       const char *callout_info);
diff --git a/security/keys/encrypted-keys/Makefile b/security/keys/encrypted-keys/Makefile
index 7a44dce6f69d..d42487bb3d8a 100644
--- a/security/keys/encrypted-keys/Makefile
+++ b/security/keys/encrypted-keys/Makefile
@@ -6,6 +6,3 @@
 obj-$(CONFIG_ENCRYPTED_KEYS) += encrypted-keys.o
 
 encrypted-keys-y := encrypted.o ecryptfs_format.o
-masterkey-$(CONFIG_TRUSTED_KEYS) := masterkey_trusted.o
-masterkey-$(CONFIG_TRUSTED_KEYS)-$(CONFIG_ENCRYPTED_KEYS) := masterkey_trusted.o
-encrypted-keys-y += $(masterkey-y) $(masterkey-m-m)
diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index 347108f660a1..06925d3b30c9 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -423,6 +423,37 @@ static struct skcipher_request *init_skcipher_req(const u8 *key,
 	return req;
 }
 
+/*
+ * request_trusted_key - request the trusted key
+ *
+ * Trusted keys are sealed to PCRs and other metadata. Although userspace
+ * manages both trusted/encrypted key-types, like the encrypted key type
+ * data, trusted key type data is not visible decrypted from userspace.
+ */
+static struct key *request_trusted_key(const char *trusted_desc,
+				const u8 **master_key, size_t *master_keylen)
+{
+	struct trusted_key_payload *tpayload;
+	struct key_type *type;
+	struct key *tkey;
+
+	type = key_type_lookup("trusted");
+	if (IS_ERR(type)) {
+		tkey = (struct key *)type;
+		goto error;
+	}
+	tkey = request_key(type, trusted_desc, NULL);
+	if (IS_ERR(tkey))
+		goto error;
+
+	down_read(&tkey->sem);
+	tpayload = tkey->payload.data[0];
+	*master_key = tpayload->key;
+	*master_keylen = tpayload->key_len;
+error:
+	return tkey;
+}
+
 static struct key *request_master_key(struct encrypted_key_payload *epayload,
 				      const u8 **master_key, size_t *master_keylen)
 {
@@ -1025,3 +1056,4 @@ late_initcall(init_encrypted);
 module_exit(cleanup_encrypted);
 
 MODULE_LICENSE("GPL");
+MODULE_SOFTDEP("pre: trusted");
diff --git a/security/keys/encrypted-keys/encrypted.h b/security/keys/encrypted-keys/encrypted.h
index 1809995db452..0ae67824a24a 100644
--- a/security/keys/encrypted-keys/encrypted.h
+++ b/security/keys/encrypted-keys/encrypted.h
@@ -3,18 +3,6 @@
 #define __ENCRYPTED_KEY_H
 
 #define ENCRYPTED_DEBUG 0
-#if defined(CONFIG_TRUSTED_KEYS) || \
-  (defined(CONFIG_TRUSTED_KEYS_MODULE) && defined(CONFIG_ENCRYPTED_KEYS_MODULE))
-extern struct key *request_trusted_key(const char *trusted_desc,
-				       const u8 **master_key, size_t *master_keylen);
-#else
-static inline struct key *request_trusted_key(const char *trusted_desc,
-					      const u8 **master_key,
-					      size_t *master_keylen)
-{
-	return ERR_PTR(-EOPNOTSUPP);
-}
-#endif
 
 #if ENCRYPTED_DEBUG
 static inline void dump_master_key(const u8 *master_key, size_t master_keylen)
diff --git a/security/keys/encrypted-keys/masterkey_trusted.c b/security/keys/encrypted-keys/masterkey_trusted.c
deleted file mode 100644
index 7560aea6438d..000000000000
--- a/security/keys/encrypted-keys/masterkey_trusted.c
+++ /dev/null
@@ -1,55 +0,0 @@
-/*
- * Copyright (C) 2010 IBM Corporation
- * Copyright (C) 2010 Politecnico di Torino, Italy
- *                    TORSEC group -- http://security.polito.it
- *
- * Authors:
- * Mimi Zohar <zohar@us.ibm.com>
- * Roberto Sassu <roberto.sassu@polito.it>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, version 2 of the License.
- *
- * See Documentation/security/keys/trusted-encrypted.rst
- */
-
-#include <linux/uaccess.h>
-#include <linux/err.h>
-#include <keys/trusted-type.h>
-#include <keys/encrypted-type.h>
-#include "encrypted.h"
-#include "../internal.h"
-
-/*
- * request_trusted_key - request the trusted key
- *
- * Trusted keys are sealed to PCRs and other metadata. Although userspace
- * manages both trusted/encrypted key-types, like the encrypted key type
- * data, trusted key type data is not visible decrypted from userspace.
- */
-struct key *request_trusted_key(const char *trusted_desc,
-				const u8 **master_key, size_t *master_keylen)
-{
-	struct trusted_key_payload *tpayload;
-	struct key_type *type;
-	struct key *tkey;
-
-	type = key_type_lookup("trusted");
-	if (IS_ERR(type)) {
-		tkey = (struct key *)type;
-		goto error;
-	}
-	tkey = request_key(type, trusted_desc, NULL);
-	if (IS_ERR(tkey))
-		goto error;
-
-	down_read(&tkey->sem);
-	tpayload = tkey->payload.data[0];
-	*master_key = tpayload->key;
-	*master_keylen = tpayload->key_len;
-error:
-	return tkey;
-}
-
-MODULE_SOFTDEP("pre: trusted");
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 8f533c81aa8d..ea2eb78459bf 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -89,8 +89,6 @@ extern spinlock_t key_serial_lock;
 extern struct mutex key_construction_mutex;
 extern wait_queue_head_t request_key_conswq;
 
-
-extern struct key_type *key_type_lookup(const char *type);
 extern void key_type_put(struct key_type *ktype);
 
 extern int __key_link_begin(struct key *keyring,
diff --git a/security/keys/key.c b/security/keys/key.c
index 696f1c092c50..9045b62afb04 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -706,6 +706,7 @@ struct key_type *key_type_lookup(const char *type)
 found_kernel_type:
 	return ktype;
 }
+EXPORT_SYMBOL_GPL(key_type_lookup);
 
 void key_set_timeout(struct key *key, unsigned timeout)
 {

