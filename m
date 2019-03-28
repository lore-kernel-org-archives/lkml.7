Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50004C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 05:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9A82173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 05:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="iO4/009I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfC1Fqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 01:46:48 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:4845 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfC1Fqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 01:46:48 -0400
X-IronPort-AV: E=Sophos;i="5.60,278,1549954800"; 
   d="scan'208";a="26278047"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 27 Mar 2019 22:46:47 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 27 Mar 2019 22:46:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhris+UJGYPwtlyDfA7qh3x0eHql/kegR8dd8hVSSJs=;
 b=iO4/009IknoGSFtciplp27KqyOFVKwo469DMzRfMaC4irrvtHBE09w+xQTbnxDevuT3d9yusW9FtQEn0Nm1HOLhbXnQAV5r/xC1IbZNZgDm0ieRbFuhmunn5bzRL/deV9PqZfEfYDM3i6px8ayTbbFEM7itYKyqPo1kX2y8oMJc=
Received: from BY5PR11MB4119.namprd11.prod.outlook.com (10.255.162.219) by
 BY5PR11MB3974.namprd11.prod.outlook.com (10.255.160.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Thu, 28 Mar 2019 05:46:44 +0000
Received: from BY5PR11MB4119.namprd11.prod.outlook.com
 ([fe80::4454:7962:5f5a:72e9]) by BY5PR11MB4119.namprd11.prod.outlook.com
 ([fe80::4454:7962:5f5a:72e9%2]) with mapi id 15.20.1730.019; Thu, 28 Mar 2019
 05:46:44 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <hkallweit1@gmail.com>,
        <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Kavyasree.Kotagiri@microchip.com>
Subject: [PATCH v2 2/2] net: phy: vitesse: Remove support for VSC8514
Thread-Topic: [PATCH v2 2/2] net: phy: vitesse: Remove support for VSC8514
Thread-Index: AQHU5SmfOxXNIr/uPE6DxxsgVZSo6A==
Date:   Thu, 28 Mar 2019 05:46:43 +0000
Message-ID: <20190328054616.10207-1-kavyasree.kotagiri@microchip.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::42) To BY5PR11MB4119.namprd11.prod.outlook.com
 (2603:10b6:a03:18f::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kavyasree.Kotagiri@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [182.72.246.220]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9064f3c1-6982-4ea8-5c4e-08d6b340c211
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY5PR11MB3974;
x-ms-traffictypediagnostic: BY5PR11MB3974:
x-microsoft-antispam-prvs: <BY5PR11MB397457891047203DD0B2469492590@BY5PR11MB3974.namprd11.prod.outlook.com>
x-forefront-prvs: 0990C54589
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(346002)(366004)(396003)(199004)(189003)(5660300002)(78486014)(66066001)(6436002)(7736002)(71190400001)(25786009)(107886003)(6116002)(97736004)(86362001)(106356001)(186003)(71200400001)(8676002)(4326008)(6486002)(1076003)(99286004)(2616005)(8936002)(486006)(3846002)(26005)(2501003)(386003)(6506007)(55236004)(305945005)(102836004)(476003)(50226002)(52116002)(36756003)(72206003)(68736007)(81156014)(478600001)(14454004)(110136005)(54906003)(6512007)(2906002)(81166006)(256004)(105586002)(316002)(2201001)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR11MB3974;H:BY5PR11MB4119.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MCwJg9Y+Jl+u8NHTlqiF2IOqe2gvkvHAEVP0xuCnpfaZ8/jo8/j26YmBQxPD6ZfXlU5JJyaVrWURFAJ25MeNH+fXTj1rN8a58t5IDDiwe6Z+Da7hlSxnK9CexdJ01CBH5uPYOqcJ420A7+80KcUAweS0QqpzUWHItuzdnhZlzyFbE8vd+o5dLvavuBaSHQ6xZv+OZ4Vr13swmBhyVvgMQaAAf3c/m7EPtQeUGHXg0Zn6XiuDs+embWnoFCGSD2CtD1Pixyl+ZZ7AA434v0JEoHcKhbVUggT40Y/3m6MTCavW9HWsBvLOc+nQ6YPDSfEUoLnIxUjVfR96JE+F2c/Dy45i3WwBZNLeMtZ5AYXbtJbY+lcdvrQIcfpgj2ju4KUEeFipfPjvDFFtMcHYU4YBRwWdMO0TDviVEc95zGIydXU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9064f3c1-6982-4ea8-5c4e-08d6b340c211
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2019 05:46:44.0014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3974
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kavya Sree <kavyasree.kotagiri@microchip.com>

Add support for VSC8514 in Microsemi driver (mscc.c)
with more features.

Signed-off-by: Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>
---

Changes in v2: None

 drivers/net/phy/vitesse.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/net/phy/vitesse.c b/drivers/net/phy/vitesse.c
index dc0dd87a6694..e5eb98e94b02 100644
--- a/drivers/net/phy/vitesse.c
+++ b/drivers/net/phy/vitesse.c
@@ -61,7 +61,6 @@
=20
 #define PHY_ID_VSC8234			0x000fc620
 #define PHY_ID_VSC8244			0x000fc6c0
-#define PHY_ID_VSC8514			0x00070670
 #define PHY_ID_VSC8572			0x000704d0
 #define PHY_ID_VSC8601			0x00070420
 #define PHY_ID_VSC7385			0x00070450
@@ -293,7 +292,6 @@ static int vsc82xx_config_intr(struct phy_device *phyde=
v)
 		err =3D phy_write(phydev, MII_VSC8244_IMASK,
 			(phydev->drv->phy_id =3D=3D PHY_ID_VSC8234 ||
 			 phydev->drv->phy_id =3D=3D PHY_ID_VSC8244 ||
-			 phydev->drv->phy_id =3D=3D PHY_ID_VSC8514 ||
 			 phydev->drv->phy_id =3D=3D PHY_ID_VSC8572 ||
 			 phydev->drv->phy_id =3D=3D PHY_ID_VSC8601) ?
 				MII_VSC8244_IMASK_MASK :
@@ -403,15 +401,6 @@ static struct phy_driver vsc82xx_driver[] =3D {
 	.config_aneg	=3D &vsc82x4_config_aneg,
 	.ack_interrupt	=3D &vsc824x_ack_interrupt,
 	.config_intr	=3D &vsc82xx_config_intr,
-}, {
-	.phy_id		=3D PHY_ID_VSC8514,
-	.name		=3D "Vitesse VSC8514",
-	.phy_id_mask	=3D 0x000ffff0,
-	.features	=3D PHY_GBIT_FEATURES,
-	.config_init	=3D &vsc824x_config_init,
-	.config_aneg	=3D &vsc82x4_config_aneg,
-	.ack_interrupt	=3D &vsc824x_ack_interrupt,
-	.config_intr	=3D &vsc82xx_config_intr,
 }, {
 	.phy_id         =3D PHY_ID_VSC8572,
 	.name           =3D "Vitesse VSC8572",
@@ -499,7 +488,6 @@ module_phy_driver(vsc82xx_driver);
 static struct mdio_device_id __maybe_unused vitesse_tbl[] =3D {
 	{ PHY_ID_VSC8234, 0x000ffff0 },
 	{ PHY_ID_VSC8244, 0x000fffc0 },
-	{ PHY_ID_VSC8514, 0x000ffff0 },
 	{ PHY_ID_VSC8572, 0x000ffff0 },
 	{ PHY_ID_VSC7385, 0x000ffff0 },
 	{ PHY_ID_VSC7388, 0x000ffff0 },
--=20
2.17.1

