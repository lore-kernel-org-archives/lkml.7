Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBD6C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D5CC20449
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="KNvJnan6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfCGPAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:00:41 -0500
Received: from mail-eopbgr10092.outbound.protection.outlook.com ([40.107.1.92]:25413
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726161AbfCGPAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:00:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LncPgjgPhnOpPx15qcbtK0vpBjiS4fmDv6F2xae+nA4=;
 b=KNvJnan6nVKVPNAt9eVdsfuKcHNJnrHzHR74wg1MJ8eChZQME99IZPf2EJr3e+CaW+U3qYdbeQ5sI3HrDJYEBqIDbmI6jx3FEK97zBboaYnkPmekHPgr5A/nuRMHfMZj36q3PSXKJyFdBUvNg200LdDFHbiNc24k3YAUL4p3beY=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB0605.EURPRD10.PROD.OUTLOOK.COM (10.167.202.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.16; Thu, 7 Mar 2019 15:00:34 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::51c2:2f6a:3148:4a1f]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::51c2:2f6a:3148:4a1f%3]) with mapi id 15.20.1686.018; Thu, 7 Mar 2019
 15:00:34 +0000
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>
CC:     Thomas Winding <twi@deif.com>, Fabio Estevam <festevam@gmail.com>,
        Per Christensen <pnc@deif.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] can: flexcan: bump FLEXCAN_TIMEOUT_US to 250
