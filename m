Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D1CC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 21:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7480424237
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 21:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNLKJhpe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfE2VpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 17:45:20 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44687 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfE2VpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 17:45:19 -0400
Received: by mail-io1-f68.google.com with SMTP id f22so3201959iol.11;
        Wed, 29 May 2019 14:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xore5EbM1RPfaLGDfwvhBCS+nazjtQv0oHu+w4QdH3A=;
        b=PNLKJhpev592jajRJweAd6ImF/wZIJ9YUIGUSqTBtUSiUhlTIrxrN9PmdrAhG1UvWU
         2mYWvkBW+ZyalqKAWpjwq+jqOB2ozxHzr6Wqj9g4HvRwPNTApf19g+/t/19uu+gPHLpg
         4D9Y2L7KYq0bI1IqIM6tZ0wbfPdXx8E4CE1Uk4lmADOuhgLg8fRHSakyWCPfq46H/CgF
         M4MMxqZ7hgvadjj6JV+7mnaAenPGpQcwNi1Tux65omB4Ds1BCwcKWLalcwfz0Bc0wjjw
         CqRmxnWABROB1QQRALB3mRl5Mkqr7MJZmzKhEIdJe5Xxuxnh9I9PaVv2wWsVSYpVVI0r
         GiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xore5EbM1RPfaLGDfwvhBCS+nazjtQv0oHu+w4QdH3A=;
        b=s9Pi6bVX/rudiajGcM0Vjv9uleZnniQkNrchCYeJPzcSdCNvryO2x+F9qi+pQRnJYi
         MhqZSgarKQSJRPjaY0F+rGybk/FS+Ez7c8lEbPGuKUYjTv3JKKRfiazJOOuV7JPiF2E5
         0sLDbYXXvBriCm+PkBL1+2syADVb9Z4offkQ/IbX6gdLv4SbmxbsPUxG2cUJljQhM6Nj
         8Aca3fijLyReUymrgxg5QhCiYbQKyYoogYMP067zPdRV/ToQC49T9Quqse773fkGdl+s
         lz5FUUTkBAEEKrHFqPRtHKL7BtL1KJ8JBgZ9aUwupi7vWYhlEHr1dJPguy6oYhKegYbO
         5fvg==
X-Gm-Message-State: APjAAAVz/AN8Au0s89jnawaBkUoX/WdXtPL6grFn2RAuNEHX/Ooex3tx
        V6KWUFvNrW2kF8zxgAnf4dI=
X-Google-Smtp-Source: APXvYqyZrKJjM9qRtO2iSZD3sXsntg5OG3mNUdRz0cpJ9sP9DLJh3Rb6v5ULOHPHFoseVQFmAwXqZA==
X-Received: by 2002:a6b:b7d5:: with SMTP id h204mr214015iof.188.1559166318332;
        Wed, 29 May 2019 14:45:18 -0700 (PDT)
Received: from localhost.localdomain ([94.29.35.141])
        by smtp.gmail.com with ESMTPSA id n193sm259992itn.27.2019.05.29.14.45.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 14:45:17 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] dmaengine: tegra-apb: Error out if DMA_PREP_INTERRUPT flag is unset
Date:   Thu, 30 May 2019 00:43:55 +0300
Message-Id: <20190529214355.15339-1-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently driver was never tested with DMA_PREP_INTERRUPT flag being
unset since it completely disables interrupt handling instead of skipping
the callbacks invocations, hence putting channel into unusable state.

The flag is always set by all of kernel drivers that use APB DMA, so let's
error out in otherwise case for consistency. It won't be difficult to
support that case properly if ever will be needed.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index cf462b1abc0b..2c84a660ba36 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -988,8 +988,12 @@ static struct dma_async_tx_descriptor *tegra_dma_prep_slave_sg(
 		csr |= tdc->slave_id << TEGRA_APBDMA_CSR_REQ_SEL_SHIFT;
 	}
 
-	if (flags & DMA_PREP_INTERRUPT)
+	if (flags & DMA_PREP_INTERRUPT) {
 		csr |= TEGRA_APBDMA_CSR_IE_EOC;
+	} else {
+		WARN_ON_ONCE(1);
+		return NULL;
+	}
 
 	apb_seq |= TEGRA_APBDMA_APBSEQ_WRAP_WORD_1;
 
@@ -1131,8 +1135,12 @@ static struct dma_async_tx_descriptor *tegra_dma_prep_dma_cyclic(
 		csr |= tdc->slave_id << TEGRA_APBDMA_CSR_REQ_SEL_SHIFT;
 	}
 
-	if (flags & DMA_PREP_INTERRUPT)
+	if (flags & DMA_PREP_INTERRUPT) {
 		csr |= TEGRA_APBDMA_CSR_IE_EOC;
+	} else {
+		WARN_ON_ONCE(1);
+		return NULL;
+	}
 
 	apb_seq |= TEGRA_APBDMA_APBSEQ_WRAP_WORD_1;
 
-- 
2.21.0

