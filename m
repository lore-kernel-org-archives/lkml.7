Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CABFC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52CF2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GrSgfku+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfKRKnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 05:43:22 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43392 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfKRKnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 05:43:21 -0500
Received: by mail-pf1-f195.google.com with SMTP id 3so10190105pfb.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 02:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oal8H4KU9ceKzMRCHfIeWqGJ097aAOuBrL6LAkt5Sts=;
        b=GrSgfku+mO66VD5S3fXJy0QqA/u2NkhlTQf4eWsc4mfIDEEYtUYATDd73lu47Uxx8K
         sGgCLMjUfyiasrcvlYBpYXko/hxwYDbDHx5LahBHGesdM+c39jmIh08y23zYqWKD+0+p
         Kqygrm1arCtVRyG/XE/mPiFlhEVQXMWzBSENA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oal8H4KU9ceKzMRCHfIeWqGJ097aAOuBrL6LAkt5Sts=;
        b=l0+i4qvGX7fN9Vtu2fvTYk5I6iuck4kqTuayU2JZcef03taHfnLQSodsOTUhbIjfVT
         3U4pro8n2I4+GlGtGDdDnc5gEXLJ5mqtQDlP9U1aNA3BmaCUahbOgbQZX+s95cdAfb1r
         MZbND8zGTsoS5z7U4kSjj5Bmgf7kv5iXPpq50CtdZGDKdoN7my2PyVNtazPjomxZkDti
         gXPYBKqIZCZ5+FkEmsc1hMOiE62LhgvCJ83884xG/fpzsn1ayEo/Qr+vRjqLXXqYHnyw
         1sLxlkeovcDoaoDB6ZByRbCewVRKJ5zgbQLDqFcKPH1st5GQLnghgsGD5Vq2wSGwxHxt
         v1ug==
X-Gm-Message-State: APjAAAU/RbK2mYv6X37bVPVMv3iH0DVykLLlkRrm6W3MW+T4/df8dEIC
        dArFiGWkXbIgy+Ua3PFjVbiPlQ==
X-Google-Smtp-Source: APXvYqz73PCW+T58lexcwbtEkYi/LQt0IUyjR4at8WkiLlPclgUmtqSyac2X2Xajrwp/TEsevh0T3Q==
X-Received: by 2002:a63:db15:: with SMTP id e21mr16299127pgg.21.1574073800047;
        Mon, 18 Nov 2019 02:43:20 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id p18sm20485310pff.9.2019.11.18.02.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 02:43:19 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: mt8173: Add gce setting in mmsys and display node
Date:   Mon, 18 Nov 2019 18:42:53 +0800
Message-Id: <20191118104252.228406-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to use GCE function, we need add some informations
into display node (mboxes, mediatek,gce-client-reg, mediatek,gce-events).

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
- This is based on series "support gce on mt8183 platform"
  https://patchwork.kernel.org/cover/11208309/
- gce setting in 8183:
  https://patchwork.kernel.org/patch/11127105/
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 15f1842f6df3..e84ec3f95d81 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -911,6 +911,11 @@ mmsys: clock-controller@14000000 {
 			assigned-clocks = <&topckgen CLK_TOP_MM_SEL>;
 			assigned-clock-rates = <400000000>;
 			#clock-cells = <1>;
+			mboxes = <&gce 0 CMDQ_THR_PRIO_HIGHEST 1>,
+				 <&gce 1 CMDQ_THR_PRIO_HIGHEST 1>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0 0x1000>;
+			mediatek,gce-events = <CMDQ_EVENT_MUTEX0_STREAM_EOF>,
+					      <CMDQ_EVENT_MUTEX1_STREAM_EOF>;
 		};
 
 		mdp_rdma0: rdma@14001000 {
@@ -991,6 +996,7 @@ ovl0: ovl@1400c000 {
 			clocks = <&mmsys CLK_MM_DISP_OVL0>;
 			iommus = <&iommu M4U_PORT_DISP_OVL0>;
 			mediatek,larb = <&larb0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xc000 0x1000>;
 		};
 
 		ovl1: ovl@1400d000 {
@@ -1001,6 +1007,7 @@ ovl1: ovl@1400d000 {
 			clocks = <&mmsys CLK_MM_DISP_OVL1>;
 			iommus = <&iommu M4U_PORT_DISP_OVL1>;
 			mediatek,larb = <&larb4>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xd000 0x1000>;
 		};
 
 		rdma0: rdma@1400e000 {
@@ -1011,6 +1018,7 @@ rdma0: rdma@1400e000 {
 			clocks = <&mmsys CLK_MM_DISP_RDMA0>;
 			iommus = <&iommu M4U_PORT_DISP_RDMA0>;
 			mediatek,larb = <&larb0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xe000 0x1000>;
 		};
 
 		rdma1: rdma@1400f000 {
@@ -1021,6 +1029,7 @@ rdma1: rdma@1400f000 {
 			clocks = <&mmsys CLK_MM_DISP_RDMA1>;
 			iommus = <&iommu M4U_PORT_DISP_RDMA1>;
 			mediatek,larb = <&larb4>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xf000 0x1000>;
 		};
 
 		rdma2: rdma@14010000 {
@@ -1031,6 +1040,7 @@ rdma2: rdma@14010000 {
 			clocks = <&mmsys CLK_MM_DISP_RDMA2>;
 			iommus = <&iommu M4U_PORT_DISP_RDMA2>;
 			mediatek,larb = <&larb4>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0 0x1000>;
 		};
 
 		wdma0: wdma@14011000 {
@@ -1041,6 +1051,7 @@ wdma0: wdma@14011000 {
 			clocks = <&mmsys CLK_MM_DISP_WDMA0>;
 			iommus = <&iommu M4U_PORT_DISP_WDMA0>;
 			mediatek,larb = <&larb0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x1000 0x1000>;
 		};
 
 		wdma1: wdma@14012000 {
@@ -1051,6 +1062,7 @@ wdma1: wdma@14012000 {
 			clocks = <&mmsys CLK_MM_DISP_WDMA1>;
 			iommus = <&iommu M4U_PORT_DISP_WDMA1>;
 			mediatek,larb = <&larb4>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x2000 0x1000>;
 		};
 
 		color0: color@14013000 {
@@ -1059,6 +1071,7 @@ color0: color@14013000 {
 			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_LOW>;
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_COLOR0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x3000 0x1000>;
 		};
 
 		color1: color@14014000 {
@@ -1067,6 +1080,7 @@ color1: color@14014000 {
 			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_LOW>;
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_COLOR1>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x4000 0x1000>;
 		};
 
 		aal@14015000 {
@@ -1075,6 +1089,7 @@ aal@14015000 {
 			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_LOW>;
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_AAL>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x5000 0x1000>;
 		};
 
 		gamma@14016000 {
@@ -1083,6 +1098,7 @@ gamma@14016000 {
 			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_LOW>;
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_GAMMA>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x6000 0x1000>;
 		};
 
 		merge@14017000 {
-- 
2.24.0.432.g9d3f5f5b63-goog

