Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D98EC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 02:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918272053B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 02:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lq9PdVaJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391246AbfIFCa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 22:30:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38029 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfIFCa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 22:30:57 -0400
Received: by mail-pl1-f193.google.com with SMTP id w11so2356248plp.5;
        Thu, 05 Sep 2019 19:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bsBBaQCwC1K7f7nPpRPamyzrfm3OUMCwJTP3+3GPnBU=;
        b=Lq9PdVaJYwXMc5V8oaUrkt16H+GBnYxx4VScdKbcw2LuIV4+CVuAXLpvrxZBJrbnoC
         3uhzl3/63DyGxIVcM/TAkZ91+/2u4tOkJCGH3BpFLkNGxZdCCcjIFQ4Bjv+W5QeCff4c
         DkAhNpermZi/NRSagLmqSP5UDha0P0P7IEGJJerMbPZot7IWbnvNkcNk2AsDsbWo8ZSz
         eiVNL/bIHf1lh1VG1GJ1g4nOhDNn/x15/gi/TtHs06e544MLkDJhYxC/ebs7pgR2XrPe
         ArzBfp45c+z7b55c+GnWdpMa175TfxULVekKnApNKC74RV6ImmCbVA7iUx5fttZD3Hyo
         GSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bsBBaQCwC1K7f7nPpRPamyzrfm3OUMCwJTP3+3GPnBU=;
        b=IDEgnfaOJim/Lzw9MXVXRyrgugJB1IpJCG004WOZzF2Zo3fnp3GEJkXL2/PRCKiD++
         q+NXOd67yIxR+3U5HKlJKGvIMruoPx1bxAwt24sA4cjgcq94vfcP0uv/n5bzHjLDdssb
         Tdsu4wuEyZkdk1gFcXPbW/9NLcfI9UOo2tL+kuoGM/l/5m72aVl7YjuKtQH4FJus9B/x
         ZtWstXRGpNoPVfs0KID7sc9p4qNhBa/eQRiYeAlxslT1McPjUwrq7hKAUvq89zzU0EaG
         2KkNkj4MPpdhyxQHbhYMDgYlb7UWmvKEzcgIcFUn9ShJwjIseToa0HtWGVyNnT1cXOsG
         SPWw==
X-Gm-Message-State: APjAAAVI+0H1WaSHjb6brUbIEVR7mCUM2Fi6lQWLs154l0rGNIFQ/uE/
        ObWM5rY7PumPCoE9PxrC5TI=
X-Google-Smtp-Source: APXvYqxoxw+3o9j7fMXe2GWIV41M865vHkQ0QGF2Y1hqYHo3O0KZNCeIR4W5jK0DNG6BYvm4bsAE+g==
X-Received: by 2002:a17:902:30d:: with SMTP id 13mr6953820pld.284.1567737056988;
        Thu, 05 Sep 2019 19:30:56 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id i190sm18146pfb.71.2019.09.05.19.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 19:30:56 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnsonm@danlj.org, ben.chuang@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH V8 2/5] mmc: sdhci: Add PLL Enable support to internal clock setup
Date:   Fri,  6 Sep 2019 10:31:05 +0800
Message-Id: <b6701eb41e7558b2d19b31eb20a3f7d39b06e5f6.1567734321.git.benchuanggli@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1567734321.git.benchuanggli@gmail.com>
References: <cover.1567734321.git.benchuanggli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

The GL9750 and GL9755 chipsets, and possibly others, require PLL Enable
setup as part of the internal clock setup as described in 3.2.1 Internal
Clock Setup Sequence of SD Host Controller Simplified Specification
Version 4.20.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Co-developed-by: Michael K Johnson <johnsonm@danlj.org>
Signed-off-by: Michael K Johnson <johnsonm@danlj.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 23 +++++++++++++++++++++++
 drivers/mmc/host/sdhci.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index bed0760a6c2a..9106ebc7a422 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1653,6 +1653,29 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
 		udelay(10);
 	}
 
+	if (host->version >= SDHCI_SPEC_410 && host->v4_mode) {
+		clk |= SDHCI_CLOCK_PLL_EN;
+		clk &= ~SDHCI_CLOCK_INT_STABLE;
+		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+		/* Wait max 150 ms */
+		timeout = ktime_add_ms(ktime_get(), 150);
+		while (1) {
+			bool timedout = ktime_after(ktime_get(), timeout);
+
+			clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+			if (clk & SDHCI_CLOCK_INT_STABLE)
+				break;
+			if (timedout) {
+				pr_err("%s: PLL clock never stabilised.\n",
+				       mmc_hostname(host->mmc));
+				sdhci_dumpregs(host);
+				return;
+			}
+			udelay(10);
+		}
+	}
+
 	clk |= SDHCI_CLOCK_CARD_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 }
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 199712e7adbb..72601a4d2e95 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -114,6 +114,7 @@
 #define  SDHCI_DIV_HI_MASK	0x300
 #define  SDHCI_PROG_CLOCK_MODE	0x0020
 #define  SDHCI_CLOCK_CARD_EN	0x0004
+#define  SDHCI_CLOCK_PLL_EN	0x0008
 #define  SDHCI_CLOCK_INT_STABLE	0x0002
 #define  SDHCI_CLOCK_INT_EN	0x0001
 
-- 
2.23.0

