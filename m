Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDBBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC892173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=itdevltd.onmicrosoft.com header.i=@itdevltd.onmicrosoft.com header.b="b6REFHFs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfC1NLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:11:09 -0400
Received: from mail-eopbgr60065.outbound.protection.outlook.com ([40.107.6.65]:54018
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726076AbfC1NLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itdevltd.onmicrosoft.com; s=selector1-itdev-co-uk;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxi+go9AaP3UdFsdmi9wCBRYpVYqIUucaRDrIHIGbpY=;
 b=b6REFHFsGsQyNY1Dof+vHyip50jI2XlqxU6L4FWs2Tx2+4s26sK/IebyEqiBAq/0pQTpws5UlUnIJ/QSB33/OJKvUgYM9rQKTdKcGV7sO5r/AfSsNdpOmSXJlQKWHaMiNCzAeWIzygZ66avILlIhyo7Lzc6W/QCq1Y5ilG/A03E=
Received: from AM0PR08MB3153.eurprd08.prod.outlook.com (52.134.91.160) by
 AM0PR08MB3060.eurprd08.prod.outlook.com (52.134.94.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Thu, 28 Mar 2019 13:11:05 +0000
Received: from AM0PR08MB3153.eurprd08.prod.outlook.com
 ([fe80::3901:8b66:2f36:acf0]) by AM0PR08MB3153.eurprd08.prod.outlook.com
 ([fe80::3901:8b66:2f36:acf0%2]) with mapi id 15.20.1750.017; Thu, 28 Mar 2019
 13:11:05 +0000
From:   Quentin Deslandes <quentin.deslandes@itdev.co.uk>
To:     Hannes Reinecke <hare@suse.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: [PATCH] scsi: aic79xx: NULL check before some freeing functions is
 not needed.
Thread-Topic: [PATCH] scsi: aic79xx: NULL check before some freeing functions
 is not needed.
Thread-Index: AQHU5WezO+aL1A7OAkOb6giQkN7X9g==
Date:   Thu, 28 Mar 2019 13:11:04 +0000
Message-ID: <20190328131101.GA21866@qd-ubuntu>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DB6PR07CA0003.eurprd07.prod.outlook.com
 (2603:10a6:6:2d::13) To AM0PR08MB3153.eurprd08.prod.outlook.com
 (2603:10a6:208:59::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=quentin.deslandes@itdev.co.uk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.21.227.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4242de83-0848-4146-8a4a-08d6b37ed574
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600127)(711020)(4605104)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3060;
x-ms-traffictypediagnostic: AM0PR08MB3060:
x-microsoft-antispam-prvs: <AM0PR08MB3060FE5F268F54209F271E33B3590@AM0PR08MB3060.eurprd08.prod.outlook.com>
x-forefront-prvs: 0990C54589
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(366004)(396003)(39830400003)(136003)(346002)(376002)(199004)(189003)(71190400001)(316002)(6512007)(71200400001)(14454004)(33716001)(9686003)(68736007)(5660300002)(52116002)(74482002)(66066001)(33656002)(81166006)(102836004)(54906003)(2906002)(8936002)(6506007)(81156014)(86362001)(386003)(26005)(508600001)(1076003)(6116002)(3846002)(25786009)(14444005)(44832011)(99286004)(4326008)(186003)(105586002)(8676002)(476003)(110136005)(486006)(305945005)(53936002)(2501003)(6436002)(6486002)(97736004)(7736002)(106356001)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3060;H:AM0PR08MB3153.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: itdev.co.uk does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XrWZz4QTqJErYzjP8Lhmtz3sN7ExxLHy7AdP3Wc3uWT7Wkt5++s0k5+g85Fjogbmg+Zcdf88Sw6yOwkMaBOSb7nlYP1gVU2/wbOA+q0M4rHdzdDhbZzms7+wNnfTVaNF0V05Gap8cbwUyycGNHTs6tUrvuBl1s4NblXMmpKMsh8lJ/Is2MOLZM/76e3kb+Xyo9syzNyflbFnLtiShilFE/2Cg/eSzH6Ei6c1CecztRYgKNr+V2d6C7RO4meUBesXtiikYFS7QrImpzz8QXsEPyYr+wIRzWXmiJ4vIGSUE2Ruy8LA5q/7RSlaxPa3J/Z1r/hWGr7GQtSSaMkkeKqrWC7jGsTBAnEXOkoGFaxjFQdy9m1AlvD3YFY258UH31ESz3MTRllWUj63J7LLpvYqve2jG4mT9UMSkz8xjMHR93Q=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3F4A414268EA46479089CFBFC4E9A5A0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: itdev.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: 4242de83-0848-4146-8a4a-08d6b37ed574
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2019 13:11:04.9640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2d2930c4-2251-45b4-ad79-3582c5f41740
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccinelle warning by removing NULL check before
calling kfree:

NULL check before some freeing functions is not needed.

Signed-off-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>
---
 drivers/scsi/aic7xxx/aic79xx_core.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic79xx_core.c b/drivers/scsi/aic7xxx/aic=
79xx_core.c
index 7e5044bf05c0..a61022db43ee 100644
--- a/drivers/scsi/aic7xxx/aic79xx_core.c
+++ b/drivers/scsi/aic7xxx/aic79xx_core.c
@@ -3664,8 +3664,6 @@ ahd_alloc_tstate(struct ahd_softc *ahd, u_int scsi_id=
, char channel)
 static void
 ahd_free_tstate(struct ahd_softc *ahd, u_int scsi_id, char channel, int fo=
rce)
 {
-	struct ahd_tmode_tstate *tstate;
-
 	/*
 	 * Don't clean up our "master" tstate.
 	 * It has our default user settings.
@@ -3674,9 +3672,7 @@ ahd_free_tstate(struct ahd_softc *ahd, u_int scsi_id,=
 char channel, int force)
 	 && force =3D=3D FALSE)
 		return;
=20
-	tstate =3D ahd->enabled_targets[scsi_id];
-	if (tstate !=3D NULL)
-		kfree(tstate);
+	kfree(ahd->enabled_targets[scsi_id]);
 	ahd->enabled_targets[scsi_id] =3D NULL;
 }
 #endif
@@ -6138,8 +6134,7 @@ ahd_set_unit(struct ahd_softc *ahd, int unit)
 void
 ahd_set_name(struct ahd_softc *ahd, char *name)
 {
-	if (ahd->name !=3D NULL)
-		kfree(ahd->name);
+	kfree(ahd->name);
 	ahd->name =3D name;
 }
=20
@@ -6200,12 +6195,9 @@ ahd_free(struct ahd_softc *ahd)
 		kfree(ahd->black_hole);
 	}
 #endif
-	if (ahd->name !=3D NULL)
-		kfree(ahd->name);
-	if (ahd->seep_config !=3D NULL)
-		kfree(ahd->seep_config);
-	if (ahd->saved_stack !=3D NULL)
-		kfree(ahd->saved_stack);
+	kfree(ahd->name);
+	kfree(ahd->seep_config);
+	kfree(ahd->saved_stack);
 #ifndef __FreeBSD__
 	kfree(ahd);
 #endif
--=20
2.17.1

