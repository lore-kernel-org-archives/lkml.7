Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D32C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850F52085B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YJ9i30mV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388099AbfKGKfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 05:35:31 -0500
Received: from mail-eopbgr140074.outbound.protection.outlook.com ([40.107.14.74]:28366
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726866AbfKGKfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 05:35:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4CkVaX3UnneSMXuQQ97oHX7GrvZFPiaKpQBYpJzhfOOcGDI443Si5INrt/9Q1LCpd8BZ6D/Kb1utSqGGMxGW6TQL4mmigzCD34eEXpxFTfyjDIotgVYn5ZMz5UDMsPu799mYGoIf+p5BmSwYY6kACZ9v133TRc7MZfzIe7MAI6FlcW8jmrUFNG0jpHw3ZgF+NtO0eiDdfPyWqD7b4lFIcQIeR9XCOvXx8QlltT4q3CBgWFDXZL9w5yUzXo5vkEULzFdZSDvOGUsBIVrFm+GZgutIfc3Y30gdwwpi7GzgQNzT1wuifI6ubL0B7lcvaENVlU+iDhBzpWF7jb7zW1lAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKf+5L3MZg4fcshelIzTHEsxVSKEUbVUJWC194TshvM=;
 b=MOI4vismKUq4irvr3Ri2wYLKojWJt7zK3wV4I92BPmngVc3TA8Zg6fP12TSvf/gsgywFeW/zWnuVInAYhn6jhYCQjqbVmWdvkCavwA6RGHtnFHjGeHXw6MPmeG39eXYHWzCOIactlWAUJUkJxbePyZ7iHnwBU3UzaKBuB3ECdOVKL3qTKv34Z83IK6OjuIuvC6PW0zMciUaCmifaxehgxlggq87s26KYy0o3wl8z0rYKH+BYIpFk9knilmVxYHeK8/WR74V8+xkigkE2INea89NgBNq2uND4+IN+J/FcKSsnHzpcPJqLkrOJiVw3l/R7GgzgyIIlCjx0Mwn8NhXpvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKf+5L3MZg4fcshelIzTHEsxVSKEUbVUJWC194TshvM=;
 b=YJ9i30mVg/zrqlHHjvISY7fCBVkEa7r0AUyY7X/4bR51MVQ6kIYF56G69LbmooLaLzIXd1HuNVI9EKucw6yBXqPNv3Vk614yXV7MjXgnoMWveC+EPj2dli8yV7EGhYP1NCs1ssc8N9bagcb9V3pPk0fsMDjCgMzruJ2K650VoXU=
Received: from AM6PR04MB4936.eurprd04.prod.outlook.com (20.177.34.20) by
 AM6PR04MB5543.eurprd04.prod.outlook.com (20.178.94.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Thu, 7 Nov 2019 10:35:26 +0000
Received: from AM6PR04MB4936.eurprd04.prod.outlook.com
 ([fe80::912a:3593:7e23:72d0]) by AM6PR04MB4936.eurprd04.prod.outlook.com
 ([fe80::912a:3593:7e23:72d0%7]) with mapi id 15.20.2430.023; Thu, 7 Nov 2019
 10:35:26 +0000
From:   Fancy Fang <chen.fang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-devel@linux.nxdi.nxp.com" <linux-devel@linux.nxdi.nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>, Jana Build <jana.build@nxp.com>
Subject: [PATCH 1/2] arm64: dts: imx8mm: remove "simple-bus" for anatop
Thread-Topic: [PATCH 1/2] arm64: dts: imx8mm: remove "simple-bus" for anatop
Thread-Index: AQHVlVcRpB4mpaFfY0a5ijwg0EA9nA==
Date:   Thu, 7 Nov 2019 10:35:26 +0000
Message-ID: <20191107103332.16485-1-chen.fang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:54::14) To AM6PR04MB4936.eurprd04.prod.outlook.com
 (2603:10a6:20b:8::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chen.fang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: afb9d01c-4c76-4b0d-1f0b-08d7636e3385
x-ms-traffictypediagnostic: AM6PR04MB5543:|AM6PR04MB5543:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB5543B2FCCE1D15CE6ABFB42EF3780@AM6PR04MB5543.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:660;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(199004)(189003)(66556008)(14454004)(5660300002)(64756008)(66446008)(66946007)(54906003)(66476007)(99286004)(71190400001)(71200400001)(14444005)(316002)(110136005)(256004)(7736002)(478600001)(36756003)(2201001)(26005)(305945005)(6436002)(4744005)(25786009)(1076003)(2501003)(8936002)(3846002)(186003)(6116002)(102836004)(81156014)(6506007)(52116002)(386003)(66066001)(50226002)(81166006)(476003)(4326008)(6486002)(486006)(2616005)(2906002)(8676002)(86362001)(6512007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5543;H:AM6PR04MB4936.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8nS5yOG8+z6/POkzEgzFfVIKHzfqXCFVzbD9D9WdErqE0TYm/38D5IP8ETbeDw0Zq+Uy4+BMzC4RVaqI34rp+u1Kxu0V/LYsK8nFaABL12NbVULR47ZJkN1JwIBXFAuMQwOp0PXp6/Gaa36+Kf13OKB071bRns6AYGmjJN9Y+tevwt8+xjao9J3SOvp6IMvaHnIww21vZ6X5lTrikegYwC2jH8ckif49RU0FTVWkW/u7XXfcDJdlI7ugrJd/Se8olZ4WyTO3xrXhAwJpuFIhAFrHNn2l6ru494aU1D4jJUKyNB1jCoLeq2fSrO6juHqcSLMHAIfAxcGyQz89/fgPTxrHfpKNKghC9BcrL3tZmYm7zcN5EPsSOdfKvVtTcfFnOaAhXkRhCFR/zK1gou5E1Kgb7bKWPeYzW0zIrfg1yKd5Te2smJrKQQ2v2DlN2adZ
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afb9d01c-4c76-4b0d-1f0b-08d7636e3385
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 10:35:26.1747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B3VuDIWAgmyKXi+gDVaO7ku5NLw2NnA1azyTffARdj58e7OpyZd67vwk4KFFq9RWf2NOQe3SGjTKwDQMtdEimA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5543
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove "simple-bus" compatible for device anatop,
since no child nodes exist under it and it is not
a populated bus.

Signed-off-by: Fancy Fang <chen.fang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mm.dtsi
index 6edbdfe2d0d7..da297b5e509d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -438,7 +438,7 @@
 			};
=20
 			anatop: anatop@30360000 {
-				compatible =3D "fsl,imx8mm-anatop", "syscon", "simple-bus";
+				compatible =3D "fsl,imx8mm-anatop", "syscon";
 				reg =3D <0x30360000 0x10000>;
 			};
=20
--=20
2.17.1

