Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE5FC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 19:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D296620B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 19:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aN5Ih/KE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406829AbfHBTrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 15:47:49 -0400
Received: from mail-eopbgr40082.outbound.protection.outlook.com ([40.107.4.82]:31662
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406656AbfHBTre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 15:47:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0WzQz8wYTq51rsYW/b+v3wH0r72VOKEcswrq2Yk3DsLoRwgcwM7J60SnXcY+QIhqYBwspwtnImv5MUkAYLjvc+IcE/QH4DzEPJmNhI4yZURKXjJ4EjYyl06EwlY0q+nZQd6AbWJ90Ac4KX1CDFqyl+aHlv1Y6nbgCanCD+T5xZ0M76U2VSVmXuYyST7hsvfUsgAOSgRrrQ2qqb21ZShrSqUMp5CHkCGON6W9MSwsWqKHuKxsDGuh2flSIrcSqvYMsvVrl8/HNgqAmbw5lTPw3py4amW0M/zE7D6QkIUt/tGNaCFcXaBFXPgCeNk+UPt9Nqf7GgFWFiaf+C1j+Tdcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qsz5V+1aWaPpbCQ15tKsqIB9J9IX5L3HJRBgrzb9Q8k=;
 b=DzjkojHhxajlQ7oBhxT4pLyvsRHKuoNGK0pQFdSvL2NQsuBTWqswIJKBnG9zfG5vPH8QDxTHfrrrT9p3tnmvX2esAVvEH7kFCsgG2f1+D3vfzJPSbd4WwazcOzoolFHXIkoMOjUIRKEP1N4SnIu5BR8TecqAJaDXtwEc2GIBPMXhWQ+ra8V59so9gOheNg8ZTcR2Bh8gQ/c26F96GhEfuKBX7IiElr3GOtEnEDWH7kgwe62H9fb15n20K5h5T+rk5+QJljO3C2lq4lxvihnFHsuiW6Ct1tQ921ddMqswXNWIIvG56ZZLmCYrVb3uPYQXXeOneaAXpjauXzsCKqlmLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qsz5V+1aWaPpbCQ15tKsqIB9J9IX5L3HJRBgrzb9Q8k=;
 b=aN5Ih/KEgM+2kKV4M6TWlv+wbhjjJZo4dwxwmPuFLbih1QplWdcsRG382hzfRUDYmjXKVBFiyj1Qzl2VypQ57hxJrT9RYZ0WH45MnLKd4d+tDMGrHiE9xJLhHYW2KHbt/Bit7Qi1HOwuNOglFXzEyffwRxiDJHx+rt8kY9BusXY=
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com (10.175.20.18) by
 VI1PR0402MB2829.eurprd04.prod.outlook.com (10.175.26.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Fri, 2 Aug 2019 19:47:21 +0000
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::7de6:ea4b:9b5d:d023]) by VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::7de6:ea4b:9b5d:d023%7]) with mapi id 15.20.2136.010; Fri, 2 Aug 2019
 19:47:21 +0000
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
Subject: [PATCH 4/6] dt-bindings: serial: Document Freescale LINFlex UART
Thread-Topic: [PATCH 4/6] dt-bindings: serial: Document Freescale LINFlex UART
Thread-Index: AQHVSWsZmO3SRwRL9k+WLeyivtMeFA==
Date:   Fri, 2 Aug 2019 19:47:21 +0000
Message-ID: <20190802194702.30249-5-stefan-gabriel.mirea@nxp.com>
References: <20190802194702.30249-1-stefan-gabriel.mirea@nxp.com>
In-Reply-To: <20190802194702.30249-1-stefan-gabriel.mirea@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.22.0
x-clientproxiedby: AM6PR04CA0051.eurprd04.prod.outlook.com
 (2603:10a6:20b:f0::28) To VI1PR0402MB2863.eurprd04.prod.outlook.com
 (2603:10a6:800:af::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stefan-gabriel.mirea@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3056d75-a9b0-4513-8921-08d717823bfa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB2829;
x-ms-traffictypediagnostic: VI1PR0402MB2829:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR0402MB28291F250A77616F653A3902DFD90@VI1PR0402MB2829.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 011787B9DD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(189003)(199004)(68736007)(446003)(8676002)(6486002)(54906003)(110136005)(3846002)(966005)(305945005)(7416002)(1076003)(14444005)(6116002)(66066001)(2906002)(2201001)(316002)(256004)(36756003)(6636002)(486006)(102836004)(14454004)(71200400001)(53936002)(26005)(66476007)(11346002)(81166006)(71190400001)(186003)(76176011)(66946007)(2616005)(64756008)(8936002)(66446008)(66556008)(99286004)(4326008)(386003)(6506007)(5660300002)(2501003)(52116002)(81156014)(50226002)(25786009)(476003)(478600001)(86362001)(6306002)(7736002)(6512007)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2829;H:VI1PR0402MB2863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lFKKqdxj9ZQRHHq8zlVYagwFapV3JgicE7xTdIfUvBVYvSOJm4ESOt14Bz4O+xga3EQaMf7D9XV3AoMF2ebFJ4gO1OrTrxmHi3/mZiKLQU7sKOK8y7Su6Mh19Wrk9EGpqdz2LOsBOdKp6Fn3KGRaWT9lNbil4gVvR2FecSIXxZmYvskDUJrc2rBjsKc3X6W1gDG55ns06QwxRebRTokCFQxvey0UqguhvYXgTfTZEZ92HhyIZ/YKGCn3S1TqnIUaQynsDPTlC3JzST6R5aN5EiKCbvFZfromuWotxpC8T2tpImwzCkaUhjLCV3qdd9i6GSzAfmtkjIGZo0UgWu7IM+rh3fGn6F72MqLL8A6Zjt696yLv+QpGUZjbMiftAI7ybhhLYa7B9uPeGjy9DwfOYdQqXAWG7XzYUC83itPgKjg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3056d75-a9b0-4513-8921-08d717823bfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2019 19:47:21.7735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: stefan-gabriel.mirea@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2829
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>

Add documentation for the serial communication interface module (LINFlex),
found in two instances on S32V234.

Signed-off-by: Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>
Signed-off-by: Larisa Grigore <Larisa.Grigore@nxp.com>
Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
---
 .../bindings/serial/fsl,s32-linflexuart.txt   | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/fsl,s32-linfle=
xuart.txt

diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.t=
xt b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.txt
new file mode 100644
index 000000000000..957ffeaca9f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.txt
@@ -0,0 +1,24 @@
+* Freescale Linflex UART
+
+The LINFlexD controller implements several LIN protocol versions, as well =
as
+support for full-duplex UART communication through 8-bit and 9-bit frames.=
 The
+Linflex UART driver enables operation only in UART mode.
+
+See chapter 47 ("LINFlexD") in the reference manual[1].
+
+Required properties:
+- compatible :
+  - "fsl,s32-linflexuart" for linflex configured in uart mode which
+  is compatible with the one integrated on S32V234 SoC
+- reg : Address and length of the register set for the device
+- interrupts : Should contain uart interrupt
+
+Example:
+uart0:serial@40053000 {
+	compatible =3D "fsl,s32-linflexuart";
+	reg =3D <0x0 0x40053000 0x0 0x1000>;
+	interrupts =3D <0 59 4>;
+	status =3D "disabled";
+};
+
+[1] https://www.nxp.com/webapp/Download?colCode=3DS32V234RM
--=20
2.22.0

