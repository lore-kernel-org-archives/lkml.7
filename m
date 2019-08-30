Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B978C3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 02:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE1C521726
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 02:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZkZXYNn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfH3CX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 22:23:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37063 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfH3CX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 22:23:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id y9so3512312pfl.4;
        Thu, 29 Aug 2019 19:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=189g0JP68z9u+Ep1GWrcVIMocc6+TBCdAX4Yd+2DXKM=;
        b=KZkZXYNnsSOYG4pBmr3NpVOqOvf7VPO/THlxI88gRD31nCWIDvzbA3wEhdyF6CqeMx
         s4YmBLm2aN+FmjsRvg8q8i15zKSxJclUqrgQTVy+tiZWOuvEG46tp6993lhhpl+kG//i
         7uVazj0a2Pzzs5r6VD3ZDCgAZjYbiVlRAKzZbgsGO1Lj6A3fTtKCLuXlwfjD37lPa2CV
         EYWMgalEtjy5moP21SSxY9J/ZnwWmGPuGlgEoHm5tXjhUfmIUTvEKFY6RDau1nxan1xY
         tEq4JVUrPHtznWP+gHW7k181+zOT/TVBHJ6ZTkRtdCbqz/6OrP+KLH0MT9Oen5K3qp4S
         ikKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=189g0JP68z9u+Ep1GWrcVIMocc6+TBCdAX4Yd+2DXKM=;
        b=ThmgKEAkisuS63sKy0C5oxkZaHzcev/2aTpdwMbFm6nd3+USchIb/GBsVbEQLG2cJL
         ugfk/4uCxFrzPhjZFWXPFh14Fqloi9ZevoOyzmqCJIOOOafrIxTeK8wZBOrbOKStSal1
         GH7/cTYSB6tJ0ZBQaBuAQbTGLuyAWqcwnvlif6jFGLPtyfEy+4cyZHLeR+fHOzcZ44ju
         LNGCawi/Q6osPPX0TIDB2rOBcVMNs0Udu26HjKCQJisw/9glOcuzmgurhuH46Ge8QIU5
         MWLPGjjoSUdTdyJ/SxEqSzIzj8aUa8RJjQjEHNFnZQGHTx9x4qhXOFUWd1muy7Muny2T
         WRJw==
X-Gm-Message-State: APjAAAUI/zfBQZ6CA2g4ZdD3+T+jS0N6irMwX7qfe6w+HSVjwyPgQQrL
        D9QmgwgpMnyXytbbywkcybA=
X-Google-Smtp-Source: APXvYqz98XE7ZA33vSW3tGTSup6MQ14PIAiPIRYNP8U7FD5EtdNbLDTw2qEr2RUy8sVxZesoZ00FXw==
X-Received: by 2002:a63:2c8:: with SMTP id 191mr10828976pgc.139.1567131807077;
        Thu, 29 Aug 2019 19:23:27 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id l124sm8652379pgl.54.2019.08.29.19.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 19:23:26 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnsonm@danlj.org, ben.chuang@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH V7 2/5] mmc: sdhci: Add PLL Enable support to internal clock setup
Date:   Fri, 30 Aug 2019 10:23:25 +0800
Message-Id: <20190830022325.8348-1-benchuanggli@gmail.com>
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

