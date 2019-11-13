Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7336EC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 18:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89E6206F2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 18:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mVk6DHX1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbfKMSrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 13:47:06 -0500
Received: from linux.microsoft.com ([13.77.154.182]:43360 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbfKMSrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 13:47:04 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1F9D220B4905;
        Wed, 13 Nov 2019 10:47:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1F9D220B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573670823;
        bh=MOGUb7jpfG2A7HaNkFYloS4DcIBLS63Y9W6vcnBeebA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mVk6DHX1r+C7PhN9DfwBCPD4ru4MKm36HB/n92YK3yN415hVa8HTS4fC1YeJkVPhX
         SaYkDStmJ32TCO8asF08uNz2a8JTTRL4dtoGvbR7KwsH3JwA+jEn33yJeL1JwBjZeD
         FFkZ+6JRY0WQYqLbFzUeclvTFv7OG/yOV7QH8JzY=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/3] KEYS: Call the IMA hook to measure keys
Date:   Wed, 13 Nov 2019 10:46:58 -0800
Message-Id: <20191113184658.2862-4-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191113184658.2862-1-nramas@linux.microsoft.com>
References: <20191113184658.2862-1-nramas@linux.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call the IMA hook from key_create_or_update function to measure
the key when a new key is created or an existing key is updated.

This patch adds the call to the IMA hook from key_create_or_update
function to measure the key on key create or update.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 include/linux/ima.h | 13 +++++++++++++
 security/keys/key.c |  9 +++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 6d904754d858..ec5afe319ab7 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -25,6 +25,12 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 extern void ima_post_path_mknod(struct dentry *dentry);
 extern void ima_kexec_cmdline(const void *buf, int size);
 
+#ifdef CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS
+extern void ima_post_key_create_or_update(struct key *keyring,
+					  struct key *key,
+					  unsigned long flags, bool create);
+#endif
+
 #ifdef CONFIG_IMA_KEXEC
 extern void ima_add_kexec_buffer(struct kimage *image);
 #endif
@@ -101,6 +107,13 @@ static inline void ima_add_kexec_buffer(struct kimage *image)
 {}
 #endif
 
+#ifndef CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS
+static inline void ima_post_key_create_or_update(struct key *keyring,
+						 struct key *key,
+						 unsigned long flags,
+						 bool create) {}
+#endif
+
 #ifdef CONFIG_IMA_APPRAISE
 extern bool is_ima_appraise_enabled(void);
 extern void ima_inode_post_setattr(struct dentry *dentry);
diff --git a/security/keys/key.c b/security/keys/key.c
index 764f4c57913e..9782d4d046fd 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -13,6 +13,7 @@
 #include <linux/security.h>
 #include <linux/workqueue.h>
 #include <linux/random.h>
+#include <linux/ima.h>
 #include <linux/err.h>
 #include "internal.h"
 
@@ -936,6 +937,9 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 		goto error_link_end;
 	}
 
+	/* let the ima module know about the created key. */
+	ima_post_key_create_or_update(keyring, key, flags, true);
+
 	key_ref = make_key_ref(key, is_key_possessed(keyring_ref));
 
 error_link_end:
@@ -965,6 +969,11 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 	}
 
 	key_ref = __key_update(key_ref, &prep);
+
+	/* let the ima module know about the updated key. */
+	if (!IS_ERR(key_ref))
+		ima_post_key_create_or_update(keyring, key, flags, false);
+
 	goto error_free_prep;
 }
 EXPORT_SYMBOL(key_create_or_update);
-- 
2.17.1

