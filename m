Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07292C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FB5207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RY5ElSrv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfLJIhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 03:37:17 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39352 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbfLJIhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 03:37:16 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so8693591pfx.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 00:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=izzwB8GMZJtES8ZNzh6CcmsnyTygddhapLbM209XNjI=;
        b=RY5ElSrvt9m23bn6KokPJuIx7mpooAE3UOGD8182QQ2aLBbw/3XARg3U4NssfIn4uf
         DIm2/IwlKT2SsUkIqx1FSNTP4G7bo3CRntEOR38TFdltdHqa/Qj0xvV9RitldJjW4t++
         tpve1aMOlW+HDP0150nclSp9OB/w9CpiLiEAeA8iyLmtUHBwZiZJNrOKo5rV94p3nbzs
         6QzDmC4trEU9d2ntnMUXeKvvN1vO5CM829dKmLFJjI6lI3d5BcIGm5FWOI2+mVNpFNr0
         10SDE/VVfKol+2nsCqSg9qJethOqcoFd/EAzPp47hyo/vhgHdTYbZRR21xPwUjhYovww
         Afqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=izzwB8GMZJtES8ZNzh6CcmsnyTygddhapLbM209XNjI=;
        b=myOqXAnhkPvi/xWYNs1ZN3ScnPCt2aVcDOJH1CfLL1l6HpNq1xX1bvGgjLT8u7qfKY
         /zQfFZWwHzSajrPD2s5VkTaKn8DrqMG+bf+p+mE+iNpJKeg2u7IaRNsz0NXCfgJm9h8Q
         4Wf/RNSFciDH/BRzb1+PUNr1nDp4runhKqFd7fO1rawzRyus2guGOJoAd23yIQUfBPkD
         5zNPJtHP+QE+F8aX7O94ehPKRGwtDf99UEoVTzySVbP4AR3SdctRFGoIwnzPim4u/LzF
         8iV0wh6b+ZrR9UISqD9lGSgfoIFW3fBgeTmyYI4hlDjznVaFqFqZsILH+eN2KFkIL8JA
         ZVCw==
X-Gm-Message-State: APjAAAWiyWptJndrKE3qBgkTVj8IZ9rBnqzkcUkysPnMp11zSLlV6m1a
        kzVdyghxlBUeMSKzZARJ6KZVrEed
X-Google-Smtp-Source: APXvYqxtI/cPX825d6dJH84afTJ2EE+ZB7g4K8G2rqcPi3OiL/v8zCDGAp1+6vtHxRwnEBV6UZhfZQ==
X-Received: by 2002:a63:4466:: with SMTP id t38mr23512976pgk.316.1575967035473;
        Tue, 10 Dec 2019 00:37:15 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y128sm2246632pfg.17.2019.12.10.00.37.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Dec 2019 00:37:15 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH RFC 7/8] dt-bindings: display: add Unisoc's generic mipi panel bindings
Date:   Tue, 10 Dec 2019 16:36:34 +0800
Message-Id: <1575966995-13757-8-git-send-email-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575966995-13757-1-git-send-email-kevin3.tang@gmail.com>
References: <1575966995-13757-1-git-send-email-kevin3.tang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Tang <kevin.tang@unisoc.com>

Adds generic MIPI panel support for Unisoc's display subsystem.

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
---
 .../devicetree/bindings/display/sprd/panel.txt     | 110 +++++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sprd/panel.txt

