Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B43C742B9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80DF5216C4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562934761;
	bh=Uzkd6LOgljI4X7EBGkkIDUfmgL0ygBzTNggI5WAp9F4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rx1hxpa3vVeEL07NEMfVdDyCdA+2p1uPcVD0OvT7SO+rc83TJaFGHw/hnPdDjoBqm
	 4uNKvK0nrqcjiawrDtOHGdBV4Lpcr/qQkLVSDnB9Tz6VJtNTJ6/cP0HDDBBXC1COMp
	 ReGZQcYWsba0o0ye11t+8lvlBEcmup8zTgzFy4RM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbfGLMck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:32:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729484AbfGLMcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:32:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F366821019;
        Fri, 12 Jul 2019 12:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934751;
        bh=Uzkd6LOgljI4X7EBGkkIDUfmgL0ygBzTNggI5WAp9F4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0TFGpfXD33sIh76tZnhTISS/oLKTPYNJ1HsiiTw5hPgxnHN3kEze5djvjKPTpuaqK
         m2/128hwIfXCaYhjV0/zSRAifDUen2rOgbyuizvf+P/UqRxwze+kOvEWnCHa1EPeE1
         A1QfXUIGcuWWg/PhxFznkzZ4wuaanR0TFf3tnWZQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.2 02/61] crypto: lrw - use correct alignmask
Date:   Fri, 12 Jul 2019 14:19:15 +0200
Message-Id: <20190712121620.745996240@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121620.632595223@linuxfoundation.org>
References: <20190712121620.632595223@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit 20a0f9761343fba9b25ea46bd3a3e5e533d974f8 upstream.

Commit c778f96bf347 ("crypto: lrw - Optimize tweak computation")
incorrectly reduced the alignmask of LRW instances from
'__alignof__(u64) - 1' to '__alignof__(__be32) - 1'.

However, xor_tweak() and setkey() assume that the data and key,
respectively, are aligned to 'be128', which has u64 alignment.

Fix the alignmask to be at least '__alignof__(be128) - 1'.

Fixes: c778f96bf347 ("crypto: lrw - Optimize tweak computation")
Cc: <stable@vger.kernel.org> # v4.20+
Cc: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/lrw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/crypto/lrw.c
+++ b/crypto/lrw.c
@@ -384,7 +384,7 @@ static int create(struct crypto_template
 	inst->alg.base.cra_priority = alg->base.cra_priority;
 	inst->alg.base.cra_blocksize = LRW_BLOCK_SIZE;
 	inst->alg.base.cra_alignmask = alg->base.cra_alignmask |
-				       (__alignof__(__be32) - 1);
+				       (__alignof__(be128) - 1);
 
 	inst->alg.ivsize = LRW_BLOCK_SIZE;
 	inst->alg.min_keysize = crypto_skcipher_alg_min_keysize(alg) +


