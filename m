Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C2DC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FE320652
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="XmCeNPhK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbfDPO6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:58:52 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:40201 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726230AbfDPO6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:58:50 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3GEpC1f016721;
        Tue, 16 Apr 2019 16:58:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=NTY1Haxpo+TbUvkzhR53oil7m7fYpv9QIqr16M4qojM=;
 b=XmCeNPhKcCPucN3LbxmYy9ytnFDheeP0HsJZKReioo2wq4YusoukY0z/nF/Co3ci4H6o
 u+pesuFqOh1U8VqGDQAT8sWrCeA69NYkgwQftrJfOXYQpCrA2DSy9mk9RsxkLCeIZ+qr
 Vss3tWPaZqZlKL9QLuTU5X4p1GPGIa4GxelcEs7nucVolGfpfj+tGfGQTS2zI8RF4BPF
 esG7j6KxEprZx+1wn3m1HPeZa0mg85EYKo3bNM4a1H9uSCQJlOTJqI4rAyuWQjCbBCQe
 yzfZ9382ckTMy+i79sVZmGr1yaBE30n/buL6p50r2DEpQtKJxq1rfzD9+TE9lzEs7N1j /A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ru5hu8ryp-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 16 Apr 2019 16:58:39 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6DAF03D;
        Tue, 16 Apr 2019 14:58:38 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5152C269B;
        Tue, 16 Apr 2019 14:58:38 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 16 Apr
 2019 16:58:38 +0200
Received: from localhost (10.201.23.25) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 16 Apr 2019 16:58:37
 +0200
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        "Ludovic Barre" <ludovic.barre@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v2 4/8] ARM: dts: stm32: add m4 remoteproc support on STM32MP157c
Date:   Tue, 16 Apr 2019 16:58:15 +0200
Message-ID: <1555426699-5340-5-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555426699-5340-1-git-send-email-fabien.dessenne@st.com>
References: <1555426699-5340-1-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.25]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-16_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declare the M4 remote processor in a sub-node of the mlahb simple bus.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index c664b55..2d3f8c0 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -1242,4 +1242,24 @@
 			status = "disabled";
 		};
 	};
+
+	mlahb {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		dma-ranges = <0x00000000 0x38000000 0x10000>,
+			     <0x10000000 0x10000000 0x60000>,
+			     <0x30000000 0x30000000 0x60000>;
+
+		m4_rproc: m4@0 {
+			compatible = "st,stm32mp1-m4";
+			reg = <0x00000000 0x10000>,
+			      <0x10000000 0x40000>,
+			      <0x30000000 0x40000>;
+			resets = <&rcc MCU_R>;
+			st,syscfg-holdboot = <&rcc 0x10C 0x1>;
+			st,syscfg-tz = <&rcc 0x000 0x1>;
+			status = "disabled";
+		};
+	};
 };
-- 
2.7.4

