Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BF1CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED82217F5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="BjdLQQ1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbfKDKzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 05:55:49 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:10480 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727771AbfKDKzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:55:47 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA4AtJ63011818;
        Mon, 4 Nov 2019 11:55:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=b8YspRAaoetqeQ0AOmzT0Wn61T1GntjuB/aZCDQVJfI=;
 b=BjdLQQ1ihUa4pmNq3LHS8oiHwfXRF2/ZE6/Veoeie1mBMskvtdsjEI+99eXuRVlcGaKX
 QJ3Vu+LAygF7ceIHCQKAvZwl1QOxfVt1L+jkSwmZzxCS8DePWTy5Os97TrEUEkMwGMNC
 4GzM8Q1mSQksmnFh595qcdZ4DYN5RNMwGJsOFfA9KBZiuXLrAq+nnePMQ7LkD0odDnVA
 u8TmAD8aAOrC1LgQkDQX3pLGaxqxfbUm42OelwYRtlfSzjzBWIx3MpAs9hcoQ3f1QqD7
 y2256RTRTTVblicJRl0rXUR73l1Wtnq2J/ZANSqSIEcL6o4Y2tWhWZyf3rNTuSJIo/Ol bg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2w0ytchn2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 11:55:38 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D762010002A;
        Mon,  4 Nov 2019 11:55:37 +0100 (CET)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C5ED72BDA96;
        Mon,  4 Nov 2019 11:55:37 +0100 (CET)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 4 Nov 2019
 11:55:37 +0100
Received: from localhost (10.201.22.141) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 4 Nov 2019 11:55:36
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
Subject: [PATCH v2 2/2] ARM: dts: stm32: change joystick pinctrl definition on stm32mp157c-ev1
Date:   Mon, 4 Nov 2019 11:55:29 +0100
Message-ID: <20191104105529.8049-3-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191104105529.8049-1-amelie.delaunay@st.com>
References: <20191104105529.8049-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.22.141]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-04_08:2019-11-04,2019-11-04 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pins used for joystick are all configured as input. "push-pull" is not a
valid setting for an input pin.

Fixes: a502b343ebd0 ("pinctrl: stmfx: update pinconf settings")
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

