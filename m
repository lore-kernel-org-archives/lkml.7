Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31C8C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF51C214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="jdxTh2zw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388615AbfDRJif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:38:35 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41760 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733049AbfDRJiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:38:15 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3I9bP6r020923;
        Thu, 18 Apr 2019 11:37:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=S+jXHzqJzO8dYDC4B9p830YLJ4bHofW7wA0ryRXwhPw=;
 b=jdxTh2zw8M/uLYuzj2aKQKAW8obz6lzepVb1JE6L6i5DqbladiABTfoFwPIHU1TkrUGk
 12UjiEc/rVDqmpIkifpMW5Of9s3u0o2hBoJ0PdAYueQZBV+RY6hb8pCbPGJcx1Yu19w8
 7ctoZ2FvVAF2ZGihkkOql89daSyC0JnktarAS2mgD81/dJ+lKMUPLbH5qTKa8tXld/vy
 Pf1rFypLehpWkfhNPOy6vonjhSUy+l7M7KBhJjrAKY53c689ybPUwHSS47c2fylHvaul
 X8GS0MdFLtwvwH0JlXI6F+/8n0cskzuilRppTsAA5MoOdmONll+9z+wtBVyhkQdCVuLS Pw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2ru6nh4yck-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 18 Apr 2019 11:37:58 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DA29331;
        Thu, 18 Apr 2019 09:37:57 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A9669159F;
        Thu, 18 Apr 2019 09:37:57 +0000 (GMT)
Received: from localhost (10.75.127.45) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 18 Apr 2019 11:37:57
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <thierry.reding@gmail.com>
CC:     <robh+dt@kernel.org>, <u.kleine-koenig@pengutronix.de>,
        <tduszyns@gmail.com>, <mark.rutland@arm.com>,
        <alexandre.torgue@st.com>, <mcoquelin.stm32@gmail.com>,
        <fabrice.gasnier@st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [RESEND PATCH v5 1/3] dt-bindings: pwm-stm32-lp: document pinctrl sleep state
Date:   Thu, 18 Apr 2019 11:37:45 +0200
Message-ID: <1555580267-29299-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555580267-29299-1-git-send-email-fabrice.gasnier@st.com>
References: <1555580267-29299-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-18_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for pinctrl sleep state on STM32 LPTimer PWM.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt
index bd23302..6521bc4 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt
@@ -11,8 +11,10 @@ Required parameters:
 			bindings defined in pwm.txt.
 
 Optional properties:
-- pinctrl-names: 	Set to "default".
-- pinctrl-0: 		Phandle pointing to pin configuration node for PWM.
+- pinctrl-names: 	Set to "default". An additional "sleep" state can be
+			defined to set pins in sleep state when in low power.
+- pinctrl-n: 		Phandle(s) pointing to pin configuration node for PWM,
+			respectively for "default" and "sleep" states.
 
 Example:
 	timer@40002400 {
@@ -21,7 +23,8 @@ Example:
 		pwm {
 			compatible = "st,stm32-pwm-lp";
 			#pwm-cells = <3>;
-			pinctrl-names = "default";
+			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&lppwm1_pins>;
+			pinctrl-1 = <&lppwm1_sleep_pins>;
 		};
 	};
-- 
2.7.4

