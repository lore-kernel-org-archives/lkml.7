Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D94FC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F64020828
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wxh7cmQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbfCYDxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 23:53:42 -0400
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:44160
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729380AbfCYDxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 23:53:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hb3sgdqzqEKrgkpAYG9r1uyzi2Keo/uYUj0wToDHNQ=;
 b=wxh7cmQIJbfnyLhE45OqqvqEMuexc/P5hpOLIw54vLweLKr+jmmaOdnk5Eh0wREmWofTZxIX2vI0OQePcjPz1pUoHCvlh8kuz3y1AbnzqdnrDyZ/nKTeNoS5uq6SCiME0/sLtII/8lLZA7eowOk/tb91KK1kjvuR+ASDQoMpN8Q=
Received: from VI1PR04MB3247.eurprd04.prod.outlook.com (10.170.232.160) by
 VI1PR04MB5711.eurprd04.prod.outlook.com (20.178.126.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Mon, 25 Mar 2019 03:53:37 +0000
Received: from VI1PR04MB3247.eurprd04.prod.outlook.com
 ([fe80::8d98:21a4:2a84:3c1d]) by VI1PR04MB3247.eurprd04.prod.outlook.com
 ([fe80::8d98:21a4:2a84:3c1d%5]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 03:53:37 +0000
From:   Qiang Zhao <qiang.zhao@nxp.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Qiang Zhao <qiang.zhao@nxp.com>
Subject: [patch v14 2/4] irqchip/qeic: merge qeic init code from platforms to
 a common function
Thread-Topic: [patch v14 2/4] irqchip/qeic: merge qeic init code from
 platforms to a common function
Thread-Index: AQHU4r5T4XAcsqdffk2+pmzkjDln0w==
Date:   Mon, 25 Mar 2019 03:53:37 +0000
Message-ID: <20190325035418.19065-3-qiang.zhao@nxp.com>
References: <20190325035418.19065-1-qiang.zhao@nxp.com>
In-Reply-To: <20190325035418.19065-1-qiang.zhao@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::36) To VI1PR04MB3247.eurprd04.prod.outlook.com
 (2603:10a6:802:11::32)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiang.zhao@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b63655e-e68e-401c-64f9-08d6b0d575ba
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5711;
x-ms-traffictypediagnostic: VI1PR04MB5711:
x-microsoft-antispam-prvs: <VI1PR04MB5711EC93DE2664EC8C8D4570915E0@VI1PR04MB5711.eurprd04.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(39860400002)(376002)(136003)(199004)(189003)(478600001)(2906002)(44832011)(1076003)(53936002)(66066001)(2201001)(256004)(50226002)(81166006)(2501003)(106356001)(316002)(305945005)(7736002)(186003)(8676002)(105586002)(71200400001)(86362001)(26005)(97736004)(486006)(3846002)(76176011)(110136005)(54906003)(11346002)(71190400001)(25786009)(81156014)(5660300002)(8936002)(386003)(6506007)(6116002)(476003)(4326008)(6486002)(6512007)(99286004)(6436002)(446003)(2616005)(68736007)(14454004)(36756003)(102836004)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5711;H:VI1PR04MB3247.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XRMX7vvewdj34nDBCYz/Q4C0GVBvSs8ErSejh/UT/FTgl7KDjltfiDT1hrwQtmkKky4PDjvpSKMABJ7hiMwvull3jhMIzTpGq6MBsSJ4FTBoqJ2Rqt73Zzj8ske9WUWxHh8wqFRN6QLk87lVN41bvOwyJxt1bYswqszbb1YSSn/MvuIl2DfJKLT+aFDHiIVhQFNADYGE8TEcRAHqTYY1fa74mt6HEQMoH7QXjWiWxqVEa2nZXBiQbaCq8smmaOtPXslrpvr6yLGH2HpkYRBdrZ5DsETQHKIegaQro54QLej1AtqGIg0AGNL0FCbhV0yt2YSHp/4Wwb2FcT2n6rBiA1M9NzWAqXbTi4xV2mPhFlEaYxfXlooWFXsb7zrbr1x2xBGkKRvIzTjzpf0LY9VVmoJnBj1Si6R09D16tKTrWjk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b63655e-e68e-401c-64f9-08d6b0d575ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 03:53:37.1868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The codes of qe_ic init from a variety of platforms are redundant,
merge them to a common function and put it to irqchip/irq-qeic.c

For non-p1021_mds mpc85xx_mds boards, use "qe_ic_init(np, 0,
qe_ic_cascade_low_mpic, qe_ic_cascade_high_mpic);" instead of
"qe_ic_init(np, 0, qe_ic_cascade_muxed_mpic, NULL);".

qe_ic_cascade_muxed_mpic was used for boards has the same interrupt
number for low interrupt and high interrupt, qe_ic_init has checked
if "low interrupt =3D=3D high interrupt"

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
 arch/powerpc/platforms/83xx/misc.c            |   15 ---------------
 arch/powerpc/platforms/85xx/corenet_generic.c |    9 ---------
 arch/powerpc/platforms/85xx/mpc85xx_mds.c     |   14 --------------
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c     |   16 ----------------
 arch/powerpc/platforms/85xx/twr_p102x.c       |   14 --------------
 drivers/irqchip/irq-qeic.c                    |   13 +++++++++++++
 6 files changed, 13 insertions(+), 68 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/misc.c b/arch/powerpc/platforms/83=
xx/misc.c
index 2b6589f..4150b56 100644
--- a/arch/powerpc/platforms/83xx/misc.c
+++ b/arch/powerpc/platforms/83xx/misc.c
@@ -94,24 +94,9 @@ void __init mpc83xx_ipic_init_IRQ(void)
 }
