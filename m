Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30333C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0263C20835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfCDUDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:03:07 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:60273 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCDUDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:03:06 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MlfCm-1hRkM03oKQ-00in5x; Mon, 04 Mar 2019 21:02:47 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] irqchip/imx-irqsteer: fix of_property_read_u32() error handling
Date:   Mon,  4 Mar 2019 21:02:18 +0100
Message-Id: <20190304200245.1196001-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yY3QFfnoMqb8FAQm+o8mha9aY0xQW9ny5jcyC/eFkGeYR80Hap7
 0GB2mC8XadjkBTtKoDV0IYKR3qIgbWXNdCvybLNLpi5h1R2gJutcL1/iJbIRKkoCCGWVEBZ
 cul5nOgjwK6cAvjq80scQiLCLTle9MFcNDy6pn4oFVcRs5vIuUW0VlO7fOXIxlkscCn+wYr
 En9Tp07HTjQOPrTRWgeVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:86vfnA4Lj/s=:KtqfiSO+xP3Qx4JtaptNca
 76l4Ex6B/TfJPAIDPMOPdWDu2OQ8pKMbFnAxRB0oMsi0+evTJQ65c4LiQ8eD0kQ8SNsSVqpLM
 F+LoemRQb4oHLxtxNSn6xT1n7bgN6f4JAVs2EoDXDH+Ze9ex4sMcW1galcQUggs2bgkmJ7ARS
 EY/TpmVjMF0g7danv6FwXgHiiyYX8Z2KvyJbLahaADUxxMzWXSN1Wl7SKbnKoub8YiWouDn7n
 GSRsZJUfZqJXgPhLqktxh794zspB9KHJf7hcd/IjtVP7ENY0YNE7uT/MYzR20abIKL7th6Zos
 vtu3E5LJXqGi0JZ/tOxlK/7z11sdhG+l409GdfnBcgaHfa6uBS+7LbdYqK+zC2fQxFKR3PTPR
 bCtVVK1gkImHbIXbFc8795JKCyG25QanOZ8vCp0H925FcpTA4Egct8fjhckqDNuLjIe3BeW1w
 2PwsWYSDsGk9YfAstxX3RDxg3nF3O5n0VLGb9elSRvmUkKQx0xIthzN8a0kAZuTjaun/OZQ6H
 HrH7t9wNTo3BTPfB1wOG2JCZ0nHt98n0yAvF55sgBAmFdDy0LIIUPLz+tP0RaAi3UqYrP3wOX
 nubLMrn4ny8TNwHJ3KB//VT1Tctz7G/IKFKasPz9mbvPFaXHqRTKIW8yQOQVTEiHXjUv9Ppl/
 TLLL5jIXS8Ie3uKEC3ezlaPV04zzc1UcuQdC3HfSxW1MJlVanmtagsa88yKFMPV+/8Ridvnls
 CBCqLZ3T10H/bUdSSlNNUQDiid2ybnlmYnTXvA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc points out that irqs_num is not initialized when of_property_read_u32()
is an empty stub function:

                 Included from drivers/irqchip/irq-imx-irqsteer.c:7:
drivers/irqchip/irq-imx-irqsteer.c: In function 'imx_irqsteer_probe':
include/uapi/linux/kernel.h:13:49: error: 'irqs_num' may be used uninitialized in this function [-Werror=maybe-uninitialized]

The same can actually happen with CONFIG_OF=y as well, though we don't
get a warning then.

Add error checking here that lets the code deal with missing or
invalid properties as well as avoid the warning.

Fixes: 28528fca4908 ("irqchip/imx-irqsteer: Add multi output interrupts support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/irqchip/irq-imx-irqsteer.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
index d1098f4da6a4..88df3d00052c 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -169,8 +169,12 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 
 	raw_spin_lock_init(&data->lock);
 
-	of_property_read_u32(np, "fsl,num-irqs", &irqs_num);
-	of_property_read_u32(np, "fsl,channel", &data->channel);
+	ret = of_property_read_u32(np, "fsl,num-irqs", &irqs_num);
+	if (ret)
+		return ret;
+	ret = of_property_read_u32(np, "fsl,channel", &data->channel);
+	if (ret)
+		return ret;
 
 	/*
 	 * There is one output irq for each group of 64 inputs.
-- 
2.20.0