Thread-Topic: [PATCH] can: flexcan: bump FLEXCAN_TIMEOUT_US to 250
Thread-Index: AQHU1PaDftXKRmjpAUe9LFJjLfS9rQ==
Date:   Thu, 7 Mar 2019 15:00:33 +0000
Message-ID: <20190307150024.23628-1-rasmus.villemoes@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0802CA0013.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::23) To VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e3::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [81.216.59.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: acb32c2f-12a9-4001-7d0f-08d6a30da616
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB0605;
x-ms-traffictypediagnostic: VI1PR10MB0605:
x-microsoft-antispam-prvs: <VI1PR10MB06051F3FF97CDEECD691BD6B8A4C0@VI1PR10MB0605.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 096943F07A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(39850400004)(346002)(136003)(189003)(199004)(4326008)(25786009)(74482002)(97736004)(36756003)(4744005)(3846002)(6486002)(6436002)(8976002)(26005)(53936002)(71190400001)(110136005)(44832011)(54906003)(6116002)(2906002)(50226002)(71200400001)(186003)(42882007)(476003)(2616005)(1076003)(99286004)(256004)(14444005)(102836004)(6506007)(106356001)(52116002)(486006)(105586002)(6512007)(316002)(66066001)(8936002)(14454004)(305945005)(7736002)(68736007)(478600001)(72206003)(81166006)(8676002)(81156014)(386003)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB0605;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR10MB0605;23:JDfweim+MJBQ8pg3HV10J2awZNVrb+Mc0p8ue6s?=
 =?iso-8859-1?Q?gQOETfTtzUGfdTS7JhLkqbFtUJ6freR6qjgGmX9SDPf9Kp6/pwLi3jeXNv?=
 =?iso-8859-1?Q?orh3g4tdTV52/dj7nLZqWytkZ75h6tT1JkuDeQHlIwEzTyvcxGtAyDBCPx?=
 =?iso-8859-1?Q?n9tke96PgXsFn8LOUvBUSi2/zDJOAtNyufZTgFeC0mU03JHH3gLRQG5PlQ?=
 =?iso-8859-1?Q?Lk3TOZVZh6Ng1vULKKQiq010LY5UyNjeOUsk6Tjtvo3LcEqW7Ov4OPDPTD?=
 =?iso-8859-1?Q?1vKCllPZQ08a9wRp9tJl3jGvF8LTOkBFJ4wlOuhk2BNamq/h76zxdEvoCj?=
 =?iso-8859-1?Q?WxpAWQgw0W+rzbx5/dCjADDzWYt3DpP+QYJyurkLUMILRGbWP77Yx+mHtL?=
 =?iso-8859-1?Q?UzYdTrVrvNkJI3qTN7fHeESTjARK9VE0LJ4IkUlTmiwn+su/TWeP8iqCk8?=
 =?iso-8859-1?Q?WaGNxMWIfRNcD0JfTd9PDHL8AB3+p9Er993ohiCvJsgf7MHt5DdDqX5o8G?=
 =?iso-8859-1?Q?hImnj/wRfvilgl/RV9/KfsWmiNMZdV9P03ZLW/4IIQIq1p9XwEluk2DMXo?=
 =?iso-8859-1?Q?0mkpDhcQy8PjuzE/5GzvAYQrurKGTR1t/++t9VL8J1Lpsvm37DET/01rfr?=
 =?iso-8859-1?Q?RduvtrIoJYhhEmtmL3MvYoqcMHOghKNMtcNhD/SbJ6Op83Ti+hkpnqJEoM?=
 =?iso-8859-1?Q?eIrPOtK93/oIzUADzw9NdFnIudEDitjHeiIXd0OSJXMRKCt0udJPGSgOL8?=
 =?iso-8859-1?Q?PPy4EUxJDK1RSGBE7VrahJw5qTloecSOYciVZ2PjoxZVce61FGoi6XeIeR?=
 =?iso-8859-1?Q?LUFHUEkNKP96/7AO4p3BMOPdAZUbyAfTVFJLI0sgBhrlTQ1LAfB616iWog?=
 =?iso-8859-1?Q?aaM/1NRE5SqA81zeZxGID72C2DmNMjnKhTuubm19cchPUcTDlXs1X3DeKK?=
 =?iso-8859-1?Q?/baZKTaKBvFQmdn4WweFBgv5ms/lfsIa99XH03g1UmT65Le9iKTH0aPw+u?=
 =?iso-8859-1?Q?VvKIUTENdr3L8XYPXHBKfk1Ffbb8LnO54AcjMy3zEEyNXegRRByiCm3Uag?=
 =?iso-8859-1?Q?AHaxRjXe+MFKimBfPKWD44nXfW549z3zoc/9DvoriIaSy+5yQel7S8k9uy?=
 =?iso-8859-1?Q?rLrkW2mhp+QMy8Nge9tRX/CJUJd1L57UznPxVTK75Qcw6n7Nr4X8b9zRgm?=
 =?iso-8859-1?Q?2xTwRJjE9GZ7TdKV0rLVGjTUcTO2VDqnXcDBe8aS2qwpUazZm5I47qMdlT?=
 =?iso-8859-1?Q?/w4Hu0Usqw4v7uH+kZk91YTxZ5IQopI+iRsXCLWFKuMZH2NKmYYYHrDgrJ?=
 =?iso-8859-1?Q?tJTdmUiJlhKjmTrqLOiNAob?=
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gKy4ArwUapXZ0Hk7kjEI9wWSKe6Jw7O7TvEWOVY/3LIttfXCmWvyaYoIBD8i7D9SR0aPmpeb1Cf4HiQAtfdTK241n/b2zEwBGq00mlhsEua44qe/k/3/00agtp1JAu8LERzvddPxclWchqfxTX1FZNGLoq1qsq4ixAjtLslc/yKfiCLJ1+vfT41dxVHOdoNzkjwQNffrLkfan2fP/piPKc0YFFTAgcU7AE0/vUo37WPhzJe1FQteGbi2VcWizWF4MAfYmfP5uBlQek7tbLN7GWsCFbwnnrejywK8umxaUhG1Pe+qgg2B1YR3E9iq2WYKbU01EGbPJK0U7uIpagAxoGLjzub42wITqB7QMe5TT973vd8Gv513ply3lkd2aOU804PvFKgqmm+KGlKrFrjh5wAmk2HbBx95Mdpib+esabU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: acb32c2f-12a9-4001-7d0f-08d6a30da616
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2019 15:00:33.9180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB0605
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to add support for the Flexcan modules on the MPC8309,
I'm hitting ETIMEDOUT in flexcan_chip_disable(). With this, probing
succeeds. Checking the leftover value of timeout with a primitive

  pr_err("%s: timeout=3D=3D%d\n", __func__, timeout);

after the loop in chip_disable() typically shows values around 12-14,
i.e. suggesting that it takes about 110-130 us for the LPM_ACK bit to
appear. So a timeout value of about twice that seems reasonable.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/net/can/flexcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 75ce11395ee8..5f32053f78de 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -165,7 +165,7 @@
 #define FLEXCAN_MB_CNT_LENGTH(x)	(((x) & 0xf) << 16)
 #define FLEXCAN_MB_CNT_TIMESTAMP(x)	((x) & 0xffff)
=20
-#define FLEXCAN_TIMEOUT_US		(50)
+#define FLEXCAN_TIMEOUT_US		(250)
=20
 /* FLEXCAN hardware feature flags
  *
--=20
2.20.1

