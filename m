Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300DBC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F109A2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563998913;
	bh=n6jo13Xzf1F/u/wDvFxu1/huCHM/JnEWMVmTrCAzpu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NfOQxfm84jPe97BG1A0B/BHSpyTxHcbuowaNQYLLxzoApzXwlbvaYl2Z0e2tMX2M2
	 RFPzqeslVl7URQ7k4MRk1+t8WOXlQ40Z16gCa6e8X/CEJEHLV5aqyKoghzHxEBkd7G
	 gMTA7mti+X46ocKWsCLG/7KBdhMrxgHdmXlPvI2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392598AbfGXUI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:08:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405489AbfGXUCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:02:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34D6B214AF;
        Wed, 24 Jul 2019 20:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998540;
        bh=n6jo13Xzf1F/u/wDvFxu1/huCHM/JnEWMVmTrCAzpu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z/D0k9a/dRqsP/pi+0PfNUCt8mBJVWHesHgmgXh20tYHG+ZdhF0ELl+L+1bPTlQlf
         /ergPE3OsHzN6KKWxHM9enPj7JGEKWix70KuZYIZm5FnjS8SgSuhx1W7tEInWZM3q5
         YoxzW9AQ1mlPAozCvqbXY2c08EcQSYT2TJJp/jwQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chandan Rajendra <chandan@linux.ibm.com>,
        Eric Biggers <ebiggers@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 029/271] fscrypt: clean up some BUG_ON()s in block encryption/decryption
Date:   Wed, 24 Jul 2019 21:18:18 +0200
Message-Id: <20190724191657.682862679@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit eeacfdc68a104967162dfcba60f53f6f5b62a334 ]

Replace some BUG_ON()s with WARN_ON_ONCE() and returning an error code,
and move the check for len divisible by FS_CRYPTO_BLOCK_SIZE into
fscrypt_crypt_block() so that it's done for both encryption and
decryption, not just encryption.

Reviewed-by: Chandan Rajendra <chandan@linux.ibm.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/crypto/crypto.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 0f46cf550907..c83ddff3ff4a 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -149,7 +149,10 @@ int fscrypt_do_page_crypto(const struct inode *inode, fscrypt_direction_t rw,
 	struct crypto_skcipher *tfm = ci->ci_ctfm;
 	int res = 0;
 
-	BUG_ON(len == 0);
+	if (WARN_ON_ONCE(len <= 0))
+		return -EINVAL;
+	if (WARN_ON_ONCE(len % FS_CRYPTO_BLOCK_SIZE != 0))
+		return -EINVAL;
 
 	BUILD_BUG_ON(sizeof(iv) != FS_IV_SIZE);
 	BUILD_BUG_ON(AES_BLOCK_SIZE != FS_IV_SIZE);
@@ -241,8 +244,6 @@ struct page *fscrypt_encrypt_page(const struct inode *inode,
 	struct page *ciphertext_page = page;
 	int err;
 
-	BUG_ON(len % FS_CRYPTO_BLOCK_SIZE != 0);
-
 	if (inode->i_sb->s_cop->flags & FS_CFLG_OWN_PAGES) {
 		/* with inplace-encryption we just encrypt the page */
 		err = fscrypt_do_page_crypto(inode, FS_ENCRYPT, lblk_num, page,
@@ -254,7 +255,8 @@ struct page *fscrypt_encrypt_page(const struct inode *inode,
 		return ciphertext_page;
 	}
 
-	BUG_ON(!PageLocked(page));
+	if (WARN_ON_ONCE(!PageLocked(page)))
+		return ERR_PTR(-EINVAL);
 
 	ctx = fscrypt_get_ctx(inode, gfp_flags);
 	if (IS_ERR(ctx))
@@ -302,8 +304,9 @@ EXPORT_SYMBOL(fscrypt_encrypt_page);
 int fscrypt_decrypt_page(const struct inode *inode, struct page *page,
 			unsigned int len, unsigned int offs, u64 lblk_num)
 {
-	if (!(inode->i_sb->s_cop->flags & FS_CFLG_OWN_PAGES))
-		BUG_ON(!PageLocked(page));
+	if (WARN_ON_ONCE(!PageLocked(page) &&
+			 !(inode->i_sb->s_cop->flags & FS_CFLG_OWN_PAGES)))
+		return -EINVAL;
 
 	return fscrypt_do_page_crypto(inode, FS_DECRYPT, lblk_num, page, page,
 				      len, offs, GFP_NOFS);
-- 
2.20.1



