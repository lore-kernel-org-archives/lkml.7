Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A10C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36552083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256873;
	bh=MAEWEKE04FwGBlbb1MbdSZtSfR5swMe5/rctFek+xME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1SIUGAD+1+djgvBJ2xaE3gupWVJ+dAkQSJzevuPFFcmZcvvsHDoRsTxEXlNExN5gP
	 y8tnkHtnbNlDuO+xPVS7o33WMihug6XrIzFHKWudpHhRcF1vfTGO54+yr26la/t2fo
	 7ze1736cIN8EKAY9gC2zmU+Af+4HsqZRfcfrmsBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389919AbfCVMOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:14:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389705AbfCVMOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:14:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EACDB2083D;
        Fri, 22 Mar 2019 12:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256869;
        bh=MAEWEKE04FwGBlbb1MbdSZtSfR5swMe5/rctFek+xME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AhnuvwKosmkboRsipAJuc5ZAa8Z1dy+2VWIkdVFBi17ZfFeHTt7WlfQcvoMyGi5Es
         RX+LoEXyYPLJOP50JxW+Czk9lljCOkmgQjkwVMDylQGgfmqEXLPtO29Xei84eFXAOJ
         NyqLpIKGaJetqfqFJ/GBmvwp0xcYOPfjn6B7TTaE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.0 019/238] crypto: cfb - add missing chunksize property
Date:   Fri, 22 Mar 2019 12:13:58 +0100
Message-Id: <20190322111259.300070389@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 394a9e044702e6a8958a5e89d2a291605a587a2a upstream.

Like some other block cipher mode implementations, the CFB
implementation assumes that while walking through the scatterlist, a
partial block does not occur until the end.  But the walk is incorrectly
being done with a blocksize of 1, as 'cra_blocksize' is set to 1 (since
CFB is a stream cipher) but no 'chunksize' is set.  This bug causes
incorrect encryption/decryption for some scatterlist layouts.

Fix it by setting the 'chunksize'.  Also extend the CFB test vectors to
cover this bug as well as cases where the message length is not a
multiple of the block size.

Fixes: a7d85e06ed80 ("crypto: cfb - add support for Cipher FeedBack mode")
Cc: <stable@vger.kernel.org> # v4.17+
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/cfb.c     |    6 ++++++
 crypto/testmgr.h |   25 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

--- a/crypto/cfb.c
+++ b/crypto/cfb.c
@@ -298,6 +298,12 @@ static int crypto_cfb_create(struct cryp
 	inst->alg.base.cra_blocksize = 1;
 	inst->alg.base.cra_alignmask = alg->cra_alignmask;
 
+	/*
+	 * To simplify the implementation, configure the skcipher walk to only
+	 * give a partial block at the very end, never earlier.
+	 */
+	inst->alg.chunksize = alg->cra_blocksize;
+
 	inst->alg.ivsize = alg->cra_blocksize;
 	inst->alg.min_keysize = alg->cra_cipher.cia_min_keysize;
 	inst->alg.max_keysize = alg->cra_cipher.cia_max_keysize;
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -12870,6 +12870,31 @@ static const struct cipher_testvec aes_c
 			  "\x75\xa3\x85\x74\x1a\xb9\xce\xf8"
 			  "\x20\x31\x62\x3d\x55\xb1\xe4\x71",
 		.len	= 64,
+		.also_non_np = 1,
+		.np	= 2,
+		.tap	= { 31, 33 },
+	}, { /* > 16 bytes, not a multiple of 16 bytes */
+		.key	= "\x2b\x7e\x15\x16\x28\xae\xd2\xa6"
+			  "\xab\xf7\x15\x88\x09\xcf\x4f\x3c",
+		.klen	= 16,
+		.iv	= "\x00\x01\x02\x03\x04\x05\x06\x07"
+			  "\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f",
+		.ptext	= "\x6b\xc1\xbe\xe2\x2e\x40\x9f\x96"
+			  "\xe9\x3d\x7e\x11\x73\x93\x17\x2a"
+			  "\xae",
+		.ctext	= "\x3b\x3f\xd9\x2e\xb7\x2d\xad\x20"
+			  "\x33\x34\x49\xf8\xe8\x3c\xfb\x4a"
+			  "\xc8",
+		.len	= 17,
+	}, { /* < 16 bytes */
+		.key	= "\x2b\x7e\x15\x16\x28\xae\xd2\xa6"
+			  "\xab\xf7\x15\x88\x09\xcf\x4f\x3c",
+		.klen	= 16,
+		.iv	= "\x00\x01\x02\x03\x04\x05\x06\x07"
+			  "\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f",
+		.ptext	= "\x6b\xc1\xbe\xe2\x2e\x40\x9f",
+		.ctext	= "\x3b\x3f\xd9\x2e\xb7\x2d\xad",
+		.len	= 7,
 	},
 };
 


