Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7DFC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9300E20857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389093AbfCAQKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:10:40 -0500
Received: from inva020.nxp.com ([92.121.34.13]:37564 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727952AbfCAQK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:10:29 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 690F91A0077;
        Fri,  1 Mar 2019 17:10:26 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5B4B61A0085;
        Fri,  1 Mar 2019 17:10:26 +0100 (CET)
Received: from sopsvulinux.ea.freescale.net (sopsvulinux.ea.freescale.net [10.161.69.178])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 35E60205ED;
        Fri,  1 Mar 2019 17:10:26 +0100 (CET)
Received: from SOPDPUATS05.ea.freescale.net (SOPDPUATS05.ea.freescale.net [10.161.66.238])
        by sopsvulinux.ea.freescale.net (Postfix) with ESMTP id 5B1D582C7D;
        Fri,  1 Mar 2019 17:08:45 +0100 (CET)
From:   Franck LENORMAND <franck.lenormand@nxp.com>
To:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Cc:     franck.lenormand@nxp.com, horia.geanta@nxp.com,
        silvano.dininno@nxp.com, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, dhowells@redhat.com, jmorris@namei.org,
        serge@hallyn.com
Subject: [RFC PATCH 2/2] dm-crypt: Use any key type which is registered
Date:   Fri,  1 Mar 2019 17:09:59 +0100
Message-Id: <1551456599-10603-3-git-send-email-franck.lenormand@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551456599-10603-1-git-send-email-franck.lenormand@nxp.com>
References: <1551456599-10603-1-git-send-email-franck.lenormand@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was only 2 key_type supported by dm-crypt which limits other
implementations.

This patch allows to use any key_type which is registered obtaining
the key_type from key framework.

This also remove the compilation dependency between dm-crypt and
key implementations.

Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
---
 drivers/md/dm-crypt.c    | 11 ++++++-----
 include/linux/key-type.h |  2 ++
 security/keys/key.c      | 42 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index dd538e6..e25efc2 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -35,6 +35,7 @@
 #include <crypto/authenc.h>
 #include <linux/rtnetlink.h> /* for struct rtattr and RTA macros only */
 #include <keys/user-type.h>
+#include <linux/key-type.h>
 
 #include <linux/device-mapper.h>
 
@@ -2010,6 +2011,7 @@ static int crypt_set_keyring_key(struct crypt_config *cc, const char *key_string
 	int ret;
 	struct key *key;
 	const struct user_key_payload *ukp;
+	struct key_type *type;
 
 	/*
 	 * Reject key_string with whitespace. dm core currently lacks code for
@@ -2025,16 +2027,15 @@ static int crypt_set_keyring_key(struct crypt_config *cc, const char *key_string
 	if (!key_desc || key_desc == key_string || !strlen(key_desc + 1))
 		return -EINVAL;
 
-	if (strncmp(key_string, "logon:", key_desc - key_string + 1) &&
-	    strncmp(key_string, "user:", key_desc - key_string + 1))
-		return -EINVAL;
+	type = get_key_type(key_string, key_desc - key_string);
+	if (!type)
+		return -ENOENT;
 
 	new_key_string = kstrdup(key_string, GFP_KERNEL);
 	if (!new_key_string)
 		return -ENOMEM;
 
-	key = request_key(key_string[0] == 'l' ? &key_type_logon : &key_type_user,
-			  key_desc + 1, NULL);
+	key = request_key(type, key_desc + 1, NULL);
 	if (IS_ERR(key)) {
 		kzfree(new_key_string);
 		return PTR_ERR(key);
diff --git a/include/linux/key-type.h b/include/linux/key-type.h
index bc9af55..2b2167b 100644
--- a/include/linux/key-type.h
+++ b/include/linux/key-type.h
@@ -176,6 +176,8 @@ extern struct key_type key_type_keyring;
 extern int register_key_type(struct key_type *ktype);
 extern void unregister_key_type(struct key_type *ktype);
 
+extern struct key_type *get_key_type(const char *type_name, size_t string_size);
+
 extern int key_payload_reserve(struct key *key, size_t datalen);
 extern int key_instantiate_and_link(struct key *key,
 				    const void *data,
diff --git a/security/keys/key.c b/security/keys/key.c
index 44a80d6..ef76114 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -1156,6 +1156,48 @@ void unregister_key_type(struct key_type *ktype)
 }
 EXPORT_SYMBOL(unregister_key_type);
 
+/**
+ * get_key_type - Get the type of key using its name
+ * @type_name: Name of the key type to get
+ * @string_size: Size of the string to match
+ *
+ * The functions support null ended string (string_size == 0) as well as
+ * pointer on a string matching a number of characters (string_size > 0)
+ *
+ * Returns a pointer on the key type if successful, -ENOENT if the key type
+ * is not registered.
+ */
+struct key_type *get_key_type(const char *type_name, size_t string_size)
+{
+	struct key_type *p;
+	struct key_type *ktype = ERR_PTR(-ENOENT);
+
+	if (!type_name)
+		return ktype;
+
+	down_write(&key_types_sem);
+
+	/* Search the key type in the list */
+	list_for_each_entry(p, &key_types_list, link) {
+		if (string_size) {
+			if (strncmp(p->name, type_name, string_size) == 0) {
+				ktype = p;
+				break;
+			}
+		} else {
+			if (strcmp(p->name, type_name) == 0) {
+				ktype = p;
+				break;
+			}
+		}
+	}
+
+	up_read(&key_types_sem);
+
+	return ktype;
+}
+EXPORT_SYMBOL(get_key_type);
+
 /*
  * Initialise the key management state.
  */
-- 
2.7.4

