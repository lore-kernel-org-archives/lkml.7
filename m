Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C566BC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1727E2196F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VegfV2GW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389648AbfIENAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 09:00:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36959 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389623AbfIENAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 09:00:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id i1so2099898wro.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 06:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ItMEpDF/ETBC68Y7AhaUHvdMI96KH343D0YWB3ja2rE=;
        b=VegfV2GWqvxCgtKh2Ptv65EU7va3mIh2cL4VnsBiVf6HgkbmXczGqy6XmSLL8OiGCm
         fsYuOIXoYsOKnLu8H/jc1Avip/zhnIj/tSgsj+DTOI7Zj0HRUhunQ+7CbtVgQp8aDYyQ
         kx2wYunEd2LnRthR76r9s6m8nFGMXJbK8ktb66zZ+GxCFK8sb9+3QGoBXwHGUKQFen3/
         F8TAHj6SrpyQFaqO4I0nGuv296Ay3FuoKbf4ELAXBw9JVXHKEVYyWTbma9+FhRXXnldk
         SFXDoPoVlZyp7mv5R1skyRCeqagUj2HUMbdFz8xBXkuo4pA0Q9zNi/au+F5G/WGpi5CL
         lIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ItMEpDF/ETBC68Y7AhaUHvdMI96KH343D0YWB3ja2rE=;
        b=mnAKIFEvbJ8Bpi9YpNczOpUzqqo80nNZSSUBLJNRFifMw5mxDyW8ECZleNxVJ5i3cH
         mvZ75Cg+p3+5O1d1ARZgruoKwvHKoQjD7YLNMRhdWCfKts6JiRL0J3xezlFQtxgU/u9P
         1JUvGfmX1HA2iYND8jD7JBikoAgCI/vqRdScnEBxAYYGJSmaea6Cd+/85kGa6lioMElX
         uXIM4KWkP43x8FT8/hyMJpqRqRhkWi0uOhl7Zxfq3T94+FmLzIY9I6T7HetxDXV6jPC+
         Rkrs5xSQk5dTqEYD7lIs6hkiQiShp03G6hW/hdx8WOYIAWRNqpFg522wEbybdpaGWrDb
         Nk7A==
X-Gm-Message-State: APjAAAV/MJypSd1WXFMV/1fTn9Up0EXeURPrF5N9Du+CThs/FV6+e7eU
        m/pSaQ5WdxTNXZX5UwL1PNiJTw==
X-Google-Smtp-Source: APXvYqwp+SuTEV+a4KTcSrYQENWCJMbhMJDAtYIjIi8jQWshU64TGTVKI1REbj9eA4A5SGa/Yz7QEw==
X-Received: by 2002:a5d:4a81:: with SMTP id o1mr2364545wrq.328.1567688407008;
        Thu, 05 Sep 2019 06:00:07 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z189sm3727903wmc.25.2019.09.05.06.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 06:00:06 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] arm64: dts: meson: g12: factor the power domain.
Date:   Thu,  5 Sep 2019 14:59:55 +0200
Message-Id: <20190905125956.4384-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190905125956.4384-1-jbrunet@baylibre.com>
References: <20190905125956.4384-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The power domain declared in the g12a and g12b dtsi are the same.
Move the declaration of these power domains in the g12 common dtsi.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12.dtsi  | 13 +++++++++++++
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 13 -------------
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi | 12 ------------
 3 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12.dtsi
index 1e30061fb2a7..ac5833781611 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12.dtsi
@@ -5,3 +5,16 @@
  */
 
 #include "meson-g12-common.dtsi"
+#include <dt-bindings/power/meson-g12a-power.h>
+
+&ethmac {
+	power-domains = <&pwrc PWRC_G12A_ETH_ID>;
+};
+
+&vpu {
+	power-domains = <&pwrc PWRC_G12A_VPU_ID>;
+};
+
+&sd_emmc_a {
+	amlogic,dram-access-quirk;
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 69339d69dfd4..07450c4babfc 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -4,7 +4,6 @@
  */
 
 #include "meson-g12.dtsi"
-#include <dt-bindings/power/meson-g12a-power.h>
 
 / {
 	compatible = "amlogic,g12a";
@@ -110,15 +109,3 @@
 		};
 	};
 };
-
-&ethmac {
-	power-domains = <&pwrc PWRC_G12A_ETH_ID>;
-};
-
-&vpu {
-	power-domains = <&pwrc PWRC_G12A_VPU_ID>;
-};
-
-&sd_emmc_a {
-	amlogic,dram-access-quirk;
-};
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
index eefac0ef092b..a9e1db0f1158 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
@@ -5,7 +5,6 @@
  */
 
 #include "meson-g12.dtsi"
-#include <dt-bindings/power/meson-g12a-power.h>
 
 / {
 	compatible = "amlogic,g12b";
@@ -102,14 +101,3 @@
 	compatible = "amlogic,g12b-clkc";
 };
 
-&ethmac {
-	power-domains = <&pwrc PWRC_G12A_ETH_ID>;
-};
-
-&vpu {
-	power-domains = <&pwrc PWRC_G12A_VPU_ID>;
-};
-
-&sd_emmc_a {
-	amlogic,dram-access-quirk;
-};
-- 
2.21.0

