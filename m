Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64E4C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69672133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="RtZgXR2a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfDIJIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:08:17 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:33989 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726463AbfDIJIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:08:15 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x398pR2a001068;
        Tue, 9 Apr 2019 11:07:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=Ln+cE2iR3bWe9OqMk89pox5DsPtivX4AI1CiOXAnqAA=;
 b=RtZgXR2aeQM2u5lA9pX+ROgBwwByMdF60SzHkIzM/u4DIUlBh3Zi4pTf6NhLdjKOlN87
 OouRRHDcG1Ij6T2a7ouxU2tXFM+Tq9bZk72LL4oaAGEBk62nxOtmR41lYkXO1bTlsB47
 LnLlGkdiGXQSbgcyTc68bNhWLFvvQE7ILsuuDwds2IYRm7BDLI1LHOugq8m7Gufdy/6Q
 5ihxnh71sboMdHn37HRnqzb406EP4DGb4zEzqvL3urUB0Q93kzhVbLPXyFYtYhlyyaxg
 Ra3HtNiPifznO6DhZ7r1e3a1qjlwFk7Yu2xy+scapAD7zYflz0nxBhE7+6tfts4rzm8/ RQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rprkdfn0j-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 09 Apr 2019 11:07:05 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B6D8138;
        Tue,  9 Apr 2019 09:07:04 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 819C92749;
        Tue,  9 Apr 2019 09:07:04 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 9 Apr
 2019 11:07:04 +0200
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Tue, 9 Apr 2019 11:07:04 +0200
From:   Pascal PAILLET-LME <p.paillet@st.com>
To:     "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "olof@lixom.net" <olof@lixom.net>, "arnd@arndb.de" <arnd@arndb.de>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "biju.das@bp.renesas.com" <biju.das@bp.renesas.com>,
        Yannick FERTRE <yannick.fertre@st.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Pascal PAILLET-LME <p.paillet@st.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 3/3] ARM: multi_v7_defconfig: Enable support for STPMIC1
Thread-Topic: [PATCH v2 3/3] ARM: multi_v7_defconfig: Enable support for
 STPMIC1
Thread-Index: AQHU7rOZF5uv7QhRukKTDkHEEhAoAA==
Date:   Tue, 9 Apr 2019 09:07:04 +0000
Message-ID: <1554800820-5412-4-git-send-email-p.paillet@st.com>
References: <1554800820-5412-1-git-send-email-p.paillet@st.com>
In-Reply-To: <1554800820-5412-1-git-send-email-p.paillet@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-09_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STPMIC1 is a PMIC from STMicroelectronics. The STPMIC1 integrates 10
regulators, 3 power switches, a watchdog and an input for a power on key.

Signed-off-by: Pascal Paillet <p.paillet@st.com>
---
 arch/arm/configs/multi_v7_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v=
7_defconfig
index c75051b..2e9fa53 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -299,6 +299,7 @@ CONFIG_INPUT_MAX8997_HAPTIC=3Dm
 CONFIG_INPUT_CPCAP_PWRBUTTON=3Dm
 CONFIG_INPUT_AXP20X_PEK=3Dm
 CONFIG_INPUT_ADXL34X=3Dm
+CONFIG_INPUT_STPMIC1_ONKEY=3Dy
 CONFIG_SERIO_AMBAKMI=3Dy
 CONFIG_SERIAL_8250=3Dy
 CONFIG_SERIAL_8250_CONSOLE=3Dy
@@ -486,6 +487,7 @@ CONFIG_TEGRA_WATCHDOG=3Dm
 CONFIG_MESON_WATCHDOG=3Dy
 CONFIG_DIGICOLOR_WATCHDOG=3Dy
 CONFIG_RENESAS_WDT=3Dm
+CONFIG_STPMIC1_WATCHDOG=3Dy
 CONFIG_BCM47XX_WDT=3Dy
 CONFIG_BCM2835_WDT=3Dy
 CONFIG_BCM_KONA_WDT=3Dy
@@ -527,6 +529,7 @@ CONFIG_MFD_TPS65218=3Dy
 CONFIG_MFD_TPS6586X=3Dy
 CONFIG_MFD_TPS65910=3Dy
 CONFIG_MFD_STM32_LPTIMER=3Dm
+CONFIG_MFD_STPMIC1=3Dy
 CONFIG_REGULATOR_ACT8865=3Dy
 CONFIG_REGULATOR_ACT8945A=3Dy
 CONFIG_REGULATOR_ANATOP=3Dy
@@ -559,6 +562,7 @@ CONFIG_REGULATOR_RN5T618=3Dy
 CONFIG_REGULATOR_S2MPS11=3Dy
 CONFIG_REGULATOR_S5M8767=3Dy
 CONFIG_REGULATOR_STM32_VREFBUF=3Dm
+CONFIG_REGULATOR_STPMIC1=3Dy
 CONFIG_REGULATOR_TI_ABB=3Dy
 CONFIG_REGULATOR_TPS51632=3Dy
 CONFIG_REGULATOR_TPS62360=3Dy
--=20
1.9.1
