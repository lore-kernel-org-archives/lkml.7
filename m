Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08B5C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7123A2070B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="gXvIsmAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387970AbfJDMy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 08:54:27 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:57822 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387690AbfJDMyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 08:54:25 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x94Cpg40007976;
        Fri, 4 Oct 2019 14:54:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=rnzvoLapup62xEU3qg28JHDE/fN/lvzvSo1oUmE5lRo=;
 b=gXvIsmAwnIC3KiMLDDGzeZtiwm3CDgVZJiZdxRVGlJ56oif6xSepVCbuMwhZx3CNGp4w
 7HKx0y+sTIDRSPvnO6ULI5wLMTEziPSpq2poz6ReTzFBXLNwr678DOOmFMaAq/0QtMv7
 NO4D5ojBZfsNirkE2TbOfSpP0R/y7mC7B1/uh9NtAzeLqhR/1Lxp932AhLGW0hJ+iFqd
 w42w1hrcn210XWLIEQ8jToKTRndNqVrUvG4fOlF8+G1Y+cYF5oZDQSveLqso4/EaJYn4
 JLGW3J6Xr4sr+rB9UIsPEkrKrDBJh9p2l44YyfOOVHGpSVTHj5SB2g8whu88Z5fA0SMs jA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vcem3fwgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Oct 2019 14:54:11 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 27F7D100034;
        Fri,  4 Oct 2019 14:54:11 +0200 (CEST)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 11F422BFDEE;
        Fri,  4 Oct 2019 14:54:11 +0200 (CEST)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.92) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 4 Oct 2019
 14:54:10 +0200
Received: from localhost (10.48.0.192) by Webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 4 Oct 2019 14:54:10 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <u.kleine-koenig@pengutronix.de>
CC:     <alexandre.torgue@st.com>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <benjamin.gaignard@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 1/3] dt-bindings: pwm-stm32: document pinctrl sleep state
Date:   Fri, 4 Oct 2019 14:53:51 +0200
Message-ID: <1570193633-6600-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570193633-6600-1-git-send-email-fabrice.gasnier@st.com>
References: <1570193633-6600-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.192]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-04_06:2019-10-03,2019-10-04 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for pinctrl sleep state that can be used by
STM32 timers PWM.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 Documentation/devicetree/bindings/pwm/pwm-stm32.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
index a8690bf..f1620c1 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
@@ -5,8 +5,9 @@ See ../mfd/stm32-timers.txt for details about the parent node.
 
 Required parameters:
 - compatible:		Must be "st,stm32-pwm".
-- pinctrl-names: 	Set to "default".
-- pinctrl-0: 		List of phandles pointing to pin configuration nodes for PWM module.
+- pinctrl-names: 	Set to "default". An additional "sleep" state can be
+			defined to set pins in sleep state when in low power.
+- pinctrl-n: 		List of phandles pointing to pin configuration nodes for PWM module.
 			For Pinctrl properties see ../pinctrl/pinctrl-bindings.txt
 - #pwm-cells:		Should be set to 3. This PWM chip uses the default 3 cells
 			bindings defined in pwm.txt.
@@ -32,7 +33,8 @@ Example:
 			compatible = "st,stm32-pwm";
 			#pwm-cells = <3>;
 			pinctrl-0	= <&pwm1_pins>;
-			pinctrl-names	= "default";
+			pinctrl-1	= <&pwm1_sleep_pins>;
+			pinctrl-names	= "default", "sleep";
 			st,breakinput = <0 1 5>;
 		};
 	};
-- 
2.7.4

