Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AE7C28CC3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013D821BF1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="SpEMvvWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfFDJMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 05:12:23 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:1798 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726877AbfFDJMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 05:12:22 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5498m8l019440;
        Tue, 4 Jun 2019 11:12:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=7dQ+9lqtmTtedvp/b3rgO/AqPLUdhqousiUICsfwmlU=;
 b=SpEMvvWcUnePXF+45Bix5UMA9ew3+AtsyZG9D1f4bqvRi04RA4ma6HaJp2oFc8jVi4Vu
 qnxjdWdnoK31qOFC1K9oPPJtmOcKtADkTIyX+h0LfN9zvTt865gX4nphqIXmO+nFJWYB
 ACVwhSUN3WTbi0o0UD6RvU0J+LLKYJYu2askkTg7JI9MYLIUhrFqhFzN8d6sgFSMWHrC
 Q6ABZAkkFhbeHzbEmWsuCfxWAfYnp8XOIO+M3MYGyEOqFbGzYepdQJdxi+GUiDRq9WwJ
 oSR02A3G4y0h8R6sVbUp/RkZiIckvq0V3VBTZ1UmRBt99+EOURN5JG3vDNfC0cBxyGK+ tQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2sunmefknd-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 04 Jun 2019 11:12:09 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7BB731A0;
        Tue,  4 Jun 2019 08:55:43 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 09829250B;
        Tue,  4 Jun 2019 08:55:42 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 4 Jun 2019
 10:55:42 +0200
Received: from localhost (10.201.23.31) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 4 Jun 2019 10:55:41
 +0200
From:   Erwan Le Ray <erwan.leray@st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Erwan Le Ray <erwan.leray@st.com>,
        "Fabrice Gasnier" <fabrice.gasnier@st.com>,
        Bich Hemon <bich.hemon@st.com>
Subject: [PATCH 07/10] ARM: dts: stm32: update uart4 pin configurations for low power
Date:   Tue, 4 Jun 2019 10:55:16 +0200
Message-ID: <1559638519-6128-8-git-send-email-erwan.leray@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1559638519-6128-1-git-send-email-erwan.leray@st.com>
References: <1559638519-6128-1-git-send-email-erwan.leray@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.31]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-04_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, pinctrl states defines only one "sleep" configuration for pins,
no matter the possible uart low power modes (Rx pin always kept active).

Sleep pin configuration is refined for low power modes:
- "sleep" (no wakeup & console suspend enabled): put pins in analog state
  to optimize power
- "idle" (wakeup capability): keep Rx pin in alternate function
- "default" state remains untouched, to be used while the UART is active
  or in case the no_console_suspend mode is enabled

Signed-off-by: Bich Hemon <bich.hemon@st.com>
Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
index 85c417d..2e1ab1b 100644
--- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
@@ -599,6 +599,23 @@
 					bias-disable;
 				};
 			};
+
+			uart4_idle_pins_a: uart4-idle-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('G', 11, ANALOG)>; /* UART4_TX */
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('B', 2, AF8)>; /* UART4_RX */
+					bias-disable;
+				};
+			};
+
+			uart4_sleep_pins_a: uart4-sleep-0 {
+				pins {
+					pinmux = <STM32_PINMUX('G', 11, ANALOG)>, /* UART4_TX */
+						 <STM32_PINMUX('B', 2, ANALOG)>; /* UART4_RX */
+				};
+			};
 		};
 
 		pinctrl_z: pin-controller-z@54004000 {
-- 
1.9.1

