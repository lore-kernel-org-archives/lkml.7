Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC93C3A5A3
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 02:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3EC20674
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 02:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQm8I160"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfH1CS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 22:18:56 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44892 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfH1CS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 22:18:56 -0400
Received: by mail-pf1-f193.google.com with SMTP id c81so608891pfc.11;
        Tue, 27 Aug 2019 19:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R1Q7WwmlwNOy5BbyDBo69OlcwTbVn9JVSGBQ2CRv1xY=;
        b=aQm8I160NpiG2BuIcCpq8UahmWPQvTZzKjN9zrQ0jzRbH6HUq52W548WtFOzn0a+fo
         Isf5fr6FJdMVV8P+J9phqkDfS19TnxGkdGE8LGhSBxsyzI8GQ8o6gt1Cif/Qg7Rbjy4O
         q0+wwzgSaFnRm6uCUEXZxe/BEUZSBvHdqlMBWSuSB5NSyQuUP/l8godEiYhhwo9ibqPa
         oYPukSNAbpUEc1HJ/UrfbauDxvm7mJmIMaCqUFFVWmOAvL4bjvAe66KxK4HzZxifv8ps
         nfQ2M69X+kyhxUcU0MF3JeLHYceRF9nsozqZXLJhBsTSTZ1xU+qPG1dPwq0gx/Z9XTVw
         drgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R1Q7WwmlwNOy5BbyDBo69OlcwTbVn9JVSGBQ2CRv1xY=;
        b=aiagS+JTaTHIzVdx7eqOn9JhhTYNhzhaE1zf8TZQbMN1VXBJ5NodkZ73yUo26zHOzO
         1pQVDzlChgcM2qLegxURjbiqZkCTMe9JE4DdOTIY8pzBfEF4A3QQdsOScfKF7uVw/KDH
         XhWs8CZGY3VAF5ixUxY/fYl7RYnmpx3U1rkX9QGRQIzuZ71ukLUae2fFnJXab3UQEIWW
         LFgNK2VWfBFhITFRpf9y1WYB1DvsetPkaYYqY4TKDGSYPcjznWvTCTDEBI8Us9xTqMfM
         egD4l21/4MIvnhVwHFzZhbEWO+L1NW1/rNqmprLbL+pr9AD8qkRnNwbR34eJXJ94c8Aq
         FeBA==
X-Gm-Message-State: APjAAAXo6U+kjRTwaMlTMKLifl5t6GGaqyuBWBSF6SsjuiRi3XRlkGdp
        jMs80SyZ0fYezwGLC60AVKY=
X-Google-Smtp-Source: APXvYqzgSBnJ0dIcy//L5pO0ndvYQbwKUE2rbQA6gzpX7b3JkIyRra8ZE3cQq/CFpWgcfNM40FqQ8g==
X-Received: by 2002:a62:e401:: with SMTP id r1mr1949847pfh.193.1566958735868;
        Tue, 27 Aug 2019 19:18:55 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id b18sm673249pfi.160.2019.08.27.19.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 19:18:55 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH v2 1/5] mmc: sdhci-sprd: fixed incorrect clock divider
Date:   Wed, 28 Aug 2019 10:17:32 +0800
Message-Id: <20190828021736.22049-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828021736.22049-1-zhang.lyra@gmail.com>
References: <20190828021736.22049-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

The register SDHCI_CLOCK_CONTROL should be cleared before config clock
divider, otherwise the frequency configured maybe lower than we
expected.

Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host
controller")
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>
Tested-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci-sprd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 6ee340a3fb3a..d5871865a1e9 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -217,10 +217,11 @@ static inline void _sdhci_sprd_set_clock(struct sdhci_host *host,
 	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
 	u32 div, val, mask;
 
-	div = sdhci_sprd_calc_div(sprd_host->base_rate, clk);
+	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
 
-	clk |= ((div & 0x300) >> 2) | ((div & 0xFF) << 8);
-	sdhci_enable_clk(host, clk);
+	div = sdhci_sprd_calc_div(sprd_host->base_rate, clk);
+	div = ((div & 0x300) >> 2) | ((div & 0xFF) << 8);
+	sdhci_enable_clk(host, div);
 
 	/* enable auto gate sdhc_enable_auto_gate */
 	val = sdhci_readl(host, SDHCI_SPRD_REG_32_BUSY_POSI);
-- 
2.20.1

