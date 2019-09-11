Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E64ECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7297C21928
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOa47PqY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfIKHWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 03:22:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46356 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfIKHWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 03:22:45 -0400
Received: by mail-pg1-f194.google.com with SMTP id m3so11035397pgv.13;
        Wed, 11 Sep 2019 00:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bsBBaQCwC1K7f7nPpRPamyzrfm3OUMCwJTP3+3GPnBU=;
        b=TOa47PqY/EJ2uUx/RG/nWlpKJYh8LyN32mcJUK/VScoTn6hHB3uEOr6Q7elpW0O35Y
         wUjUphKzvuRoixYzHCT7MO6hzQzmpXSxpdZ8/eiC/JhbF45ZfM9WAd2AxWXwKHZrtEaV
         DTCJuZia2EbXmqfSQITpgn8ap/7iHCV27hQpOXDvox3JjnkNTJoH0aL82MxKWfNoklNL
         vGYynuzYElBTiw1kW9MOBCHOL/oNRxyrjmtHgFCSK6WxpYNu7ASMCdTCGjvpnggH9cy5
         imdbIU/mBPIy0zy1lGkGIj1njA6XpYp9ISLVDA5lPvEtN3skSe8frg+C6DZY4k6+57si
         scMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bsBBaQCwC1K7f7nPpRPamyzrfm3OUMCwJTP3+3GPnBU=;
        b=pkaTOt4kF3/GwphGgjuvI29QzsnzCAB9Q0AAjyohIpvGmYkLXwd6UexCEnrTS0Gs9u
         nxzQu0KWmLAg6TrTJ2bi3G+GBZiP/ZMD54RgrE0cBCiqyf1t7xyw4SpZlKE5TCnaBbK1
         rnUgaUCbTYygitzLmFhKhTVlgR3jGRd/90X9AQKeNZm4611/s6lqcO5A6JIP8nbrd4yj
         /tQ1A9mSVE2jXx5VwYcHLQqNqykumMt/6qU2w6PQfjVshB4l9iJAnjKYftt/nyBumXyF
         vzhAtfD+yLF4nlqYnZtO3ueLBtiy36CfuPp8+mwrZOhCFM1f3+Huk/AQJ9YSIQ67Lkhn
         +0iA==
X-Gm-Message-State: APjAAAW5OQqKvdjaAt3voKzJz4alurJAclWUi8nMHapXrsq7YsjYEo5n
        sXYkyguae0e9jLMhkKQyVOc=
X-Google-Smtp-Source: APXvYqy3gYoy4ykaSNVVN0RlnHzxLN1uwoGZ0ilR2f6kFpF18m1tuoe8eHiTLjrwam/XV0V4n3UVXg==
X-Received: by 2002:a63:f357:: with SMTP id t23mr32221336pgj.421.1568186564742;
        Wed, 11 Sep 2019 00:22:44 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id u65sm20878456pfu.104.2019.09.11.00.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 00:22:44 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnsonm@danlj.org, ben.chuang@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH V9 2/5] mmc: sdhci: Add PLL Enable support to internal clock setup
Date:   Wed, 11 Sep 2019 15:23:01 +0800
Message-Id: <b6701eb41e7558b2d19b31eb20a3f7d39b06e5f6.1568184581.git.benchuanggli@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568184581.git.benchuanggli@gmail.com>
References: <cover.1568184581.git.benchuanggli@gmail.com>
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

