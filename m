Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91005C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F70922CEC
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hrKh88Ar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388842AbfIEL6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 07:58:44 -0400
Received: from mail-eopbgr80057.outbound.protection.outlook.com ([40.107.8.57]:16451
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388280AbfIEL6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 07:58:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6+kmODlRo4w6jtgfChlx1wtmXtNzmM6fyCig24yldkSijjvhKK32B39rNq+b6vW1mN7JdhrkyLJirEPZihoOjV8tf/WlCEU2cXg1EALdT7opKRbDs9XdM29b1mLFFwmH2nqfww4gu80+OEVJkjuSf4oQ5yRSmnQHugsHyfRSgmjGcPrKF6oJ6TPiM73UT5sWSpVDZMc3TDnObzxPSOErhieMFwYi9c+MGDrTNA6HKe3RUd0YIMa/t5U2x2+pkdUhgKX40yF3sPZJdN8h5N7RjtQJSFW5ZpQnA4UUEC/nAZoPrzQyTwdZJmsxJ4et5E5BcRuvDYWqeNt9mxgKPGqcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pe33SIbYB88KZ1InOfVAGswqJd5chZSXWAxNGDHRk5M=;
 b=UDfvq3i+HP3RgQuMOszAX7RCP8kqJKUJ9pMRrKP2ZB56Q1eotWiMuRfECCjv/xS4Lgugt1O+VjZfqcppmHG2ca+2xGg0okfZ2fI5J7paVC/bR3RWRN9tvUVYou/hGDXmxjZhSA4tzNNE1L8kJcvjmPqPXsAmYtJpXgzh7Kx1MKB75cTZ+yYm2xGGBjTSzHY7KUpVIMNonoFWwmSo+XbTrJY6s2CzqR52el3oi+nNZZe4k/ZbuxxGIhHZ5wFVwBIY3XSbwDQDmYc/s5+ngRdwnCBPceHzLjgQedAtYRCpB/E076LCDfn5n9lE+kGdazDOsYXo47635hOC+zRmGBRs5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pe33SIbYB88KZ1InOfVAGswqJd5chZSXWAxNGDHRk5M=;
 b=hrKh88Arql4uEXjaCjycdM2pHxlo9qHw9oh7OJLB1jGO7AzePlLYBFLvCmfezdKdfChOKkXp7aqdBC9XwYzvIohnhYal+ZrRlNp070WN/IsUlBCFAcYw9vfMjE6obTZlktn/1UTbqJF2I4YVe0W/drqkOGqy8GjgnBox8G3wRTk=
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com (10.175.20.18) by
 VI1PR0402MB3805.eurprd04.prod.outlook.com (52.134.16.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.18; Thu, 5 Sep 2019 11:58:34 +0000
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::19cd:9f82:31ce:fbbb]) by VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::19cd:9f82:31ce:fbbb%8]) with mapi id 15.20.2220.022; Thu, 5 Sep 2019
 11:58:34 +0000
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
        Cosmin Stefan Stoica <cosmin.stoica@nxp.com>
Subject: [PATCH v4 2/6] arm64: Introduce config for S32
Thread-Topic: [PATCH v4 2/6] arm64: Introduce config for S32
Thread-Index: AQHVY+E+ReIuxfnMP0GZYie3bCDopA==
Date:   Thu, 5 Sep 2019 11:58:34 +0000
Message-ID: <20190905115803.19565-3-stefan-gabriel.mirea@nxp.com>
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
x-ms-office365-filtering-correlation-id: 38f7cb3b-944b-440f-c4f0-08d731f860c7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3805;
x-ms-traffictypediagnostic: VI1PR0402MB3805:|VI1PR0402MB3805:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB38051AA48F40A5BFD59DA5DADFBB0@VI1PR0402MB3805.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(199004)(189003)(476003)(81156014)(81166006)(446003)(2616005)(486006)(71190400001)(11346002)(6436002)(1076003)(54906003)(71200400001)(110136005)(53936002)(8676002)(7416002)(102836004)(478600001)(36756003)(14454004)(6512007)(25786009)(2501003)(2201001)(86362001)(256004)(66556008)(64756008)(66446008)(186003)(66946007)(26005)(4326008)(4744005)(3846002)(7736002)(316002)(6506007)(52116002)(99286004)(8936002)(76176011)(2906002)(305945005)(6486002)(5660300002)(50226002)(66066001)(6116002)(66476007)(6636002)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3805;H:VI1PR0402MB2863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rG1Z/T24/fg58W50AuAd3J8EyTbZKK65/Crm0swh4/ZQn85MMOtQwA6NNv0LSvfENUxaPLM6Qp8BF1JNh3k3atrTPmum+4IlZijzt7gqQfCb8J4us3Hy2CQOFBge8zc5br7gNFgG5gL1jF8yBnvUjKso60qVMmFUnLycjUkc9T+t2wL20LjJalCiTM0DxCnTPece/SvdTs7DMwkyH+7927NQOEDYPMIfPp/mf+crIxfVOoQZxUIAZXgd0OfPozBHffIXgUnqw7F6JcfmngHfezVbRofQFMFJdNX4c3C8q5KAQ5DnYLla8ocT5zwON5uBxZD5vosBAXz9CUCGgJFnFkXRIrx51fpxmsgDPxbyfsPUX6Q30h3+Ot++etDBZ+r9xo1iEjEr3qg/+Oc5op9JFUuVXI7V/OO6msfVmkRIEeo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f7cb3b-944b-440f-c4f0-08d731f860c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 11:58:34.5468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: REvhj/6nsbFkKMvRvoNHl7u+an9wAm+xmVFQvIfWzUcbWmMtRRDBsZ40w9T1g00h6XLl6ROrifabO/UK/F4CHQICEAbut7N5bjvYyl1+xcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3805
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mihaela Martinas <Mihaela.Martinas@freescale.com>

Add configuration option for the NXP S32 platform family in
Kconfig.platforms. For starters, the only SoC supported will be Treerunner
(S32V234), with a single execution target: the S32V234-EVB (rev 29288)
board.

Signed-off-by: Mihaela Martinas <Mihaela.Martinas@freescale.com>
Signed-off-by: Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>
Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
---
 arch/arm64/Kconfig.platforms | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 4778c775de1b..64bbe2d0b04f 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -210,6 +210,11 @@ config ARCH_ROCKCHIP
 	  This enables support for the ARMv8 based Rockchip chipsets,
 	  like the RK3368.
=20
+config ARCH_S32
+	bool "NXP S32 SoC Family"
+	help
+	  This enables support for the NXP S32 family of processors.
+
 config ARCH_SEATTLE
 	bool "AMD Seattle SoC Family"
 	help
--=20
2.22.0

