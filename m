Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AAFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A0120651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711629;
	bh=OGNhdJ0tHPQlntJP3QhnssYHMu2YeCCTJrsQ2kgHVrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zx0VfNE4ivrgCC7RGlksQrj+Kd42GKzFon2Lm4EgW+sjX+AaXdjpaluEfzhH+dh8k
	 udL23r/ZD/hnHVdzBJTJJyyhZIQBKrdgsL1QmVN2ohvWi7rsv/tVaHaI8icGXtElLB
	 HinVWAHe46KgXgbPYpg5IAEUtnnKfTpMW8NTq4Fg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389831AbfC0Sds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:33:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404098AbfC0SZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:25:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AB83206BA;
        Wed, 27 Mar 2019 18:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711105;
        bh=OGNhdJ0tHPQlntJP3QhnssYHMu2YeCCTJrsQ2kgHVrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gsk/NtA/F+E3Vur0PeOJKJ06hM+uX0O9UBluCXF703FdN7HulMj+irXAKCBFJSrP5
         g6fJ/G6Hrc76n4RboG5OcUrCBVH3f4uBLEqgZPXCCgRMutTAeiC3i4sjNzc6xDWuO9
         5aYS9JjJauFQ51pQ1K2OudGzyhiCnJycY4s+G2P8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 56/63] dmaengine: imx-dma: fix warning comparison of distinct pointer types
Date:   Wed, 27 Mar 2019 14:23:16 -0400
Message-Id: <20190327182323.18577-56-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327182323.18577-1-sashal@kernel.org>
References: <20190327182323.18577-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anders Roxell <anders.roxell@linaro.org>

[ Upstream commit 9227ab5643cb8350449502dd9e3168a873ab0e3b ]

The warning got introduced by commit 930507c18304 ("arm64: add basic
Kconfig symbols for i.MX8"). Since it got enabled for arm64. The warning
haven't been seen before since size_t was 'unsigned int' when built on
arm32.

../drivers/dma/imx-dma.c: In function ‘imxdma_sg_next’:
../include/linux/kernel.h:846:29: warning: comparison of distinct pointer types lacks a cast
   (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                             ^~
../include/linux/kernel.h:860:4: note: in expansion of macro ‘__typecheck’
   (__typecheck(x, y) && __no_side_effects(x, y))
    ^~~~~~~~~~~
../include/linux/kernel.h:870:24: note: in expansion of macro ‘__safe_cmp’
  __builtin_choose_expr(__safe_cmp(x, y), \
                        ^~~~~~~~~~
../include/linux/kernel.h:879:19: note: in expansion of macro ‘__careful_cmp’
 #define min(x, y) __careful_cmp(x, y, <)
                   ^~~~~~~~~~~~~
../drivers/dma/imx-dma.c:288:8: note: in expansion of macro ‘min’
  now = min(d->len, sg_dma_len(sg));
        ^~~

Rework so that we use min_t and pass in the size_t that returns the
minimum of two values, using the specified type.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Acked-by: Olof Johansson <olof@lixom.net>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/imx-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index dfa337ae06fc..529b315a6683 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -286,7 +286,7 @@ static inline int imxdma_sg_next(struct imxdma_desc *d)
 	struct scatterlist *sg = d->sg;
 	unsigned long now;
 
-	now = min(d->len, sg_dma_len(sg));
+	now = min_t(size_t, d->len, sg_dma_len(sg));
 	if (d->len != IMX_DMA_LENGTH_LOOP)
 		d->len -= now;
 
-- 
2.19.1

