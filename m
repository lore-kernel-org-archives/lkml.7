Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4C4C3A5AB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5DD22CF5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="L0t8j/bw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388890AbfIEL6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 07:58:53 -0400
Received: from mail-eopbgr80057.outbound.protection.outlook.com ([40.107.8.57]:16451
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388858AbfIEL6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 07:58:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ne3AOILdRkmkFza4292dhigs4tf/EbWdt3evRPm2vLSBJYDFBaPnmRL4Bszn8k9sB0vkR3F2hkHum4VrOA2+zw84tmOES1LGfKJ3a8dfCYZxVG38+3oyHurPjzAgPf7Kn+WqIYDmETAhaONr596wUUX1degXdPNYvda/w8V7N6Yevh2sxolLWMGVMW8yYsuYmfLKVSeSmotmK6XqBFb/vfTCu1inAXhDVAlejQCBu75T5or02t8cEC188eqI7TozHMIx6RKFnRk93L8Kto1RcLgv2Jod5mQjjkevAm6PmROkk2/ovpKucgz4ea4vKagi+AnttfvV5xC0YqasOKsRsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7j2kPiROaie9oEnDMTMxiT+49euk0rtlIzW9UozmdMk=;
 b=dToZoIklLsuF39n1tZEQ2D/vJgnYGsctVpSnGjxLuhLD3CFzh+iMIDGH+AR/bx574NPmNqso9TbJN7Q063zpuRCTB5WXDo3NaCuLfuEB4IfuyusPjigvz5ZwYCO+Poffb6ZPX8E1b8RgZ4TZzL46pLcBXyit1vA33dtPkv0KTTKa3AzmVeAt5IMtico03yy44DbsU7030Lo166tA1PiCG4ar/IrP44HzN6Fkn8fAaRreeqF/Gy/kpA8eMCRoIjrx1kS1yspdzYd6wkyV0rVK5sT+I8QEGVeWYmXjCvU4ou4EFucrOVjCkgnxBpD3WWz/a0wa5m8BFN7R8Tyaz9yIUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7j2kPiROaie9oEnDMTMxiT+49euk0rtlIzW9UozmdMk=;
 b=L0t8j/bw8J3cImQ2gM7IP7qbRODlivd/5H6qM2eE80oY5Uualmxdx9NrAmaMEJHk85AFxDT/vV5CtXCi1YwIFjlmOuy8wrtOxv5NJO644UCdz2tfb9SwJ73Mi2AuifdCwAmk303YvrWeG50j7/+7yC4X2oV8aJvAKLkKDmOXm6A=
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com (10.175.20.18) by
 VI1PR0402MB3805.eurprd04.prod.outlook.com (52.134.16.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.18; Thu, 5 Sep 2019 11:58:40 +0000
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::19cd:9f82:31ce:fbbb]) by VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::19cd:9f82:31ce:fbbb%8]) with mapi id 15.20.2220.022; Thu, 5 Sep 2019
 11:58:40 +0000
From:   Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>
CC:     "jslaby@suse.com" <jslaby@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Cosmin Stefan Stoica <cosmin.stoica@nxp.com>,
        Larisa Ileana Grigore <larisa.grigore@nxp.com>
Subject: [PATCH v4 5/6] dt-bindings: serial: Document Freescale LINFlexD UART
Thread-Topic: [PATCH v4 5/6] dt-bindings: serial: Document Freescale LINFlexD
 UART
