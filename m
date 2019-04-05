Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0E4C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2BB3217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="XXoW+7Ss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbfDEHx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 03:53:59 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:53203 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726594AbfDEHx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 03:53:58 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x357pETq020151;
        Fri, 5 Apr 2019 09:53:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=28xcdt7ECA8HE3zOStPC0IUbTNdk8VWd3DquM7I3DdA=;
 b=XXoW+7Ss1rRT6ZI6J5Y/KwpaBuv+YEPfjYBYX9nEJhbChD8mH/lGsNFZsebUAhZUb+YU
 +I9CpQVnhJktjBsJLaVKRiIx8JWAmY9ycqjNcXQniPNLnmkERixT33Mjld+bLqA6JEjY
 ateQrpaAAWWiRMx/Krhoyhn/zuD7xp1d1Fx2p64N4hPvbmJOlcWIKCKbXEfAR6th4bu3
 Z73wGHf5b3EjAxcKB8y/N3zQKHd4/H3MtXDWFILZf+P5Ud7zdvnHUFvbTSzo9jpTqUqz
 AliF25c8UjuhVJRLhrtSBhRlDS3wbdwpqjsEpMe6IBrKpJE+9F1o/HDmlpDki0W3uLO3 iA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rmgevfrf6-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 05 Apr 2019 09:53:50 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 60E0031;
        Fri,  5 Apr 2019 07:53:50 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag4node2.st.com [10.75.127.11])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3D01F1E3B;
        Fri,  5 Apr 2019 07:53:50 +0000 (GMT)
Received: from localhost (10.75.127.50) by SFHDAG4NODE2.st.com (10.75.127.11)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 5 Apr 2019 09:53:49
 +0200
From:   Gabriel Fernandez <gabriel.fernandez@st.com>
To:     michael turquette <mturquette@baylibre.com>,
        stephen boyd <sboyd@kernel.org>,
        rob herring <robh+dt@kernel.org>,
        mark rutland <mark.rutland@arm.com>,
        maxime coquelin <mcoquelin.stm32@gmail.com>,
        alexandre torgue <alexandre.torgue@st.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Gabriel Fernandez <gabriel.fernandez@st.com>
Subject: [PATCH 2/2] ARM: dts: stm32: Enable STM32F769 clock driver
Date:   Fri, 5 Apr 2019 09:53:32 +0200
Message-ID: <20190405075332.28530-3-gabriel.fernandez@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190405075332.28530-1-gabriel.fernandez@st.com>
References: <20190405075332.28530-1-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-05_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables clocks for STM32F769 boards.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 arch/arm/boot/dts/stm32f769-disco.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f769-disco.dts b/arch/arm/boot/dts/stm32f769-disco.dts
index 3c7216844a9b..6f1d0ac8c31c 100644
--- a/arch/arm/boot/dts/stm32f769-disco.dts
+++ b/arch/arm/boot/dts/stm32f769-disco.dts
@@ -102,6 +102,10 @@
 	};
 };
 
+&rcc {
+	compatible = "st,stm32f769-rcc", "st,stm32f746-rcc", "st,stm32-rcc";
+};
+
 &cec {
 	pinctrl-0 = <&cec_pins_a>;
 	pinctrl-names = "default";
-- 
2.17.1

