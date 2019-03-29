Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A34C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C592173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KrUlOGAf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbfC2HAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 03:00:47 -0400
Received: from mail-eopbgr10052.outbound.protection.outlook.com ([40.107.1.52]:58859
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728719AbfC2HAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 03:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1nPZ3fawbW9uB4G/flZgW4Mvo3PKMF+JVIpwuzqTKs=;
 b=KrUlOGAffpB0lTL5c1GNvq41m3LjE+Bj4UJD9kDcW7Dg9cy1n01PWjEx8eHL6xiAJnjhYsAJSMuGXUtmlyxdKQHGJHlPL0fGL21MxE9bOTisTzQKnfWHBV8F3ORy3V9wImvi+sqiHYFy5kAlavdZwtxD+sN54ig1AZQEQMc3D9Q=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3945.eurprd04.prod.outlook.com (52.134.65.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.19; Fri, 29 Mar 2019 07:00:43 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%7]) with mapi id 15.20.1750.017; Fri, 29 Mar 2019
 07:00:43 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 1/2] input: keyboard: imx: no need to control interrupt status
 in event check
Thread-Topic: [PATCH 1/2] input: keyboard: imx: no need to control interrupt
 status in event check
Thread-Index: AQHU5f0glAeb6buLqE2+JexOYz88tw==
Date:   Fri, 29 Mar 2019 07:00:43 +0000
Message-ID: <1553842562-8481-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:203:36::25) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8b5a43e-b9b0-4e84-f580-08d6b4144262
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3945;
x-ms-traffictypediagnostic: DB3PR0402MB3945:
x-microsoft-antispam-prvs: <DB3PR0402MB39454A1F3D29775EB94DC34EF55A0@DB3PR0402MB3945.eurprd04.prod.outlook.com>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(136003)(376002)(39860400002)(189003)(199004)(7736002)(52116002)(81166006)(256004)(8676002)(110136005)(4326008)(386003)(25786009)(99286004)(26005)(53936002)(6506007)(105586002)(2201001)(6512007)(102836004)(305945005)(106356001)(36756003)(316002)(86362001)(486006)(81156014)(50226002)(66066001)(97736004)(6436002)(186003)(71190400001)(71200400001)(476003)(2616005)(2906002)(6486002)(478600001)(68736007)(5660300002)(6116002)(3846002)(8936002)(4744005)(2501003)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3945;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IzS0s19/3obEbT+FzO7lKUOYdl3sw29LSiHQwCOXf/vFBPT/hqm1757s3zBYg90ZqkDMUfnovG/0vbUiSLn3Q91fKW7eltPDkNJU0npJqv4IW2tnjEhhtG5pqIvNqQnDJOhik+XuaKslj08sUGO67B2UoDokSz2+VTY1wMReA9wcfiUbHdRLJRhpoerRnJHHCIPZR/zx9fwiivEAHwRONtEs9i8R2SxEy3bhQ5GRdmh8kmTg8P67YRM5osUonlqDvhL9egq3MXxBvWiHSOrG9cxurIWhQ3HeL6LiEuJVyv0u2N+PxVAqffS68JDm5iqBUNzYvLit2/iYC653qsntyqcOSJgJqEgBNkTa+r2ho+1UuS0OBPjC52yHhRpAs4ZxP7T72Hor6J+YW6sFbqq6+sZJEcZEAyvphg2+RkPmeds=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b5a43e-b9b0-4e84-f580-08d6b4144262
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 07:00:43.1875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3945
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to enable release interrupt and disable depress
interrupt in event check, as a timer is setup for checking these
events rather than interrupts.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/input/keyboard/imx_keypad.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/i=
mx_keypad.c
index 539cb67..7e32c36 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -276,11 +276,6 @@ static void imx_keypad_check_for_events(struct timer_l=
ist *t)
 		reg_val =3D readw(keypad->mmio_base + KPSR);
 		reg_val |=3D KBD_STAT_KPKR | KBD_STAT_KRSS;
 		writew(reg_val, keypad->mmio_base + KPSR);
-
-		reg_val =3D readw(keypad->mmio_base + KPSR);
-		reg_val |=3D KBD_STAT_KRIE;
-		reg_val &=3D ~KBD_STAT_KDIE;
-		writew(reg_val, keypad->mmio_base + KPSR);
 	}
 }
=20
--=20
2.7.4