diff --git a/Documentation/devicetree/bindings/display/sprd/panel.txt b/Documentation/devicetree/bindings/display/sprd/panel.txt
new file mode 100644
index 0000000..a4017af
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sprd/panel.txt
@@ -0,0 +1,110 @@
+Unisoc Generic MIPI Panel
+================================================================
+
+Required properties:
+  - compatible: must be "sprd,generic-mipi-panel"
+  - reg: panel ID
+  - #address-cells, #size-cells: should be set respectively to <1> and <0>
+  - port: video port for DPI input
+  - sprd,dsi-work-mode: the following dsi mode can be select:
+	0: cmd mode,
+	1: video burst mode,
+	2: video non-burst mode with sync pulse,
+	3: video non-burst mode with sync event
+  - sprd,dsi-lane-number: number of dsi lanes to use, default is 4
+  - sprd,dsi-color-format: data format for video stream transmission, currently
+	supports "rgb888", "rgb666", "rgb666_packed", "rgb565" and "dsc", defaults rgb888
+  - sprd,phy-bit-clock: the transmission rate of the clock lane for High-Speed,
+	the unit is Kbps, and the default value is 500Mbps
+  - sprd,phy-escape-clock: the transmission rate of the clock lane for Low-Power,
+	the unit is Kbps, and the default value is 20Mbps
+
+
+Optional properties:
+  - width-mm: see [2] for details
+  - height-mm: see [2] for details
+  - sprd,esd-check-enable: esd check function enable switch
+  - sprd,esd-check-mode: esd detection method, default is register
+	0: register,
+	1: TE signal
+  - sprd,esd-check-period: esd detection cycle, unit ms, default 1000ms
+  - sprd,esd-check-register: if register detection is used, this attribute must be configured
+  - sprd,esd-check-value: if register detection is used, this attribute must be configured
+  - sprd,reset-on-sequence: timing of the reset pin when the lcd power on
+	<1 5>, <0 5> means first keep high for 5ms, then keep low for 5ms
+  - sprd,reset-on-sequence: timing of the reset pin when the lcd power off
+  - sprd,use-dcs-write: bool attribute, indicating whether to use the dcs to send inital & sleep cmds,
+	default use generic
+  - sprd,initial-command: lcd initialization command set
+  - sprd,sleep-in-command: lcd suspend command set
+  - sprd,sleep-out-command: lcd resume command set
+  - display-timings: see [1] for details
+
+
+	[1] Documentation/devicetree/bindings/display/panel/display-timing.txt
+	[2] Documentation/devicetree/bindings/display/panel/panel-common.yaml
+
+Example
+-------
+
+Panel specific DT entry:
+
+	&dsi {
+		panel {
+			compatible = "sprd,generic-mipi-panel";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			port {
+				reg = <1>;
+				panel_in: endpoint {
+					remote-endpoint = <&dphy_out>;
+				};
+			};
+		};
+	};
+
+	/ { lcds {
+        lcd_mipi_hd: lcd_mipi_hd {
+                sprd,dsi-work-mode = <1>;
+                sprd,dsi-lane-number = <4>;
+                sprd,dsi-color-format = "rgb888";
+                sprd,phy-bit-clock = <1100000>;
+                sprd,phy-escape-clock = <20000>;
+                width-mm = <68>;
+                height-mm = <121>;
+                sprd,esd-check-enable = <0>;
+                sprd,esd-check-mode = <0>;
+                sprd,esd-check-period = <1000>;
+                sprd,esd-check-register = <0x0A>;
+                sprd,esd-check-value = <0x9C>;
+                sprd,reset-on-sequence = <1 5>, <0 5>, <1 20>;
+                sprd,reset-off-sequence = <0 5>;
+                sprd,use-dcs-write;
+                sprd,initial-command = [
+                        39 00 00 02 b0 00
+                        39 00 00 04 B3 31 00 06
+                        ];
+                sprd,sleep-in-command = [
+                        13 0A 00 01 28
+                        13 78 00 01 10
+                        ];
+                sprd,sleep-out-command = [
+                        13 78 00 01 11
+                        13 32 00 01 29
+                        ];
+                display-timings {
+                        timing0 {
+                                clock-frequency = <64000000>;
+                                hactive = <720>;
+                                vactive = <1280>;
+                                hback-porch = <31>;
+                                hfront-porch = <31>;
+                                vback-porch = <32>;
+                                vfront-porch = <16>;
+                                hsync-len = <20>;
+                                vsync-len = <2>;
+                        };
+                };
+        };
\ No newline at end of file
-- 
2.7.4

