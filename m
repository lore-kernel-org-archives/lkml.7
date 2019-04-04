Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63C8C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A9820882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554367972;
	bh=PhC6DtTCkc9GAEmR6XXZPlXvDjeO3BVB2sY58ydJfVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n7Ao3QgVln+U6dQ6n2vCapNwUTiYAp+sv3KMU5JEA/+0amT60rrVNzpCo7wYO+YqQ
	 QnyQlwad7gqgM9yYqREMRP8ita7NhcmlA3UZ2xukd2gJj/x6T6I67TmiJzMlktQkCL
	 UsLCyYEZ+qswLZQD9t154xwpZnkU6mK6z782FKvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbfDDIwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:52:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729680AbfDDIwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:52:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69E002184B;
        Thu,  4 Apr 2019 08:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554367966;
        bh=PhC6DtTCkc9GAEmR6XXZPlXvDjeO3BVB2sY58ydJfVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cw01RXn89UcmybYnEEE/2L8FcMEMgACTxVlbhloSHdwEOyj2wmr8wfCJFWuTllzze
         YKalVrHiROmKp8Zc0tN65eLDMhI3rjioIUcX+zskNu0yNhuPfbSm3LZRHLDt4A5NaE
         0sW7Ic7dWms0Ob3VO/H/OZThw5YA4QExFQh190FQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Fabio Estevam <festevam@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 79/91] dmaengine: imx-dma: fix warning comparison of distinct pointer types
Date:   Thu,  4 Apr 2019 10:48:03 +0200
Message-Id: <20190404084540.018522148@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084535.450029272@linuxfoundation.org>
References: <20190404084535.450029272@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
index 1cfa1d9bc971..f8786f60cdc1 100644
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



