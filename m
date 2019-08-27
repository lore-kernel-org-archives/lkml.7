Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6776BC3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D377217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="v84wXD4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbfH0PI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 11:08:56 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58774 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726054AbfH0PI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 11:08:56 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7RF27Ps026516;
        Tue, 27 Aug 2019 17:08:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=WCVwMfXR8g1j5Zrd8gSemrcYNLfQjqC+GHfOy9t5zVo=;
 b=v84wXD4zkDFkoWgr/paZtKm5VOcO5Nrnzm7i0EE2WfaYqJa3fi7e2mIQ4iIz+sLvtCvr
 5/ewb5Q4At/B/iv1d+9B1wSTKn3U39s/W1ipI9+0A+tIJ/6Q+NZLvC1iDmrf5Qvi6MuO
 fgD7nXic52Sre8I0aymQ/tj8WU7dkiBBRymnEWeqThDHfCXw5rvfKTDCJykbj5pdNGyM
 NRjeE8FlDpMjzCLNMbYWjDVB0sXIlVhdr5nIMdOP1oyq7/py2u304A9hR0RibjYzeL1G
 iZZ6eMbS/XXEy/WayuibsrKp/Utelpdr+pITnYWg1YY/gFVDrzMrJrqyH35TQccFqP7C gQ== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx08-00178001.pphosted.com with ESMTP id 2ujv4kt4as-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 27 Aug 2019 17:08:29 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id CB53B52;
        Tue, 27 Aug 2019 15:08:20 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7AFAE2B6ABC;
        Tue, 27 Aug 2019 17:08:20 +0200 (CEST)
Received: from SFHDAG5NODE1.st.com (10.75.127.13) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 27 Aug
 2019 17:08:20 +0200
Received: from SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6]) by
 SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6%20]) with mapi id
 15.00.1473.003; Tue, 27 Aug 2019 17:08:19 +0200
From:   Gerald BAEZA <gerald.baeza@st.com>
To:     "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "olof@lixom.net" <olof@lixom.net>, "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     Gerald BAEZA <gerald.baeza@st.com>
Subject: [PATCH v3 2/5] dt-bindings: perf: stm32: ddrperfm support
Thread-Topic: [PATCH v3 2/5] dt-bindings: perf: stm32: ddrperfm support
Thread-Index: AQHVXOlCMu3qbdWcXEe5CqPZR/zfNQ==
Date:   Tue, 27 Aug 2019 15:08:19 +0000
Message-ID: <1566918464-23927-3-git-send-email-gerald.baeza@st.com>
References: <1566918464-23927-1-git-send-email-gerald.baeza@st.com>
In-Reply-To: <1566918464-23927-1-git-send-email-gerald.baeza@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-27_03:,,
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
 Documentation/devicetree/bindings/perf/stm32-ddr-pmu.txt | 16 ++++++++++++=
++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/stm32-ddr-pmu.tx=
t

diff --git a/Documentation/devicetree/bindings/perf/stm32-ddr-pmu.txt b/Doc=
umentation/devicetree/bindings/perf/stm32-ddr-pmu.txt
new file mode 100644
index 0000000..87ab12e
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/stm32-ddr-pmu.txt
@@ -0,0 +1,16 @@
+* STM32 DDR Performance Monitor (DDRPERFM)
+
+Required properties:
+- compatible: must be "st,stm32-ddr-pmu".
+- reg: physical address and length of the registers set.
+- clocks: phandle and specifier for DDRPERFM input clock
+- resets: phandle and specifier for DDRPERFM reset
+
+Example:
+	ddrperfm: perf@5a007000 {
+		compatible =3D "st,stm32-ddr-pmu";
+		reg =3D <0x5a007000 0x400>;
+		clocks =3D <&rcc DDRPERFM>;
+		resets =3D <&rcc DDRPERFM_R>;
+	};
+
--=20
2.7.4
