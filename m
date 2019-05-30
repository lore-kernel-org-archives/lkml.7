Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A64C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518F224758
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559186280;
	bh=MebKhiyvJ7riAHzHPq/RqDHrA7XgxeH37Lqj5HQRhYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d3+xp1Z8Mn530j+aK7iUlzBilv7Hbn8eaF2cHYiIfOrLAAagcgZHn7O2bTxUo2sfe
	 BCta3b+OPTEn+lQqu4fu4QLFWZ08o4k/eDlIHGI3hCii/JMtwObnSg13TUWyfDQPr3
	 JugHP1qi8HTxxbRecCWbIVFYO5Lm+aeHZtXUV60E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731372AbfE3DR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:17:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729804AbfE3DOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:14:18 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90F4224565;
        Thu, 30 May 2019 03:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186057;
        bh=MebKhiyvJ7riAHzHPq/RqDHrA7XgxeH37Lqj5HQRhYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bjSRSgKAv/d7ZW3XNfoqcUStL//ugnFj4SZFdQRRGMlFD42ottjzOMkfDk3/85eg0
         rXWsJnqO56N4snEwR+9FeenYD8OqCvQsX5oKn7l8NIKqfZC2doVMv0Sw7IBrS6V+uB
         dMJ+MoV0V/tVWiVGer3XkhTeLjNGiHzUta2iHZkI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Corentin Labbe <clabbe.montjoie@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 115/346] crypto: sun4i-ss - Fix invalid calculation of hash end
Date:   Wed, 29 May 2019 20:03:08 -0700
Message-Id: <20190530030546.916898262@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
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



