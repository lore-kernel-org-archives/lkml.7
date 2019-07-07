Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61658C0650E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 23:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B322070D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 23:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2JE/yvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfGGXEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 19:04:36 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36674 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbfGGXEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 19:04:34 -0400
Received: by mail-qk1-f195.google.com with SMTP id g18so11916057qkl.3;
        Sun, 07 Jul 2019 16:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HhDnJKh/3Ha8unreHKtqNEp30E3pACp0xd02dRvGJ6k=;
        b=Z2JE/yvEAozbhlCiPL3kID+pj9QiNBAAiRH4eCTFAZTGV/S2UFjN2h2Gki9/NgXgiR
         Yuko99gqBb0AorcCm3hjUC9jYhmuTeT5X75wMtRCZ8vyDApPGNEov+LetqcT/tPLfpmS
         9GgeyNmf2vUuF4cMcKU0izgXSLgmbNN7PdFQ2Pz91LX51UOuLviOIA89+eJEy1jyl9h6
         BAHpLKYNmSP+a08twGbdxm3XlYWZcrFU3Gc6cGhTtjqdpenIskmHELLQIjFhVT0g5qYJ
         dszQ0ilcPXF6QzPG3/NKuOpwr8svkPD1jGW0vTynYYhV8mVin0zIl2K6TLWZxVw8uH8O
         R6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HhDnJKh/3Ha8unreHKtqNEp30E3pACp0xd02dRvGJ6k=;
        b=o3dhmreLI0+M7wH9X5vJsL+WcFTU6ltC0aWVzeG+KqjrIBpMzEusWpOgtM43uQjcwa
         /j/0N4hxGMTq9e9CF1JeCmzRzQ+FjrX8dZWKijx+HrKCF0R3+7dR8gAfRHrfNm3uBlv5
         AGYYUNFtTMwJz2uTtA4pZR9pXcEI9v2r+Gi3VjCpPtee5LwcK5ahx0M3kjdcget5qfLE
         0xjtEMsQJ/T26QfRDnaeJzipFfNc9GLvdH47W5j96g3t1lsEhwxdxFt30HFfWPZP0BUq
         6xnNh9Hmc7n8JFLXLczKAfdWpOAvEBsHCgG+h52puIGm+9ZMNJbg0YdSY8ttI0guYBCC
         6akw==
X-Gm-Message-State: APjAAAXNWX3KPoQzEFP7b591JJUPg8JbmHpAxOhtmGg3la9Vd0+LCddw
        0atZYcM3ZgE77/glYLYKk3KTC5yK
X-Google-Smtp-Source: APXvYqzRiTSNA66eoQqutiK8E0GncAOIbDO5QPv+S5I1Oxl2PkkYT6wVXaPGbWQ8KpQq5eHPbXOamQ==
X-Received: by 2002:a37:e40b:: with SMTP id y11mr11946657qkf.88.1562540673673;
        Sun, 07 Jul 2019 16:04:33 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id g22sm2788420qtr.95.2019.07.07.16.04.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 16:04:33 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] ARM: tegra: Use WFE for power-gating on Tegra30
Date:   Mon,  8 Jul 2019 02:03:58 +0300
Message-Id: <20190707230358.10672-3-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707230358.10672-1-digetx@gmail.com>
References: <20190707230358.10672-1-digetx@gmail.com>
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

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/sleep-tegra30.S |  4 +++-
 drivers/soc/tegra/flowctrl.c        | 19 +++++++++++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index e95e46d65e8c..2e42f2bc0630 100644
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
index b6bdeef33db1..b62ff4c1b997 100644
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
+			 * hence use wfe that is working perfectly well.
+			 * Note that Tegra30 TRM doc clearly stands that
+			 * wfi should be used for "Cluster Switching",
+			 * while wfe for the power-gating just like it is
+			 * done on Tegra20.
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

