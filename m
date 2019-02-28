Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55DDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA0D218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="gw8CpdqL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732410AbfB1KbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:31:06 -0500
Received: from mail-eopbgr80119.outbound.protection.outlook.com ([40.107.8.119]:56544
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726918AbfB1KbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 05:31:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qiKfOEoD7LWvT6XVeHYGuetm6Dw1yMRQvisIUR8he/Q=;
 b=gw8CpdqL/fO8y6rdBy9mQ+HUpeCpQGIfEojTxMObaQE2dtQd+BHhAKnlEg2M0jBH+hXL20zXGqiC1OmRobk4thbZxvaW8L2cxp2ktkB6Y+7Ws9GkWZZWILBzP2tdJF8+Nc7R+68gKmE7rOdI/9n7eZiLzcjKoStecahBOoI+V4o=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB0509.EURPRD10.PROD.OUTLOOK.COM (10.167.201.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Thu, 28 Feb 2019 10:30:41 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d49:d85b:58bf:cd5b]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d49:d85b:58bf:cd5b%6]) with mapi id 15.20.1643.022; Thu, 28 Feb 2019
 10:30:41 +0000
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Leo Li <leoyang.li@nxp.com>
CC:     Scott Wood <oss@buserror.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Timur Tabi <timur@freescale.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
Subject: [PATCH 2/4] soc/fsl/qe: qe.c: reduce static memory footprint by 1.7K
Thread-Topic: [PATCH 2/4] soc/fsl/qe: qe.c: reduce static memory footprint by
 1.7K
Thread-Index: AQHUz1CnAOIVCpxVHkiuxkUMgN/E7A==
Date:   Thu, 28 Feb 2019 10:30:41 +0000
Message-ID: <20190228103026.9566-3-rasmus.villemoes@prevas.dk>
References: <338677b2-ef74-2afc-4542-c66f1acdb7e5@prevas.dk>
 <20190228103026.9566-1-rasmus.villemoes@prevas.dk>
