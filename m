Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9DEC33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 13:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132C420643
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 13:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="0S5bzDvr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgAHN1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 08:27:08 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:20760 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726087AbgAHN1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 08:27:07 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 008DNeqh002687;
        Wed, 8 Jan 2020 14:26:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=mRBCKFBQg+ia5d/y2ZIbtPulwQsHjLNs+eoJZvCHQNY=;
 b=0S5bzDvr9G/QfG1gLoSSUu097SWxu5WB0FxASc79Xe6Bd3eDDdoyh2aaER7f9ra7VvoD
 KyDQ4AODoY48O9/qjJP9aCWNesEF2hGyofnl6H9znc1mwvjwD6eGqCWCvCFNE7TaBsXd
 9qZWIgIJvmP1SV85fMsEimVl4KpG1QXVLGnmsXr5DVF6fDO7hGyK1/eISiCgbW44jUHr
 ji1q0gtg8v+CTXoCEEOKDhXBBVkavJBl+pVkGa1hsmWtEDDO//E/6SZ02ox+qZd+943e
 j7C387tIO/mwKRdRnwmBQtprAikdQTIquIPcihE/W3fvsUG29GiaHupFkjrMjL8QAND2 cw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xakuqv23w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jan 2020 14:26:55 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0B2B510003B;
        Wed,  8 Jan 2020 14:26:51 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EA5732B772D;
        Wed,  8 Jan 2020 14:26:50 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 8 Jan 2020 14:26:50
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] ARM: dts: stm32: Add power-supply for RGB panel on stm32429i-eval
Date:   Wed, 8 Jan 2020 14:26:46 +0100
Message-ID: <20200108132647.26131-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG4NODE1.st.com (10.75.127.10) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-08_03:2020-01-08,2020-01-08 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a fixed regulator and use it as power supply for RBG panel.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/boot/dts/stm32429i-eval.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index 58288aa53fee..c27fa355e5ab 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -95,6 +95,13 @@
 		regulator-max-microvolt = <3300000>;
 	};
 
+	vdd_panel: vdd-panel {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_panel";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		green {
@@ -138,6 +145,7 @@
 
 	panel_rgb: panel-rgb {
 		compatible = "ampire,am-480272h3tmqw-t01h";
+		power-supply = <&vdd_panel>;
 		status = "okay";
 		port {
 			panel_in_rgb: endpoint {
-- 
2.15.0

