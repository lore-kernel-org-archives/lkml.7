Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E98C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC6C244FF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559185891;
	bh=MebKhiyvJ7riAHzHPq/RqDHrA7XgxeH37Lqj5HQRhYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FJk4uO8VVnVYRdU2BQ5RWdy3gWffWgCsKnduIrW/OcuIcbft7pit86MVWiR+LuHbO
	 8ELzAktagm6K1l7u/p+HAFsDC5MTIFvCRJZ44xMtGbc31AWRZID71Qm9C9YdT1EWVY
	 FUcNTCAg1uSuYE2ZTZ/Rb3kPyEVNA9z/DFjdkzNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbfE3DL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:11:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728101AbfE3DK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:10:28 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F588244A6;
        Thu, 30 May 2019 03:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185827;
        bh=MebKhiyvJ7riAHzHPq/RqDHrA7XgxeH37Lqj5HQRhYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FAhFXAVjR+lfQ2JI+yC1j1zSimmTrwGQvzdDqGc5k3mBxvLXPKue/lKsDwQJMxjqb
         7/URvMkc6d4qxjwIVXoP/jGWcvl4YqZy20FKGXI1o5/p+3Gek1xBC1dcA5HQEWkNMg
         kXHyhadh1HNGXmaFRN4UYsnSiUwNk6Z+W4J3TGDU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Corentin Labbe <clabbe.montjoie@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 128/405] crypto: sun4i-ss - Fix invalid calculation of hash end
Date:   Wed, 29 May 2019 20:02:06 -0700
Message-Id: <20190530030547.530195937@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit f87391558acf816b48f325a493d81d45dec40da0 ]

When nbytes < 4, end is wronlgy set to a negative value which, due to
uint, is then interpreted to a large value leading to a deadlock in the
following code.

This patch fix this problem.

Fixes: 6298e948215f ("crypto: sunxi-ss - Add Allwinner Security System crypto accelerator")
Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/sunxi-ss/sun4i-ss-hash.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/sunxi-ss/sun4i-ss-hash.c b/drivers/crypto/sunxi-ss/sun4i-ss-hash.c
index a4b5ff2b72f87..f6936bb3b7be4 100644
--- a/drivers/crypto/sunxi-ss/sun4i-ss-hash.c
+++ b/drivers/crypto/sunxi-ss/sun4i-ss-hash.c
@@ -240,7 +240,10 @@ static int sun4i_hash(struct ahash_request *areq)
 		}
 	} else {
 		/* Since we have the flag final, we can go up to modulo 4 */
-		end = ((areq->nbytes + op->len) / 4) * 4 - op->len;
+		if (areq->nbytes < 4)
+			end = 0;
+		else
+			end = ((areq->nbytes + op->len) / 4) * 4 - op->len;
 	}
 
 	/* TODO if SGlen % 4 and !op->len then DMA */
-- 
2.20.1