In-Reply-To: <20190228103026.9566-1-rasmus.villemoes@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0127.eurprd05.prod.outlook.com
 (2603:10a6:7:28::14) To VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e3::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [81.216.59.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fa6443e-1e30-42f0-3f86-08d69d67c9c3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB0509;
x-ms-traffictypediagnostic: VI1PR10MB0509:
x-microsoft-antispam-prvs: <VI1PR10MB050996E6A602E9BEEFF9C2788A750@VI1PR10MB0509.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39850400004)(376002)(366004)(346002)(396003)(189003)(199004)(476003)(446003)(11346002)(2616005)(8936002)(44832011)(8976002)(106356001)(42882007)(486006)(68736007)(186003)(50226002)(107886003)(105586002)(54906003)(74482002)(110136005)(316002)(5660300002)(97736004)(1076003)(72206003)(2906002)(52116002)(71190400001)(6486002)(305945005)(478600001)(256004)(71200400001)(53936002)(14444005)(99286004)(6436002)(66066001)(6512007)(6116002)(81156014)(81166006)(102836004)(4326008)(25786009)(6506007)(386003)(26005)(76176011)(7736002)(36756003)(8676002)(14454004)(3846002)(2004002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB0509;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR10MB0509;23:c/tvSpQ1+lKObDsKaK296uh1iKVUeRGa26Pp1BQ?=
 =?iso-8859-1?Q?CCGx+kx+XsTRy2ucE+br9y2Sm4ZnzSPbKU9HPQpCrJeaj6zdlJcOkJAaPh?=
 =?iso-8859-1?Q?CZ6bqVQUGBxyJOGyPGPbzzf7AObw3k3XHgwZgTuYxUNpEGYiP2/IV9CYtw?=
 =?iso-8859-1?Q?0VMjdd7TLY7rP17s1rY6xBmEzyjDca81/obs+bB6jIglm9+g0GWKv2g2s7?=
 =?iso-8859-1?Q?LPndQYcSS7ovu2ZC8Y3jScitDb+85Ev4/RcauCjWijwW9cZmcSptHn3t05?=
 =?iso-8859-1?Q?tdVJLOeldRCQrwn2D3jg8I89kmWGEKhhJhdb072z7Yjw7qnR8WrG3ysD+i?=
 =?iso-8859-1?Q?+Y5alx7jCPQEfGjgNhOU+m50Mr7YxXqeN2w0xHN2q1WXxDAoRBH/Nkm1tQ?=
 =?iso-8859-1?Q?2/b6Bc9G3X8xLApU29PkSpS5SfwEhqjM4Bfa7TXjetsYR1jTgd1bIsYxT9?=
 =?iso-8859-1?Q?DDksGz+nG4q1hcT+aiZFY0duLtq4XcIV+zlVADgiTuj2k86+79iBFHLHqJ?=
 =?iso-8859-1?Q?AGa4+NJ4lPhefGlxysIHU+KxW4dM8CbLPoA+jouYNzBUB2tMnnBCA+bHKf?=
 =?iso-8859-1?Q?cb2bV1XhprcXoXTt8irrxC6beemMRIQllrKu8rtw1l7ps59ue4AUsRTIpl?=
 =?iso-8859-1?Q?v3Rk5u3303Aqq9dQObDmZJKsgOEqV7bKLoG136X0MPTd0gRIVdNNlCPvvI?=
 =?iso-8859-1?Q?ApoFJ9fvRtQ3rQLt2g0UzsfJ1VdPjrxbh1Gjqo63KFrLPDVlr8nOnUDvfn?=
 =?iso-8859-1?Q?LK13ohI12f+IahTLyjsrrvIzg8VwBUDtJpOqfsTJCAmNdv9zFn9fmqYzzI?=
 =?iso-8859-1?Q?D2yYu/jkatxk340qPpk1yXZlKBTCktqMGWOH70Qos8B/NYc6CKuVgt7xuM?=
 =?iso-8859-1?Q?JKNqFSeF2U0TV21AplsjC98NAQqFefwv+mi6i62eyHz/ZLQ9hp7k9b5OZ4?=
 =?iso-8859-1?Q?VWiLtxmP2ST5Ajxxp2CiLbbFpYK22ap5RJgcdD/iPZpAvkSEtfUiah2qdx?=
 =?iso-8859-1?Q?EiwPLCVAeMSyHbg/ojI6gd4qIzkHwqhtMzl29ILkRXESDoLnotyDv+WXwH?=
 =?iso-8859-1?Q?hIO/es6Xvabk6dpaZNXbnfNwUfFlV3d/zW4cm+FGZOE/73J75LFFH+QWTW?=
 =?iso-8859-1?Q?ezs+AyA554BFnGtA/4oXYmSkR83RCY/GbNXVgnaPzpfLHa7lYkzZAqLQcf?=
 =?iso-8859-1?Q?g86FcOspuhob+4+QyOgqmym7IyczcKMrrucCk9WM+e1tgpAuahuv6oEnui?=
 =?iso-8859-1?Q?g/t55bDlwbUCFmQEb+LbLs3hg6vRaOqlTVVjKqYS3HXwtDDFyGfGFIYjxJ?=
 =?iso-8859-1?Q?7qo/E0qJRQG/FdVSKNNivt/bpJOTG3jPzQ3vP4ckdEBRCX7ElqG+AYnDzG?=
 =?iso-8859-1?Q?4TSNGlz9/tVsRpDi/u10cSfn7fzAWvNKVL38I8iMeE7OKYDpEYQ=3D=3D?=
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: q/hLy4F0sAld+yopBovsRKuMS9F6X6w2vWe4Q28b2Fo21alVcn88Q6U1iP6IDooJmemxOV2m9bmZoawaZbdWEQZOZrSH7H3S5/PSUCcjLp7c6pKLS7kIY5Tw8dwbUpxBEC5vF5tLYABBJu6gYkifLYQgkCl92onuo/9/NBYkl3UAw3Ntskdn85nON0zkHSBemrNXWWvVKOmImmAiCGVfNabrx0W05xdSTP1vu4noWcYvj6lMvrjV1EWf6+bHuXLynvPlPPw1Fa3YE63aVpCjoZ3yJHsgG+gIlIXgbAW4SBlzy/tBS2Te4GgB7AxAIR4XTJnwddxVR9Tq46TubwsFnuPeW4ZhQ5FXVZmEyw57ePRcPv1IAYborbVItFgfj0uB2FtO1qCiIjEHvV4C7igEG82PQV+ymHjZSn0Uie6UfJI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa6443e-1e30-42f0-3f86-08d69d67c9c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 10:30:40.6278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB0509
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current array of struct qe_snum use 256*4 bytes for just keeping
track of the free/used state of each index, and the struct layout
means there's another 768 bytes of padding. If we just unzip that
structure, the array of snum values just use 256 bytes, while the
free/inuse state can be tracked in a 32 byte bitmap.

So this reduces the .data footprint by 1760 bytes. It also serves as
preparation for introducing another DT binding for specifying the snum
values.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/soc/fsl/qe/qe.c | 37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 4b6aa6b3b685..9b9737a583ef 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -14,6 +14,7 @@
  * Free Software Foundation;  either version 2 of the  License, or (at you=
r
  * option) any later version.
  */
+#include <linux/bitmap.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
@@ -43,25 +44,14 @@ static DEFINE_SPINLOCK(qe_lock);
 DEFINE_SPINLOCK(cmxgcr_lock);
 EXPORT_SYMBOL(cmxgcr_lock);
=20
-/* QE snum state */
-enum qe_snum_state {
-	QE_SNUM_STATE_USED,
-	QE_SNUM_STATE_FREE
-};
-
-/* QE snum */
-struct qe_snum {
-	u8 num;
-	enum qe_snum_state state;
-};
-
 /* We allocate this here because it is used almost exclusively for
  * the communication processor devices.
  */
 struct qe_immap __iomem *qe_immr;
 EXPORT_SYMBOL(qe_immr);
=20
-static struct qe_snum snums[QE_NUM_OF_SNUM];	/* Dynamically allocated SNUM=
s */
+static u8 snums[QE_NUM_OF_SNUM];	/* Dynamically allocated SNUMs */
+static DECLARE_BITMAP(snum_state, QE_NUM_OF_SNUM);
 static unsigned int qe_num_of_snum;
=20
 static phys_addr_t qebase =3D -1;
@@ -308,6 +298,7 @@ static void qe_snums_init(void)
 	};
 	const u8 *snum_init;
