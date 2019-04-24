Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2790C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98244206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126074;
	bh=fHm1lQ58fZ+2Oho54RIE+k5BYDeaoq5LDGwRmBj+Do0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aedEEVPT7Ti+eDKn/v8go0wGPVnRK4F3vLy8uf6aqvKZPMYeY9wiIkgcXlvNrRi0X
	 cdeRE3pdi7KC5mtfL6CezuYqsiuv6ypiw6g+IjkcAWmc3+RhcwFByY/qHKXxdFsUrA
	 BUpUKyox93e+0UF+1ND1dl5OKhydpJz4XVOSnmy4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388085AbfDXROd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:14:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387635AbfDXRO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:14:27 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1C6C206BA;
        Wed, 24 Apr 2019 17:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126066;
        bh=fHm1lQ58fZ+2Oho54RIE+k5BYDeaoq5LDGwRmBj+Do0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=auX+NhqM0l/l4vhAOEJGCfvN2wqYbrzZ9xm1EKPUEFej9eEqolK96zbWHxjMauv3O
         XGA6LBtU34Dg7H3eW3RUzVxRR7klYoTSLb9nDOfChwgg8R+xfONDWq9GIKRZN+VHIw
         BsLdjqhXHFaTOr1m6Q1M4Dg7fwkcUX4fRDH8/PP4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Fabio Estevam <festevam@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 036/104] dmaengine: imx-dma: fix warning comparison of distinct pointer types
Date:   Wed, 24 Apr 2019 19:08:53 +0200
Message-Id: <20190424170858.348804107@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
References: <20190424170839.996641496@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index ddfd8024881e..f0182c5001ad 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -291,7 +291,7 @@ static inline int imxdma_sg_next(struct imxdma_desc *d)
 	struct scatterlist *sg = d->sg;
 	unsigned long now;
 
-	now = min(d->len, sg_dma_len(sg));
+	now = min_t(size_t, d->len, sg_dma_len(sg));
 	if (d->len != IMX_DMA_LENGTH_LOOP)
 		d->len -= now;
 
-- 
2.19.1



