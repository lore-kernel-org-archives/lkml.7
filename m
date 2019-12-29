Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66F6C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 14:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9B220722
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 14:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtDU/f23"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfL2O5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 09:57:25 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41025 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfL2O4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 09:56:50 -0500
Received: by mail-lj1-f193.google.com with SMTP id h23so31093703ljc.8;
        Sun, 29 Dec 2019 06:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4rypt1/kYJGAf6C/Gog1EznwTiuR8sj2lcgKvtqgbT8=;
        b=jtDU/f23fjGAkrYDUGfztSbigaefpxmAZE1wgF6mNUXR7ud4IkLl34nOYjjQd4Ufz5
         2GJdDFGqwpoDNzvawQdzGMLk39Xq+6ACTYbb+8qPX9gfpC0u+1WzCnrLYG9Vn2nFMJQ5
         EDnSJ9M5w/ah8hYslp1kcWZEIZGnOlWAHhowA7s5qPLyWvzV7ziC7eownNVdF7KgB1dD
         d5vo2A6KPBCx0vW3ncBjGiDia/5kpnJhVaKH9rHjbR7YkOWB7kPN6NNexB2cZ24qK/0g
         R3GK7Cmko1cA89+4D1EguRytBvocYYBjm40K+Evd9nvuEF7Iqk8CtoJqiqHniv/E9iRy
         l8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4rypt1/kYJGAf6C/Gog1EznwTiuR8sj2lcgKvtqgbT8=;
        b=l9B+Yn6GpeJVpFZfO8paBpUVlSTVV/i7wMbKwkP5+qMFZoasXG77xETOb5760KAwTW
         bbQccw+Ypzd2+8zyFV6mClrB48B5t1nIgv0DaoEr3jquk+uiF+MQSw2RJXRtE2uy02I0
         O29qnd0/SaUjq+3D3HRZMVm0ApLyrtTDHPbWt98NTAitnxiEQn3xHJ/e/x2TI1ljPJOT
         +T7SAT5SpOgIRd2D+avzEmrgT3SYWiDduHQPzFK7B4isje0Rkx1fChmKQx0o0GaWWpu3
         22b3buKz5DI3YZszNVycZWcA9800tZbGjQHdKNpKAXvVsUUBO32u0ZQLfuHi+RXHTVDw
         SGXA==
X-Gm-Message-State: APjAAAXdZYO3rpaTUvnUgv4wsfX0Z6+G6CPPVLVcuXgVE4oouBm2AI6Z
        O5mdUl74ZBfYp1rIlJgYbv8=
X-Google-Smtp-Source: APXvYqxrPDaWDjTL2XwKhhtOIHEW3ERFEraLYPk2l+FsJV658+vWGCONjFA/eymMN/UCUeQbO8lbOA==
X-Received: by 2002:a2e:8755:: with SMTP id q21mr35122419ljj.156.1577631408038;
        Sun, 29 Dec 2019 06:56:48 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g15sm11563944ljl.10.2019.12.29.06.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 06:56:47 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/12] dmaengine: tegra-apb: Prevent race conditions of tasklet vs free list
Date:   Sun, 29 Dec 2019 17:55:17 +0300
Message-Id: <20191229145525.533-5-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191229145525.533-1-digetx@gmail.com>
References: <20191229145525.533-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt handler puts a half-completed DMA descriptor on a free list
and then schedules tasklet to process bottom half of the descriptor that
executes client's callback, this creates possibility to pick up the busy
descriptor from the free list. Thus let's disallow descriptor's re-use
until it is fully processed.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 28aff0b9763e..740b0ceec7ec 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -281,7 +281,7 @@ static struct tegra_dma_desc *tegra_dma_desc_get(
 
 	/* Do not allocate if desc are waiting for ack */
 	list_for_each_entry(dma_desc, &tdc->free_dma_desc, node) {
-		if (async_tx_test_ack(&dma_desc->txd)) {
+		if (async_tx_test_ack(&dma_desc->txd) && !dma_desc->cb_count) {
 			list_del(&dma_desc->node);
 			spin_unlock_irqrestore(&tdc->lock, flags);
 			dma_desc->txd.flags = 0;
-- 
2.24.0