Thread-Index: AQHVY+FBDBHz8YxpUkWiYnjWoMIYag==
Date:   Thu, 5 Sep 2019 11:58:39 +0000
Message-ID: <20190905115803.19565-6-stefan-gabriel.mirea@nxp.com>
References: <20190905115803.19565-1-stefan-gabriel.mirea@nxp.com>
In-Reply-To: <20190905115803.19565-1-stefan-gabriel.mirea@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.22.0
x-clientproxiedby: AM6P193CA0005.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::18) To VI1PR0402MB2863.eurprd04.prod.outlook.com
 (2603:10a6:800:af::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stefan-gabriel.mirea@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fde2049-6d71-48bf-6da7-08d731f86402
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3805;
x-ms-traffictypediagnostic: VI1PR0402MB3805:|VI1PR0402MB3805:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB3805141090FB433A6086C8AEDFBB0@VI1PR0402MB3805.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(199004)(189003)(476003)(81156014)(81166006)(446003)(2616005)(486006)(71190400001)(11346002)(6436002)(1076003)(54906003)(71200400001)(110136005)(53936002)(8676002)(7416002)(102836004)(478600001)(36756003)(966005)(14454004)(6512007)(25786009)(2501003)(2201001)(86362001)(256004)(66556008)(64756008)(66446008)(186003)(66946007)(26005)(4326008)(3846002)(7736002)(316002)(6506007)(52116002)(99286004)(8936002)(76176011)(2906002)(305945005)(6486002)(5660300002)(50226002)(66066001)(6306002)(6116002)(66476007)(6636002)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3805;H:VI1PR0402MB2863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: enxCorFcYC1gkqfpR/ThFDdP5hImky/2/6j7yhv2WmMbT34KnsfJi9KPUS09ovRVgLFqOh3t5myI4LeZy5jQ5SjXIoI8EPob71EUeiFm2DgjhS4h0Hd9mHXuBzyB5ztvMHKgfMwaRpMKaknv5cJnojKg5CAv2SSTvWaobU2GDEB2aMbJJUcEMEcMSFwFTX8IPplNZPD6A6Z6Xzf+zZ0GoSWYdiRJWtn433fer5wk0uJGn6bo6pId7/LdVmXIih6LSrYCC3i9ud0z2XHuAZy7rSSYO/EkdQtKLaxCBvRv3KbnpbnBxuOgP8fL2+We+t4em+CXMyMHMvl71kvmbYH/aWhsyKsjiS7HtAvBuXBLz80idDQNbA8dn/R0nOL6Ovoo5QD0bbjZqSTo5L+SHANnAyfdp+zoA83buGZEVdA9nqg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fde2049-6d71-48bf-6da7-08d731f86402
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 11:58:39.8724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6SpBk+oPMnhSMNvw/MFKJcA87GGKBFUsGyhIWvAW3nPg5mhWXOBud2ugp5YHWNKjDO4esytqizR0Chn/CCD/E4VEAncTNWNyg03qc4Y6HHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3805
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>

Add documentation for the serial communication interface module (LINFlexD),
found in two instances on S32V234.

Signed-off-by: Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>
Signed-off-by: Larisa Grigore <Larisa.Grigore@nxp.com>
Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/serial/fsl,s32-linflexuart.txt   | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/fsl,s32-linfle=
xuart.txt

diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.t=
xt b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.txt
new file mode 100644
index 000000000000..f1bbe0826be5
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.txt
@@ -0,0 +1,22 @@
+* Freescale LINFlexD UART
+
+The LINFlexD controller implements several LIN protocol versions, as well =
as
+support for full-duplex UART communication through 8-bit and 9-bit frames.
+
+See chapter 47 ("LINFlexD") in the reference manual[1].
+
+Required properties:
+- compatible :
+  - "fsl,s32v234-linflexuart" for LINFlexD configured in UART mode, which
+    is compatible with the one integrated on S32V234 SoC
+- reg : Address and length of the register set for the device
+- interrupts : Should contain uart interrupt
+
+Example:
+uart0: serial@40053000 {
+	compatible =3D "fsl,s32v234-linflexuart";
+	reg =3D <0x0 0x40053000 0x0 0x1000>;
+	interrupts =3D <0 59 4>;
+};
+
+[1] https://www.nxp.com/webapp/Download?colCode=3DS32V234RM
--=20
2.22.0

