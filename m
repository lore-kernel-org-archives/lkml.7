Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E489C04AAD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6FF21479
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S9Cy/p1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfEGGKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 02:10:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38252 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfEGGKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 02:10:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id 10so8081878pfo.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 23:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=kSx/2bQ8k2nUJmyS2liy45fCcO2iYHSDnrOKKw/RGV4=;
        b=S9Cy/p1GeoEOtS8YQZgB0lYyFi1dHKS/HGpgplRm+Jl+6OwdRLa3AqzF/D5EUzwLum
         6hKH5eF/hHqGo6nqyFFDunpeoF4PfUOZ4/3aiB1lh7Zg+TO0UrCiOOaD7NClpHGZAiY0
         TW96Fv/P4Z05tGlR7xVhb505XEaI4omMP478SFFOL/CUS/3EEQurGtDg+8HfcBpLYr8W
         Sk+/f/aBON9i+QLuBzR1USCQJWELEUjdKzeNLt2a/DSVGTvrqPvpmw3vwNaYio7Muj4g
         1s+6KN1usY/566XMORgT84favpF5luB63k/rnOCSRzVpCQhtbAJPLNl4Coh1vz8pOguZ
         +IIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=kSx/2bQ8k2nUJmyS2liy45fCcO2iYHSDnrOKKw/RGV4=;
        b=UX14eARs7lWm8IdNL/DgVpFaht2oI9BAvAWk2MIo5LZF9dt4FdLqPP2LOkg0or48zK
         tvKU5GGb5+6ls3hcrsqMo2oTdnxQGgZwEdy8q+kqNxC+Z/g9lqljg4AyT8Dt/QI+WB9a
         Dj/8CKZwOQlXnylbtWw5bHwtbNJ15nxWVVbSwBqtyPIUqMbNqZC6aF+fO6x0m8IRfRIU
         +1o6ixZRuJV0Mw/S6MsgNmfKR0/3V4PyMJ182GQHjkG7AEzshv3dG1SfpZfc2CW8XaF0
         tplfoQGKXHqHTnAWGzlw4Kuh+CanGmmcMP2/noCQVpwe4quOPSt/htTNMHj8u9SYw91h
         OTpQ==
X-Gm-Message-State: APjAAAWv+j2IfzWBhgBVPq4mXUZPA1GxG4fHBXstdkYFutCSRq6tcqbV
        99bToFMb2frQsvmxdnKj9XTdrA==
X-Google-Smtp-Source: APXvYqzZDYlq7eyLwOtGEhDSsOmFAWA99COPckp4Min5Ajit5tRyKl66VcQ9loYKdX1dxZ/egVqG6g==
X-Received: by 2002:a63:1706:: with SMTP id x6mr4603838pgl.280.1557209449086;
        Mon, 06 May 2019 23:10:49 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e184sm30786325pfc.102.2019.05.06.23.10.43
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 23:10:48 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Zubair.Kakakhel@imgtec.com,
        wsa+renesas@sang-engineering.com, jroedel@suse.de,
        vincent.guittot@linaro.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 8/8] dmaengine: sh: usb-dmac: Let the core do the device node validation
Date:   Tue,  7 May 2019 14:09:45 +0800
Message-Id: <6dc4f90df68276e6c21f7e0087b91e95b153f85f.1557206859.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1557206859.git.baolin.wang@linaro.org>
References: <cover.1557206859.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1557206859.git.baolin.wang@linaro.org>
References: <cover.1557206859.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let the DMA engine core do the device node validation instead of drivers.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sh/usb-dmac.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
index 59403f6..0afabf3 100644
--- a/drivers/dma/sh/usb-dmac.c
+++ b/drivers/dma/sh/usb-dmac.c
@@ -636,9 +636,6 @@ static bool usb_dmac_chan_filter(struct dma_chan *chan, void *arg)
 	struct usb_dmac_chan *uchan = to_usb_dmac_chan(chan);
 	struct of_phandle_args *dma_spec = arg;
 
-	if (dma_spec->np != chan->device->dev->of_node)
-		return false;
-
 	/* USB-DMAC should be used with fixed usb controller's FIFO */
 	if (uchan->index != dma_spec->args[0])
 		return false;
@@ -659,7 +656,8 @@ static struct dma_chan *usb_dmac_of_xlate(struct of_phandle_args *dma_spec,
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	chan = dma_request_channel(mask, usb_dmac_chan_filter, dma_spec);
+	chan = __dma_request_channel(&mask, usb_dmac_chan_filter, dma_spec,
+				     ofdma->of_node);
 	if (!chan)
 		return NULL;
 
-- 
1.7.9.5

