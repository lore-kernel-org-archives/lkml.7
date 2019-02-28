Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEAEC10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42DF12171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="Dn+UFXxO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732444AbfB1KbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:31:08 -0500
Received: from mail-eopbgr80119.outbound.protection.outlook.com ([40.107.8.119]:56544
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727666AbfB1KbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 05:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6z81K0W96j894STLgudBmvoVYJfCsaxejDMwLE4FwQ=;
 b=Dn+UFXxOliSd+BXsMHsN8DAx7Us7GCi2tt38+Aj/S4bJtQHPWeF5Wh7c7Aq3RSRz4YX9/vBN1s5u2sMoEzwemX48wbKvOgxpy+U2kqpDUsgJanHJkQMwNHkOnTrju4AuVc6kVihN2kU1DUfHAbkPAxhy6jIs7BCVAJT4N+PGtfU=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB0509.EURPRD10.PROD.OUTLOOK.COM (10.167.201.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Thu, 28 Feb 2019 10:30:42 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d49:d85b:58bf:cd5b]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d49:d85b:58bf:cd5b%6]) with mapi id 15.20.1643.022; Thu, 28 Feb 2019
 10:30:42 +0000
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Leo Li <leoyang.li@nxp.com>
CC:     Scott Wood <oss@buserror.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Timur Tabi <timur@freescale.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
Subject: [PATCH 3/4] soc/fsl/qe: qe.c: introduce qe_get_device_node helper
Thread-Topic: [PATCH 3/4] soc/fsl/qe: qe.c: introduce qe_get_device_node
 helper
