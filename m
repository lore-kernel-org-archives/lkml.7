Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9453BC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA0F2178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eBRJ+wYO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388138AbfKGKfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 05:35:36 -0500
Received: from mail-eopbgr20073.outbound.protection.outlook.com ([40.107.2.73]:54499
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726866AbfKGKff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 05:35:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0YyjL/WcMKwlNUb85K90O3op12NnJg4uOZU6lccrAsBhA7LfV9VgNgIvTNNEXSbVBekHOh7RUsIZb93Gf8nvu2fzg+kWKLyxAqnQJH7Zeez7ciluYShEADrb4Bzn6g8DknUe9il1JlKSy/J47oIxbLv1j9VPxiydjPBFroIdlzJBZEBAIYiLPFtWWvYamHCehGyib6RCjKZiO5p1HVhIjVGRP/89DkB0zankQliQacjKYgiMd70CsCfwbX0/lNaBh5ZpyiK2LPyLWZF+j/M60Eke010/GG8knHtqU7ZzNGnPZbZB7jNXI6u4MRPDBt+WyBM/Hy5dQDryCSxEGt2Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgVsO4i3AdgxVuKPyXMkUN9Y2SvE690p5wzpZ6BlxMg=;
 b=HbIvoysBq5Pgf22EYHRyKSPkfn5NAGQ+36LIq5jCGBmgfZ0DaeVUrL/69DP9nLUY7jlOP6gfSz0UDLfaLqgG9B74S0yp2g7b/A8TDovdwPBb7XhA1/EI0tQ/X1voFUMXkRQM1dx+GWixp98uRmzxfxI2S1tADveWwheb9eLO+gcv/i5ZViJ46D32UZuW+gilczrlsPv8VpRhUkJd/wmsBdekkz3faO3dNOCdC3O+XJgNjhlqkn4Bc9KP9LcBlQz1T+xutnGlLkUgHuaHt5+gnP2WmjtnwI/26HyPuZLhx4Hj+2DMkm4GE1gZ1i7uSyS8V6NvYwPPmgKwODu60Yi7Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgVsO4i3AdgxVuKPyXMkUN9Y2SvE690p5wzpZ6BlxMg=;
 b=eBRJ+wYOo436/IumHq+iXxsMN2ImV6NTMknNoqPPFMjzz/f/vkayrkQy9+2+OFJ2oemu1xJhvyog8MvHGku/V1XXi2IjNUAaPU/AX9SoM4twIJgPeBZ5yMHtiKvl7jFxFv99eCyhzgIXAPlpJuiHnZLk6++VIm4o8R+sqjFevw0=
Received: from AM6PR04MB4936.eurprd04.prod.outlook.com (20.177.34.20) by
 AM6PR04MB5543.eurprd04.prod.outlook.com (20.178.94.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Thu, 7 Nov 2019 10:35:30 +0000
Received: from AM6PR04MB4936.eurprd04.prod.outlook.com
 ([fe80::912a:3593:7e23:72d0]) by AM6PR04MB4936.eurprd04.prod.outlook.com
 ([fe80::912a:3593:7e23:72d0%7]) with mapi id 15.20.2430.023; Thu, 7 Nov 2019
 10:35:30 +0000
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
Subject: [PATCH 2/2] arm64: dts: imx8mn: remove "simple-bus" for anatop
Thread-Topic: [PATCH 2/2] arm64: dts: imx8mn: remove "simple-bus" for anatop
Thread-Index: AQHVlVcTGcDZNqwodE+6bb4q1XT4Qg==
Date:   Thu, 7 Nov 2019 10:35:30 +0000
Message-ID: <20191107103332.16485-2-chen.fang@nxp.com>
References: <20191107103332.16485-1-chen.fang@nxp.com>
In-Reply-To: <20191107103332.16485-1-chen.fang@nxp.com>
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
x-ms-office365-filtering-correlation-id: 1b727b75-9dda-4bf0-501c-08d7636e3617
x-ms-traffictypediagnostic: AM6PR04MB5543:|AM6PR04MB5543:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB554304AFD192689E4EDF2355F3780@AM6PR04MB5543.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:660;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(199004)(189003)(66556008)(14454004)(5660300002)(64756008)(66446008)(66946007)(54906003)(66476007)(99286004)(71190400001)(71200400001)(14444005)(316002)(110136005)(256004)(7736002)(478600001)(36756003)(2201001)(26005)(446003)(305945005)(11346002)(6436002)(4744005)(25786009)(1076003)(2501003)(8936002)(3846002)(186003)(6116002)(102836004)(81156014)(6506007)(52116002)(386003)(66066001)(76176011)(50226002)(81166006)(476003)(4326008)(6486002)(486006)(2616005)(2906002)(8676002)(86362001)(6512007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5543;H:AM6PR04MB4936.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vb5/bX+h8a3W/gwQFbXTsVxa4wx/wBoc7ZFJoL8KfLfwN52OD017rkMFyXP9j5hthGOnQp3fMaKJ1zECXYZZb4EMhgygDJ0fABguPwlHad1/1aecF9tuOpTxXUSW+jwCHT2c3z+Fm74V8KOG5V2xKTtVWaHV3txkWrHYHNg0WM9im0NwTleJd5280ILlCxpQSK6rn5yJA4DxSRI3GTgCRzmKDpRrnP2SNqkVEi7KC5ODz/FXUsgXePSvEcU5HCyhZ9y418ovyeq35jL4hao1QLDFBEqVVqo36EZvaVRfsWu24hvUU7+NoRj5w8MiEq09QV2oAw3Q8XqQ4YiBmWBmKRzkQxqhDxxQaqUS1C1ONXpI9SIfCq7rOGaLFj5czb144pokBNETZiUWi7Z9ezHL0kvZm99m1rlNRR+6pKugAvqKraaV5+9j3BHMlU/SNVKd
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b727b75-9dda-4bf0-501c-08d7636e3617
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 10:35:30.4722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NqCnPnTmyD5sj8e9EnV7yrZgtI207QNASmb+ufP3o3g7/GpgponcCLyxvIs5/QE3vD7/sXxuspRCtnauvqf/pA==
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
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mn.dtsi
index e91625063f8e..aa95f76de5ef 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -349,7 +349,7 @@
=20
 			anatop: anatop@30360000 {
 				compatible =3D "fsl,imx8mn-anatop", "fsl,imx8mm-anatop",
-					     "syscon", "simple-bus";
+					     "syscon";
 				reg =3D <0x30360000 0x10000>;
 			};
=20
--=20
2.17.1

