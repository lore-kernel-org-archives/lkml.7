Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AF5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37F721872
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="c/OCQgOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfCMJGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 05:06:03 -0400
Received: from mail-eopbgr30054.outbound.protection.outlook.com ([40.107.3.54]:11073
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727303AbfCMJGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 05:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KG7aXS7nZ1MdGVaMBRMVYU28WaSY7vXsYkvK6MjXTe0=;
 b=c/OCQgOTNifeFRMgH6+utQdwNaP5HUcK2X/+BrHcuwQdxYCXKP9WAGjymifAJrrQC3OC/kYHYFjBt0o1kR/fPeFIhBxNmWURdIm68NqbPm/hfn6nOAekVgPRHIPdjhSVnB8TnLU+HveZWcqlHahzi59j9F4zU4GbXs2oCG6SdX0=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5332.eurprd04.prod.outlook.com (52.134.95.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Wed, 13 Mar 2019 09:06:00 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185%5]) with mapi id 15.20.1686.021; Wed, 13 Mar 2019
 09:06:00 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] ARM: imx: mach-imx7ulp: warn when imx_soc_device_init
 fail
Thread-Topic: [PATCH 2/2] ARM: imx: mach-imx7ulp: warn when
 imx_soc_device_init fail
Thread-Index: AQHU2Xv55ycgcbWqOUOiTJMdwKpBcw==
Date:   Wed, 13 Mar 2019 09:05:59 +0000
Message-ID: <20190313091757.16410-2-peng.fan@nxp.com>
References: <20190313091757.16410-1-peng.fan@nxp.com>
In-Reply-To: <20190313091757.16410-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK2PR0302CA0011.apcprd03.prod.outlook.com
 (2603:1096:202::21) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84d9a019-5b97-470a-6034-08d6a7931bfb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5332;
x-ms-traffictypediagnostic: AM0PR04MB5332:
x-microsoft-antispam-prvs: <AM0PR04MB53323B54AB97EDB158DB3EC9884A0@AM0PR04MB5332.eurprd04.prod.outlook.com>
x-forefront-prvs: 09752BC779
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(39860400002)(136003)(199004)(189003)(386003)(8676002)(186003)(71200400001)(71190400001)(52116002)(26005)(53936002)(76176011)(6512007)(66066001)(68736007)(6506007)(102836004)(8936002)(36756003)(7736002)(1076003)(14454004)(305945005)(50226002)(81156014)(81166006)(4326008)(6436002)(25786009)(478600001)(105586002)(110136005)(54906003)(2906002)(44832011)(5660300002)(6116002)(3846002)(6486002)(2201001)(446003)(11346002)(86362001)(2616005)(476003)(256004)(14444005)(2501003)(486006)(99286004)(97736004)(316002)(106356001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5332;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rQ2g0IB390yt4LD7Si91cOdTx/g4koNIcst+zLz1g8lBp+rFobnDkQ6cTh60rMACyklZ4WvNM8+C0BDRwka/BOnGIT1V8hrpnVYEjRsS9AlNoMhPR1ve9xlnVDjM4+fOIslu8RBtFOqFXwmNEhALlQhhCQeaXGCjkunJY5y/fY1OAlrY3YYmJE/orsIU6iIKC7UfMw7fwHWTyr+CbjN4ctlbGzpHYLMHpogtjZQC7i6bb70Fn4VJbjSkxq8AEbX7et6iw9RGJjWKuTqnttd6avxoa6wGIKN0MlEtgIb5oP6F6b7F9MXnUg4R5rR7qcKhpimakUUTXSTg5CmAJaoeXuSmIpxAXj1pGl2ryUlGIZYc89MtwoKt89cmUZsokjUytQMX2zP4dsOThgAsH+0vkhrOrnE0u6Pa7GsZ+4PCB90=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d9a019-5b97-470a-6034-08d6a7931bfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2019 09:06:00.2391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5332
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow other i.MX6/7 machince code to check return value
of imx_soc_device_init and warn when fail.

Also drop of_platform_default_populate, because
"arch_initcall_sync(of_platform_default_populate_init);" could be
used to populate the device tree.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/mach-imx7ulp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mach-imx7ulp.c b/arch/arm/mach-imx/mach-imx7=
ulp.c
index 11ac71aaf965..6d823f05d9aa 100644
--- a/arch/arm/mach-imx/mach-imx7ulp.c
+++ b/arch/arm/mach-imx/mach-imx7ulp.c
@@ -53,11 +53,16 @@ static void __init imx7ulp_set_revision(void)
=20
 static void __init imx7ulp_init_machine(void)
 {
+	struct device *soc_dev;
+
+	soc_dev =3D imx_soc_device_init();
+	if (soc_dev =3D=3D NULL)
+		pr_warn("failed to initialize soc device\n");
+
 	imx7ulp_pm_init();
=20
 	mxc_set_cpu_type(MXC_CPU_IMX7ULP);
 	imx7ulp_set_revision();
-	of_platform_default_populate(NULL, NULL, imx_soc_device_init());
 }
=20
 static const char *const imx7ulp_dt_compat[] __initconst =3D {
--=20
2.16.4

