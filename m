Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31F5C17467
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA89521D7F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="c2Q9V9yH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388991AbfKEMwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 07:52:55 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:26182 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388833AbfKEMws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:52:48 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA5Cq9ZK024543;
        Tue, 5 Nov 2019 13:52:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=xEGD8vXEOIUdaCKgzE5zRyL6GzL6CnxaGb454HU1N+w=;
 b=c2Q9V9yH3NCkJPvVriKRUF4VjJGb76DcOGFqDaVxGRGJ9EuT0WCIKIF5fBqeM6ITVPJN
 +k3NAv6acFjr9gKt9EADlVQs+2OUx6HPIKoiDdvz5Ea6MtGiPSn3j9U96jWf0qB+FDyO
 UPGTdLH2VQPAcySgp8xvkGclvB5a9dGqjLNMZu/l8qfDUoEPGaKkm0UQlOmjjcmSaje1
 ajGXb890Gw4/G57kdG9A79cAWUhYXEy3Iy6YL1lKqQIL378rkuZZdzT2cwLogVJAKtPz
 +ok5dj8iV/mmkeJs/yQJAwp4+3tNXfTzCeVuYPm1FYymXowJA/l4k8ProdGYyAj7S2u+ 0A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2w0ytcr0bu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Nov 2019 13:52:38 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 00DF8100034;
        Tue,  5 Nov 2019 13:52:38 +0100 (CET)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E892E2BC5E5;
        Tue,  5 Nov 2019 13:52:37 +0100 (CET)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.46) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 5 Nov 2019
 13:52:37 +0100
Received: from localhost (10.48.0.192) by webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 5 Nov 2019 13:52:37 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <alexandre.torgue@st.com>
CC:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@st.com>
Subject: [PATCH 4/4] ARM: dts: stm32: add support for PWM on stm32mp157a-dk1
Date:   Tue, 5 Nov 2019 13:52:21 +0100
Message-ID: <1572958341-12404-5-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572958341-12404-1-git-send-email-fabrice.gasnier@st.com>
References: <1572958341-12404-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.192]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-05_04:2019-11-05,2019-11-05 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PWM support on stm32mp157a-dk1 board. There are several timers channels
made available on GPIO expansion and arduino connectors:
- Add PWM and trigger support (these timers can also be used as trigger
  for ADC).
It's easier then to configure them all. But keep them disabled by default,
so the pins are kept in their initial state to lower power consumption.
This way they can also be used as GPIO.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32mp157a-dk1.dts | 85 +++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157a-dk1.dts b/arch/arm/boot/dts/stm32mp157a-dk1.dts
index 984a47c..d4e37ab 100644
--- a/arch/arm/boot/dts/stm32mp157a-dk1.dts
+++ b/arch/arm/boot/dts/stm32mp157a-dk1.dts
@@ -502,6 +502,91 @@
 	status = "okay";
 };
 
+&timers1 {
+	/* spare dmas for other usage */
+	/delete-property/dmas;
+	/delete-property/dma-names;
+	status = "disabled";
+	pwm {
+		pinctrl-0 = <&pwm1_pins_a>;
+		pinctrl-1 = <&pwm1_sleep_pins_a>;
+		pinctrl-names = "default", "sleep";
+		status = "okay";
+	};
+	timer@0 {
+		status = "okay";
+	};
+};
+
+&timers3 {
+	/delete-property/dmas;
+	/delete-property/dma-names;
+	status = "disabled";
+	pwm {
+		pinctrl-0 = <&pwm3_pins_a>;
+		pinctrl-1 = <&pwm3_sleep_pins_a>;
+		pinctrl-names = "default", "sleep";
+		status = "okay";
+	};
+	timer@2 {
+		status = "okay";
+	};
+};
+
+&timers4 {
+	/delete-property/dmas;
+	/delete-property/dma-names;
+	status = "disabled";
+	pwm {
+		pinctrl-0 = <&pwm4_pins_a &pwm4_pins_b>;
+		pinctrl-1 = <&pwm4_sleep_pins_a &pwm4_sleep_pins_b>;
+		pinctrl-names = "default", "sleep";
+		status = "okay";
+	};
+	timer@3 {
+		status = "okay";
+	};
+};
+
+&timers5 {
+	/delete-property/dmas;
+	/delete-property/dma-names;
+	status = "disabled";
+	pwm {
+		pinctrl-0 = <&pwm5_pins_a>;
+		pinctrl-1 = <&pwm5_sleep_pins_a>;
+		pinctrl-names = "default", "sleep";
+		status = "okay";
+	};
+	timer@4 {
+		status = "okay";
+	};
+};
+
+&timers6 {
+	/delete-property/dmas;
+	/delete-property/dma-names;
+	status = "disabled";
+	timer@5 {
+		status = "okay";
+	};
+};
+
+&timers12 {
+	/delete-property/dmas;
+	/delete-property/dma-names;
+	status = "disabled";
+	pwm {
+		pinctrl-0 = <&pwm12_pins_a>;
+		pinctrl-1 = <&pwm12_sleep_pins_a>;
+		pinctrl-names = "default", "sleep";
+		status = "okay";
+	};
+	timer@11 {
+		status = "okay";
+	};
+};
+
 &uart4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart4_pins_a>;
-- 
2.7.4

