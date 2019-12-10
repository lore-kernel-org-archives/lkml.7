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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EAEC2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D6B207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S44Wn2T5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfLJIhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 03:37:06 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39155 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfLJIhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 03:37:04 -0500
Received: by mail-pg1-f196.google.com with SMTP id b137so8553300pga.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 00:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O3M2kUIZvh1y7QnzVDJ72RW9/rxyHw9ji71B/UMwuh4=;
        b=S44Wn2T5PcoqwaV3CVGoQ1DX9MYFHbLY8nvZt/g3ehUarxNrT2OSCdpjgUyTFPJwYR
         HmAJpQ2csDJi5yEBjb0YCWsYeAqXZlP2zOZmmD0y3asMy+6lmU70hwyPNBFOUgaNNEE0
         VTT4yqPiUiIXV+OeRrYBApkok60cYKDOQmDseZz/yNWXMfCjAy/dJTYmYU60yksY8p2Z
         s04xPejKe3eUmxzXKwnoNH24oCbbVZWmrx5O8y/LYwKDmqRoD7rpiR0h7KVYOnccqU2k
         FL/qkSC/026aXibE0xe0nccjQ4Aa+Bz5cQYw5TUMcHV0R+jxqrkKSSleaQz5xSR11RD+
         7zxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O3M2kUIZvh1y7QnzVDJ72RW9/rxyHw9ji71B/UMwuh4=;
        b=F7UxTvZlNUZEv4T0me5wvkFP2Kcn2SDoKE3U/Sj3YDnClo41kYykrbnNpn80MbSgnI
         HKD9Oxny7q1OmIEIMNqgFGnOQw7u/Bu3aOGntmEcOn6zZudqSiKvD6Zx4YCSKHQiVkUM
         RbsZ2rcEGXzchT44Yo5o3rZAV4hxW2445vISuBEBKW7d5e+sP+RZK4KJmIt9QEoouvnQ
         dp6zT6sE6lth3MNC7hrfQQLzoDZxDS5e3aN5H0ZGlXGBn2kxBgXWw8GuvoJaSNJJ1EyQ
         G16+4o7p99440HOn0KZXvZg+lUCeM26IBuZr3CGh1csc3H+dLbOusyblJ1LNUDSNoGCK
         CWTA==
X-Gm-Message-State: APjAAAVmNASsvgYQ+l85kEnoH+6XTQjf3WZsECef3jW87qW879ZWXDhQ
        JNn4644BpaUIaZ9eEPGM9eM=
X-Google-Smtp-Source: APXvYqwhny1ZVNzbPOBw/olf4ehlF11KH1tCeKi32VRZ+TDhrLTREKKuG5ium9HCOL33qjdar33b+Q==
X-Received: by 2002:a63:f5c:: with SMTP id 28mr23720083pgp.348.1575967023390;
        Tue, 10 Dec 2019 00:37:03 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y128sm2246632pfg.17.2019.12.10.00.36.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Dec 2019 00:37:02 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH RFC 5/8] dt-bindings: display: add Unisoc's mipi dsi&dphy bindings
Date:   Tue, 10 Dec 2019 16:36:32 +0800
Message-Id: <1575966995-13757-6-git-send-email-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575966995-13757-1-git-send-email-kevin3.tang@gmail.com>
References: <1575966995-13757-1-git-send-email-kevin3.tang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Tang <kevin.tang@unisoc.com>

Adds MIPI DSI Master and MIPI DSI-PHY (D-PHY)
support for Unisoc's display subsystem.

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
---
 .../devicetree/bindings/display/sprd/dphy.txt      | 49 ++++++++++++++++
 .../devicetree/bindings/display/sprd/dsi.txt       | 68 ++++++++++++++++++++++
 2 files changed, 117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sprd/dphy.txt
 create mode 100644 Documentation/devicetree/bindings/display/sprd/dsi.txt

diff --git a/Documentation/devicetree/bindings/display/sprd/dphy.txt b/Documentation/devicetree/bindings/display/sprd/dphy.txt
new file mode 100644
index 0000000..474c2b2
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sprd/dphy.txt
@@ -0,0 +1,49 @@
+Unisoc MIPI DSI-PHY (D-PHY)
+============================================================================
+
+Required properties:
+  - compatible: value should be "sprd,dsi-phy".
+  - reg: must be the dsi controller base address.
+  - #address-cells, #size-cells: should be set respectively to <1> and <0>
+
+Video interfaces:
+  Device node can contain video interface port nodes according to [1].
+  The following are properties specific to those nodes:
+
+  port node inbound:
+    - reg: (required) must be 0.
+  port node outbound:
+    - reg: (required) must be 1.
+
+  endpoint node connected from DSI controller node (reg = 0):
+    - remote-endpoint: specifies the endpoint in DSI node.
+  endpoint node connected to panel node (reg = 1):
+    - remote-endpoint: specifies the endpoint in panel node.
+
+[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
+
+
+Example:
+
+	dphy: dphy {
+		compatible = "sprd,dsi-phy";
+		reg = <0x0 0x63100000 0x0 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* input port*/
+		port@1 {
+			reg = <1>;
+			dphy_in: endpoint {
+				remote-endpoint = <&dsi_out>;
+			};
+		};
+
+		/* output port */
+		port@0 {
+			reg = <0>;
+			dphy_out: endpoint {
+				remote-endpoint = <&panel_in>;
+			};
+		};
+	};
diff --git a/Documentation/devicetree/bindings/display/sprd/dsi.txt b/Documentation/devicetree/bindings/display/sprd/dsi.txt
new file mode 100644
index 0000000..1719ff5
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sprd/dsi.txt
@@ -0,0 +1,68 @@
+Unisoc MIPI DSI Master
+=============================================================================
+
+Required properties:
+  - compatible: value should be "sprd,dsi-host";
+  - reg: physical base address and length of the registers set for the device
+  - interrupts: should contain DSI interrupt
+  - clocks: list of clock specifiers, must contain an entry for each required
+	    entry in clock-names
+  - clock-names: list of clock names sorted in the same order as the clocks
+                 property.
+  - #address-cells, #size-cells: should be set respectively to <1> and <0>
+    according to DSI host bindings (see MIPI DSI bindings [1])
+
+Optional properties:
+  - power-domains: a phandle to DSIM power domain node
+
+Child nodes:
+  Should contain DSI peripheral nodes (see MIPI DSI bindings [1]).
+
+Video interfaces:
+  Device node can contain video interface port nodes according to [2].
+  The following are properties specific to those nodes:
+
+  port node inbound:
+    - reg: (required) must be 0.
+  port node outbound:
+    - reg: (required) must be 1.
+
+  endpoint node connected from DPU node (reg = 0):
+    - remote-endpoint: specifies the endpoint in DPU node.
+  endpoint node connected to D-PHY node (reg = 1):
+    - remote-endpoint: specifies the endpoint in D-PHY node.
+
+[1]: Documentation/devicetree/bindings/display/mipi-dsi-bus.txt
+[2]: Documentation/devicetree/bindings/media/video-interfaces.txt
+
+Example:
+
+SoC specific DT entry:
+
+	dsi: dsi@63100000 {
+		compatible = "sprd,dsi-host";
+		reg = <0 0x63100000 0 0x1000>;
+		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+		clock-names = "clk_aon_apb_disp_eb";
+		clocks = <&clk_aon_top_gates 2>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				dsi_in: endpoint {
+					remote-endpoint = <&dpu_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				dsi_out: endpoint@1 {
+					remote-endpoint = <&dphy_in>;
+				};
+			};
+		};
+	};
\ No newline at end of file
-- 
2.7.4

