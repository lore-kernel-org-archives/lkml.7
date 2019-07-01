Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C830C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A9B208C4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="tX1mNaJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbfGAJSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 05:18:54 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:53754 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728284AbfGAJSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 05:18:54 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x619BYrY020146;
        Mon, 1 Jul 2019 11:18:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=KIy5BakllxdZ3xXg+Q83R/MpzH9X3aj4n2maKUHUR+w=;
 b=tX1mNaJkfexbL9sT+Gk8U/rMpCocwcqwlpNbazhIYaMZcoM7+yUdfDOKZKsubVrj/4ht
 3NSgReFCRAF50ozCrjv8J5yBFSlAk3u4UgAgGemGCYd4Bdeo6eESFzD6h+PWI/DTp1dO
 E4Gsud7dhy8Vt3N/kOWftwAZIZaC1dpLf/WCfzkdJDUP8NtVdn82jGyREDh578Q7lBx/
 1FTHz5bKWCQlZghhHBYzbFPDgwaXMlXQ5jp/tTV5HQsefnQ10yllsLs3CtVmIbs/Dlvl
 sGb4FNaQoMNkUrhCtiT91vGgFZUqQjNhUAHvTharYk/v1UppsnPGh0lrouDkVdpgB2ZW gA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2tdxvhktqf-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 01 Jul 2019 11:18:38 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5405F34;
        Mon,  1 Jul 2019 09:18:37 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2B88E24EC;
        Mon,  1 Jul 2019 09:18:37 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 1 Jul 2019
 11:18:37 +0200
Received: from localhost (10.201.23.31) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 1 Jul 2019 11:18:36
 +0200
From:   Erwan Le Ray <erwan.leray@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <erwan.leray@st.com>, <bich.hemon@st.com>
Subject: [PATCH] ARM: dts: stm32: fix -Wall W=1 compilation warnings for can1_sleep pinctrl
Date:   Mon, 1 Jul 2019 11:18:06 +0200
Message-ID: <1561972686-23281-1-git-send-email-erwan.leray@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.31]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-01_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix compilations warnings detected by -Wall W=1 compilation option:
- node has a unit name, but no reg property

Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
index 140a983..ce98fd8 100644
--- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
@@ -427,7 +427,7 @@
 				};
 			};
 
-			m_can1_sleep_pins_a: m_can1-sleep@0 {
+			m_can1_sleep_pins_a: m_can1-sleep-0 {
 				pins {
 					pinmux = <STM32_PINMUX('H', 13, ANALOG)>, /* CAN1_TX */
 						 <STM32_PINMUX('I', 9, ANALOG)>; /* CAN1_RX */
-- 
1.9.1

