Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EE9C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 10:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F112082F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 10:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Ueff3Vkq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfKYK1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 05:27:24 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:35182 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727278AbfKYK1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 05:27:23 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAPAR9LU008283;
        Mon, 25 Nov 2019 11:27:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=8y417jH9pUhx+qJrqcveEBhpHl79/MlPJT2zJMNWxbs=;
 b=Ueff3Vkq9ht5vcZShB+nSK3r8AkhkK9GM2Fy+/kczFLOXI4n7bWihIU6yg4GKbmI1vvn
 6nVHb36nTDtFP+rbojZWJUKakx4I6A024c8FoehgoJm3M+uBysDUhowu6P6aFjXechlc
 HCST1zCbrzo9KwSPd/kPgzUD+4cMipBtE0tQT28DEF1TcuzdwxuDKA1gmf27j3KyogAf
 mCEA4BCquRaIDQK5wk33je71i2Kh0IIDvoayOhqGO49ldtj9j2ly0IFlkXlTomBpbr8D
 yP0wqa3hA8lWv8SHT4mc0nPCtlSKWMqYMRR/bStbpcIU+d81ErcZKnS1Ma287pkWhkpt xQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2weu428m9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Nov 2019 11:27:11 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 75BFD100038;
        Mon, 25 Nov 2019 11:27:11 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 67D862B0115;
        Mon, 25 Nov 2019 11:27:11 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 25 Nov 2019 11:27:10
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 1/2] dt-bindings: usb: dwc2: add support for STM32MP15 SoCs USB OTG HS and FS
Date:   Mon, 25 Nov 2019 11:26:58 +0100
Message-ID: <20191125102659.22853-2-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191125102659.22853-1-amelie.delaunay@st.com>
References: <20191125102659.22853-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-25_02:2019-11-21,2019-11-25 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the specific compatible string for the DWC2 IP found in the STM32MP15
SoCs.
STM32MP15 SoCs uses sensing comparators to detect Vbus valid levels and
ID pin state. usb33d-supply described the regulator supplying Vbus and ID
sensing comparators.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 Documentation/devicetree/bindings/usb/dwc2.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
index aafff3a6904d..c2c8d40076cf 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.txt
+++ b/Documentation/devicetree/bindings/usb/dwc2.txt
@@ -23,6 +23,9 @@ Required properties:
   configured in HS mode;
   - "st,stm32f7-hsotg": The DWC2 USB HS controller instance in STM32F7 SoCs
     configured in HS mode;
+  - "st,stm32mp15-fsotg": The DWC2 USB controller instance in STM32MP15 SoCs,
+  configured in FS mode (using dedicated FS transceiver).
+  - "st,stm32mp15-hsotg": The DWC2 USB controller instance in STM32MP15 SoCs;
 - reg : Should contain 1 register range (address and length)
 - interrupts : Should contain 1 interrupt
 - clocks: clock provider specifier
@@ -46,6 +49,8 @@ Refer to phy/phy-bindings.txt for generic phy consumer properties
                           on for remote wakeup during suspend.
 - snps,reset-phy-on-wake: If present indicates that we need to reset the PHY when
                           we detect a wakeup.  This is due to a hardware errata.
+- usb33d-supply: external VBUS and ID sensing comparators supply, in order to
+		 perform OTG operation, used on STM32MP15 SoCs.
 
 Deprecated properties:
 - g-use-dma: gadget DMA mode is automatically detected
-- 
2.17.1

