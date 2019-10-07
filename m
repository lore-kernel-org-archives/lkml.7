Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B840DC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F10E20684
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="q0TPlvDo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbfJGOeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:34:18 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:36912 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726334AbfJGOeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:34:18 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x97EVYlU021655;
        Mon, 7 Oct 2019 16:34:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=nv1TCeEQ/O9vBQCY+dZl79SaUra+CXgFAkJJgkjP1yE=;
 b=q0TPlvDo9zcqZmQtHJ2/Fk+ye+QckQfiWXRNbD4aAAjgZKcREHxkWU3fScfZ8uPfIVaX
 KzTwIJIBkb3GCuvyTH1C5Cwa5XRz7RCfi0aozmUF+Nrawhd0enzU1jmAgljyfcH1dpi5
 6pDqeZ3BVwoOPDtfdaJ2N2mp31CtzbMST0pabC93xjikUq3A8azoOlCfmiECbBBAAdl9
 iys1vrqveq6J4zE2I+uhSJpDZvb+i0Bxi+aoj8VfJKu4Pm5os6CjHe+YB2MOX4KrtLLe
 3Nvr+ZE9wu9p21mzw/AlicqC+Ueh5P8a+CSMEFFxyi1Dfc7aPXEPTM/6NgemHia+C18U kw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vegn0jw3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Oct 2019 16:34:06 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4BDE1100038;
        Mon,  7 Oct 2019 16:34:06 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 409E22AC883;
        Mon,  7 Oct 2019 16:34:06 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 7 Oct 2019 16:34:05
 +0200
From:   Alexandre Torgue <alexandre.torgue@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>, <arnd@arndb.de>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] ARM: dts: stm32: fix joystick node on stm32f746 and stm32mp157c eval boards
Date:   Mon, 7 Oct 2019 16:34:00 +0200
Message-ID: <20191007143402.13266-3-alexandre.torgue@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191007143402.13266-1-alexandre.torgue@st.com>
References: <20191007143402.13266-1-alexandre.torgue@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-07_02:2019-10-07,2019-10-07 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"#size-cells" entry is not needed for "gpio-keys" driver. Indeed "reg"
entry is not used. This commit will fix a warnings seen by DT validation
tool.

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

diff --git a/arch/arm/boot/dts/stm32746g-eval.dts b/arch/arm/boot/dts/stm32746g-eval.dts
index d7bb2027cfaa..fcc804e3c158 100644
--- a/arch/arm/boot/dts/stm32746g-eval.dts
+++ b/arch/arm/boot/dts/stm32746g-eval.dts
@@ -95,7 +95,6 @@
 
 	joystick {
 		compatible = "gpio-keys";
-		#size-cells = <0>;
 		pinctrl-0 = <&joystick_pins>;
 		pinctrl-names = "default";
 		button-0 {
diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index 89d29b50c3f4..6287db532e7d 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -32,7 +32,6 @@
 
 	joystick {
 		compatible = "gpio-keys";
-		#size-cells = <0>;
 		pinctrl-0 = <&joystick_pins>;
 		pinctrl-names = "default";
 		button-0 {
-- 
2.17.1

