Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243A4C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB8F20850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="mKWaHbhy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388564AbfCAO6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:58:04 -0500
Received: from mail-eopbgr40129.outbound.protection.outlook.com ([40.107.4.129]:7393
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728231AbfCAO6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:58:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7vofbeYRVs5vQJ136UJYoHaKnsjhJIdevN6DdoJNEc=;
 b=mKWaHbhywxU/onU+XbkDXoYXSEQcIdnygGYEd93pCWRCI21Qgfd/HztDjCMD+j0C101hBcvGb2Y0CVTMFKANiLGapaaHmU3bVxZrmBp9g74YMaHNL9AUhtx/VpVN7p9SmR3D1Y7ZzEAl0RqT9Ia+RBXF+ik8pN178XuJ1aPWVuY=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB1885.EURPRD10.PROD.OUTLOOK.COM (52.134.26.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Fri, 1 Mar 2019 14:57:59 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d49:d85b:58bf:cd5b]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d49:d85b:58bf:cd5b%6]) with mapi id 15.20.1643.022; Fri, 1 Mar 2019
 14:57:59 +0000
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Leo Li <leoyang.li@nxp.com>
CC:     Scott Wood <oss@buserror.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
Subject: [PATCH 5/4] soc/fsl/qe: qe.c: fold qe_get_num_of_snums into
 qe_snums_init
Thread-Topic: [PATCH 5/4] soc/fsl/qe: qe.c: fold qe_get_num_of_snums into
 qe_snums_init
