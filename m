Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83BFC43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 13:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4876206F4
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 13:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfLHN4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 08:56:03 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60430 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726883AbfLHNyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 08:54:45 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1idx1G-0007hK-6V; Sun, 08 Dec 2019 13:54:42 +0000
Received: from ben by deadeye with local (Exim 4.93-RC1)
        (envelope-from <ben@decadent.org.uk>)
        id 1idx1E-0002P1-Jc; Sun, 08 Dec 2019 13:54:40 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Sun, 08 Dec 2019 13:53:41 +0000
Message-ID: <lsq.1575813165.245786844@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 57/72] crypto: user - Fix crypto_alg_match race
In-Reply-To: <lsq.1575813164.154362148@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.79-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

commit 016baaa1183bb0c5fb2a7de42413bba8a51c1bc8 upstream.

The function crypto_alg_match returns an algorithm without taking
any references on it.  This means that the algorithm can be freed
at any time, therefore all users of crypto_alg_match are buggy.

This patch fixes this by taking a reference count on the algorithm
to prevent such races.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 crypto/crypto_user.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

--- a/crypto/crypto_user.c
+++ b/crypto/crypto_user.c
@@ -65,10 +65,14 @@ static struct crypto_alg *crypto_alg_mat
 		else if (!exact)
 			match = !strcmp(q->cra_name, p->cru_name);
 
-		if (match) {
-			alg = q;
-			break;
-		}
+		if (!match)
+			continue;
+
+		if (unlikely(!crypto_mod_get(q)))
+			continue;
+
+		alg = q;
+		break;
 	}
 
 	up_read(&crypto_alg_sem);
@@ -211,9 +215,10 @@ static int crypto_report(struct sk_buff
 	if (!alg)
 		return -ENOENT;
 
+	err = -ENOMEM;
 	skb = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);
 	if (!skb)
-		return -ENOMEM;
+		goto drop_alg;
 
 	info.in_skb = in_skb;
 	info.out_skb = skb;
@@ -221,6 +226,10 @@ static int crypto_report(struct sk_buff
 	info.nlmsg_flags = 0;
 
 	err = crypto_report_alg(alg, &info);
+
+drop_alg:
+	crypto_mod_put(alg);
+
 	if (err)
 		return err;
 
@@ -293,6 +302,7 @@ static int crypto_update_alg(struct sk_b
 
 	up_write(&crypto_alg_sem);
 
+	crypto_mod_put(alg);
 	crypto_remove_final(&list);
 
 	return 0;
@@ -303,6 +313,7 @@ static int crypto_del_alg(struct sk_buff
 {
 	struct crypto_alg *alg;
 	struct crypto_user_alg *p = nlmsg_data(nlh);
+	int err;
 
 	if (!netlink_capable(skb, CAP_NET_ADMIN))
 		return -EPERM;
@@ -319,13 +330,19 @@ static int crypto_del_alg(struct sk_buff
 	 * if we try to unregister. Unregistering such an algorithm without
 	 * removing the module is not possible, so we restrict to crypto
 	 * instances that are build from templates. */
+	err = -EINVAL;
 	if (!(alg->cra_flags & CRYPTO_ALG_INSTANCE))
-		return -EINVAL;
+		goto drop_alg;
 
-	if (atomic_read(&alg->cra_refcnt) != 1)
-		return -EBUSY;
+	err = -EBUSY;
+	if (atomic_read(&alg->cra_refcnt) > 2)
+		goto drop_alg;
 
-	return crypto_unregister_instance(alg);
+	err = crypto_unregister_instance(alg);
+
+drop_alg:
+	crypto_mod_put(alg);
+	return err;
 }
 
 static struct crypto_alg *crypto_user_skcipher_alg(const char *name, u32 type,
@@ -404,8 +421,10 @@ static int crypto_add_alg(struct sk_buff
 		return -EINVAL;
 
 	alg = crypto_alg_match(p, exact);
-	if (alg)
+	if (alg) {
+		crypto_mod_put(alg);
 		return -EEXIST;
+	}
 
 	if (strlen(p->cru_driver_name))
 		name = p->cru_driver_name;

