Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2962C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9991521479
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558354930;
	bh=e0wQ/Or/KATeiOfZ/Wp3Ts3mjkNeCXdisU7ebNssEb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FzAPqx9yYNNsejxcj2BtcUbt6zWuQvhzzq0Cgp/6pzdz4EEQu+j+rMnQCDKSambSi
	 h/GIS507A/NXCCi+DxlXB9sO3nGhvbzKW/gPg+t/jTBPWOcRrGPJjAwpvJWvTt/J/c
	 RFipGnAbnRlR3Esl3W7mV1C5MSXQCIwn3Dft8IcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388346AbfETMWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:22:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387507AbfETMWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:22:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E9C4216E3;
        Mon, 20 May 2019 12:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558354924;
        bh=e0wQ/Or/KATeiOfZ/Wp3Ts3mjkNeCXdisU7ebNssEb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cJeF2kK0z4WsIdm9vEiZdGd98EolgVK1UjK3P+8G8DK4UUmXKwFAvy/h2CRVp681D
         1T6+DEH8koc3NEMJSlTxWb1HDaeJiAgSreU4IqKlN2qZU0z+Y1CiRlEUdu7bys+G4W
         Nj8NFqV+4N6aYKJR13/mHmTqUk512gQjhKryNgp4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 030/105] crypto: arm/aes-neonbs - dont access already-freed walk.iv
Date:   Mon, 20 May 2019 14:13:36 +0200
Message-Id: <20190520115249.126168343@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115247.060821231@linuxfoundation.org>
References: <20190520115247.060821231@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit 767f015ea0b7ab9d60432ff6cd06b664fd71f50f upstream.

If the user-provided IV needs to be aligned to the algorithm's
alignmask, then skcipher_walk_virt() copies the IV into a new aligned
buffer walk.iv.  But skcipher_walk_virt() can fail afterwards, and then
if the caller unconditionally accesses walk.iv, it's a use-after-free.

arm32 xts-aes-neonbs doesn't set an alignmask, so currently it isn't
affected by this despite unconditionally accessing walk.iv.  However
this is more subtle than desired, and it was actually broken prior to
the alignmask being removed by commit cc477bf64573 ("crypto: arm/aes -
replace bit-sliced OpenSSL NEON code").  Thus, update xts-aes-neonbs to
start checking the return value of skcipher_walk_virt().

Fixes: e4e7f10bfc40 ("ARM: add support for bit sliced AES using NEON instructions")
Cc: <stable@vger.kernel.org> # v3.13+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/crypto/aes-neonbs-glue.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm/crypto/aes-neonbs-glue.c
+++ b/arch/arm/crypto/aes-neonbs-glue.c
@@ -278,6 +278,8 @@ static int __xts_crypt(struct skcipher_r
 	int err;
 
 	err = skcipher_walk_virt(&walk, req, true);
+	if (err)
+		return err;
 
 	crypto_cipher_encrypt_one(ctx->tweak_tfm, walk.iv, walk.iv);
 


