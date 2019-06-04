Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE24C28D17
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8631024C4A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="wbdxU1Rh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfFDIzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:55:48 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52690 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726883AbfFDIzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:55:47 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x548tJOm021222;
        Tue, 4 Jun 2019 10:55:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=Psif9qopZgVPe8dWo9XocFzMybtKO3gMouXdNYlMSBI=;
 b=wbdxU1RhcrRqVd8GvtqUF6E7gD45eJui7EOW9VT0NrZAAAamgNDp17bfkn2af+pcbb6x
 clO1KwCb1DpWZwmc06+ExO2LBRKXzSLOXGRGSacVPY29fY5kAa2BP/z7nHjHPAWWleus
 8+EqGjTp1KPoJ6tNdNsy/IFNZvMvdfP9CwP0ulmAuJ+FMOwappLa90LWWZf5bfbCv2af
 UyzaYF0piRFO/Co6KSYpRCuhuwwjDSqf02ljJBJzKtB2aZuhYQCvGM8tvzRYQDQV5kxY
 cvo1eQEbpiSLoWGig77MQ+JqPpfgh7oSeqBzimn3K0ZfNqILvTUlwzPcuLMfnY+HdXmb qA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2sundrynh0-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 04 Jun 2019 10:55:33 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 42A9315E;
        Tue,  4 Jun 2019 08:55:28 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1974F2503;
        Tue,  4 Jun 2019 08:55:28 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 4 Jun 2019
 10:55:28 +0200
Received: from localhost (10.201.23.31) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 4 Jun 2019 10:55:26
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
Subject: [PATCH 02/10] dt-bindings: serial: add optional pinctrl states
Date:   Tue, 4 Jun 2019 10:55:11 +0200
Message-ID: <1559638519-6128-3-git-send-email-erwan.leray@st.com>
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

