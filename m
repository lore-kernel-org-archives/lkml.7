Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F352C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3BF214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="REk6Kuup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbfDHPYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:24:22 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:26900 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728824AbfDHPYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:24:22 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x38FFwmO017674;
        Mon, 8 Apr 2019 17:24:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=8NB65M5rO5FiFbEGG/GlrIlPxGe4fP0kMDfL2P8Ygrs=;
 b=REk6KuuptXkcfbGLIpL0nSjDrg3X7eO2ZFZMIxyVdNLjH/kFW4tb1EBeigRoumwBqSKE
 9Run1Hymz93VSM92+hkQUMG83fj32tuMd62NYqJg95e5sjhKlyvQrNTqp9CEEqNeRkrT
 WZaszhTxcOOxVu1M97hk3+idq/a8UYkL6mTg+bkVANd2nCR5SjjwuskQHXHWVr/bFcFB
 u3IAVDSdU8rZ7bOOw80uKf/ItK6gMFFIj40mRkWymQ4mfbkbpDeSM2KiPL64YMrycSHO
 MWAynOzwCv2cgL48sEeVqETc9+7iY//MvZ2dlhB72dRBxOmHCJbZQCHsFe6Y+KQLr28f 5Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rprcnuab8-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 08 Apr 2019 17:24:09 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 462413D;
        Mon,  8 Apr 2019 15:24:08 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 221B328E7;
        Mon,  8 Apr 2019 15:24:08 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 8 Apr
 2019 17:24:07 +0200
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Mon, 8 Apr 2019 17:24:07 +0200
From:   Pascal PAILLET-LME <p.paillet@st.com>
To:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Pascal PAILLET-LME <p.paillet@st.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 1/2] dt-bindings: regulator: Add stm32mp1 pwr regulators
Thread-Topic: [PATCH 1/2] dt-bindings: regulator: Add stm32mp1 pwr regulators
Thread-Index: AQHU7h8bz82KCLvT6U6ly7lIFu/tMQ==
Date:   Mon, 8 Apr 2019 15:24:07 +0000
Message-ID: <1554737044-9460-2-git-send-email-p.paillet@st.com>
References: <1554737044-9460-1-git-send-email-p.paillet@st.com>
In-Reply-To: <1554737044-9460-1-git-send-email-p.paillet@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-08_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document devicetree bindings for stm32mp1 pwr regulators.

Signed-off-by: Pascal Paillet <p.paillet@st.com>
---
 .../bindings/regulator/st,stm32mp1-pwr-reg.txt     | 43 ++++++++++++++++++=
++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/st,stm32mp1=
-pwr-reg.txt

diff --git a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-re=
g.txt b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.txt
new file mode 100644
index 0000000..e372dd3
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.txt
@@ -0,0 +1,43 @@
+STM32MP1 PWR Regulators
+-----------------------
+
+Available Regulators in STM32MP1 PWR block are:
+  - reg11 for regulator 1V1
+  - reg18 for regulator 1V8
+  - usb33 for the swtich USB3V3
+
+Required properties:
+- compatible: Must be "st,stm32mp1,pwr-reg"
+- list of child nodes that specify the regulator reg11, reg18 or usb33
+  initialization data for defined regulators. The definition for each of
+  these nodes is defined using the standard binding for regulators found a=
t
+  Documentation/devicetree/bindings/regulator/regulator.txt.
+- vdd-supply: phandle to the parent supply/regulator node for vdd input
+- vdd_3v3_usbfs-supply: phandle to the parent supply/regulator node for us=
b33
+
+Example:
+
+pwr_regulators: pwr@50001000 {
+	compatible =3D "st,stm32mp1,pwr-reg";
+	reg =3D <0x50001000 0x10>;
+	vdd-supply =3D <&vdd>;
+	vdd_3v3_usbfs-supply =3D <&vdd_usb>;
+
+	reg11: reg11 {
+		regulator-name =3D "reg11";
+		regulator-min-microvolt =3D <1100000>;
+		regulator-max-microvolt =3D <1100000>;
+	};
+
+	reg18: reg18 {
+		regulator-name =3D "reg18";
+		regulator-min-microvolt =3D <1800000>;
+		regulator-max-microvolt =3D <1800000>;
+	};
+
+	usb33: usb33 {
+		regulator-name =3D "usb33";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+	};
+};
--=20
1.9.1
