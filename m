Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEC6C06510
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D928B20B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="b729Gy3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfGAIPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 04:15:18 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:37794 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727944AbfGAIPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 04:15:14 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x618ASXC004695;
        Mon, 1 Jul 2019 10:15:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=gFZXnm/IaqS/lZZLWx/8MO4ceDiguvcxpYNkcDkG8Ug=;
 b=b729Gy3D+8FM1VqOdqGZ64Zo98NHkQ/iPu3MYYVADy7BdKya/4oOW1yrH6Q7vio5v5tq
 njQx38cYogDzFpD5thOdNJwXYLq9MvQnWzpaIA1TFF2fYEGwrkiVtkN7tw2kl7xFUAMY
 SZ6XY/yngiI7mJwQ9M3wf9fs3gx9CINYYEOlCJGCakSQSbPPC6y0S4S4JppMkgzVdzNs
 xAHRyVniYa+xofUfd/4fS66X4yZG7bMuGdJ+IYcDuOfjlTFHUlZ1WC/hAGuEyF85nIbG
 rZQ/aFSIPx3XFzkxA7XU8o0y4V7AXtL0c1GpknYpHMYz9/lOZprOt1GTp4bfMS8gifrf xQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2tdxvhkefe-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 01 Jul 2019 10:14:35 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 829AB46;
        Mon,  1 Jul 2019 08:14:34 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 506701C33;
        Mon,  1 Jul 2019 08:14:34 +0000 (GMT)
Received: from localhost (10.75.127.51) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 1 Jul 2019 10:14:33
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <alexandre.torgue@st.com>
CC:     <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 1/4] dt-bindings: regulator: add support for the stm32-booster
Date:   Mon, 1 Jul 2019 10:14:22 +0200
Message-ID: <1561968865-22037-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561968865-22037-1-git-send-email-fabrice.gasnier@st.com>
References: <1561968865-22037-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-01_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the 3.3V booster regulator embedded in stm32h7 and stm32mp1
devices, that can be used to supply ADC analog input switches.
It's controlled by using system configuration registers (SYSCFG).
Introduce two compatibles as the booster regulator is controlled by:
- a unique register/bit in STM32H7
- a set/clear register pair in STM32MP1

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 .../devicetree/bindings/regulator/st,stm32-booster.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/st,stm32-booster.txt

diff --git a/Documentation/devicetree/bindings/regulator/st,stm32-booster.txt b/Documentation/devicetree/bindings/regulator/st,stm32-booster.txt
new file mode 100644
index 0000000..479ad4c
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/st,stm32-booster.txt
@@ -0,0 +1,18 @@
+STM32 BOOSTER - Booster for ADC analog input switches
+
+Some STM32 devices embed a 3.3V booster supplied by Vdda, that can be used
+to supply ADC analog input switches.
+
+Required properties:
+- compatible: Should be one of:
+  "st,stm32h7-booster"
+  "st,stm32mp1-booster"
+- st,syscfg: Phandle to system configuration controller.
+- vdda-supply: Phandle to the vdda input analog voltage.
+
+Example:
+	booster: regulator-booster {
+		compatible = "st,stm32mp1-booster";
+		st,syscfg = <&syscfg>;
+		vdda-supply = <&vdda>;
+	};
-- 
2.7.4

