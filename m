Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442E3C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 19:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C509920850
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 19:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lbHmBq2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406098AbfHWTL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 15:11:58 -0400
Received: from mail-eopbgr20069.outbound.protection.outlook.com ([40.107.2.69]:31678
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406061AbfHWTLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 15:11:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9mTBc0Z9XC9T579ZhWZYwzdWCsC1RZ1k08GLaTfDJGpaQ4fuMv14V5UvDd/TxzZ3R/Dgh/y1E4dKHUBlvnhWYcDFzVxMqbdzs3ZyAvVK5bsMHWIsMk9Feaz0zTNHt5FWjIlxh1fA7ec/JbK1YKZ7wKGZIYQy7vxA8v6pV+R6pXtyP5MSVC8btuVFcA7tbe5hNFFnPgouKGARnPmBxx8qOq0CDzqarYpN8mLRugummcJfuXw+fd3dyh84Kw/FuXdpjUPSAFbQfzMSM6qc7knkkfCPPo4V21gJL5SPQAU1wbU2GnZ6cBJUr6DsJnQqF1DyMlm3VV4EE1lFneX/ydySA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baq0+T4FN7wutqVLCsogGr0cPRc/vTHMqtYZTX3sui8=;
 b=aHksG1oGjudZ++Wfqnv5S2M7eln5swg40k8dA5U7y97HDZNup2UaR+D8VbZcoC4P5bYnr0U60J5beD+bYP/gudcWfCEgWW2dHBOgyOOEgaYEr/6eVhJ2a+jqu2yR2PDg9V4ts5Wijy3z7wPe+aAyrcqohx8P4e8+lCW8mngJTnQ+mnhOhDPZYHvFe9jsucK9MFow3vM4VdExMd1ggUuT+Ds3VkSxR5f7A4NRgDr0OOztFiHlsEnwrsTRieUuhGDzcXKwAS9WxDd3E2vftQVXKYezk86yrt4Ob2IsLLqpxbwItgQ2K0gzQbsUpfEiXGqh+HFs6jo0T5d0dP6H8xSymA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baq0+T4FN7wutqVLCsogGr0cPRc/vTHMqtYZTX3sui8=;
 b=lbHmBq2IASDOe8JP01zQ1nGKiQgnvTEB/tXOfrtz4oY0Mns9lcTwnsSsJT6OzaM11RaMm5bmTWE+zeWYh0YYgEVCK8dBal6w5OF4sy45pBdG0OHuGuGRt+DkeQTKepLPOPAzTb1r/NmcD++ulAzXo7Ma6t62XLDUGMftB/+nN4s=
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com (10.175.20.18) by
 VI1PR0402MB2717.eurprd04.prod.outlook.com (10.175.22.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Fri, 23 Aug 2019 19:11:35 +0000
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::7de6:ea4b:9b5d:d023]) by VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::7de6:ea4b:9b5d:d023%7]) with mapi id 15.20.2178.020; Fri, 23 Aug 2019
 19:11:35 +0000
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
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 3/7] serial: fsl_linflexuart: Update compatible string
Thread-Topic: [PATCH v3 3/7] serial: fsl_linflexuart: Update compatible string
Thread-Index: AQHVWeaU4T6zYLj2ak+wDZxA8SV1Xg==
Date:   Fri, 23 Aug 2019 19:11:35 +0000
Message-ID: <20190823191115.18490-4-stefan-gabriel.mirea@nxp.com>
References: <20190823191115.18490-1-stefan-gabriel.mirea@nxp.com>
In-Reply-To: <20190823191115.18490-1-stefan-gabriel.mirea@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.22.0
x-clientproxiedby: AM5PR0402CA0007.eurprd04.prod.outlook.com
 (2603:10a6:203:90::17) To VI1PR0402MB2863.eurprd04.prod.outlook.com
 (2603:10a6:800:af::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stefan-gabriel.mirea@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fbf7c670-1192-44a8-b7cd-08d727fdb749
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0402MB2717;
x-ms-traffictypediagnostic: VI1PR0402MB2717:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB2717175A9EE3EA0A73E8D144DFA40@VI1PR0402MB2717.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(189003)(199004)(446003)(476003)(2501003)(66446008)(76176011)(6436002)(6486002)(386003)(6506007)(50226002)(81156014)(256004)(86362001)(66946007)(64756008)(66556008)(66476007)(66066001)(186003)(8936002)(6512007)(25786009)(81166006)(36756003)(478600001)(52116002)(8676002)(14454004)(102836004)(6116002)(5660300002)(486006)(26005)(2201001)(71200400001)(53936002)(71190400001)(1076003)(316002)(110136005)(7416002)(54906003)(4326008)(99286004)(7736002)(305945005)(6636002)(3846002)(11346002)(2616005)(4744005)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2717;H:VI1PR0402MB2863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oDFgqHJn7ZolwviHpmarpMdXcD1QcV6Y0+BRDzWJaVDzl5tc/bASainnqX/3ztof47SU7zutkG6cNYjnqQBHU4OPW8BkvDC21/EtBBKYmAidNsGSyWpAt88BmxZiQxKvgAIOw++uL1c/IkTgfINqILkC3VBNJvVZnZW3A0RrZvqakvxANjCJHWppztVNbGYTJjQP6n6C1O3/oSFJoIY3yf7ubmANyFv3BIJGslb+QP53vVJGvg44XMr8WQZj8ybjNmAv/lklwDNVKqprJqcW81FCayKt5WuoZo1OossEJUIe/YQtlOA2ohybiKVKlD3TfBtlc2Z2S5+276lfbkxlmuHRje2QMQgduM+drirKMzs55VGSbHlx+9ojsOhGDdpX+nYMqvfLILD7NHwAOQR4nAuQ4W0Bs5rn7QZ1HGaRMIs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf7c670-1192-44a8-b7cd-08d727fdb749
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 19:11:35.4763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gtx7180Iwk1ypt1//1YPT0iTd406RINy75nNKCVHxI4el+MKW56iRNtaRzTHy6JWn2z05I4jdkGc44k64554P6w7WgM9TmYgJW7lxO0Rwfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2717
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "fsl,s32-linflexuart" compatible string is too generic. Make it SoC
specific.

Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
---
 drivers/tty/serial/fsl_linflexuart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_=
linflexuart.c
index 26b9601a0952..e54c65830e5e 100644
--- a/drivers/tty/serial/fsl_linflexuart.c
+++ b/drivers/tty/serial/fsl_linflexuart.c
@@ -127,7 +127,7 @@
=20
 static const struct of_device_id linflex_dt_ids[] =3D {
 	{
-		.compatible =3D "fsl,s32-linflexuart",
+		.compatible =3D "fsl,s32v234-linflexuart",
 	},
 	{ /* sentinel */ }
 };
@@ -801,7 +801,7 @@ static int __init linflex_early_console_setup(struct ea=
rlycon_device *device,
 	return 0;
 }
=20
-OF_EARLYCON_DECLARE(linflex, "fsl,s32-linflexuart",
+OF_EARLYCON_DECLARE(linflex, "fsl,s32v234-linflexuart",
 		    linflex_early_console_setup);
=20
 #define LINFLEX_CONSOLE	(&linflex_console)
--=20
2.22.0

