Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E68C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5156E20675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gpuzGeOz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfEGGKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 02:10:19 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43789 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfEGGKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 02:10:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id c6so2872192pfa.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 23:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=fegqHJdxTxrNP4emVZDAfoflYxMDA5HIYSCVsGvvNyk=;
        b=gpuzGeOzJL+S9gtU42ApMv5X8chVRN0hkaUIvi7zD8VoJwnOqdqmXq7dtEBURIpA7j
         G/9Ev+cBM6PV3Go/z0mD8a8YNo5qNaDn0y4C4vJmag/YvzNjrhKByuxYlaoJr0TbQ5eo
         2nfWjzDy/wFJLus92xSxL6b1c35GEBUadXry11rD/4luRTR0OTnpL1BvwojJFoJbTZ3q
         qWa5bLbGM9gj9Fx9aaKvHXZ3P3VInHnxnX37d6LK/Ysm/eB1ph8aMLSOBxn6e7x3Zz1j
         uw+pixeKEBnvOiks2g0sUhhj+flFxFWtez0II53gaB23VlKlK7kIVnWRfR8jUkae/ejN
         WMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=fegqHJdxTxrNP4emVZDAfoflYxMDA5HIYSCVsGvvNyk=;
        b=GLkW/UJF98gVHx1X+5RLKIF7wUeKYt2Mps8451mnF13gt3t7KLt+9zAKND9bZ60Nkl
         ABo+HQqKKerrPkEIybE4gemDeAPdH0+WONoU7KH4oXVbk3y5PW4GEC1PQZ0wW7zCL90o
         8r41GdhzucordYCQAD7cd6DBgn0X556zbAmuF0FV4kxW9FR6uGOegluUy5P8o8nl0x3C
         ArrYhKZsnrYj1U9sANkUAJZ537mB/l/p8EyHsdzMr2oNLvKg18zmPlh3Ko7nBHk1Jjie
         VCqKUOcSBOazb5YtX8eIOvK5XaujOX48PoEko49fY7R+iV32J1JFaPOzjptGYT/OUWQv
         uYow==
X-Gm-Message-State: APjAAAUyafoYivX71l1YomCohGW9agfY5lfibVZaXjs6Yz1mBeGOFg+t
        Tmj15IaY0INHTd/ChBOnogCk6Q==
X-Google-Smtp-Source: APXvYqzTNghUUH/vAVAHLtApBnwfwTv9iOi8rSX6GEZxoSO4Ljp5Aibele+BPHXO5ocKnwntiyTY2w==
X-Received: by 2002:a65:5184:: with SMTP id h4mr37881601pgq.109.1557209417270;
        Mon, 06 May 2019 23:10:17 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e184sm30786325pfc.102.2019.05.06.23.10.12
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 23:10:16 -0700 (PDT)
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
Subject: [PATCH 2/8] soc: tegra: fuse: Change to the correct __dma_request_channel() prototype
Date:   Tue,  7 May 2019 14:09:39 +0800
Message-Id: <1ddb1abe8722154dd546d265d5c4536480a24a87.1557206859.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1557206859.git.baolin.wang@linaro.org>
References: <cover.1557206859.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1557206859.git.baolin.wang@linaro.org>
References: <cover.1557206859.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we've introduced one device node parameter for __dma_request_channel(),
thus change to the correct function prototype.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/soc/tegra/fuse/fuse-tegra20.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra20.c b/drivers/soc/tegra/fuse/fuse-tegra20.c
index 49ff017..e2571b6 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra20.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra20.c
@@ -110,7 +110,7 @@ static int tegra20_fuse_probe(struct tegra_fuse *fuse)
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	fuse->apbdma.chan = __dma_request_channel(&mask, dma_filter, NULL);
+	fuse->apbdma.chan = __dma_request_channel(&mask, dma_filter, NULL, NULL);
 	if (!fuse->apbdma.chan)
 		return -EPROBE_DEFER;
 
-- 
1.7.9.5

