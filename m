Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68F3C31E56
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC5A2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="lXEL++QN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbfFQIuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 04:50:54 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:2200 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725826AbfFQIuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 04:50:52 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5H8faGH018088;
        Mon, 17 Jun 2019 10:50:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=mKq6aXRt6yPdvv0WN1RsD2U79XJ8Gb1nUEC8uornMGc=;
 b=lXEL++QNAZxVCrBJMcQ3hfh4I5HKtmd5STDTD4YVF6nQjaTCtoEimMpUIUr9lyJhj9v0
 fEMxnPguKtPsD9ZLF6qf3K6Ct6/OkTIaYttCe3EgOljrxllyJoBeoN8517uSjrWWh7ty
 Ior/IDc/F4EM7Ni0o6/bw0kmUP9iE5nz+x0UWtQWIx4bgkkkRjE4YcTAbEY6tC317Xx+
 UWypLPYJZLEL7tVt5VEZVn/V/A0plkgXhZbRJgdUJ08bg/fL25kNA1AdVMMBfkg0yBN1
 D5SL7os/TCvcKZLzdy3zhXGVoGbaroguwZUa9Sr4gMGaPPD7PCdENpgCDZj9FOKOmxkW mQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2t4p519f5m-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 17 Jun 2019 10:50:33 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 737F538;
        Mon, 17 Jun 2019 08:50:32 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4133D246F;
        Mon, 17 Jun 2019 08:50:32 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 17 Jun
 2019 10:50:31 +0200
Received: from localhost (10.201.22.222) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 17 Jun 2019 10:50:31
 +0200
From:   Christophe Roullier <christophe.roullier@st.com>
To:     <robh@kernel.org>, <davem@davemloft.net>, <joabreu@synopsys.com>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <peppe.cavallaro@st.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <christophe.roullier@st.com>, <andrew@lunn.ch>
Subject: [PATCH  1/1] ARM: dts: stm32: replace rgmii mode with rgmii-id on stm32mp15 boards
Date:   Mon, 17 Jun 2019 10:50:18 +0200
Message-ID: <20190617085018.20352-2-christophe.roullier@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190617085018.20352-1-christophe.roullier@st.com>
References: <20190617085018.20352-1-christophe.roullier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.22.222]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-17_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On disco and eval board, Tx and Rx delay are applied (pull-up of 4.7k
put on VDD) so which correspond to RGMII-ID mode with internal RX and TX
delays provided by the PHY, the MAC should not add the RX or TX delays
in this case

Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
---
 arch/arm/boot/dts/stm32mp157a-dk1.dts | 2 +-
 arch/arm/boot/dts/stm32mp157c-ev1.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp157a-dk1.dts b/arch/arm/boot/dts/stm32mp157a-dk1.dts
index 098dbfb06b61..2c105740dfad 100644
--- a/arch/arm/boot/dts/stm32mp157a-dk1.dts
+++ b/arch/arm/boot/dts/stm32mp157a-dk1.dts
@@ -51,7 +51,7 @@
 	pinctrl-0 = <&ethernet0_rgmii_pins_a>;
 	pinctrl-1 = <&ethernet0_rgmii_pins_sleep_a>;
 	pinctrl-names = "default", "sleep";
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	max-speed = <1000>;
 	phy-handle = <&phy0>;
 
diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index b6aca40b9b90..ab1393caf799 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -79,7 +79,7 @@
 	pinctrl-0 = <&ethernet0_rgmii_pins_a>;
 	pinctrl-1 = <&ethernet0_rgmii_pins_sleep_a>;
 	pinctrl-names = "default", "sleep";
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	max-speed = <1000>;
 	phy-handle = <&phy0>;
 
-- 
2.17.1