Thread-Index: AQHUz1Co2oHyD1DDBUuzX0GX5in8aw==
Date:   Thu, 28 Feb 2019 10:30:42 +0000
Message-ID: <20190228103026.9566-4-rasmus.villemoes@prevas.dk>
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
x-ms-office365-filtering-correlation-id: 48be3bbf-95a1-475c-c52d-08d69d67ca54
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB0509;
x-ms-traffictypediagnostic: VI1PR10MB0509:
x-microsoft-antispam-prvs: <VI1PR10MB050901B21BDD5AC31972E6FC8A750@VI1PR10MB0509.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39850400004)(376002)(366004)(346002)(396003)(189003)(199004)(476003)(446003)(11346002)(2616005)(8936002)(44832011)(8976002)(106356001)(42882007)(486006)(68736007)(186003)(50226002)(107886003)(105586002)(54906003)(74482002)(110136005)(316002)(5660300002)(97736004)(1076003)(72206003)(2906002)(52116002)(71190400001)(6486002)(305945005)(478600001)(256004)(71200400001)(53936002)(99286004)(6436002)(66066001)(6512007)(6116002)(81156014)(81166006)(102836004)(4326008)(25786009)(6506007)(386003)(26005)(76176011)(7736002)(36756003)(8676002)(14454004)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB0509;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR10MB0509;23:AVJKJ1jIfBMN8nqRtuLBFKpypqkQ2bxXs4QI8V2?=
 =?iso-8859-1?Q?bTBccqaRxZnhMcauAbzH3dIqwt/QK1ExKKTIYRhRJ6l4d59DivtnaExZbu?=
 =?iso-8859-1?Q?Qg4eo4YWUL5VkEbt83+uReSaaiGA7aXPAn8hGY8ah81JD5XECzFFKI+Wh3?=
 =?iso-8859-1?Q?9uvnYuITLCDrP9e4VQ4kEOWq9j0CDIkUqL/LIif0TXY4cZUJ8s4kf9ld4k?=
 =?iso-8859-1?Q?cCBCmUS873x8IvWyad3COkNR4vIGna2jjhQdk3AFRO42ZTwNC+EME7GH6N?=
 =?iso-8859-1?Q?28o2ZHm9HjMULAck17GSfIsQe6vF3FhONPW3eZd3feMrXFhDOh/v7wlMnz?=
 =?iso-8859-1?Q?j05r4IDVQwBNTPK6pbQl+pid/jAcBvHadVS7idLL75TkQeUgU4t0UAGnNG?=
 =?iso-8859-1?Q?aY7VJ8M2Vya+t0xq6uQVnX5HNwDtByf6yga6WP2IGq19N8GsK2oqo6ZRpK?=
 =?iso-8859-1?Q?0+VY0Lymcrgcy29iFbFbcG+43N1HK968dDXKx0Q7aN+iI3Z3Q991RHfM8i?=
 =?iso-8859-1?Q?g9xhZU/HGBNrYuH/83Zl7lZQhjZbIeBCxmkmiZK/5Ci/v5ijPXsDId2wVA?=
 =?iso-8859-1?Q?NQ7FqZ0XZiVFZ+vrvwh5HEiI5zbCBtVM2rtZAmqnJlqRNMPq9Caj9ILdVd?=
 =?iso-8859-1?Q?hzfmegnIj8Xo8HZe/3VVXA2rLv9RbW6jzjhlaVP2SQPlhSeQh6XWyD1DF+?=
 =?iso-8859-1?Q?WBH8MSFdF2teSgb/Ai+F5e7IUbtHkCcUojC+1/YwU2lATDjJN+9XdMmPm5?=
 =?iso-8859-1?Q?a70X/hxkxRFW/7jw3HtKNmvXo0Q598eYFhPW3/aN3JxYO/bxYaUEKOonOC?=
 =?iso-8859-1?Q?EzAJMwwu7Ag+QuuoZgAU/9kiJxAu0PUUtiv16R6zF0GAcjkMEGcU/7DB/n?=
 =?iso-8859-1?Q?guRinrWzwll9/pLv0lkr+mEEA++74NTr8oRmvGo4mIw+PDOTLNETLJrd2S?=
 =?iso-8859-1?Q?Gw7w+OfuKCNtRN9rzvy1ebEyGXk1/4BDunck/swD3hfPhgKrOZKjO6xJ90?=
 =?iso-8859-1?Q?2gSclQyTzL7h3+Usr3Qo+LWzX+a21ExQHLn0hIWo5FhQxKo7XjIjOWPIMh?=
 =?iso-8859-1?Q?Nke3IOlZZYftmKI2Gf9XYMghy/B+/zFGiWEGaC9WqMIJ63FqRwdBDCs57g?=
 =?iso-8859-1?Q?tEuHwuaGu+kNqCL5mYkL+RrK70rJG3H49CXCXGjupgM6a1vHtvA5VXIrEg?=
 =?iso-8859-1?Q?LFXE6iiT8v/pUoLDfP5BVU5WIGtZ7DQqitytXYtkfZzTkm++Qmlt5M2IF7?=
 =?iso-8859-1?Q?akiNKhqrtuNr6zbGhWUTmw9Y4bKwI10hwe0sxxnOAQ5Vd/e3p2cuzBLcPV?=
 =?iso-8859-1?Q?IGd8BySa/vgoteWN8OMC4E92AK3KsDA8chIdY0o9RnUYGoB/sOeXAwJlsU?=
 =?iso-8859-1?Q?yysZbonQ=3D?=
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: olPirPRai45qVcbXyD2RlrcLKdWOaDkH2DJiLlVU1F5WZ8BYdn1mlM5R52+pffxQ4tpabDSFZMPGNttMo5qRWyYvsIAbzl3fS4/KuKvbNC+v7SxuTq8kXy8HerhAso48OCeB0SiFFq+l+Ati2TjET2kuwWD77twRQEj65cN8ShGppHLPdFiPBc5deXBkuiAmaScjz4LBFhpt6f6mGt7sxkmf6rhgK+t0K4uCiM3jICXkx+LmNXqW4xITFvG2Rvyjtb2JACy52WlAQw9yDKGleK8xgn1AIYsnLGVKt6gcWqxympR9FWg6f2GJmzWuiNm19jilCwJasspEQyVZ1B5nabmUcWIrso25tFc5YB/3q1VLYSp8K2+XdUlEoAmgLFBVLWjq/vaQNwVY09po9PSwCdMCmw0CDUwc3qRZk/iLlNQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 48be3bbf-95a1-475c-c52d-08d69d67ca54
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 10:30:41.5815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB0509
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'try of_find_compatible_node(NULL, NULL, "fsl,qe"), fall back to
of_find_node_by_type(NULL, "qe")' pattern is repeated five
times. Factor it into a common helper.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/soc/fsl/qe/qe.c | 71 +++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 42 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 9b9737a583ef..71beeb72eee4 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -56,6 +56,20 @@ static unsigned int qe_num_of_snum;
=20
 static phys_addr_t qebase =3D -1;
