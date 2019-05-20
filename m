Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B5AC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB1E2081C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="EUW1ao9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388422AbfETP1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 11:27:52 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:17566 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388179AbfETP1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 11:27:51 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4KFM4a7003544;
        Mon, 20 May 2019 17:27:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=XaWvgYoi3fn5tdDi/Sgs87wZpH8WFoKkowCANtilYJs=;
 b=EUW1ao9bejz7k51WbxPGf7MHnnjEmw6rDbuq4UQnFMlalClsTUHLEgj7I0HnxGlpwPnx
 ZOwYGC+2EJvuJjXQVBYFrSLY3UDiG1KtWL0uccRmmMhoUIa7AqaPa2Hhl3PpbVfr82kJ
 5YfadjKxrO7LT59p31V8U0tWnCPjJjpWRP0RT/nOUbuV2nogisiVkPLWaoz7NKOxlQ1r
 bfMlSHkqWWEKtkWIMYnWwMv98hfq42Mxqw3Hpw8CMs4G2PZk0bAS04VuwOf/bHul0OQR
 WpGVwIeV95NRstJ+YiUDk1u3kl0TCre0w4KGzq6X7GXavBwGfT43oSxjUujDgVtYG3VE IQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2sj773vj5w-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 20 May 2019 17:27:18 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3B47D38;
        Mon, 20 May 2019 15:27:17 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0BA022BAE;
        Mon, 20 May 2019 15:27:17 +0000 (GMT)
Received: from SFHDAG5NODE1.st.com (10.75.127.13) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 20 May
 2019 17:27:16 +0200
Received: from SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6]) by
 SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6%20]) with mapi id
 15.00.1347.000; Mon, 20 May 2019 17:27:16 +0200
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
Subject: [PATCH v2 2/5] dt-bindings: perf: stm32: ddrperfm support
Thread-Topic: [PATCH v2 2/5] dt-bindings: perf: stm32: ddrperfm support
Thread-Index: AQHVDyCBQQc7A9kqVEqkYhOzbDRQTg==
Date:   Mon, 20 May 2019 15:27:16 +0000
Message-ID: <1558366019-24214-3-git-send-email-gerald.baeza@st.com>
References: <1558366019-24214-1-git-send-email-gerald.baeza@st.com>
In-Reply-To: <1558366019-24214-1-git-send-email-gerald.baeza@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-20_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DDRPERFM is the DDR Performance Monitor embedded in STM32MP1 SOC.

This documentation indicates how to enable stm32-ddr-pmu driver on
DDRPERFM peripheral, via the device tree.

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
---
 .../devicetree/bindings/perf/stm32-ddr-pmu.txt       | 20 ++++++++++++++++=
++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/stm32-ddr-pmu.tx=
t

diff --git a/Documentation/devicetree/bindings/perf/stm32-ddr-pmu.txt b/Doc=
umentation/devicetree/bindings/perf/stm32-ddr-pmu.txt
new file mode 100644
index 0000000..9d36209
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/stm32-ddr-pmu.txt
@@ -0,0 +1,20 @@
+* STM32 DDR Performance Monitor (DDRPERFM)
+
+Required properties:
+- compatible: must be "st,stm32-ddr-pmu".
+- reg: physical address and length of the registers set.
+- clocks: list of phandles and specifiers to all input clocks listed in
+	  clock-names property.
+- clock-names: "bus" corresponds to the DDRPERFM bus clock and "ddr" to
+	       the DDR frequency.
+- resets: phandle to the reset controller and DDRPERFM reset specifier
+
+Example:
+	ddrperfm: perf@5a007000 {
+		compatible =3D "st,stm32-ddr-pmu";
+		reg =3D <0x5a007000 0x400>;
+		clocks =3D <&rcc DDRPERFM>, <&rcc PLL2_R>;
+		clock-names =3D "bus", "ddr";
+		resets =3D <&rcc DDRPERFM_R>;
+	};
+
--=20
2.7.4
