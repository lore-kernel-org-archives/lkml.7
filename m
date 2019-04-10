Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6B7C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49EDF2083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TkhvHLwM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfDJHsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 03:48:11 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39700 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfDJHsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 03:48:10 -0400
Received: by mail-pf1-f195.google.com with SMTP id i17so946046pfo.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 00:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=skXQPHyDnnOMLPLPuYFyTD9T90iTaKhdEM7fSMIdTTs=;
        b=TkhvHLwMDsXKGAq0AiPDmvH5yC1SdIcVn6Oazrqv8ASNM8ALILI1m7rMlztC6i4dDV
         4M0++4jdbtMValVSWn83txV7CB5hj3olvE2GOkzebV9y4lvwgrcNO8Oc8ZTnIYg9ubf7
         F8vzG2K7CJodAL0bqEPAVHOXsZQOrSqXH4qgJvBWXOP2uluSrjMLq5IsAMHa546tdE2B
         6RKieD758yfk5Q/yUroKzvCdDf4EYiKXVdcN0HUDoQ4DJIYYyS7AbSvKuvGgdX1Ln559
         RpSu1Z3vAFYWDZ4GHzM4/Ce5gzgtvfCftRqfLOkjvH7Zi9PIOaV9XPUsQTXVXmCRnNpP
         OL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=skXQPHyDnnOMLPLPuYFyTD9T90iTaKhdEM7fSMIdTTs=;
        b=TttjKk3VUYXTXCfYhkPatbja1mInPx7X/4j6KnDdUuG4qZk0mnrIoLeCWysmJi1SRr
         bFi2bsu7TEDEG0c3AQrjHtlvpR04HzTRCAf6Y5EufsLBBuGUiOQes3E15ARJP8zTDa4+
         FvYX1FaVKy36Szl12t6wm4AqAiJ7fRaz46v1hC35oCUlb2UJWliT8SSV218G72fryJGZ
         e0nFrE6Glc922WPQc993UU2Lz8GK2EmxmdV7YsCGEyE8+5Rjjy2vDxRa4owFgpUu2PwG
         MTGG8bqdx4SS5znwSf6aYSdiBL1NT3uR4+BX6vDtasrqCZJctwGYVCR5VY0+il/wFJq2
         FQfA==
X-Gm-Message-State: APjAAAXbBZ1X9ddxMiz58revgw5wCBQZWl4yF+lwU23ptUPC20n4iG+w
        yZryrW87yOsKwIEwSJ60heYhKQ==
X-Google-Smtp-Source: APXvYqxqTeb+EqhxeDU6+0fMPYC52ziiOkECp/pdej0bBIJKPOLM9JKtccNDZMSyvjp0G1F1tFw8TQ==
X-Received: by 2002:a62:69c2:: with SMTP id e185mr41478628pfc.119.1554882489460;
        Wed, 10 Apr 2019 00:48:09 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 17sm46355818pgz.52.2019.04.10.00.48.06
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Apr 2019 00:48:08 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang@linaro.org,
        broonie@kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: eic: sprd: Fix incorrect irq type setting for the sync EIC
Date:   Wed, 10 Apr 2019 15:47:54 +0800
Message-Id: <e7ca1df3b3159d6e1c65c6a2a9f01a7ecabcc821.1554882235.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When setting sync EIC as IRQ_TYPE_EDGE_BOTH type, we missed to set the
SPRD_EIC_SYNC_INTMODE register to 0, which means detecting edge signals.

Thus this patch fixes the issue.

Fixes: 25518e024e3a ("gpio: Add Spreadtrum EIC driver support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/gpio/gpio-eic-sprd.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index f0223ce..7709226 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -414,6 +414,7 @@ static int sprd_eic_irq_set_type(struct irq_data *data, unsigned int flow_type)
 			irq_set_handler_locked(data, handle_edge_irq);
 			break;
 		case IRQ_TYPE_EDGE_BOTH:
+			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMODE, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBOTH, 1);
 			irq_set_handler_locked(data, handle_edge_irq);
 			break;
-- 
1.7.9.5

