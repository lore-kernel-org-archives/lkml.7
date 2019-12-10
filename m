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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB64C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB7A207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ID8MYin3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfLJIg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 03:36:57 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43287 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfLJIg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 03:36:56 -0500
Received: by mail-pg1-f195.google.com with SMTP id b1so8531900pgq.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 00:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8aLq+zy1een00EBR5gN+QvF45u2P32aHof0Im7Tyw5A=;
        b=ID8MYin392wjJCTORhHWXcvHVnVhFIpi587MhFLIgIdPKGS17DEOddSgBZrFw2Fwrq
         PUeOpi/F3cwzQJ0wbX7KOMrNI3Zmd7xUchOhXceBwtf+86jpJUY7cyspi9/PPxTIYLGq
         duv8wJIgDM4eSGWoDK7SdAeYuTMs2biu9SBPfi8t/obKIhqCZsTc5G9P5+NoCIS0otzu
         M7Flw0Qjsa5zATKmfhbT4NPJwB3eVjYrjKWiYydx7eXscIvfe1j7QVJqnvLtKgp3wJb1
         UAIn57kuvJ2b4bapShQtp5AANO2sxYjC2SFDJ+3uduiqcjhsQgviH8cHxJYJNhQzSyHH
         LXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8aLq+zy1een00EBR5gN+QvF45u2P32aHof0Im7Tyw5A=;
        b=KIc9plYkTMZZ0mGaftp61HrCvJJc3zMbxFNdhWh3MGV2330IAJTkEaIN3MmqVM3Rjt
         eqr/Aql7tQq+nNV8XrcvscziAJFe9TEz4d5f5u76ftycxabn1z5e5iFNqNPG2XorsQte
         fYG3AaRqzcTsDsl7lBgCNFOKIMjQDImWmVyz6B5gR2iOHBEqGPCVU/Q8gTFLcrPItesK
         Z8GXQnVVjJRwTwJEQpIpkf1hSz513cA7p3ocCMHdEpzW9NquSSJ3ZOzTydutpy6Cl6lO
         8koDC7iqr96kdknY3SjL6QqtOOlWBSG/NS6fDMtzM0ldTlvSn1cesZYI4tqBSAse+QpY
         fwOQ==
X-Gm-Message-State: APjAAAWNd3qqJ54PXtui5/ZzxA5n1XEj9PDJ2uhiDtDPL8oRzMU6ekxf
        5Hm9p+xTRh+oxQr5flGi12A=
X-Google-Smtp-Source: APXvYqzGXYvWKHpEqVKsvI7bRoXjkDFpKrzHgLjzj+1HuAaG2gLFB4oqdQPvOfr6i7EFQSemwkx8pg==
X-Received: by 2002:a63:3e03:: with SMTP id l3mr23512465pga.118.1575967015262;
        Tue, 10 Dec 2019 00:36:55 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y128sm2246632pfg.17.2019.12.10.00.36.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Dec 2019 00:36:54 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH RFC 3/8] dt-bindings: display: add Unisoc's dpu bindings
Date:   Tue, 10 Dec 2019 16:36:30 +0800
Message-Id: <1575966995-13757-4-git-send-email-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575966995-13757-1-git-send-email-kevin3.tang@gmail.com>
References: <1575966995-13757-1-git-send-email-kevin3.tang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Tang <kevin.tang@unisoc.com>

DPU (Display Processor Unit) is the Display Controller for the Unisoc SoCs
which transfers the image data from a video memory buffer to an internal
LCD interface.

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
---
 .../devicetree/bindings/display/sprd/dpu.txt       | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sprd/dpu.txt

diff --git a/Documentation/devicetree/bindings/display/sprd/dpu.txt b/Documentation/devicetree/bindings/display/sprd/dpu.txt
new file mode 100644
index 0000000..25cbf8e
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sprd/dpu.txt
@@ -0,0 +1,55 @@
+Unisoc SoC Display Processor Unit (DPU)
+============================================================================
+
+DPU (Display Processor Unit) is the Display Controller for the Unisoc SoCs
+which transfers the image data from a video memory buffer to an internal
+LCD interface.
+
+Required properties:
+  - compatible: value should be "sprd,display-processor";
+  - reg: physical base address and length of the DPU registers set.
+  - interrupts: the interrupt signal from DPU.
+  - clocks: must include clock specifiers corresponding to entries in the
+	    clock-names property.
+  - clock-names: list of clock names sorted in the same order as the clocks
+                 property.
+  - dma-coherent: with this property, the dpu driver can allocate large and
+		  continuous memorys.
+  - port: a port node with endpoint definitions as defined in document [1].
+
+[1]: Documentation/devicetree/bindings/media/video-interfaces.txt.
+
+Optional Properties:
+  - iommus: a phandle to DPU iommu node.
+  - power-domains: a phandle to DPU power domain node.
+
+
+Example:
+
+SoC specific DT entry:
+
+	dpu: dpu@63000000 {
+		compatible = "sprd,display-processor";
+		reg = <0x0 0x63000000 0x0 0x1000>;
+		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+		clock-names = "clk_src_128m",
+			"clk_src_153m6",
+			"clk_src_384m",
+			"clk_dpu_core",
+			"clk_dpu_dpi",
+			"clk_aon_apb_disp_eb";
+
+		clocks = <&clk_twpll_128m>,
+			<&clk_twpll_153m6>,
+			<&clk_twpll_384m>,
+			<&clk_dpu>,
+			<&clk_dpu_dpi>,
+			<&clk_aon_top_gates 2>;
+
+		dma-coherent;
+		dpu_port: port {
+			dpu_out: endpoint {
+				remote-endpoint = <&dsi_in>;
+			};
+		};
+	};
\ No newline at end of file
-- 
2.7.4

