Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0A7C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B0120896
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="WIoDnfwT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733043AbfFMPMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:12:06 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:21666 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732291AbfFMNub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:50:31 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5DDlO4w027701;
        Thu, 13 Jun 2019 15:50:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=Psif9qopZgVPe8dWo9XocFzMybtKO3gMouXdNYlMSBI=;
 b=WIoDnfwT2Lvl5uka5QWoFdeeNPZ8oP5D+fSpCiLpQo+CZTFie4V1i/ds6flvxctfD3bt
 gjMy0/+VEx8OfkjzhrlUEeH7VPZ2zSKPs16TJ5gdyLu94+bZREimLhgEu8jaQEGlTaT+
 NE9CKsRRaA0NW4qHeUZBO/fEDFxKHQW0BQ6OfzD0bBX66di2q88gu4Uh4VNXrL3OH+y5
 XyQn8fv3w7fvZgm3Ji5Z7eu3f9elrRdc2uYKp10PQZD260O9VikoFhw4/2ZgMZTC5WOF
 /mR/IbyxnA51uD+v5+q7VE/qgS3neJQTQHSd8PEGphh7o1wUoJij1EyvMeAkM8Ba58xh SQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2t2f8c49a3-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 13 Jun 2019 15:50:15 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CE9F73D;
        Thu, 13 Jun 2019 13:50:14 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 736032BC2;
        Thu, 13 Jun 2019 13:50:14 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 13 Jun
 2019 15:50:14 +0200
Received: from localhost (10.201.23.31) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 13 Jun 2019 15:50:13
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
Subject: [PATCH v3 02/10] dt-bindings: serial: add optional pinctrl states
Date:   Thu, 13 Jun 2019 15:49:52 +0200
Message-ID: <1560433800-12255-3-git-send-email-erwan.leray@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560433800-12255-1-git-send-email-erwan.leray@st.com>
References: <1560433800-12255-1-git-send-email-erwan.leray@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.31]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-13_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bich Hemon <bich.hemon@st.com>

Add options for pinctrl states:
- "sleep" for low power
- "idle" for low power and wakeup capabilities enabled
- "no_console_suspend" for enabling console messages in low power

Signed-off-by: Bich Hemon <bich.hemon@st.com>
Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
index 5ec80c1..64a5ea9 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
+++ b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
@@ -13,7 +13,14 @@ Required properties:
 - clocks: The input clock of the USART instance
 
 Optional properties:
-- pinctrl: The reference on the pins configuration
+- pinctrl-names: Set to "default". An additional "sleep" state can be defined
+  to set pins in sleep state when in low power. In case the device is used as
+  a wakeup source, "idle" state is defined in order to keep RX pin active.
+  For a console device, an optional state "no_console_suspend" can be defined
+  to enable console messages during suspend. Typically, "no_console_suspend" and
+  "default" states can refer to the same pin configuration.
+- pinctrl-n: Phandle(s) pointing to pin configuration nodes.
+  For Pinctrl properties see ../pinctrl/pinctrl-bindings.txt
 - st,hw-flow-ctrl: bool flag to enable hardware flow control.
 - rs485-rts-delay, rs485-rx-during-tx, rs485-rts-active-low,
   linux,rs485-enabled-at-boot-time: see rs485.txt.
@@ -31,8 +38,11 @@ usart4: serial@40004c00 {
 	reg = <0x40004c00 0x400>;
 	interrupts = <52>;
 	clocks = <&clk_pclk1>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "sleep", "idle", "no_console_suspend";
 	pinctrl-0 = <&pinctrl_usart4>;
+	pinctrl-1 = <&pinctrl_usart4_sleep>;
+	pinctrl-2 = <&pinctrl_usart4_idle>;
+	pinctrl-3 = <&pinctrl_usart4>;
 };
 
 usart2: serial@40004400 {
-- 
1.9.1

