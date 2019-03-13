Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F14AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E672147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kBUv/qIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfCMJFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 05:05:55 -0400
Received: from mail-eopbgr30043.outbound.protection.outlook.com ([40.107.3.43]:18823
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726694AbfCMJFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 05:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sznuWZQrZNfM2TP+wFo6OzXs0NioKBnsWljJojEnuqo=;
 b=kBUv/qIWh2n8T8Ar4MHAoL5hHaIkG33SX2UBl9ppDdfL1S6ya3WQ1CvOmqWHvZ+3CtebvcZ412MOnJvYsur1sGyRtxa2sDqE4l40o7GKWXOucBhz78+DM+JwDaiCTY2bv2nV+8dqRnyKzgbf/Q7+fxgkI9uL3IpOPuSJG6WjQcw=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5332.eurprd04.prod.outlook.com (52.134.95.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Wed, 13 Mar 2019 09:05:52 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185%5]) with mapi id 15.20.1686.021; Wed, 13 Mar 2019
 09:05:52 +0000
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
Subject: [PATCH 1/2] ARM: imx: drop uneccessary of_platform_default_populate
Thread-Topic: [PATCH 1/2] ARM: imx: drop uneccessary
 of_platform_default_populate
Thread-Index: AQHU2Xv1SFnRc4p0SkOOn59vTkEkOw==
Date:   Wed, 13 Mar 2019 09:05:52 +0000
Message-ID: <20190313091757.16410-1-peng.fan@nxp.com>
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
x-ms-office365-filtering-correlation-id: 1bbaa476-1def-4b08-2ec7-08d6a7931782
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5332;
x-ms-traffictypediagnostic: AM0PR04MB5332:
x-microsoft-antispam-prvs: <AM0PR04MB5332A5DDCA2F58120CC14065884A0@AM0PR04MB5332.eurprd04.prod.outlook.com>
x-forefront-prvs: 09752BC779
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(39860400002)(136003)(199004)(189003)(386003)(8676002)(186003)(71200400001)(71190400001)(52116002)(26005)(53936002)(6512007)(66066001)(68736007)(6506007)(102836004)(8936002)(36756003)(7736002)(1076003)(14454004)(305945005)(50226002)(81156014)(81166006)(4326008)(6436002)(25786009)(478600001)(105586002)(110136005)(54906003)(2906002)(44832011)(5660300002)(6116002)(3846002)(6486002)(2201001)(86362001)(2616005)(476003)(256004)(2501003)(486006)(99286004)(97736004)(316002)(106356001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5332;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KL/z/ofBx1U+AGrQgF1bnwMPMGMZFeZWQls5emm9BTA3tN8xKIE2mPEu3MrklIzYYcqpfVpAF7w/IgJ56ChJ0DVwgctl1LFE8+0fVHG2UoWQCtKM2w0lz67+LfA/69pHsnXk+MqjB2jzJPHhdMKiPYzUdU9V8ZOlCzhTtM7fkxhv7Scp2VJzGrGnY9Jpt+EdLOOUpOPblmVe9zcDVOJp0qgvsILVKdLTqZKtg72zn1x1PioZn66M/k04ZgxMuWzaLV5xypd2Y12KgJKvzLXxvWU7ofnPK5FKEsJGh3ne1k5CZXqQIHD4gPNlvkWWuFb6d4P+P82VBkmo+jKPKjXIeFBteMr1gxh5m8AdN/iabIrAUVuNt8SyLzDOujZU8ctoTrRhL2G4tK8YKHjtse0Gt9yr3ho4vxJ3G7xD9GDhaoU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bbaa476-1def-4b08-2ec7-08d6a7931782
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2019 09:05:52.0465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5332
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"arch_initcall_sync(of_platform_default_populate_init);" could be
used to populate the device tree, there is no need to call
of_platform_default_populate in machine code.

Tested on i.MX6Q-SDB i.MX6SL-EVK i.MX6UL-EVK board.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/mach-imx6q.c  | 2 --
 arch/arm/mach-imx/mach-imx6sl.c | 2 --
 arch/arm/mach-imx/mach-imx6sx.c | 2 --
 arch/arm/mach-imx/mach-imx6ul.c | 1 -
 4 files changed, 7 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.=
c
index 7d80a0ae723c..655398c20256 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -278,8 +278,6 @@ static void __init imx6q_init_machine(void)
=20
 	imx6q_enet_phy_init();
=20
-	of_platform_default_populate(NULL, NULL, parent);
-
 	imx_anatop_init();
 	cpu_is_imx6q() ?  imx6q_pm_init() : imx6dl_pm_init();
 	imx6q_1588_init();
diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6s=
l.c
index 99be4225297a..9743bdbb68fa 100644
--- a/arch/arm/mach-imx/mach-imx6sl.c
+++ b/arch/arm/mach-imx/mach-imx6sl.c
@@ -56,8 +56,6 @@ static void __init imx6sl_init_machine(void)
 	if (parent =3D=3D NULL)
 		pr_warn("failed to initialize soc device\n");
=20
-	of_platform_default_populate(NULL, NULL, parent);
-
 	if (cpu_is_imx6sl())
 		imx6sl_fec_init();
 	imx_anatop_init();
diff --git a/arch/arm/mach-imx/mach-imx6sx.c b/arch/arm/mach-imx/mach-imx6s=
x.c
index 7f52d9b1e8a4..19b9f2dd309e 100644
--- a/arch/arm/mach-imx/mach-imx6sx.c
+++ b/arch/arm/mach-imx/mach-imx6sx.c
@@ -72,8 +72,6 @@ static void __init imx6sx_init_machine(void)
 	if (parent =3D=3D NULL)
 		pr_warn("failed to initialize soc device\n");
=20
-	of_platform_default_populate(NULL, NULL, parent);
-
 	imx6sx_enet_init();
 	imx_anatop_init();
 	imx6sx_pm_init();
diff --git a/arch/arm/mach-imx/mach-imx6ul.c b/arch/arm/mach-imx/mach-imx6u=
l.c
index 6cb8a22b617d..c57b9df791b1 100644
--- a/arch/arm/mach-imx/mach-imx6ul.c
+++ b/arch/arm/mach-imx/mach-imx6ul.c
@@ -65,7 +65,6 @@ static void __init imx6ul_init_machine(void)
 	if (parent =3D=3D NULL)
 		pr_warn("failed to initialize soc device\n");
=20
-	of_platform_default_populate(NULL, NULL, parent);
 	imx6ul_enet_init();
 	imx_anatop_init();
 	imx6ul_pm_init();
--=20
2.16.4