=20
 #ifdef CONFIG_QUICC_ENGINE
-void __init mpc83xx_qe_init_IRQ(void)
-{
-	struct device_node *np;
-
-	np =3D of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
-	if (!np) {
-		np =3D of_find_node_by_type(NULL, "qeic");
-		if (!np)
-			return;
-	}
-	qe_ic_init(np, 0, qe_ic_cascade_low_ipic, qe_ic_cascade_high_ipic);
-	of_node_put(np);
-}
-
 void __init mpc83xx_ipic_and_qe_init_IRQ(void)
 {
 	mpc83xx_ipic_init_IRQ();
-	mpc83xx_qe_init_IRQ();
 }
 #endif /* CONFIG_QUICC_ENGINE */
=20
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/p=
latforms/85xx/corenet_generic.c
index 785e964..e44bb44 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -42,8 +42,6 @@ void __init corenet_gen_pic_init(void)
 	unsigned int flags =3D MPIC_BIG_ENDIAN | MPIC_SINGLE_DEST_CPU |
 		MPIC_NO_RESET;
=20
-	struct device_node *np;
-
 	if (ppc_md.get_irq =3D=3D mpic_get_coreint_irq)
 		flags |=3D MPIC_ENABLE_COREINT;
=20
@@ -51,13 +49,6 @@ void __init corenet_gen_pic_init(void)
 	BUG_ON(mpic =3D=3D NULL);
=20
 	mpic_init(mpic);
-
-	np =3D of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
-	if (np) {
-		qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
-				qe_ic_cascade_high_mpic);
-		of_node_put(np);
-	}
 }
=20
 /*
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platf=
orms/85xx/mpc85xx_mds.c
index 80939a4..6892bc1 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -283,20 +283,6 @@ static void __init mpc85xx_mds_qeic_init(void)
 		of_node_put(np);
 		return;
 	}
-
-	np =3D of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
-	if (!np) {
-		np =3D of_find_node_by_type(NULL, "qeic");
-		if (!np)
-			return;
-	}
-
-	if (machine_is(p1021_mds))
-		qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
-				qe_ic_cascade_high_mpic);
-	else
-		qe_ic_init(np, 0, qe_ic_cascade_muxed_mpic, NULL);
-	of_node_put(np);
 }
 #else
 static void __init mpc85xx_mds_qe_init(void) { }
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platf=
orms/85xx/mpc85xx_rdb.c
index 1006950..000d385 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -48,10 +48,6 @@ void __init mpc85xx_rdb_pic_init(void)
 {
 	struct mpic *mpic;
=20
-#ifdef CONFIG_QUICC_ENGINE
-	struct device_node *np;
-#endif
-
 	if (of_machine_is_compatible("fsl,MPC85XXRDB-CAMP")) {
 		mpic =3D mpic_alloc(NULL, 0, MPIC_NO_RESET |
 			MPIC_BIG_ENDIAN |
@@ -66,18 +62,6 @@ void __init mpc85xx_rdb_pic_init(void)
=20
 	BUG_ON(mpic =3D=3D NULL);
 	mpic_init(mpic);
-
-#ifdef CONFIG_QUICC_ENGINE
-	np =3D of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
-	if (np) {
-		qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
-				qe_ic_cascade_high_mpic);
-		of_node_put(np);
-
-	} else
-		pr_err("%s: Could not find qe-ic node\n", __func__);
-#endif
-
 }
=20
 /*
diff --git a/arch/powerpc/platforms/85xx/twr_p102x.c b/arch/powerpc/platfor=
ms/85xx/twr_p102x.c
index 360f625..6be9b33 100644
--- a/arch/powerpc/platforms/85xx/twr_p102x.c
+++ b/arch/powerpc/platforms/85xx/twr_p102x.c
@@ -35,26 +35,12 @@ static void __init twr_p1025_pic_init(void)
 {
 	struct mpic *mpic;
=20
-#ifdef CONFIG_QUICC_ENGINE
-	struct device_node *np;
-#endif
-
 	mpic =3D mpic_alloc(NULL, 0, MPIC_BIG_ENDIAN |
 			MPIC_SINGLE_DEST_CPU,
 			0, 256, " OpenPIC  ");
=20
 	BUG_ON(mpic =3D=3D NULL);
 	mpic_init(mpic);
-
-#ifdef CONFIG_QUICC_ENGINE
-	np =3D of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
-	if (np) {
-		qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
-				qe_ic_cascade_high_mpic);
-		of_node_put(np);
-	} else
-		pr_err("Could not find qe-ic node\n");
-#endif
 }
=20
 /* ***********************************************************************=
*
diff --git a/drivers/irqchip/irq-qeic.c b/drivers/irqchip/irq-qeic.c
index aba7135..673afb4 100644
--- a/drivers/irqchip/irq-qeic.c
+++ b/drivers/irqchip/irq-qeic.c
@@ -18,6 +18,7 @@
 #include <linux/of_address.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/irqchip.h>
 #include <linux/errno.h>
 #include <linux/reboot.h>
 #include <linux/slab.h>
@@ -598,4 +599,16 @@ static int __init init_qe_ic_sysfs(void)
 	return 0;
 }
=20
+static int __init qeic_of_init(struct device_node *node,
+			       struct device_node *parent)
+{
+	if (!node)
+		return -ENODEV;
+	qe_ic_init(node, 0, qe_ic_cascade_low_mpic,
+		   qe_ic_cascade_high_mpic);
+	of_node_put(node);
+	return 0;
+}
+
+IRQCHIP_DECLARE(qeic, "fsl,qe-ic", qeic_of_init);
 subsys_initcall(init_qe_ic_sysfs);
--=20
1.7.1

