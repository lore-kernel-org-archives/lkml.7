Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412DCC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D53206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554371203;
	bh=eAgVWoBXyQ/QuAtExZ/y2/uNMPDFHhzQdGunIk/2hkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EEW8OuyvMcCwhCESOU8ig9AcAW+CsOlSLi3JokBkfCq7SPNNXX9yZdUB2Weutmji9
	 RAgYD7v36uHEo6ac0SbaKyzzVH5LwNCf0I36wkd/6IZhDgQBr2qFiiUb6P9wENsRlR
	 21tZUhjXS5fzciFZNYtoLt1kOBh5XvGSK87eZUsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbfDDI6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:58:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730167AbfDDI6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:58:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3D2C21738;
        Thu,  4 Apr 2019 08:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368285;
        bh=eAgVWoBXyQ/QuAtExZ/y2/uNMPDFHhzQdGunIk/2hkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t/c2QtgvB9SfgJkzeatNm9CQTxM1XyZSEwnJ35Y6DWqxpULm72YL6oB8Duk3QFWjF
         pUtUBzAj3MYQ8toTMUXUdovy4ePrkp/eXbPPoLCB2fYYjXWGlPdabu54dgIaUo1xdo
         YX95mFnoAaC80qeV8js6b8E1g6z9XaeL7svhCq9I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Fabio Estevam <festevam@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 106/121] dmaengine: imx-dma: fix warning comparison of distinct pointer types
Date:   Thu,  4 Apr 2019 10:48:14 +0200
Message-Id: <20190404084551.030025550@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index cb37730f9272..6eb1f05f7c3c 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -290,7 +290,7 @@ static inline int imxdma_sg_next(struct imxdma_desc *d)
 	struct scatterlist *sg = d->sg;
 	unsigned long now;
 
-	now = min(d->len, sg_dma_len(sg));
+	now = min_t(size_t, d->len, sg_dma_len(sg));
 	if (d->len != IMX_DMA_LENGTH_LOOP)
 		d->len -= now;
 
-- 
2.19.1



