Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACDEC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6CAD20850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="xEh8ra8l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbfDJKLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:11:14 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:54721 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728409AbfDJKLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:11:14 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3A9pWi9020144;
        Wed, 10 Apr 2019 12:02:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=CTjBmZ/8Y8sJIntk4HY3GIldUOqlwVPxpqC9dk1e2Xg=;
 b=xEh8ra8lbWjLeIpLlXGN5yLjXmtOQcOeXLNq7Z2rDhccAojsr9meuJJFw3SS2Mgs4YT6
 kKKTP2F4R4xzDHznA5x/X2Aobiw3jU9OkPq58SCyccpI5JKhvTtE6gzf2eUTqwRoFW8l
 PZgOdVWVK2HVQtF4u8dQYYWn0LOXX6OlX5v/jD22FCJ6sAZZXiFILrK3QIYylBLfLZbm
 wBFHrnaF7Ao0+uNppG/04bdYIycY9hDOxl24wGg/fBBJr+YSbbkK2Rx5lQwhUNYKxXGx
 Ht6AXd62eSFNqrXYBaLd34g7Pi16AktYkiyMB2gLUyJQRh8S74lmOkSytycQPLjKug9X zw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rse7881st-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 10 Apr 2019 12:02:33 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 50C4931;
        Wed, 10 Apr 2019 10:02:33 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3A9891393;
        Wed, 10 Apr 2019 10:02:33 +0000 (GMT)
Received: from localhost (10.75.127.44) by SFHDAG5NODE2.st.com (10.75.127.14)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 10 Apr 2019 12:02:32
 +0200
From:   Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH v2 3/3] ARM: dts: stm32: enable Vivante GPU support on stm32mp157a-dk1 board
Date:   Wed, 10 Apr 2019 12:02:28 +0200
Message-ID: <1554890548-24448-4-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554890548-24448-1-git-send-email-pierre-yves.mordret@st.com>
References: <1554890548-24448-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-10_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Vivante GPU driver for stm32mp157a-dk1 and dk2 boards.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v2:
       * move GPU reserved memeory out of bottom DDR to let free this area for
         U-Boot
    v1:
       * Initial
---
---
 arch/arm/boot/dts/stm32mp157a-dk1.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157a-dk1.dts b/arch/arm/boot/dts/stm32mp157a-dk1.dts
index 1b1886d..bd06f7b 100644
--- a/arch/arm/boot/dts/stm32mp157a-dk1.dts
+++ b/arch/arm/boot/dts/stm32mp157a-dk1.dts
@@ -27,6 +27,17 @@
 		reg = <0xc0000000 0x20000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		gpu_reserved: gpu@d4000000 {
+			reg = <0xd4000000 0x4000000>;
+			no-map;
+		};
+	};
+
 	led {
 		compatible = "gpio-leds";
 		blue {
@@ -69,6 +80,11 @@
 	status = "okay";
 };
 
+&gpu {
+	contiguous-area = <&gpu_reserved>;
+	status = "okay";
+};
+
 &iwdg2 {
 	timeout-sec = <32>;
 	status = "okay";
-- 
2.7.4