Thread-Index: AQHU0D8pHnLoyNcm7E6CZSWEV2hy1g==
Date:   Fri, 1 Mar 2019 14:57:59 +0000
Message-ID: <20190301145744.623-1-rasmus.villemoes@prevas.dk>
References: <de425a29-58c6-b173-8c13-0d30ecfa96c0@prevas.dk>
In-Reply-To: <de425a29-58c6-b173-8c13-0d30ecfa96c0@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0101CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::30) To VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e3::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [81.216.59.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db37fe01-6dbe-4aa6-c5a6-08d69e564bad
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB1885;
x-ms-traffictypediagnostic: VI1PR10MB1885:
x-microsoft-antispam-prvs: <VI1PR10MB1885DA957B47BA82556709BE8A760@VI1PR10MB1885.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(366004)(396003)(39850400004)(189003)(199004)(446003)(110136005)(72206003)(106356001)(105586002)(54906003)(316002)(256004)(6486002)(2616005)(476003)(486006)(102836004)(11346002)(6506007)(386003)(44832011)(74482002)(6436002)(68736007)(8976002)(26005)(8936002)(6512007)(71190400001)(71200400001)(52116002)(107886003)(42882007)(478600001)(6116002)(7736002)(99286004)(2906002)(5660300002)(50226002)(81156014)(81166006)(305945005)(186003)(3846002)(1076003)(14454004)(8676002)(4326008)(25786009)(36756003)(66066001)(97736004)(76176011)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB1885;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR10MB1885;23:/mTPTqIJ3r1RbbkUoeqwfmVCr66Seb9wN6I5jH+?=
 =?iso-8859-1?Q?FCuYHOg5E5yfveqjrXLJ9Au3+v5TLsck3uSFXNj6WPbIYZWv0Oy8UqpDbp?=
 =?iso-8859-1?Q?uEDsdXiCiHFW7DVN2qCvOroBoCKeZHhrHnmy3hLz2kkBG8gDPqMWQfLSl0?=
 =?iso-8859-1?Q?rG2QzNg5JjIsYNLqajQksvJAWJnsXK6A+atKXpQ/ji0veIU6woQJfIw+MX?=
 =?iso-8859-1?Q?WiOslJd+wETHA/Ds1ar6iCaZZk8WY8GUvdE+2PNVOCgXTfze5qqIRriz5Z?=
 =?iso-8859-1?Q?XtTFCJ8gWHgE0Jx4oauGSLFx70yuJCah8jclGuud2FRpv3Xd0070UEH5vT?=
 =?iso-8859-1?Q?IOr9reeRhgnslkFudP0Shw5dkbVhgM5X/kbGGtmyL5Zp+4nWa2IRqkK+5z?=
 =?iso-8859-1?Q?MjX+YTo4zCqAu4XxGcD6otS/d3+V/qXUWixNI/wQL7YqXtAj0pU8zbjugJ?=
 =?iso-8859-1?Q?XZFDXdreDpLs0NSRXzKo3nPXjujvL3Dxe1XXtb1yNVE8s8in+gF8PPeDZz?=
 =?iso-8859-1?Q?inX116cowc2Vh2Lyh6fwZffJ5BUT5pKQ0ERtpNGK31a725yxaujaMK4LH7?=
 =?iso-8859-1?Q?AxDkGqkg/xEZys0U42h4FxNedwMn+p5Gc4xN3dx2fcRc5uBA+y1wKABmar?=
 =?iso-8859-1?Q?OMmwBPHvjp3TfRAaB/QfIg4rMM6dOWPntHhVjoHNnMfEnXfWUnHpsAA1vv?=
 =?iso-8859-1?Q?AUY7/dc0Uv8rWrCRXBq5e/MKTaz8PGrOQ8ADUmdl6pChQbt7S69foplgT4?=
 =?iso-8859-1?Q?Ccn8862bfsyxBTBo348JCK5mf730Y1+e3nzQS1PSmAUZ8qaSCcObDr+j5b?=
 =?iso-8859-1?Q?+pE5U23wyY5re7wd1B+XViubNoR8LQaA9AzQMD23dNwq8g0xUFq7ZorKbR?=
 =?iso-8859-1?Q?evSE1CK4TgOAdz0Gn3AGWdhgjyfSoUT2cIP1VBg2hIEoVPIq6LDx9+uLE+?=
 =?iso-8859-1?Q?iY3q3hUT1UB1y/kLnNr2zKpfok+WMKlb44siQ8ERNu1T9UsmfeT1eOe3RR?=
 =?iso-8859-1?Q?nOWLJ8uKqJrAoGo48yZEJj2er102a6SRyCoD36VXbCpPi52Fvl2Ao30Sie?=
 =?iso-8859-1?Q?E37MtLS4wVZdOYK2JyAX6uhraPQyZL8eGbCNDhKigPbtxwmZTaeT4UcaZQ?=
 =?iso-8859-1?Q?9+YRYogJ8KHs+vvjak4mYCYbJNB1nyao4rrES6Anuettp0N1Q37EFU8sDV?=
 =?iso-8859-1?Q?2FcPjSsye4XfZQwBUDso7OqrJzdVgcIvwRcswmeMmCUpswCjaUiE3kSuni?=
 =?iso-8859-1?Q?E9zk9sXKgycIncFv/8tvxwJaEyqQD9Vu0F0SqZxkLh2jN+zHEpgAaaVT2Y?=
 =?iso-8859-1?Q?4eNd/qee2E7lC8gYTf3wpHKN6bmSV03U/1tW+AQcMXPDVJd3KzNIhUKSzQ?=
 =?iso-8859-1?Q?pFWOxMu0=3D?=
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Qq4JW1eihwM5wrWfq1I3SGr2hmgEe+o9+8xlmoVdWQ31jb1vRdWnJVLQNIrl/OR9ZsYrnLHxSyEYIdSQEfhSdLI+l/mMuABHI3LvngDrVIwQD/7mBk1MJUkwBqZOoUQo7LiQ6FoKBdVbQ2Jk94e2iT3X7kzSWRzUEKxY4hLdAtm/Xn7JOH848b915MeKGCzelGZl+XATtaE05ymKP5k6zmpbtPaYLkISNi6CiOxWSf9V+wVBuoPZmBC2klZOhsfUq+e3Lq6ZU570kGzld5DNoqUAQP8JHzpFzgr0k62FuVsSpDxSyihaGfkD95E0s/UkEodllhFdBwWEJtIgeoKUni2JUHaF4XA7VMzzH8ekXNAKcAs1ZMiNF3ty6gJ80XSPYqURWpjQoPqKDQhdIJ+NXikvb7n4i9cMZJgEvvq9i44=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: db37fe01-6dbe-4aa6-c5a6-08d69e564bad
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 14:57:58.8906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1885
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment "No QE ever has fewer than 28 SNUMs" is false; e.g. the
MPC8309 has 14. The code path returning -EINVAL is also a recipe for
instant disaster, since the caller (qe_snums_init) uncritically
assigns the return value to the unsigned qe_num_of_snum, and would
thus proceed to attempt to copy 4GB from snum_init_46[] to the snum[]
array.

So fold the handling of the legacy fsl,qe-num-snums into
qe_snums_init, and make sure we do not end up using the snum_init_46
array in cases other than the two where we know it makes sense.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---

Qiang: Something like this. I prefer not to fold it into patch 4/4
since it really fixes unrelated issues (the wrong comment and the
bogus handling of unexpected return values from qe_get_num_of_snums),
but I can do so if you wish.


 drivers/net/ethernet/freescale/ucc_geth.c |  2 +-
 drivers/soc/fsl/qe/qe.c                   | 54 +++++++----------------
 include/soc/fsl/qe/qe.h                   |  2 +-
 3 files changed, 19 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethern=
et/freescale/ucc_geth.c
index 22a817da861e..3b2e28614e7b 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -3842,7 +3842,7 @@ static int ucc_geth_probe(struct platform_device* ofd=
ev)
 		}
