Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4186C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744CA208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYJdqV50"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730762AbfG3RYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:24:20 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46615 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730703AbfG3RYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:24:15 -0400
Received: by mail-lf1-f67.google.com with SMTP id z15so41036142lfh.13;
        Tue, 30 Jul 2019 10:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b+B6WL/Mm5Gfj7Ncn0tXPPFbZ6O1gNJ677UNpoqOzb4=;
        b=hYJdqV50me0Z9LIdMcr2Yt/NUeD1qzNq/EJ/XPcfa4N2919j7hN3oVhfzSs7GEl9TB
         uQx+G8VoPAKfDYFwGnzMqkB/72fsZ0CfIvu7fwwYr72a0TI+Uyc7lvvO4zFD2ggoBVBK
         u7oZRLwBFX+kbpv0ZNzshvreXj1nM1egHCZXdMPv+dlO0mzzaDC+bcATx12WkEnMQY2S
         7iR9GDmKN8TtQuWWEV/5b9Eg9Jy1aOt7voz649s3a+LVMvW5vCllyKory7wijPfKSp96
         5MbVrKAWTryDC2WJm4JdmddbDTr8XsIosoJip0DatpmblrPRdzlt1fJM23SAGUnJfRzL
         mFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b+B6WL/Mm5Gfj7Ncn0tXPPFbZ6O1gNJ677UNpoqOzb4=;
        b=OMrZbcIXZ8Ux9TDo1VJ5OE2fmINmzgftR5pvaLW2IOxidb+LH6s55BeuQ36IkSOori
         jG0mQSbRfr4iqD4ofGqIr9VXC3jbZ3oYAcxxHcMLFdRbGdSvDZwKx1calFP8D5vCH2pA
         ycRtxS2P35wqll2dEXOr8DWZmRMFGLmbVCh9FLXT+3vouibaHIBWdEgInfhYkKjoiUI2
         tenM2E7xHkl0XlusuCzw/gU7jn3XLCOImUa/xgjwFria0JRcJLXDlNMiXkTn0h68y0yW
         bcdSPCAmQ4Zfzbc3QI7DTDg+XXedwCPGrWQCUAx/v6HUb1Bu8fUw7k0ziMyLJR3NDEpy
         wQsA==
X-Gm-Message-State: APjAAAX8ipmSsSYTyNOSHkXp5KKmA0SknLslQkIiN/ZAUUG5gKnjN5sC
        NJiePRzxoNwJMq0O9rCplHA=
X-Google-Smtp-Source: APXvYqwYFp5syPBqan4DsGyDHstS6GiCFJI4WqfTbURhiAjMn5P8Os8pIXoFfSJ1VoMaPr+3yFcT5A==
X-Received: by 2002:ac2:42ca:: with SMTP id n10mr37481007lfl.121.1564507453058;
        Tue, 30 Jul 2019 10:24:13 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id c15sm13345252lja.79.2019.07.30.10.24.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 10:24:12 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ARM: tegra: Use WFE for power-gating on Tegra30
Date:   Tue, 30 Jul 2019 20:23:40 +0300
Message-Id: <20190730172340.14037-3-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730172340.14037-1-digetx@gmail.com>
References: <20190730172340.14037-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turned out that WFI doesn't work reliably on Tegra30 as a trigger for
the power-gating, it causes CPU hang under some circumstances like having
memory controller running of PLLP. The TRM doc states that WFI should be
used for the Big-Little "Cluster Switch", while WFE for the power-gating.
Hence let's use the WFE for CPU0 power-gating, like it is done for the
power-gating of a secondary cores. This fixes CPU hang after entering LP2
with memory running off PLLP.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/sleep-tegra30.S |  4 +++-
 drivers/soc/tegra/flowctrl.c        | 19 +++++++++++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index 6c28395d8c75..17f7a2a6a494 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -683,10 +683,12 @@ tegra30_enter_sleep:
 	dsb
 	ldr	r0, [r6, r2] /* memory barrier */
 
+	cmp	r10, #TEGRA30
 halted:
 	isb
 	dsb
-	wfi	/* CPU should be power gated here */
+	wfine	/* CPU should be power gated here */
+	wfeeq
 
 	/* !!!FIXME!!! Implement halt failure handler */
 	b	halted
diff --git a/drivers/soc/tegra/flowctrl.c b/drivers/soc/tegra/flowctrl.c
index b6bdeef33db1..eb96a3086d6d 100644
--- a/drivers/soc/tegra/flowctrl.c
+++ b/drivers/soc/tegra/flowctrl.c
@@ -91,8 +91,23 @@ void flowctrl_cpu_suspend_enter(unsigned int cpuid)
 		reg &= ~TEGRA30_FLOW_CTRL_CSR_WFE_BITMAP;
 		/* clear wfi bitmap */
 		reg &= ~TEGRA30_FLOW_CTRL_CSR_WFI_BITMAP;
-		/* pwr gating on wfi */
-		reg |= TEGRA30_FLOW_CTRL_CSR_WFI_CPU0 << cpuid;
+
+		if (tegra_get_chip_id() == TEGRA30) {
+			/*
+			 * The wfi doesn't work well on Tegra30 because
+			 * CPU hangs under some odd circumstances after
+			 * power-gating (like memory running off PLLP),
+			 * hence use wfe that is working perfectly fine.
+			 * Note that Tegra30 TRM doc clearly stands that
+			 * wfi should be used for the "Cluster Switching",
+			 * while wfe for the power-gating, just like it
+			 * is done on Tegra20.
+			 */
+			reg |= TEGRA20_FLOW_CTRL_CSR_WFE_CPU0 << cpuid;
+		} else {
+			/* pwr gating on wfi */
+			reg |= TEGRA30_FLOW_CTRL_CSR_WFI_CPU0 << cpuid;
+		}
 		break;
 	}
 	reg |= FLOW_CTRL_CSR_INTR_FLAG;			/* clear intr flag */
-- 
2.22.0

