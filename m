Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D683C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE602186A
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PyD+LfjU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbfHZUo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 16:44:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37907 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730804AbfHZUoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 16:44:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id g17so16620482wrr.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 13:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OboacTrzgAOa6X4jkuvUHc+l7jAME1gqmIpY2bzkzqY=;
        b=PyD+LfjU7OVquXNkhIpuu1n1a7Ab8iOnkoR+6jLIXYZZWBcjBT2NqMthIH6UklpW1s
         QbETODPNNIdMcOEFvYqkj9YryteX7MuLgjyT1j8a4JT5YMxdSwxqYhJ6m4pmw8uawZeo
         Jd2zQQFBws2rVZG/K7HCAGMX0veGaqCnnEisfHTqKu8/czwwnnnupRnnH2CfhAAh6E/L
         abwUbQ5mnY/Yx5qJZOIEglK2RhU7+b81wd4Sn83SqSNMehTm5xH1FC4f0wc5ZkD2H/Q6
         prmV2kpcdp+tWoMM/ru37JKd6+fUBlk3ZUqYBtDTktare9gDoW+NhxNRfsX9k1bgsBAR
         H0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OboacTrzgAOa6X4jkuvUHc+l7jAME1gqmIpY2bzkzqY=;
        b=lgYHb5n3GE3bVu+AzVp6QMOFN2SM8eyZaW+j9TyJgUUMKDbXtVRKyUpb7FQP/GwU5v
         EtgJDEMYLSrbR+GCI0KXPhAlUwTel7eNp8CQbIZiWlGShOfXHeVKCT7Vc4M9kYUJjCwm
         biHOJW6XWbxjuNGQ+Uy3H9yU2H+uISvXvz88sS8NYBaxd+Nnx1RovCKcjL2j3Qv7/col
         kTjLVPvdpG372Zh7LA1v3g0QI+XCxUAzIyiS/m4nTC4EsuG8YxySCR87qIF0/DpJAnCm
         7ua1gXveE5P8Xprf4rt0Bzfe0wy2RaShudpe1ejvXjzSToconQyRo+1sSkB33m9DAgP2
         q93g==
X-Gm-Message-State: APjAAAVivZ+KUMQRL9+88dIbMxYEYrbRXlXQ0y0s8r1IA79lLi+4mMUP
        IUQRef+cjCfaPtNRUUZAZPRD7A==
X-Google-Smtp-Source: APXvYqwDbuatKmkruPgKaQhGuiQoijDAgy8zV07L44qgXLBO/6UFizDsG2B3QdLPnz3pzfySmZSCDg==
X-Received: by 2002:a5d:4448:: with SMTP id x8mr25331881wrr.119.1566852292217;
        Mon, 26 Aug 2019 13:44:52 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:f881:f5ed:b15d:96ab])
        by smtp.gmail.com with ESMTPSA id 20sm549557wmk.34.2019.08.26.13.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 13:44:51 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE)
Subject: [PATCH 07/20] clocksource/drivers/imx-sysctr: Add internal clock divider handle
Date:   Mon, 26 Aug 2019 22:43:54 +0200
Message-Id: <20190826204407.17759-7-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190826204407.17759-1-daniel.lezcano@linaro.org>
References: <df27caba-d9f8-e64d-0563-609f8785ecb3@linaro.org>
 <20190826204407.17759-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

The system counter block guide states that the base clock is
internally divided by 3 before use, that means the clock input of
system counter defined in DT should be base clock which is normally
from OSC, and then internally divided by 3 before use.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-imx-sysctr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clocksource/timer-imx-sysctr.c b/drivers/clocksource/timer-imx-sysctr.c
index fd7d68066efb..b7c80a368a1b 100644
--- a/drivers/clocksource/timer-imx-sysctr.c
+++ b/drivers/clocksource/timer-imx-sysctr.c
@@ -20,6 +20,8 @@
 #define SYS_CTR_EN		0x1
 #define SYS_CTR_IRQ_MASK	0x2
 
+#define SYS_CTR_CLK_DIV		0x3
+
 static void __iomem *sys_ctr_base;
 static u32 cmpcr;
 
@@ -134,6 +136,9 @@ static int __init sysctr_timer_init(struct device_node *np)
 	if (ret)
 		return ret;
 
+	/* system counter clock is divided by 3 internally */
+	to_sysctr.of_clk.rate /= SYS_CTR_CLK_DIV;
+
 	sys_ctr_base = timer_of_base(&to_sysctr);
 	cmpcr = readl(sys_ctr_base + CMPCR);
 	cmpcr &= ~SYS_CTR_EN;
-- 
2.17.1