=20
 	if (max_speed =3D=3D SPEED_1000) {
-		unsigned int snums =3D qe_get_num_of_snums();
+		unsigned int snums =3D qe_num_of_snum;
=20
 		/* configure muram FIFOs for gigabit operation */
 		ug_info->uf_info.urfs =3D UCC_GETH_URFS_GIGA_INIT;
diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 8b915129077a..f8ddbb5b0eb5 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -52,7 +52,8 @@ EXPORT_SYMBOL(qe_immr);
=20
 static u8 snums[QE_NUM_OF_SNUM];	/* Dynamically allocated SNUMs */
 static DECLARE_BITMAP(snum_state, QE_NUM_OF_SNUM);
-static unsigned int qe_num_of_snum;
+unsigned int qe_num_of_snum;
+EXPORT_SYMBOL(qe_num_of_snum);
=20
 static phys_addr_t qebase =3D -1;
=20
@@ -308,26 +309,34 @@ static void qe_snums_init(void)
 	int i;
=20
 	bitmap_zero(snum_state, QE_NUM_OF_SNUM);
+	qe_num_of_snum =3D 28; /* The default number of snum for threads is 28 */
 	qe =3D qe_get_device_node();
 	if (qe) {
 		i =3D of_property_read_variable_u8_array(qe, "fsl,qe-snums",
 						       snums, 1, QE_NUM_OF_SNUM);
-		of_node_put(qe);
 		if (i > 0) {
+			of_node_put(qe);
 			qe_num_of_snum =3D i;
 			return;
 		}
+		/*
+		 * Fall back to legacy binding of using the value of
+		 * fsl,qe-num-snums to choose one of the static arrays
+		 * above.
+		 */
+		of_property_read_u32(qe, "fsl,qe-num-snums", &qe_num_of_snum);
+		of_node_put(qe);
 	}
=20
-	qe_num_of_snum =3D qe_get_num_of_snums();
-
 	if (qe_num_of_snum =3D=3D 76)
 		snum_init =3D snum_init_76;
-	else
+	else if (qe_num_of_snum =3D=3D 28 || qe_num_of_snum =3D=3D 46)
 		snum_init =3D snum_init_46;
-
-	for (i =3D 0; i < qe_num_of_snum; i++)
-		snums[i] =3D snum_init[i];
+	else {
+		pr_err("QE: unsupported value of fsl,qe-num-snums: %u\n", qe_num_of_snum=
);
+		return;
+	}
+	memcpy(snums, snum_init, qe_num_of_snum);
 }
=20
 int qe_get_snum(void)
@@ -649,35 +658,6 @@ unsigned int qe_get_num_of_risc(void)
 }
 EXPORT_SYMBOL(qe_get_num_of_risc);
=20
-unsigned int qe_get_num_of_snums(void)
-{
-	struct device_node *qe;
-	int size;
-	unsigned int num_of_snums;
-	const u32 *prop;
-
-	num_of_snums =3D 28; /* The default number of snum for threads is 28 */
-	qe =3D qe_get_device_node();
-	if (!qe)
-		return num_of_snums;
-
-	prop =3D of_get_property(qe, "fsl,qe-num-snums", &size);
-	if (prop && size =3D=3D sizeof(*prop)) {
-		num_of_snums =3D *prop;
-		if ((num_of_snums < 28) || (num_of_snums > QE_NUM_OF_SNUM)) {
-			/* No QE ever has fewer than 28 SNUMs */
-			pr_err("QE: number of snum is invalid\n");
-			of_node_put(qe);
-			return -EINVAL;
-		}
-	}
-
-	of_node_put(qe);
-
-	return num_of_snums;
-}
-EXPORT_SYMBOL(qe_get_num_of_snums);
-
 static int __init qe_init(void)
 {
 	struct device_node *np;
diff --git a/include/soc/fsl/qe/qe.h b/include/soc/fsl/qe/qe.h
index b3d1aff5e8ad..af5739850bf4 100644
--- a/include/soc/fsl/qe/qe.h
+++ b/include/soc/fsl/qe/qe.h
@@ -212,7 +212,7 @@ int qe_setbrg(enum qe_clock brg, unsigned int rate, uns=
igned int multiplier);
 int qe_get_snum(void);
 void qe_put_snum(u8 snum);
 unsigned int qe_get_num_of_risc(void);
-unsigned int qe_get_num_of_snums(void);
+extern unsigned int qe_num_of_snum;
=20
 static inline int qe_alive_during_sleep(void)
 {
--=20
2.20.1

