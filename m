Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7380AC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 408F22087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zcT6IdJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfEGGKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 02:10:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42917 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfEGGK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 02:10:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id p6so7718894pgh.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 23:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Cnx84NxIhSp4uZgqi6VSWZYaVNVqt10XSPlG8JL56aM=;
        b=zcT6IdJyApB7KuMxuSWwG5peXYnsSHChNqw51B358ycUWDId/NngGMOqGHnT3h3bSm
         qChmgQ9pGa5Yu+EMHMNgnlyKYIB+8jttgce0QhMdtSj38lOgaDPhUawls09xh0d5XiU9
         XcUQsGp7Ng6At2b8JIe5cM9Fi4JL9LcN1RY7mpjCslKb9GSOd5Mhf/HsE8HqngQ8riLP
         Tn/Gs+4flfKLlVDKesVK3VuGQZKXSUi+yaLrRL2c29XWNjnhW/3qUQ/1SZeyFjforxBc
         bUG3zRsnRVBy6oLxJo+88AKeAdIeoUpkW0hyt61HMVCFbY41ZhTb9Ur818qX/RjkvnlV
         3E3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Cnx84NxIhSp4uZgqi6VSWZYaVNVqt10XSPlG8JL56aM=;
        b=a/U5b5HGq42N4iQhnsmVdGuPhE/OaRlxSpTBSTh+ZnVHuyYomvjt+BA9nFtQ0xhj44
         x57B11IJVG6JVwYSMrLq4r86NcRkFJzfY/WHFfeQt1teJ8nixcrkvHytKX9pSsyrwSiM
         b4s+x+htIUYDMp4Rxv+NIRaG0iJd40yEhdbmkg/xa9VVbrozGo6/8nzlBmOaFoxlqQAA
         PXg4evKHZh8zycie1meMTMOyYdD9aTf7D2bAd7+rU93KCC8AfSFZ3s7WQtyhzOW9Le44
         s8tBoPAMHONr40G7UMc+9QOSF0kPc+vuWilW+815VQhvt3aniaixUH9a6TRYAw2jiRzZ
         pzaQ==
X-Gm-Message-State: APjAAAX0b6ubWz2cIR73GKBmG/XsSVfD3aLNC5Sqdv4FxJN7vE9ZoP3t
        VRgaTHRAdXxJ+WmG9u8FIZOzwA==
X-Google-Smtp-Source: APXvYqzkqrYcV0QI2O93YtbQlxdQBJiQcmO6JQgG6k1Oorppv4hJ97iFy40k5ajwk08mkc41nQffKg==
X-Received: by 2002:a65:534b:: with SMTP id w11mr37576307pgr.210.1557209427968;
        Mon, 06 May 2019 23:10:27 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e184sm30786325pfc.102.2019.05.06.23.10.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 23:10:27 -0700 (PDT)
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
Subject: [PATCH 4/8] dmaengine: dma-jz4780: Let the core do the device node validation
Date:   Tue,  7 May 2019 14:09:41 +0800
Message-Id: <0b8b0597623608bee186c573511be127ae5939c0.1557206859.git.baolin.wang@linaro.org>
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
 drivers/dma/dma-jz4780.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 9ce0a38..7e1d381 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -160,7 +160,6 @@ struct jz4780_dma_dev {
 };
 
 struct jz4780_dma_filter_data {
-	struct device_node *of_node;
 	uint32_t transfer_type;
 	int channel;
 };
@@ -765,8 +764,6 @@ static bool jz4780_dma_filter_fn(struct dma_chan *chan, void *param)
 	struct jz4780_dma_dev *jzdma = jz4780_dma_chan_parent(jzchan);
 	struct jz4780_dma_filter_data *data = param;
 
-	if (jzdma->dma_device.dev->of_node != data->of_node)
-		return false;
 
 	if (data->channel > -1) {
 		if (data->channel != jzchan->id)
@@ -790,7 +787,6 @@ static struct dma_chan *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
 	if (dma_spec->args_count != 2)
 		return NULL;
 
-	data.of_node = ofdma->of_node;
 	data.transfer_type = dma_spec->args[0];
 	data.channel = dma_spec->args[1];
 
@@ -815,7 +811,8 @@ static struct dma_chan *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
 		return dma_get_slave_channel(
 			&jzdma->chan[data.channel].vchan.chan);
 	} else {
-		return dma_request_channel(mask, jz4780_dma_filter_fn, &data);
+		return __dma_request_channel(&mask, jz4780_dma_filter_fn, &data,
+					     ofdma->of_node);
 	}
 }
 
-- 
1.7.9.5

