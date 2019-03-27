Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76859C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F40205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713062;
	bh=Od0BhSqKtryhppQWPlimH3Mgu9vIc8me812QHfVFYL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yEJO5hgMOl7OCOQUAdHUe8qHwa7uJsZE7VabSzmFieQQ+yrR/TyI6mQ0HtiPGXNTk
	 6nmb7ZPUv+bXCFh6rvaxzprBNNSo9qK1cbe1D7eqDvLi2CPuWhyvAcajN6t7Et+IK4
	 iQNjqaSGsFRxLfbvieg10nXCYIR4fP4dn0qJwNA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389901AbfC0SPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:15:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389379AbfC0SPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:15:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C228D20449;
        Wed, 27 Mar 2019 18:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710545;
        bh=Od0BhSqKtryhppQWPlimH3Mgu9vIc8me812QHfVFYL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ot100VN7O8P5Aj/CXwru0lUcxO+aPlOw0XWnil0jLcEYmVMoNXr0y41iD/Otcv+qC
         Pw2qfsCEp0kILkbcKhejtLxjHQKcG7Zbe+FgKAILl8vlwqNBHEKJqodO0CvpTE/Qex
         imq0g6YLG53TRlT7VyCKsmJD10RJsM3o098sWA70=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 168/192] dmaengine: imx-dma: fix warning comparison of distinct pointer types
Date:   Wed, 27 Mar 2019 14:10:00 -0400
Message-Id: <20190327181025.13507-168-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
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
index 118d371a2a4a..dfee0d895ce3 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -284,7 +284,7 @@ static inline int imxdma_sg_next(struct imxdma_desc *d)
 	struct scatterlist *sg = d->sg;
 	unsigned long now;
 
-	now = min(d->len, sg_dma_len(sg));
+	now = min_t(size_t, d->len, sg_dma_len(sg));
 	if (d->len != IMX_DMA_LENGTH_LOOP)
 		d->len -= now;
 
-- 
2.19.1

