Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D01C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 10:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD302084B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 10:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="DpgqOeuI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfD2KEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 06:04:16 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:36182 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727820AbfD2KEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 06:04:04 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3TA2515025587;
        Mon, 29 Apr 2019 12:03:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=22Q4dOcM7XTrNOZYvE/T6BS+Fnv79Cx7eiAXNJdGtiE=;
 b=DpgqOeuIhrPeVUaaTeQ5B/opN5QNgu37ecK7ILXP9oj98s/mFxE0Z1ViwyRsYqtE/rnp
 FoskmRuzx+VOwwTUoHJMQicAehT5/TK39XrB6HsVUyvjiklvOPlKXUaBSInucT2g7lE0
 tXt+ygKoOve/8gMNVsf4nA91CnaI3UMF/n0l6+Ks7eGtiB/j6RGUQTX+uBAtALewHZgE
 tlx1/gbS617gS1bF5oV3nm0P3csptmm6+5CrCt+ndF0SLNwKzoF7nSHwrNjscbxNOXmq
 SjGmANpvhEpOlkLG93Ar+4DWFvRDXnIq4z1CtKmQRPU7Cer4zCfMgYPCRnjQ72fLa3SA ew== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2s5u5d1cpk-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 29 Apr 2019 12:03:40 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 079FD31;
        Mon, 29 Apr 2019 10:03:40 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node1.st.com [10.75.127.13])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D195F1516;
        Mon, 29 Apr 2019 10:03:39 +0000 (GMT)
Received: from SFHDAG5NODE1.st.com (10.75.127.13) by SFHDAG5NODE1.st.com
 (10.75.127.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 29 Apr
 2019 12:03:39 +0200
Received: from SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6]) by
 SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6%20]) with mapi id
 15.00.1347.000; Mon, 29 Apr 2019 12:03:39 +0200
From:   Gerald BAEZA <gerald.baeza@st.com>
To:     "will.deacon@arm.com" <will.deacon@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "olof@lixom.net" <olof@lixom.net>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "arnd@arndb.de" <arnd@arndb.de>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Gerald BAEZA <gerald.baeza@st.com>
Subject: [PATCH 5/5] ARM: dts: stm32: add ddrperfm on stm32mp157c
Thread-Topic: [PATCH 5/5] ARM: dts: stm32: add ddrperfm on stm32mp157c
Thread-Index: AQHU/nLRxwgji6v2RkORmNtCUuK6Ow==
Date:   Mon, 29 Apr 2019 10:03:39 +0000
Message-ID: <1556532194-27904-6-git-send-email-gerald.baeza@st.com>
References: <1556532194-27904-1-git-send-email-gerald.baeza@st.com>
In-Reply-To: <1556532194-27904-1-git-send-email-gerald.baeza@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-29_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DDRPERFM is the DDR Performance Monitor embedded
in STM32MP1 SOC.

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp=
157c.dtsi
index f8bbfff..6883762 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -1155,6 +1155,15 @@
 			};
 		};
=20
+		ddrperfm: perf@5a007000 {
+			compatible =3D "st,stm32-ddr-pmu";
+			reg =3D <0x5a007000 0x400>;
+			clocks =3D <&rcc DDRPERFM>, <&rcc PLL2_R>;
+			clock-names =3D "bus", "ddr";
+			resets =3D <&rcc DDRPERFM_R>;
+			status =3D "okay";
+		};
+
 		usart1: serial@5c000000 {
 			compatible =3D "st,stm32h7-uart";
 			reg =3D <0x5c000000 0x400>;
--=20
2.7.4
