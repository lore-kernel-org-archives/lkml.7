Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E30C2D0D1
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA50218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhcLEAjg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfL1Urk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 15:47:40 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32984 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfL1Urh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 15:47:37 -0500
Received: by mail-lj1-f194.google.com with SMTP id y6so21868187lji.0;
        Sat, 28 Dec 2019 12:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fLPm8kYY1aMbkcJ/I/yZlSuw3yqow+z5kIYMGPZJf+g=;
        b=DhcLEAjgQc+e+kejOgHEOasdw3svYPV7Y0HmjnfxXi3lqUPMqunzHIWTkaz5yWpfn8
         m88ZSmIorpX/QQN40Anbfw+53ES/v8KWYZd4x18I4b38+UEnfx5yL6QvciIrvATeawOG
         gQlmj6Ep0Z2I/mU6fTY7RELCJWEAIC4KxTimJ8M4lyo5uOeAF9pKs6zp+l08EdJYyp5g
         Hu/0u37DttgBZY7SsdR3pzp8/a3HeWQBUYBwSUwnk2daPXbBS26aQdMXepu0L1E94C1A
         FpCtkpKqj43jCoehxyt8tIkBFWEVchkU4ELgI7kFKzsQoE1250WaTNNvGX6D0Zza9X7P
         Msaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fLPm8kYY1aMbkcJ/I/yZlSuw3yqow+z5kIYMGPZJf+g=;
        b=cN9X1SLIFCCEqe3FIXeE+oZXGm7sGmQe+stQjpCWUofOpYxLH8KKUargC6CnCG8XQ9
         iNQ745xPqzJqL5bKFDWwJGb1RehvN5j+hvwTl6//zWiykBqav4liteUVn4/M5BxwxK16
         L0oVVucpaYQEU8wMFR8zL8W9A65wBpCHipcX92bvQGP1eEhfVgqbKeV4wc1gnSjH578o
         9cU//v37C26ykBsIFrksO0makLQZQIOt4JvOPT3yIEMWmjJzTfxDAlxMQm7xHnmwgD4w
         IyJK87pVSKt+xwhxgFJ8JvKA+scnVbKWNdBgjMH3fHb5Pn96p2cNRxU0FG4ilZG0mOcm
         OI/g==
X-Gm-Message-State: APjAAAWxW7SL3WNHW4vo6oQ1sG+BaD6JCG6x8re1Hk3tp0dVHPzjG5cH
        xCJEj2MYrKGYTh4334RdxOk=
X-Google-Smtp-Source: APXvYqwkrd2qAHBpXHL6S2DsvRKvIdpUjHngYf75N5aAJvkIP0DUqrZ2vWLREPyGCmS39AcXIRHwSQ==
X-Received: by 2002:a2e:556:: with SMTP id 83mr33163294ljf.127.1577566054744;
        Sat, 28 Dec 2019 12:47:34 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g15sm10571219ljl.10.2019.12.28.12.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 12:47:34 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/7] dmaengine: tegra-apb: Prevent race conditions on channel's freeing
Date:   Sat, 28 Dec 2019 23:46:36 +0300
Message-Id: <20191228204640.25163-4-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191228204640.25163-1-digetx@gmail.com>
References: <20191228204640.25163-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's unsafe to check the channel's "busy" state without taking a lock,
it is also unsafe to assume that tasklet isn't in-fly.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 664e9c5df3ba..28aff0b9763e 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1294,8 +1294,8 @@ static void tegra_dma_free_chan_resources(struct dma_chan *dc)
 
 	dev_dbg(tdc2dev(tdc), "Freeing channel %d\n", tdc->id);
 
-	if (tdc->busy)
-		tegra_dma_terminate_all(dc);
+	tegra_dma_terminate_all(dc);
+	tasklet_kill(&tdc->tasklet);
 
 	spin_lock_irqsave(&tdc->lock, flags);
 	list_splice_init(&tdc->pending_sg_req, &sg_req_list);
@@ -1543,7 +1543,6 @@ static int tegra_dma_probe(struct platform_device *pdev)
 		struct tegra_dma_channel *tdc = &tdma->channels[i];
 
 		free_irq(tdc->irq, tdc);
-		tasklet_kill(&tdc->tasklet);
 	}
 
 	pm_runtime_disable(&pdev->dev);
@@ -1563,7 +1562,6 @@ static int tegra_dma_remove(struct platform_device *pdev)
 	for (i = 0; i < tdma->chip_data->nr_channels; ++i) {
 		tdc = &tdma->channels[i];
 		free_irq(tdc->irq, tdc);
-		tasklet_kill(&tdc->tasklet);
 	}
 
 	pm_runtime_disable(&pdev->dev);
-- 
2.24.0

