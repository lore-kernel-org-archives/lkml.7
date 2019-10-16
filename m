Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8485FECE59E
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 01:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB1720650
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 01:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8542C+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390492AbfJPBGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 21:06:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32942 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730786AbfJPBF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 21:05:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id i76so13217153pgc.0;
        Tue, 15 Oct 2019 18:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZGa/e8ScYFo0O0ofE/HYTLUJXgs85jMHJAoOtTpoL4A=;
        b=s8542C+T1nvH48+/1s6d3Xekjoe2EDEc+K6WurUBiDeTR3Nghfdcrf7bDoH76cOrtY
         4TjcKrfCtWSmiVTGaNU+g/vOKYFE/N9iHkJv51qPAKJjKED21ERvREaG5pxAt1qezxmt
         VIpE9b2I5zkSqk6IQXIRc/lHK3fFho0ZQ03XMh0R9UhbORRgE4lN49XfzAjfbLm90yAv
         3Ac4jwRxX2rvfR0AnFUElfc/nKLj3Pl2ZLZojkWa4AhWuYBpTKijvwKjG8tKDQ96DYh1
         QhT0dyPv7CM/g798VyLVKCHDicsjKiPE9XlRwRrzBVDniK1vexzQDDfDvYUMhzMlcr4g
         z4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZGa/e8ScYFo0O0ofE/HYTLUJXgs85jMHJAoOtTpoL4A=;
        b=uC6RaVfXcJsYwKbLv8vfG0tneUAMCvcdH344T7USq3sOEfaMSkXV1oD27MkYkBBH1i
         sZsjrWUsrQdVYq7VOkB2Wp9LyDeZzUDxEnSGiOOuooRYyPH5Y/t2zx0edE9f40fB9Oyj
         +49DL9FJvSySp7e+dYyM5XooWpDLz3o3o0T4vq3cWDpL7IqsIX3HWYi8vkUVQNcz0a9E
         f9O7Gg1KpQN6/wZ8RSu3DgM4Iub96Tqera54r2z3dO8BbmZjz9HBUEVjVz31lGDF3EaG
         nr5kgwxsMsaTgtLj/SaG82j0lbQOJ0GGBwl3q7N/SuygEmhoeph47E9/l2rCFFukNhCQ
         +Ziw==
X-Gm-Message-State: APjAAAUn+afHJ+pD9shuAjKDP93LPoLdIN6Aq9Uew7LE67TE7E0N3s1G
        y+SRdAD35fFcBxKPUnKmo4s=
X-Google-Smtp-Source: APXvYqya1S4ppX7c9j/nZ9F987416mfu5NR9idjjbi0YlAVSoDy4n57Uews0z1b09VTxy5KpMBEWKw==
X-Received: by 2002:a17:90a:d991:: with SMTP id d17mr1654428pjv.73.1571187957506;
        Tue, 15 Oct 2019 18:05:57 -0700 (PDT)
Received: from majic.sklembedded.com (c-73-202-231-77.hsd1.ca.comcast.net. [73.202.231.77])
        by smtp.googlemail.com with ESMTPSA id n15sm453714pjt.13.2019.10.15.18.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 18:05:56 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org (open list:CLOCKSOURCE, CLOCKEVENT DRIVERS),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE)
Cc:     Steve Longerbeam <slongerbeam@gmail.com>
Subject: [PATCH 2/2] dt-bindings: timer: imx: gpt: Add pin group bindings for input capture
Date:   Tue, 15 Oct 2019 18:05:44 -0700
Message-Id: <20191016010544.14561-3-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191016010544.14561-1-slongerbeam@gmail.com>
References: <20191016010544.14561-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pin group bindings to support input capture function of the i.MX
GPT.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
 .../devicetree/bindings/timer/fsl,imxgpt.txt  | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt b/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
index 5d8fd5b52598..32797b7b0d02 100644
--- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
+++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
@@ -33,6 +33,13 @@ Required properties:
            an entry for each entry in clock-names.
 - clock-names : must include "ipg" entry first, then "per" entry.
 
+Optional properties:
+
+- pinctrl-0: For the i.MX GPT to support the Input Capture function,
+  	     the input capture channel pin groups must be listed here.
+- pinctrl-names: must be "default".
+
+
 Example:
 
 gpt1: timer@10003000 {
@@ -43,3 +50,24 @@ gpt1: timer@10003000 {
 		 <&clks IMX27_CLK_PER1_GATE>;
 	clock-names = "ipg", "per";
 };
+
+
+Example with input capture channel 0 support:
+
+pinctrl_gpt_input_capture0: gptinputcapture0grp {
+	fsl,pins = <
+		MX6QDL_PAD_SD1_DAT0__GPT_CAPTURE1 0x1b0b0
+	>;
+};
+
+gpt: gpt@2098000 {
+	compatible = "fsl,imx6q-gpt", "fsl,imx31-gpt";
+	reg = <0x02098000 0x4000>;
+	interrupts = <0 55 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&clks IMX6QDL_CLK_GPT_IPG>,
+		<&clks IMX6QDL_CLK_GPT_IPG_PER>,
+		<&clks IMX6QDL_CLK_GPT_3M>;
+	clock-names = "ipg", "per", "osc_per";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpt_input_capture0>;
+};
-- 
2.17.1

