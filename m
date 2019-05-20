Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B2EC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9204214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558355244;
	bh=qFmpTGVLbRz4mBAxDSw8NvsVt8gaTA3Jkk/yCGfbfOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sd0mrhqAOFc/iw3M8DNnxklMavzx0uDLDV86GUokDzy6zb/Lf+bHQEI8/qAVc7znC
	 t+vb4QbySRM48MHLzuctKiFopHxM/2JQ0YY3EwJv/njiXUWnx+nasJeySDFdrXbGO6
	 Gcv+7WdkpXxi0k56fzJksJ+M0j3pSVb+YLg9Noak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389487AbfETM1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:27:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:42908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389465AbfETM1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:27:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D638D21479;
        Mon, 20 May 2019 12:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558355239;
        bh=qFmpTGVLbRz4mBAxDSw8NvsVt8gaTA3Jkk/yCGfbfOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iZRWiJGkljTCcd8ipU5ixH24zK85iIraCm/eqjyv/K0sjZ3qPUd//ZticJaHQrjPN
         tH7vqd2frmdmwx8eAJm/VUnQnYoctZcb5l/2rqfzPraHh0EOx60c++3Ww8y46PsrjC
         X2j16EY980GNkbjEUix8aTVQBuVJZbTSPvmOpGIE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.0 043/123] crypto: arm64/aes-neonbs - dont access already-freed walk.iv
Date:   Mon, 20 May 2019 14:13:43 +0200
Message-Id: <20190520115247.594313696@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115245.439864225@linuxfoundation.org>
References: <20190520115245.439864225@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit 4a8108b70508df0b6c4ffa4a3974dab93dcbe851 upstream.

If the user-provided IV needs to be aligned to the algorithm's
alignmask, then skcipher_walk_virt() copies the IV into a new aligned
buffer walk.iv.  But skcipher_walk_virt() can fail afterwards, and then
if the caller unconditionally accesses walk.iv, it's a use-after-free.

xts-aes-neonbs doesn't set an alignmask, so currently it isn't affected
by this despite unconditionally accessing walk.iv.  However this is more
subtle than desired, and unconditionally accessing walk.iv has caused a
real problem in other algorithms.  Thus, update xts-aes-neonbs to start
checking the return value of skcipher_walk_virt().

Fixes: 1abee99eafab ("crypto: arm64/aes - reimplement bit-sliced ARM/NEON implementation for arm64")
Cc: <stable@vger.kernel.org> # v4.11+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/crypto/aes-neonbs-glue.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm64/crypto/aes-neonbs-glue.c
+++ b/arch/arm64/crypto/aes-neonbs-glue.c
@@ -304,6 +304,8 @@ static int __xts_crypt(struct skcipher_r
 	int err;
 
 	err = skcipher_walk_virt(&walk, req, false);
+	if (err)
+		return err;
 
 	kernel_neon_begin();
 	neon_aes_ecb_encrypt(walk.iv, walk.iv, ctx->twkey, ctx->key.rounds, 1);


