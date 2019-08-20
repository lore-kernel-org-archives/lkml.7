Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54701C3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26FBA20644
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2mF/Qkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbfHTCG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 22:06:27 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35156 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfHTCG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 22:06:26 -0400
Received: by mail-pl1-f194.google.com with SMTP id gn20so1892384plb.2;
        Mon, 19 Aug 2019 19:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yVYu9hmEdA0HGmWZ5vmto49b1VgMTPaD/kMUSIHjxzo=;
        b=q2mF/Qkz0j9/DhdmrAsPYXps1ET9UZ0HRCaz/e1ehZWkt1yimeXTHTZMW/JvDsomkg
         hBNwMIG15fkyNpzTNxICvKekLlbujUjDpa/tEJoLKykQ8N9s+C9JSz1fM3MIBmB9PRwQ
         t+E/GTCRlM04Ggq3o0udwfS1cJL7S6LlP6FRbe75Qi+Wfb/VzVcmRnONUJj7LMWorUTi
         eQamt0PgCWO9LUrlEsn4x56Sx0n64vb3e0pT7SBM3efWj/8YBY/l75Vg9Vqx20ndXDQX
         euHf9qVZxT3v30yRkipEckFUQB/JVVRDL43dOYfS1JWD6HGHi8QlAkuSMLuUKCX9R8AO
         GLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yVYu9hmEdA0HGmWZ5vmto49b1VgMTPaD/kMUSIHjxzo=;
        b=uFBNqQkb15ao/0mSOOyCTX40kY7hdoXxVrSOMIRHO3nTZbBgihzCLd9+OxeZ+iwYTl
         qzE6Jad2b1xf3KMhIkNXkLvBUz5v8+/yR7YxQfiXXoQQ0a2RVB8g0fgpIpm3wjEERMu2
         T+bGktOUJQS61mpByp/ld4t0BOJ/kdQaBOuzmz7TVnMv7QmIvKvyRBhw1ZcNLpdb3qi4
         wd5C17UjeYX9UIpkH143oD1ry3LR3gRD9pOI6EuwV+S3DiKY7mEgX8Ic1xOYzvEJa1YF
         1U02XpQDIq5ShfO+5Ls8CsL7BvqWCq/N7M1wQ/9WkU2jmoFNYRF9ndbcnreHzN+ohFtZ
         HILQ==
X-Gm-Message-State: APjAAAXUiLVZewr5HDpvrR336dDvN8ya7qsztWolWDD2tmGxGMJhqRCy
        7d0jtelmpWV0TSzC6UajJjs=
X-Google-Smtp-Source: APXvYqy0Vi/I3kVS6yTtR5WbhIHGAZWn4pLYpBmipdo/UUlxnWlwHp7czXSEqWeeMvvpnPEEcsbIdw==
X-Received: by 2002:a17:902:1c7:: with SMTP id b65mr20001249plb.313.1566266786276;
        Mon, 19 Aug 2019 19:06:26 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id h195sm24166137pfe.20.2019.08.19.19.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 19:06:25 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnsonm@danlj.org, ben.chuang@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH V5 2/4] mmc: sdhci: Add PLL Enable support to internal clock setup
Date:   Tue, 20 Aug 2019 10:06:36 +0800
Message-Id: <20190820020636.8279-1-benchuanggli@gmail.com>
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

