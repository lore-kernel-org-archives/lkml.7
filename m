Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7104C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 19:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89192133F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 19:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbfCXTpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 15:45:42 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:54447 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfCXTpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 15:45:42 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MIx7U-1hRJXC4Aws-00KR5b; Sun, 24 Mar 2019 20:45:09 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ubifs: work around high stack usage with clang
Date:   Sun, 24 Mar 2019 20:44:51 +0100
Message-Id: <20190324194505.3244479-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YCZ4t4TKytA+xgmmV/ZeoVdXaCcLMykTcd/+MqVgKK9RGQVFZkk
 +k7Pc/E9cLc1rLgM26mCQ2Iroecuntrd+sk+4cID9SU7y4zy8dmcIkiIhBEuMrrXvxclSoB
 JsPFcKWlxMXCh+K17vhnsbena8D2r2Au5wSfQRAaFHlWTjN3EEf4Zt/uTxHTxtdImMcKfZO
 +XqSM09rswT2VTr7OiILg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l1dFlghIaU4=:8fIJOYjmDOXT2bqE+tL4E0
 VXUgvmJ4S4eKXpgYqbDmTgpgOB32HQo6Ql21y0tLyw2fmC/8BzpYpwDBvKOFklE+NdzDbx7my
 +HNTsKid8rJCFqUwT1CGI4ohiZesGGnOSleQg3XWN3feuqfbvoPpS9Xv55qtzSbPyy1o2vSf5
 gwdClwqQlerzhpcmXLe5EoG2I0fuQQVUhExF84yihpg2xannrn0/XaZypI/qF2GWnTc6BpgVr
 AZHzjSMBHeKdEqXKQzgI+lA3IFIJdisR00yK4MpGsQzOb8kI7s79iR16JpNni5AVK8nDc5TNE
 dx0CsBww1mn3d3bNmvi9mfwpv/WcvDgDUsfHusitDMl9EmchqQI339si/RvRluI6DA6Zl2U2y
 2md1vIi7w1wEoSLNf0YLL/1APxcmdSgiEPJh3NoZqJTiEb0+cx4OJSoAqoq0xmJQSCekbvr7m
 VGL71qsxbvGJyVcfKRAtTg15I4jrA1hhi9NOsD4JsILU6+VJxBfdfK95EOpzFBMf35YvPb5un
 YP2LjLdo/3ksCVDWAZk5kDLq8PcIHq4yEUMAoslO+VQf15bn6MMPmSkDomewWI8bzIVRRtfMt
 2vRMwuB4Y+hm2K9RBOil3SIRVJSBgQzN7xzEQUWAqxTTLPBF8uD70XGfNJA39FKOxPD/NqEia
 GfAvs54Hvq7NvPGCck9ceH8JbeNMJd3AMuiIq4IrjTvy/3F4/Cv4GpHPXj72rfo5pS/X7na4i
 gfn1lWK6Rw676RXAxhnDoK/jMaMRNhucdBjGkQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building this file with clang can result in large stack usage as seen from
this warning:

fs/ubifs/auth.c:78:5: error: stack frame size of 1152 bytes in function 'ubifs_prepare_auth_node'

The problem is that inlining ubifs_hash_calc_hmac() leads to
two SHASH_DESC_ON_STACK() blocks in the same function, and clang
for some reason does not reuse the stack space as it should.

Putting the first declaration into a separate basic block avoids
this problem and reduces the stack allocation to 640 bytes.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ubifs/auth.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/ubifs/auth.c b/fs/ubifs/auth.c
index 5bf5fd08879e..5d3d0b37a908 100644
--- a/fs/ubifs/auth.c
+++ b/fs/ubifs/auth.c
@@ -78,7 +78,6 @@ static int ubifs_hash_calc_hmac(const struct ubifs_info *c, const u8 *hash,
 int ubifs_prepare_auth_node(struct ubifs_info *c, void *node,
 			     struct shash_desc *inhash)
 {
-	SHASH_DESC_ON_STACK(hash_desc, c->hash_tfm);
 	struct ubifs_auth_node *auth = node;
 	u8 *hash;
 	int err;
@@ -87,13 +86,17 @@ int ubifs_prepare_auth_node(struct ubifs_info *c, void *node,
 	if (!hash)
 		return -ENOMEM;
 
-	hash_desc->tfm = c->hash_tfm;
-	hash_desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
-	ubifs_shash_copy_state(c, inhash, hash_desc);
+	{
+		SHASH_DESC_ON_STACK(hash_desc, c->hash_tfm);
 
-	err = crypto_shash_final(hash_desc, hash);
-	if (err)
-		goto out;
+		hash_desc->tfm = c->hash_tfm;
+		hash_desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
+		ubifs_shash_copy_state(c, inhash, hash_desc);
+
+		err = crypto_shash_final(hash_desc, hash);
+		if (err)
+			goto out;
+	}
 
 	err = ubifs_hash_calc_hmac(c, hash, auth->hmac);
 	if (err)
-- 
2.20.0

