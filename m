Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE738CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C473321479
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="DPAfYLC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387937AbfJ2MrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:47:14 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:11868 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387900AbfJ2MrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:47:13 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9TCfxew000600;
        Tue, 29 Oct 2019 13:47:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=1nwd9gPkOqyupJiLN77jkobep/DMP0KgZrF3TOLlqdU=;
 b=DPAfYLC3ixkhLVGGKfYfNtx/qGTnPbsz022vAFZimP/swmM+C8fy1SXgfOw3Ztd1+0PP
 /f+vsC29zVtnPV1OnjIhYJDMPxAcNzqh9lU2/ZgH9GecUPaT9NSlRghOrXHwK9e3VsDv
 FvHWCgS4DlrYWSQ8COYGBFKYsYB+Ratb+TMO7EPLNF+MP6S1uPLnCvP1cPwPw9h32xR1
 FkjDwpaDvc0RiT5mcudcQLmjiOwIA5398JHESfDmW9sBvb7wcuuJQuXkauOm80GAQWJh
 K4LXLK08YmCS+Pf2zdYwtI7NcdVFht5LFZeTEMzrN4pNiJqnAk89zz8KKilg3tohG24B gg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2vvb98fuss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Oct 2019 13:47:02 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A5D8710002A;
        Tue, 29 Oct 2019 13:47:01 +0100 (CET)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9BB5D2BE234;
        Tue, 29 Oct 2019 13:47:01 +0100 (CET)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.44) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 29 Oct
 2019 13:47:01 +0100
Received: from localhost (10.201.22.141) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 29 Oct 2019 13:47:01
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 2/2] ARM: dts: stm32: change joystick pinctrl definition on stm32mp157c-ev1
Date:   Tue, 29 Oct 2019 13:46:51 +0100
Message-ID: <20191029124651.12625-3-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029124651.12625-1-amelie.delaunay@st.com>
References: <20191029124651.12625-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.22.141]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-29_04:2019-10-28,2019-10-29 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pins used for joystick are all configured as input. "push-pull" is not a
valid setting for an input pin.

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32mp157c-ev1.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index 3f7fcba3a516..3789312c8539 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -220,7 +220,6 @@
 
 			joystick_pins: joystick {
 				pins = "gpio0", "gpio1", "gpio2", "gpio3", "gpio4";
-				drive-push-pull;
 				bias-pull-down;
 			};
 		};
-- 
2.17.1

