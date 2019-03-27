Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F24C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84175206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O8+PKhgO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfC0Pjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:39:49 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:44177 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbfC0Pjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 11:39:48 -0400
Received: by mail-yw1-f73.google.com with SMTP id l203so23846206ywb.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 08:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eR83P0sJs14fUDLDbA9zUQB2J/T1uwUazEW3OOsgSmE=;
        b=O8+PKhgOxfZwWiidbkx+dop2jJQA52WIAMM+O4dhBMFOKrBign0ZlQnFGGZJNz+Soj
         Jdd4iML4NYZqkV4haoQ23Bl4flBELnW8zw5nMjGvBzyfRSTGSxvP7hpGxfBP/WHiTwk2
         1Jv2AkoNB0LBKsAPViow8W2kyJEcICBE10frxdGCLSxMXVPdCotUM7oTXNQ50ScoZ/L7
         z1hDFJQEAGR7dBoLN+5OyV0VOKYqDJAYhDBkdeoiBuQTWgpLDYGgJ9Lupwq737ZXTFHx
         SmfvvAspbOfs4HQ0LgUg31JDd1no4GEHGj3eFNfr8KGSOlRxK9XLYvf5EMxQwKlz6pE4
         IkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eR83P0sJs14fUDLDbA9zUQB2J/T1uwUazEW3OOsgSmE=;
        b=CgQOjwkhhLZFOtzSKwMVcch16rNQi8KzhLNZxkoqmxJg6w17GR9/M7O0q5BXlN9QJD
         n0ZQe08R+dxZH6Ahd/G7Fi4EZ2qYBAp3W6/QjTl0DFbAYonsSv8Jaj6s6mI6udKjFtKF
         Fyrc37qAeAjclv0IvCcx01t2pFGNOLkJ7y4FX9Y6gjvRiz+OCEzXOplffgLr6b9Knm7l
         hQlKndUAyf8uPolo6C1A29+EePkPgXKuUOooT+2QPFLuBPMr9vfutpmmRkg+F0Ux0aYw
         q9wFHv1c/njYCUnaV9K32X+xeYtWYhpULm05eKd3OdlqbVJuSwzKUgTr+WvU1pnXCG5c
         mpUQ==
X-Gm-Message-State: APjAAAULBL9FfuBnbECErUCNXwlVvfu4L3ydKHiPkTU4gHt9/2MtwDvO
        Srff2z7uTx9GFY1kX29N0teBNo9vog==
X-Google-Smtp-Source: APXvYqw0bYV9liWjuXHJV0k7j0WuR96xgbYPTdG/AeruF4hk+dRr+7QTqvEy3vKrV6EJt20esMDFOw/JDQ==
X-Received: by 2002:a25:d107:: with SMTP id i7mr787682ybg.26.1553701187174;
 Wed, 27 Mar 2019 08:39:47 -0700 (PDT)
Date:   Wed, 27 Mar 2019 16:39:38 +0100
Message-Id: <20190327153938.82007-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH] security: don't use RCU accessors for cred->session_keyring
From:   Jann Horn <jannh@google.com>
To:     David Howells <dhowells@redhat.com>, jannh@google.com
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse complains that a bunch of places in kernel/cred.c access
cred->session_keyring without the RCU helpers required by the __rcu
annotation.

cred->session_keyring is written in the following places:

 - prepare_kernel_cred() [in a new cred struct]
 - keyctl_session_to_parent() [in a new cred struct]
 - prepare_creds [in a new cred struct, via memcpy]
 - install_session_keyring_to_cred()
  - from install_session_keyring() on new creds
  - from join_session_keyring() on new creds [twice]
  - from umh_keys_init()
   - from call_usermodehelper_exec_async() on new creds

All of these writes are before the creds are committed; therefore,
cred->session_keyring doesn't need RCU protection.

Remove the __rcu annotation and fix up all existing users that use __rcu.

Signed-off-by: Jann Horn <jannh@google.com>
---
 include/linux/cred.h         |  2 +-
 security/keys/process_keys.c | 12 ++++--------
 security/keys/request_key.c  |  9 ++-------
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index ddd45bb74887..efb6edf32de7 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -138,7 +138,7 @@ struct cred {
 #ifdef CONFIG_KEYS
 	unsigned char	jit_keyring;	/* default keyring to attach requested
 					 * keys to */
-	struct key __rcu *session_keyring; /* keyring inherited over fork */
+	struct key	*session_keyring; /* keyring inherited over fork */
 	struct key	*process_keyring; /* keyring private to this process */
 	struct key	*thread_keyring; /* keyring private to this thread */
 	struct key	*request_key_auth; /* assumed request_key authority */
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index 9320424c4a46..bd7243cb4c85 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -227,6 +227,7 @@ static int install_process_keyring(void)
  * Install the given keyring as the session keyring of the given credentials
  * struct, replacing the existing one if any.  If the given keyring is NULL,
  * then install a new anonymous session keyring.
+ * @cred can not be in use by any task yet.
  *
  * Return: 0 on success; -errno on failure.
  */
@@ -254,7 +255,7 @@ int install_session_keyring_to_cred(struct cred *cred, struct key *keyring)
 
 	/* install the keyring */
 	old = cred->session_keyring;
-	rcu_assign_pointer(cred->session_keyring, keyring);
+	cred->session_keyring = keyring;
 
 	if (old)
 		key_put(old);
@@ -392,11 +393,8 @@ key_ref_t search_my_process_keyrings(struct keyring_search_context *ctx)
 
 	/* search the session keyring */
 	if (ctx->cred->session_keyring) {
-		rcu_read_lock();
 		key_ref = keyring_search_aux(
-			make_key_ref(rcu_dereference(ctx->cred->session_keyring), 1),
-			ctx);
-		rcu_read_unlock();
+			make_key_ref(ctx->cred->session_keyring, 1), ctx);
 
 		if (!IS_ERR(key_ref))
 			goto found;
@@ -612,10 +610,8 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 			goto reget_creds;
 		}
 
-		rcu_read_lock();
-		key = rcu_dereference(ctx.cred->session_keyring);
+		key = ctx.cred->session_keyring;
 		__key_get(key);
-		rcu_read_unlock();
 		key_ref = make_key_ref(key, 1);
 		break;
 
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 2f17d84d46f1..db72dc4d7639 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -142,12 +142,10 @@ static int call_sbin_request_key(struct key *authkey, void *aux)
 		prkey = cred->process_keyring->serial;
 	sprintf(keyring_str[1], "%d", prkey);
 
-	rcu_read_lock();
-	session = rcu_dereference(cred->session_keyring);
+	session = cred->session_keyring;
 	if (!session)
 		session = cred->user->session_keyring;
 	sskey = session->serial;
-	rcu_read_unlock();
 
 	sprintf(keyring_str[2], "%d", sskey);
 
@@ -287,10 +285,7 @@ static int construct_get_dest_keyring(struct key **_dest_keyring)
 
 			/* fall through */
 		case KEY_REQKEY_DEFL_SESSION_KEYRING:
-			rcu_read_lock();
-			dest_keyring = key_get(
-				rcu_dereference(cred->session_keyring));
-			rcu_read_unlock();
+			dest_keyring = key_get(cred->session_keyring);
 
 			if (dest_keyring)
 				break;
-- 
2.21.0.392.gf8f6787159e-goog