=20
+static struct device_node *qe_get_device_node(void)
+{
+	struct device_node *qe;
+
+	/*
+	 * Newer device trees have an "fsl,qe" compatible property for the QE
+	 * node, but we still need to support older device trees.
+	 */
+	qe =3D of_find_compatible_node(NULL, NULL, "fsl,qe");
+	if (qe)
+		return qe;
+	return of_find_node_by_type(NULL, "qe");
+}
+
 static phys_addr_t get_qe_base(void)
 {
 	struct device_node *qe;
@@ -65,12 +79,9 @@ static phys_addr_t get_qe_base(void)
 	if (qebase !=3D -1)
 		return qebase;
=20
-	qe =3D of_find_compatible_node(NULL, NULL, "fsl,qe");
-	if (!qe) {
-		qe =3D of_find_node_by_type(NULL, "qe");
-		if (!qe)
-			return qebase;
-	}
+	qe =3D qe_get_device_node();
+	if (!qe)
+		return qebase;
=20
 	ret =3D of_address_to_resource(qe, 0, &res);
 	if (!ret)
@@ -164,12 +175,9 @@ unsigned int qe_get_brg_clk(void)
 	if (brg_clk)
 		return brg_clk;
=20
-	qe =3D of_find_compatible_node(NULL, NULL, "fsl,qe");
-	if (!qe) {
-		qe =3D of_find_node_by_type(NULL, "qe");
-		if (!qe)
-			return brg_clk;
-	}
+	qe =3D qe_get_device_node();
+	if (!qe)
+		return brg_clk;
=20
 	prop =3D of_get_property(qe, "brg-frequency", &size);
 	if (prop && size =3D=3D sizeof(*prop))
@@ -563,16 +571,9 @@ struct qe_firmware_info *qe_get_firmware_info(void)
=20
 	initialized =3D 1;
=20
-	/*
-	 * Newer device trees have an "fsl,qe" compatible property for the QE
-	 * node, but we still need to support older device trees.
-	*/
-	qe =3D of_find_compatible_node(NULL, NULL, "fsl,qe");
-	if (!qe) {
-		qe =3D of_find_node_by_type(NULL, "qe");
-		if (!qe)
-			return NULL;
-	}
+	qe =3D qe_get_device_node();
+	if (!qe)
+		return NULL;
=20
 	/* Find the 'firmware' child node */
 	for_each_child_of_node(qe, fw) {
@@ -622,16 +623,9 @@ unsigned int qe_get_num_of_risc(void)
 	unsigned int num_of_risc =3D 0;
 	const u32 *prop;
=20
-	qe =3D of_find_compatible_node(NULL, NULL, "fsl,qe");
-	if (!qe) {
-		/* Older devices trees did not have an "fsl,qe"
-		 * compatible property, so we need to look for
-		 * the QE node by name.
-		 */
-		qe =3D of_find_node_by_type(NULL, "qe");
-		if (!qe)
-			return num_of_risc;
-	}
+	qe =3D qe_get_device_node();
+	if (!qe)
+		return num_of_risc;
=20
 	prop =3D of_get_property(qe, "fsl,qe-num-riscs", &size);
 	if (prop && size =3D=3D sizeof(*prop))
@@ -651,16 +645,9 @@ unsigned int qe_get_num_of_snums(void)
 	const u32 *prop;
=20
 	num_of_snums =3D 28; /* The default number of snum for threads is 28 */
-	qe =3D of_find_compatible_node(NULL, NULL, "fsl,qe");
-	if (!qe) {
-		/* Older devices trees did not have an "fsl,qe"
-		 * compatible property, so we need to look for
-		 * the QE node by name.
-		 */
-		qe =3D of_find_node_by_type(NULL, "qe");
-		if (!qe)
-			return num_of_snums;
-	}
+	qe =3D qe_get_device_node();
+	if (!qe)
+		return num_of_snums;
=20
 	prop =3D of_get_property(qe, "fsl,qe-num-snums", &size);
 	if (prop && size =3D=3D sizeof(*prop)) {
--=20
2.20.1

