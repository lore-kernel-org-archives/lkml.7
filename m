Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6F0CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 19:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA4021872
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 19:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMXoI8ZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732882AbfJVTVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 15:21:08 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44849 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbfJVTVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 15:21:08 -0400
Received: by mail-qt1-f196.google.com with SMTP id z22so7988854qtq.11;
        Tue, 22 Oct 2019 12:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=p3HQhINpc7sZsIcpNCn/h8geG6mtLx6BBg3t3ICTUhg=;
        b=pMXoI8ZHhGZcW/PUKZ0iseGz3giLQXTTrrO+IGc6who5BO+L9ecTquG6EerKy1i86J
         Fcu488f3Aa7B+qe5IDaHvkaGntiwBcF4RF5Dm25f0HueFN2+NlW4FGm3/4JpP4df/2NZ
         hmQI8vsK7dJJX2BY4cJASDZ18EkacZYjjwwCzTkWTg7H0ZCIQFmp1d9qeM0jJ+WJ7ffG
         S+5PHNyYMz4EH+zRdeWb2UTAIFp6RVSR/WLLc8S3fcMRuebkIqkOAhGnHJklPt2rYofZ
         rpNikWcoi4RNqcbS8BU9/zlo8CyEGYF3CSPlMPP1xuSGwCqmMbi4InOsFIlelX/wh75V
         sdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p3HQhINpc7sZsIcpNCn/h8geG6mtLx6BBg3t3ICTUhg=;
        b=d3qozAw5aIDM0TMile5vrw4cD5ufh26ZPVl5qWehM05syI+M+Bp8Y5B63cxQ8aVLOH
         PWX9umOj7tVzywnT8S8GDrCkbQi+9kF4p/FramGWZFl9P9wgwYqLQATK7OhyUiSShBTg
         /GYuC9ctrEH/aWotVbAk1mtByIu3JxgYLUxeoSHaqDkABNSbH140DfTo/dZuaMrFDg2B
         u2FP35GnA/rc7o7OGau2YRdu3Mj8oeDPiZhhEWCazUb+Unbt1KroInUXFC/6v3Ey7Zq4
         evj6IlLJHh1op9Buo9Ef6V1SrCRBpoo9qI3FjfyZNj5C0vg3trXprJ0B902gfsiTolGp
         ZGJA==
X-Gm-Message-State: APjAAAXz7RdBjNVtpCGa5ukhubT2bk43DGLl7DMeB/8LcFYWFaj/ipY0
        eEcQANkgjRj2P74JT9pSDZQ=
X-Google-Smtp-Source: APXvYqxo6yjcFHy00Qtvm6n/aWHlQmpIUDixfzEK4DqPUaT+bhPco4Rl8Q6Ob6JJu+WOl+bpRZJMPA==
X-Received: by 2002:ac8:1e89:: with SMTP id c9mr5258144qtm.226.1571772067051;
        Tue, 22 Oct 2019 12:21:07 -0700 (PDT)
Received: from rogerio-Latitude-7490.nxp.com ([177.221.114.206])
        by smtp.gmail.com with ESMTPSA id h20sm8185938qtp.93.2019.10.22.12.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 12:21:06 -0700 (PDT)
From:   Rogerio Pimentel da Silva <rpimentel.silva@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Carlo Caione <ccaione@baylibre.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     rpimentel.silva@gmail.com
Subject: [PATCH] arm64: dts: imx8mq-evk: Add remote control
Date:   Tue, 22 Oct 2019 16:20:34 -0300
Message-Id: <20191022192038.30094-1-rpimentel.silva@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add remote control to i.MX8M EVK device tree.

The rc protocol must be selected by writing to:
/sys/devices/platform/ir-receiver/rc/rc0/protocols

On my tests, I used "nec" rc protocol:
echo nec > protocols

Tested using evetest:
evtest /dev/input/event0

Output log for each key pressed:
Event: 
time 1568122608.267845, -------------- SYN_REPORT ------------
Event: 
time 1568122610.503835, type 4 (EV_MSC), code 4 (MSC_SCAN), value 440

Signed-off-by: Rogerio Pimentel da Silva <rpimentel.silva@gmail.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index 6ede46f7d45b..bd81e4a45ff5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -50,6 +50,13 @@
 			  900000 0x1>;
 	};
 
+	ir-receiver {
+		compatible = "gpio-ir-receiver";
+		gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ir>;
+	};
+
 	wm8524: audio-codec {
 		#sound-dai-cells = <0>;
 		compatible = "wlf,wm8524";
@@ -340,6 +347,12 @@
 		>;
 	};
 
+	pinctrl_ir: irgrp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_GPIO1_IO12_GPIO1_IO12		0x4f
+		>;
+	};
+
 	pinctrl_pcie0: pcie0grp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_I2C4_SCL_PCIE1_CLKREQ_B		0x76
-- 
2.17.1

