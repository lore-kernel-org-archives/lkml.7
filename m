Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294DBC282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 12:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDFB520820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 12:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3Th9y2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389806AbfFJMP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 08:15:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36594 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389775AbfFJMPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 08:15:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so8966357wrs.3;
        Mon, 10 Jun 2019 05:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FlvwpC6m0v53KavCocJ+2csqLAYMxCnpT0Lw1VCqit4=;
        b=T3Th9y2P8mFhAGe5f2GRszLTwWxc6rRrQtrzWo2OCdsGyBknRfs4DoV1f9pNEJ7DnD
         bhynNiQHLGjvAX5Hj8Gme1I8jBPVbYX1fkNs98qmi8n4pWCLUXs3ul43FCLWUm/Uaguw
         IiJw6WZbo0kaLkzs97FkomBsEFzD3WV+rCVK39RjXiq6huqwSEiPLNdsOlaJLhzOzvZZ
         QeXE+Vz0VGLAf3yDhDhLjrcGiOZM0mcig0NXAEcKGoyniF6m1N0qBnUS4UPLW1RRmGqf
         knIcqtaZeEdF9ffKj4E16lrrgkipRKQx0tau1XjbQcjhF+XCGHye1SROp0h6UTOg2lGA
         a6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FlvwpC6m0v53KavCocJ+2csqLAYMxCnpT0Lw1VCqit4=;
        b=p3Dl+5DpB38k/FDQkFeYnNC3G3vEvozT+lUFuk+SDQwiOQQdQN9gaCG3pJvbVQJ118
         Fd04XrWyqdOfMWTyxCyHEYTRJkoMU6tpYiTgQ+9OA2+72kYxxnOdu+r/XmKedQA91gTG
         1yAX2BccrvP/J7filgztPN5mKD5eCRVDKBCgIaCKnjbyUXf29vOYVM3H7ctRA14UL9g/
         TmDq6Bi1oHvm3tbAJnzMHh9GZid9Y1Yee5gAZnwzfNBL/K8xt5erZvua/2ymT63qpzm5
         P7K1Yf+aNPDG9ZSLtW2VzdjPmbQqgfvy2TiMMdYEAjN8w07OI6D1+RrRa6PHlm+X70Pz
         CvuA==
X-Gm-Message-State: APjAAAXPr8kG3VpI8ENUbeC2Q2QevKPEaXDR1/KQ83QepMSaXAYO4WYO
        ydaaU7c5m7VwHLlxUX677+EcL5V7LWnaFT56
X-Google-Smtp-Source: APXvYqzsoAkn97R3560OJNeo/y83djbhV8nq+nIziMx4Zq7RVWl4008WIAc8fw11dPOCmAdmrJM83w==
X-Received: by 2002:adf:b689:: with SMTP id j9mr24269221wre.76.1560168950907;
        Mon, 10 Jun 2019 05:15:50 -0700 (PDT)
Received: from ryzen.lan (5-12-114-167.residential.rdsnet.ro. [5.12.114.167])
        by smtp.gmail.com with ESMTPSA id f21sm10385574wmb.2.2019.06.10.05.15.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 05:15:50 -0700 (PDT)
From:   Abel Vesa <abelvesa@gmail.com>
X-Google-Original-From: Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bai Ping <ping.bai@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Carlo Caione <ccaione@baylibre.com>
Subject: [RFC 1/2] irqchip: irq-imx-gpcv2: Add workaround for i.MX8MQ ERR11171
Date:   Mon, 10 Jun 2019 15:13:45 +0300
Message-Id: <20190610121346.15779-2-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190610121346.15779-1-abel.vesa@nxp.com>
References: <20190610121346.15779-1-abel.vesa@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8MQ is missing the wake_request signals from GIC to GPCv2. This indirectly
breaks cpuidle support due to inability to wake target cores on IPIs.

Here is the link to the errata (see e11171):

https://www.nxp.com/docs/en/errata/IMX8MDQLQ_0N14W.pdf

Now, in order to fix this, we can trigger IRQ 32 (hwirq 0) to all the cores by
setting 12th bit in IOMUX_GPR1 register. In order to control the target cores
only, that is, not waking up all the cores every time, we can unmask/mask the
IRQ 32 in the first GPC IMR register. So basically we can leave the IOMUX_GPR1
12th bit always set and just play with the masking and unmasking the IRO 32 for
each independent core.

Since EL3 is the one that deals with powering down/up the cores, and since the
cores wake up in EL3, EL3 should be the one to control the IMRs in this case.
This implies we need to get into EL3 on every IPI to do the unmasking, leaving
the masking to be done on the power-up sequence by the core itself.

In order to be able to get into EL3 on each IPI, we 'hijack' the registered smp
cross call handler, in this case the gic_raise_softirq which is registered by
the irq-gic-v3 driver and register our own handler instead. This new handler is
basically a wrapper over the hijacked handler plus the call into EL3.

To get into EL3, we use a custom vendor SIP id added just for this purpose.

All of this is conditional for i.MX8MQ only.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/irqchip/irq-imx-gpcv2.c | 42 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index 66501ea..b921105 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -6,11 +6,19 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/arm-smccc.h>
+#include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
+#include <linux/mfd/syscon.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/irqchip.h>
 #include <linux/syscore_ops.h>
+#include <linux/smp.h>
+
+#define IMX_SIP_GPC		0xC2000004
+#define IMX_SIP_GPC_CORE_WAKE	0x00
 
 #define IMR_NUM			4
 #define GPC_MAX_IRQS            (IMR_NUM * 32)
@@ -73,6 +81,37 @@ static struct syscore_ops imx_gpcv2_syscore_ops = {
 	.resume		= gpcv2_wakeup_source_restore,
 };
 
+static void (*__gic_v3_smp_cross_call)(const struct cpumask *, unsigned int);
+
+static void imx_gpcv2_raise_softirq(const struct cpumask *mask,
+					  unsigned int irq)
+{
+	struct arm_smccc_res res;
+
+	/* call the hijacked smp cross call handler */
+	__gic_v3_smp_cross_call(mask, irq);
+
+	/* now call into EL3 and take care of the wakeup */
+	arm_smccc_smc(IMX_SIP_GPC, IMX_SIP_GPC_CORE_WAKE,
+			*cpumask_bits(mask), 0, 0, 0, 0, 0, &res);
+}
+
+static void imx_gpcv2_wake_request_fixup(void)
+{
+	struct regmap *iomux_gpr;
+
+	/* hijack the already registered smp cross call handler */
+	__gic_v3_smp_cross_call = __smp_cross_call;
+
+	/* register our workaround handler for smp cross call */
+	set_smp_cross_call(imx_gpcv2_raise_softirq);
+
+	iomux_gpr = syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
+	if (!IS_ERR(iomux_gpr))
+		regmap_update_bits(iomux_gpr, IOMUXC_GPR1, IMX6Q_GPR1_GINT,
+					IMX6Q_GPR1_GINT);
+}
+
 static int imx_gpcv2_irq_set_wake(struct irq_data *d, unsigned int on)
 {
 	struct gpcv2_irqchip_data *cd = d->chip_data;
@@ -269,6 +308,9 @@ static int __init imx_gpcv2_irqchip_init(struct device_node *node,
 		cd->wakeup_sources[i] = ~0;
 	}
 
+	if (of_property_read_bool(node, "broken-wake-request-signals"))
+		imx_gpcv2_wake_request_fixup();
+
 	/* Let CORE0 as the default CPU to wake up by GPC */
 	cd->cpu2wakeup = GPC_IMR1_CORE0;
 
-- 
2.7.4

