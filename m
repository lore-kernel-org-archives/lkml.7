Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D5BC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC8C2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="iNORaUj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbfH0PJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 11:09:03 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58784 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728612AbfH0PI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 11:08:57 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7RF28XA026519;
        Tue, 27 Aug 2019 17:08:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=XBn5EdlEuwPuny7s/ZVplkEwvVDz5QZdOFX+dgKCXXA=;
 b=iNORaUj7p6Vrz+dT27NTys4RFbS+VfOsa9329guLiC7b/Do+brszYr2pMO4ew3YzyzNM
 NB0Pjy6+9dBvLiwvNd+yE7efuMkFFrfe7UiYNHZ7+prV8NXDD24+bgJ5upoorAKVYi+T
 c3P2DG8fCtnZ3rJDwIq+9B9t7srkeH93DdVhn4TZoQpeXnEtLl6nB/6F6eEMNPuwetOU
 IFpI3OhI6uS1ozBIUwvNz3fe+qjtwQRge6Fh8bbYlBsa16M/sBr3KC6kFcA+RVBZ8Fa1
 /bM2ZiVTFBhLv/okCWn0oJvRLk4GFWajAJFT1uMjpZdI7sKsbVj9cw42Q7mZDfhVq/wV WA== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx08-00178001.pphosted.com with ESMTP id 2ujv4kt4b3-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 27 Aug 2019 17:08:28 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 20FB056;
        Tue, 27 Aug 2019 15:08:23 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D02862B76DD;
        Tue, 27 Aug 2019 17:08:22 +0200 (CEST)
Received: from SFHDAG5NODE1.st.com (10.75.127.13) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Aug
 2019 17:08:22 +0200
Received: from SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6]) by
 SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6%20]) with mapi id
 15.00.1473.003; Tue, 27 Aug 2019 17:08:21 +0200
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
Subject: [PATCH v3 5/5] ARM: dts: stm32: add ddrperfm on stm32mp157c
Thread-Topic: [PATCH v3 5/5] ARM: dts: stm32: add ddrperfm on stm32mp157c
Thread-Index: AQHVXOlE7eeGfv5rUUSEpFdWg8XWbA==
Date:   Tue, 27 Aug 2019 15:08:21 +0000
Message-ID: <1566918464-23927-6-git-send-email-gerald.baeza@st.com>
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

The DDRPERFM is the DDR Performance Monitor embedded
in STM32MP1 SOC.

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp=
157c.dtsi
index 0c4e6eb..6ea6933 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -1378,6 +1378,14 @@
 			};
 		};
=20
+		ddrperfm: perf@5a007000 {
+			compatible =3D "st,stm32-ddr-pmu";
+			reg =3D <0x5a007000 0x400>;
+			clocks =3D <&rcc DDRPERFM>;
+			resets =3D <&rcc DDRPERFM_R>;
+			status =3D "okay";
+		};
+
 		usart1: serial@5c000000 {
 			compatible =3D "st,stm32h7-uart";
 			reg =3D <0x5c000000 0x400>;
--=20
2.7.4