=20
+	bitmap_zero(snum_state, QE_NUM_OF_SNUM);
 	qe_num_of_snum =3D qe_get_num_of_snums();
=20
 	if (qe_num_of_snum =3D=3D 76)
@@ -315,10 +306,8 @@ static void qe_snums_init(void)
 	else
 		snum_init =3D snum_init_46;
=20
-	for (i =3D 0; i < qe_num_of_snum; i++) {
-		snums[i].num =3D snum_init[i];
-		snums[i].state =3D QE_SNUM_STATE_FREE;
-	}
+	for (i =3D 0; i < qe_num_of_snum; i++)
+		snums[i] =3D snum_init[i];
 }
=20
 int qe_get_snum(void)
@@ -328,12 +317,10 @@ int qe_get_snum(void)
 	int i;
=20
 	spin_lock_irqsave(&qe_lock, flags);
-	for (i =3D 0; i < qe_num_of_snum; i++) {
-		if (snums[i].state =3D=3D QE_SNUM_STATE_FREE) {
-			snums[i].state =3D QE_SNUM_STATE_USED;
-			snum =3D snums[i].num;
-			break;
-		}
+	i =3D find_first_zero_bit(snum_state, qe_num_of_snum);
+	if (i < qe_num_of_snum) {
+		set_bit(i, snum_state);
+		snum =3D snums[i];
 	}
 	spin_unlock_irqrestore(&qe_lock, flags);
=20
@@ -346,8 +333,8 @@ void qe_put_snum(u8 snum)
 	int i;
=20
 	for (i =3D 0; i < qe_num_of_snum; i++) {
-		if (snums[i].num =3D=3D snum) {
-			snums[i].state =3D QE_SNUM_STATE_FREE;
+		if (snums[i] =3D=3D snum) {
+			clear_bit(i, snum_state);
 			break;
 		}
 	}
--=20
2.20.1

