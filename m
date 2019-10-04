Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6B0C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C002D207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="I2csExbB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388422AbfJDNVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:21:24 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:35396 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388313AbfJDNVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:21:23 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x94DLFI7001754;
        Fri, 4 Oct 2019 15:21:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=9Uex5pTCkhp4v8CMWAiUWlq97PLFUphIHvTvPnjz9jk=;
 b=I2csExbB326H9vM0Ed1LTD8ceGt2FGDV3BkbfYTOzMVxxOPSg2F+glSGDKrK/AfV1k/L
 yMWDbitX7LXxb8FUMpzP0Ih2CBhLHxxcUOmvnKd5SPg3vqq6hrqZv/G2anYlj/OnxT12
 Oazv7elhxpnnWW2/hctDa2QLG004/43nO4sg+yoHhGzYHTT656Ei8v9UI5mmKF5SXlxz
 gjGPH+xylHeN65JODXEW3gXZQz00QLg9SSeSlJ488jwPSyg3/6trsA72UDLWrzHqN7DQ
 9U8TihQi/9PGF5q7xjwInI6QzZL1pdaZlnaeuYJR+Hg//Wce1xB99Xiuon5u/p4FucgF zw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2v9xdhau44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Oct 2019 15:21:15 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C993B10002A;
        Fri,  4 Oct 2019 15:21:09 +0200 (CEST)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B8A4C2C434C;
        Fri,  4 Oct 2019 15:21:09 +0200 (CEST)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 4 Oct 2019
 15:21:09 +0200
Received: from localhost (10.201.23.97) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 4 Oct 2019 15:21:09
 +0200
From:   =?UTF-8?q?Yannick=20Fertr=C3=A9?= <yannick.fertre@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH] ARM: dts: stm32: add focaltech touchscreen on stm32mp157c-dk2 board
Date:   Fri, 4 Oct 2019 15:17:02 +0200
Message-ID: <1570195022-23327-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.23.97]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-04_06:2019-10-03,2019-10-04 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable focaltech ft6236 touchscreen on STM32MP157C-DK2 board.

Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
---
 arch/arm/boot/dts/stm32mp157c-dk2.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-dk2.dts b/arch/arm/boot/dts/stm32mp157c-dk2.dts
index 20ea601..d44a7c6 100644
--- a/arch/arm/boot/dts/stm32mp157c-dk2.dts
+++ b/arch/arm/boot/dts/stm32mp157c-dk2.dts
@@ -61,6 +61,19 @@
 	};
 };
 
+&i2c1 {
+	touchscreen@38 {
+		compatible = "focaltech,ft6236";
+		reg = <0x38>;
+		interrupts = <2 2>;
+		interrupt-parent = <&gpiof>;
+		interrupt-controller;
+		touchscreen-size-x = <480>;
+		touchscreen-size-y = <800>;
+		status = "okay";
+	};
+};
+
 &ltdc {
 	status = "okay";
 
-- 
2.7.4

