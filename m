Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAF8C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07104206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Ea4HNDZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387852AbfJJNDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 09:03:13 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:1592 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733300AbfJJNDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:03:12 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9AD1h73005680;
        Thu, 10 Oct 2019 15:02:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=Lrgg/JupVUGfx1EGZYXupcFmvCwMUXEFDk4NGGs/DEM=;
 b=Ea4HNDZ8L1C/e6Lzy8QRdZUdC+Hk25JWFCYZUnWqGyjQQIG4woiazEpBlpEu7LnCt1LK
 zvTBvXtqnFYR1FHlFhK7h3ZM82I661+9R1M+GrEIJ8WLkK7EOtUAvoq19pDTBLmBQ9NJ
 X+NhV7iPKEeSTbnTwcdn95yClLC5T1T8ojfob2c+EB0hfEjERbOZMTdfhbvwgwRxhWK1
 zPfGF0cexHrIYmC0SAojbvDZHWOpEdXBLPSRJJc0sjqfh/yeNXDfKTZIK5awaiXtuD+a
 ANDOANFlDAbodjbG9ZnRhJGfmSEGmFhrjueGr+ESl8T8z0kLeo4/0z2ymq1hlEbRySBn OA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vegn13t3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Oct 2019 15:02:53 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AB81810002A;
        Thu, 10 Oct 2019 15:02:51 +0200 (CEST)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 96E2F2AA31D;
        Thu, 10 Oct 2019 15:02:51 +0200 (CEST)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 10 Oct
 2019 15:02:51 +0200
Received: from localhost (10.201.21.218) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 10 Oct 2019 15:02:51
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <linux-stm32@st-md-mailman.stormreply.com>,
        <alexandre.torgue@st.com>, <robh@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>
Subject: [PATCH] ARM: dts: stm32: add hdmi audio support to stm32mp157a-dk1 board
Date:   Thu, 10 Oct 2019 15:02:47 +0200
Message-ID: <20191010130247.32027-1-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.21.218]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-10_04:2019-10-10,2019-10-10 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add HDMI audio support through Sil9022 HDMI transceiver
on stm32mp157a-dk1 board.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 arch/arm/boot/dts/stm32mp157a-dk1.dts | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp157a-dk1.dts b/arch/arm/boot/dts/stm32mp157a-dk1.dts
index 5ad4cef9e971..7a20640c00a9 100644
--- a/arch/arm/boot/dts/stm32mp157a-dk1.dts
+++ b/arch/arm/boot/dts/stm32mp157a-dk1.dts
@@ -92,7 +92,7 @@
 			"Playback" , "MCLK",
 			"Capture" , "MCLK",
 			"MICL" , "Mic Bias";
-		dais = <&sai2a_port &sai2b_port>;
+		dais = <&sai2a_port &sai2b_port &i2s2_port>;
 		status = "okay";
 	};
 };
@@ -173,6 +173,7 @@
 		reset-gpios = <&gpioa 10 GPIO_ACTIVE_LOW>;
 		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
 		interrupt-parent = <&gpiog>;
+		#sound-dai-cells = <0>;
 		status = "okay";
 
 		ports {
@@ -185,6 +186,13 @@
 					remote-endpoint = <&ltdc_ep0_out>;
 				};
 			};
+
+			port@3 {
+				reg = <3>;
+				sii9022_tx_endpoint: endpoint {
+					remote-endpoint = <&i2s2_endpoint>;
+				};
+			};
 		};
 	};
 
@@ -370,6 +378,23 @@
 	};
 };
 
+&i2s2 {
+	clocks = <&rcc SPI2>, <&rcc SPI2_K>, <&rcc PLL3_Q>, <&rcc PLL3_R>;
+	clock-names = "pclk", "i2sclk", "x8k", "x11k";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&i2s2_pins_a>;
+	pinctrl-1 = <&i2s2_pins_sleep_a>;
+	status = "okay";
+
+	i2s2_port: port {
+		i2s2_endpoint: endpoint {
+			remote-endpoint = <&sii9022_tx_endpoint>;
+			format = "i2s";
+			mclk-fs = <256>;
+		};
+	};
+};
+
 &ipcc {
 	status = "okay";
 };
-- 
2.17.1

