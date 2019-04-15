Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A66C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12B020825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="exbKQxTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfDOMPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:15:34 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34882 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbfDOMPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:15:30 -0400
Received: by mail-pl1-f193.google.com with SMTP id w24so8484570plp.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 05:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=lTV/HwBV1wkVNbsMEdMR98H0jnrUsLsqBHs1N83HCIU=;
        b=exbKQxTI4xxMk74weN1pp2wuWgBFrTV9NGMiVFBHcSOizFz6Pm1jJnsGxfzgw6aiZl
         WTZuVOV27S2Q/kVYJy44QMwfvkZWepHXib3hYamU+tiN/c6VURhf7etsMsdTK1o9qLie
         yNGlyJ6v2Yz3v1vgXciDRK2F/rULdNOQq6GrSAivnwrVe6HeUA/T6mjfNByP14j6smbK
         2Smp0i7gWEX//tj2tce9NLHqnI4U4FGzml63MT5exyr1d8fubsuqsrcHqbQOG7ICSlTP
         fxw1JPFdDt2h8Rr4kaYNFEzpqeXIRZnuD604uXsMxWfqqzHlCNmLHN8py/gbxBb2OFJQ
         VTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=lTV/HwBV1wkVNbsMEdMR98H0jnrUsLsqBHs1N83HCIU=;
        b=a9Vgd8QP4HzwMXrGCddTEmQA+iaQf8UyWtO3GPjGSK3NCjFfOK3K8UiyO8rgH6MbFc
         jtl4ieD3dE1a2FvfUyfOhTuAxq+pMVL4Lctv+IDQh16KRb3wTvvp7Ojo/VA5mmMgxFN3
         5/50fgD0fCwC7UjyJjC1i3WueWkCvR9xi9iHXGDD+669+XSlKC7aXH/nOlnBuifz9uC5
         piY1Eg3akoxEfyZgoZAO03xyFC81B+KSk3M+DXAccZvW4eWPNOi9X8qaPfrSqSybTbFP
         7zURFubIn64EzWa+wyMcln8jsNTDUE3buaMNRzNf0edlSZ6A4zGRPb8uO65lVNK2Lzgy
         dN/w==
X-Gm-Message-State: APjAAAVUS/N+mAPrkNrmqOoR3tez07ZPgmu4nNtaO1BRzUReQbs/YZQ9
        0/HJVBYGYzhgczaOD7tTWaR7RQ==
X-Google-Smtp-Source: APXvYqxyOesy66KaWP5IzQdijN7MfwXi/pMBporGCAAsQQYxbnf4/O/N5kUUgpF51R3icRYVy6aQ+Q==
X-Received: by 2002:a17:902:6bc7:: with SMTP id m7mr27139625plt.146.1555330530070;
        Mon, 15 Apr 2019 05:15:30 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 6sm64157155pfj.95.2019.04.15.05.15.25
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Apr 2019 05:15:29 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     eric.long@unisoc.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        broonie@kernel.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] dmaengine: sprd: Add device validation to support multiple controllers
Date:   Mon, 15 Apr 2019 20:14:58 +0800
Message-Id: <d77dca51a14087873627d735a17adcfde5517398.1555330115.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1555330115.git.baolin.wang@linaro.org>
References: <cover.1555330115.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1555330115.git.baolin.wang@linaro.org>
References: <cover.1555330115.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Long <eric.long@unisoc.com>

Since we can support multiple DMA engine controllers, we should add
device validation in filter function to check if the correct controller
to be requested.

Signed-off-by: Eric Long <eric.long@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 0f92e60..9f99d4b 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -1020,8 +1020,13 @@ static void sprd_dma_free_desc(struct virt_dma_desc *vd)
 static bool sprd_dma_filter_fn(struct dma_chan *chan, void *param)
 {
 	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
+	struct of_phandle_args *dma_spec =
+		container_of(param, struct of_phandle_args, args[0]);
 	u32 slave_id = *(u32 *)param;
 
+	if (chan->device->dev->of_node != dma_spec->np)
+		return false;
+
 	schan->dev_id = slave_id;
 	return true;
 }
-- 
1.7.9.5

