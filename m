Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A019EC3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 00:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72718217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 00:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuztGt+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfH0Acy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 20:32:54 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36765 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfH0Acy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 20:32:54 -0400
Received: by mail-pl1-f195.google.com with SMTP id f19so10858364plr.3;
        Mon, 26 Aug 2019 17:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=189g0JP68z9u+Ep1GWrcVIMocc6+TBCdAX4Yd+2DXKM=;
        b=KuztGt+nXT1gTEb5csKxCYy4+7BmsyakHzvzGyMtFyRqmTySJrI0NB05w5Fuz9nO48
         Llgge4WwGN02rS9wUnnTdnQ/8KTvKkSVAK65Xvz5ruXm9HJ/x1L8jehOEu+pr3Jswa54
         zxMllUu66M0CF70bAOEpGjK/3v9U9Jk77jgDAboFs3uCWkTdLWejqzFeJULd0F7pPcr6
         UlRxO4l5oBhdnM0UBeXqxOcYZV8N5GzwoAt92jTFDJWGTaer2jdvopGcTkdP7Hsou0gA
         lkrMHx0BxVijrWQ12Br1pQ1jJdTf+Onhh3C1RgDPJdei85GLeIvbroXUB+2PDB3DPSgq
         ormQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=189g0JP68z9u+Ep1GWrcVIMocc6+TBCdAX4Yd+2DXKM=;
        b=n19u1XSsm0hIZVvdPB8vvBY9RqSIdtkDlEI4Oi0nprZ/IZlBzDdAaSYUsjBIDqFbu3
         Ho5G+KNW+F4sivtBkEbciW4vtVkTW4rMlUbNdrLl6P8U7BSkb5nU8HSX7DmJMIN7tfT8
         2lHDEP/DBGW77KfzhmDG5/T7ZsYpUVrvDG14jl+bcIUP3Z/6XCsyGmyif9S/WH4ys1If
         kw2IRx52259qE10XGQKxPSL4XWIlX9f5B/0hOoXEeugC/o+GsUVZBU2yAKx6kih/6EHI
         3u1QyAd4jZiwfTJeyNOCVe7eLTG/m6Ql4eTHyFP5K09XTeNQCSf2GW40b9AlUD5Mf8mh
         hIQg==
X-Gm-Message-State: APjAAAXO9Z9iPkE44ZdzXObvMLEtKbCp6fP8Vk0YzSgUkkTesAF2S7V/
        xZD8aeH9qrEp5pd7yJLpwQs=
X-Google-Smtp-Source: APXvYqyNdNPY19KQGF32db9ueEkPRVWw5IgAFygk1tLqn7BQl/o/Or77fI0K590F0VOLTbX0RU66mQ==
X-Received: by 2002:a17:902:5c3:: with SMTP id f61mr20153314plf.98.1566865973709;
        Mon, 26 Aug 2019 17:32:53 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id l7sm7444220pff.35.2019.08.26.17.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 17:32:52 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnsonm@danlj.org, ben.chuang@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH V6 2/5] mmc: sdhci: Add PLL Enable support to internal clock setup
Date:   Tue, 27 Aug 2019 08:32:55 +0800
Message-Id: <20190827003255.2347-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.22.1
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
2.22.1

