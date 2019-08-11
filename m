Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFDDC0650F
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 18:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A172147A
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 18:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVUdInEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfHKSdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 14:33:18 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54523 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfHKSdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 14:33:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id p74so10231352wme.4;
        Sun, 11 Aug 2019 11:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q8/Bml7WQofU6xEmk9woWoZ9hyJMjPfyaxuZGqKSQtw=;
        b=oVUdInEt67eTaZ5xCaP6Chx0Kdccq1NX2TTzBf1vJCSYiegdUeNkHExiqF1N90QYhI
         H9YtHDoqaPG0BgQB23EX6O7al2AxuUH/l0aENRMc15GzSfHvKE5nwUPUhAEdSXokOeMA
         bLZI2XLXT9Su3EnwUaod0U/mGPgV4NyNQ+bsv8XEJl/JjQo15hm48PjJHQaR0rufExXK
         TgIPmh3N91lqXgoyBMDSL7q/H8eCdHsJhqaQtn44FYtG3vJFNF5zQk8e5oTTPTMQlQhP
         TB7OAQYk+34/HzJiEuJV9egqKXtV8rcv1MRgEhVkz4qvPFxGawCytDMPEE9fB22xxEOz
         nuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q8/Bml7WQofU6xEmk9woWoZ9hyJMjPfyaxuZGqKSQtw=;
        b=SE8RPKMhL/x/Igx3jaZenXT3AktsffaU5H3ahy8ivTOKVOR7mXdPHYMhW8CUu9p4Nu
         /c9QLaHA7l/QJV+YBc2r1USMFsbXqhAlxnXl5R0A7aOu5GZJficZNs+2vTQR76N9AT9n
         47GgtpoRREDQQgS4ISgm+xi7PzHCT9N2FkbYEW37c3fyx3nZG7uKcb/eWZNGOPi1SqgY
         LCfab7bijD3aTSXg0trGtBVE5M0wQ+3yhW6Vb0PcS2kQmST6SGb5lZBriX4m/1i6EGHJ
         DWRWkvA21RgkxAiSts1v/YaPawmZU4xmpZ7LSWu6Z6i0pS0a0ap5k5TzT7JQC85DupUB
         0Sqg==
X-Gm-Message-State: APjAAAXYR7/fldeOcoWi0N32w36hw5PNCzWrMrZ67b99dgrpB8NAQE6W
        VMxO++5YxjT9ZmuZAmC6/Hw=
X-Google-Smtp-Source: APXvYqwudgFggXfkbvd9H9ZngRxpG3yFbLN44zVRoq5yraE7Q3twPzyuHjbkbk5mA1q55StvWOCJEg==
X-Received: by 2002:a1c:9d8c:: with SMTP id g134mr3486164wme.174.1565548394335;
        Sun, 11 Aug 2019 11:33:14 -0700 (PDT)
Received: from localhost.localdomain ([94.29.34.218])
        by smtp.gmail.com with ESMTPSA id c19sm6824340wml.13.2019.08.11.11.33.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 11:33:13 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] irqchip/tegra: Remove everything related to COP
Date:   Sun, 11 Aug 2019 21:30:43 +0300
Message-Id: <20190811183044.13925-1-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point in touching of the COP (ARM7TDMI auxiliary boot/firmware
CPU) because COP's interrupts should be related only to an old multimedia
firmware that is not applicable to the upstream kernel. Hence let's remove
everything related to the COP, for consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/irqchip/irq-tegra.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/irqchip/irq-tegra.c b/drivers/irqchip/irq-tegra.c
index e1f771c72fc4..14dcacc2ad38 100644
--- a/drivers/irqchip/irq-tegra.c
+++ b/drivers/irqchip/irq-tegra.c
@@ -33,11 +33,6 @@
 #define ICTLR_CPU_IER_CLR	0x28
 #define ICTLR_CPU_IEP_CLASS	0x2C
 
-#define ICTLR_COP_IER		0x30
-#define ICTLR_COP_IER_SET	0x34
-#define ICTLR_COP_IER_CLR	0x38
-#define ICTLR_COP_IEP_CLASS	0x3c
-
 #define TEGRA_MAX_NUM_ICTLRS	6
 
 static unsigned int num_ictlrs;
@@ -68,8 +63,6 @@ static const struct of_device_id ictlr_matches[] = {
 struct tegra_ictlr_info {
 	void __iomem *base[TEGRA_MAX_NUM_ICTLRS];
 #ifdef CONFIG_PM_SLEEP
-	u32 cop_ier[TEGRA_MAX_NUM_ICTLRS];
-	u32 cop_iep[TEGRA_MAX_NUM_ICTLRS];
 	u32 cpu_ier[TEGRA_MAX_NUM_ICTLRS];
 	u32 cpu_iep[TEGRA_MAX_NUM_ICTLRS];
 
@@ -144,11 +137,6 @@ static int tegra_ictlr_suspend(void)
 		/* Save interrupt state */
 		lic->cpu_ier[i] = readl_relaxed(ictlr + ICTLR_CPU_IER);
 		lic->cpu_iep[i] = readl_relaxed(ictlr + ICTLR_CPU_IEP_CLASS);
-		lic->cop_ier[i] = readl_relaxed(ictlr + ICTLR_COP_IER);
-		lic->cop_iep[i] = readl_relaxed(ictlr + ICTLR_COP_IEP_CLASS);
-
-		/* Disable COP interrupts */
-		writel_relaxed(~0ul, ictlr + ICTLR_COP_IER_CLR);
 
 		/* Disable CPU interrupts */
 		writel_relaxed(~0ul, ictlr + ICTLR_CPU_IER_CLR);
@@ -175,11 +163,6 @@ static void tegra_ictlr_resume(void)
 		writel_relaxed(~0ul, ictlr + ICTLR_CPU_IER_CLR);
 		writel_relaxed(lic->cpu_ier[i],
 			       ictlr + ICTLR_CPU_IER_SET);
-		writel_relaxed(lic->cop_iep[i],
-			       ictlr + ICTLR_COP_IEP_CLASS);
-		writel_relaxed(~0ul, ictlr + ICTLR_COP_IER_CLR);
-		writel_relaxed(lic->cop_ier[i],
-			       ictlr + ICTLR_COP_IER_SET);
 	}
 	local_irq_restore(flags);
 }
-- 
2.22.0

