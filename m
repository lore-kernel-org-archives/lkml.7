Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38E2C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7692070D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HT2F+L2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbfDJHXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 03:23:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42277 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbfDJHXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 03:23:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id p6so989453pgh.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 00:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=IyLTTyJEtgA+Hevwz2wGkZkZqjm4Ms8sZpRlR1WnhEc=;
        b=HT2F+L2GVnlEGqomVZ4A3sVgTiy0jmlyDZs4GBhK+9QMoEvtu0VBiv2GvQJmDvBGGL
         6zFxddfh5ls2dXqSt+CnIHX+Ncb9sTdH2luvh/mEaSDb+/e60FiHibOxv2nYmbedqlgw
         wihrM0HbZHYdKkZlHHFM1qD9hy9dWmJeZd5BDbkyQFqzaIgtrthkItIexHSk3/2s7kZ+
         FFtn6bfFNdBLmaGvfni4AgA1ejvcrrHnj9sqDcdK0VE3wjRUrUOOnz9gxKJD/5xREP4e
         giKwF6GfBEu84ymgYKocaN112MQgB72+/8KUqZXqHRo+vmlY78TJnTcWnPiLMg7EISJj
         h/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IyLTTyJEtgA+Hevwz2wGkZkZqjm4Ms8sZpRlR1WnhEc=;
        b=RCvPLO9KTzAdlWsmT/zveM/+meJmVrB8PybYWudQmj7sHma4dfpckvCfVRqKF/18a1
         QGFRypbFKbn+3TB+d5GG6YefJh4PPduHual05DODbO1r7wzP3FU72/UHvczmnmTV20Co
         nyeGroOOPc/cXKeAa7Kwi+RRWJ0BAPAGkxQDH12e7DuxnlyhGmB6DKi6GJFhw9vmHYIc
         fhtuh2CTbRt9nPJA45/hRXdEe5z+AC/pKnVjNUrxyl1VnhNYthlnIS6lqWFKMIRXuCIH
         tukb2jTaZOEoe1NtQ9sDWKgnMU7Rghmz/pkILCIsB9XB3KHVnBhxl0TYePut9mKXKDMr
         yY4g==
X-Gm-Message-State: APjAAAUQKwU5HWmfx6WU+Nl17o8Lt6DUkwLD7xMnScOJOLaOQ26S5cYB
        9/WT448AzW/9nWpfxKvdlw0BVA==
X-Google-Smtp-Source: APXvYqxiT5Qot/XF7isNUXvtcXItNeqDuIUqFTnYusrTgpcUCCeVugoNmFezjevC+cn07Nb1MeBAQA==
X-Received: by 2002:a63:570d:: with SMTP id l13mr39297636pgb.55.1554880997864;
        Wed, 10 Apr 2019 00:23:17 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id s19sm49163542pfe.74.2019.04.10.00.23.13
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Apr 2019 00:23:16 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     arnd@arndb.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     olof@lixom.net, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, orsonzhai@gmail.com,
        baolin.wang@linaro.org, zhang.lyra@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: sprd: Add clock properties for serial devices
Date:   Wed, 10 Apr 2019 15:22:50 +0800
Message-Id: <1246f7a9ce912458ea3b889b0c0e392897a664c8.1554879978.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've introduced power management logics for the Spreadtrum serial
controller by commit 062ec2774c8a ("serial: sprd: Add power management
for the Spreadtrum serial controller"), thus add related clock properties
to support this feature.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/whale2.dtsi |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
index 34b6ca0..b5c5dce 100644
--- a/arch/arm64/boot/dts/sprd/whale2.dtsi
+++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
@@ -75,7 +75,9 @@
 					     "sprd,sc9836-uart";
 				reg = <0x0 0x100>;
 				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&ext_26m>;
+				clock-names = "enable", "uart", "source";
+				clocks = <&apapb_gate CLK_UART0_EB>,
+				       <&ap_clk CLK_UART0>, <&ext_26m>;
 				status = "disabled";
 			};
 
@@ -84,7 +86,9 @@
 					     "sprd,sc9836-uart";
 				reg = <0x100000 0x100>;
 				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&ext_26m>;
+				clock-names = "enable", "uart", "source";
+				clocks = <&apapb_gate CLK_UART1_EB>,
+				       <&ap_clk CLK_UART1>, <&ext_26m>;
 				status = "disabled";
 			};
 
@@ -93,7 +97,9 @@
 					     "sprd,sc9836-uart";
 				reg = <0x200000 0x100>;
 				interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&ext_26m>;
+				clock-names = "enable", "uart", "source";
+				clocks = <&apapb_gate CLK_UART2_EB>,
+				       <&ap_clk CLK_UART2>, <&ext_26m>;
 				status = "disabled";
 			};
 
@@ -102,7 +108,9 @@
 					     "sprd,sc9836-uart";
 				reg = <0x300000 0x100>;
 				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&ext_26m>;
+				clock-names = "enable", "uart", "source";
+				clocks = <&apapb_gate CLK_UART3_EB>,
+				       <&ap_clk CLK_UART3>, <&ext_26m>;
 				status = "disabled";
 			};
 		};
-- 
1.7.9.5

