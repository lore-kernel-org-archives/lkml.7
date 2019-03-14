Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD310C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FDDD21019
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="dQhl7k7q";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="qK6CUZVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfCNKXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 06:23:17 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:47510 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726697AbfCNKXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 06:23:17 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2EAHCPb027705;
        Thu, 14 Mar 2019 03:21:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=proofpoint;
 bh=avUUj9tH84q9bi4m71L/oQNGJZkQqh+QXeuEMHIDZms=;
 b=dQhl7k7qSkiINeg3biqtEQ8B6Lpem/su6ZV1MSe2aJzxVIBsCigXANdZ00BifBoHEXF8
 O0qlJXZ0fF/Id6qyG+YB/wLKzFTVjocQpXsf0ZYt1L5VtuwWpRP5vkOtWmUqYJse6uJJ
 PzCtYnfageJN+IPOIDY3CTi4xQi3XNmskb8rp+a85REYqeXxmfOFOq5iHJTEpnsToYE/
 J+NW0JLu+7g9POUK8CIAeLXgklwaPzCCgGwPH5G6kt3QNfOA2QowqOirsaJxdmWknG7n
 73GUEu89oaHaWzCXztRIZwoIGXZHqvNWHR6xKTorb6Ox9FBJyF59mpFTpigdhJ79/DxO vg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pthombar@cadence.com
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2058.outbound.protection.outlook.com [104.47.38.58])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2r6sq573yj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Mar 2019 03:21:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avUUj9tH84q9bi4m71L/oQNGJZkQqh+QXeuEMHIDZms=;
 b=qK6CUZVXsEfgQN9+cTOM4F+kogNtUv3Lmj9CTaA2983Wst7C+oC82QcsKjsApxG/Yxo8JtLp0QOEaju+3FaXl/aUgl+gE0BDZqDXNbNNz+lfiyL7VD9Di8f7IkwuDGXyhoRW9ID4wKMjU0bZaE7+6QOghja+Q3JR+yXYn1tOyhQ=
Received: from SN2PR07MB2480.namprd07.prod.outlook.com (10.167.14.144) by
 SN2PR07MB2559.namprd07.prod.outlook.com (10.167.15.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Thu, 14 Mar 2019 10:21:07 +0000
Received: from SN2PR07MB2480.namprd07.prod.outlook.com
 ([fe80::9c79:9acd:5997:4af1]) by SN2PR07MB2480.namprd07.prod.outlook.com
 ([fe80::9c79:9acd:5997:4af1%2]) with mapi id 15.20.1709.011; Thu, 14 Mar 2019
 10:21:07 +0000
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Piotr Sroka <piotrs@cadence.com>, Jan Kotas <jank@cadence.com>
Subject: RE: [PATCH 2/3 v2] net: ethernet: add c45 PHY support in MDIO
 read/write functions.
Thread-Topic: [PATCH 2/3 v2] net: ethernet: add c45 PHY support in MDIO
 read/write functions.
Thread-Index: AdTaT6BJ5TykYRonR+ml5O2Vgug0ZQ==
Date:   Thu, 14 Mar 2019 10:21:07 +0000
Message-ID: <SN2PR07MB248087F7B4DFE317FA7E5895C14B0@SN2PR07MB2480.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1kZjFkOWU3Yi00NjQyLTExZTktODRlOS0xMDY1MzBlNmVmM2VcYW1lLXRlc3RcZGYxZDllN2QtNDY0Mi0xMWU5LTg0ZTktMTA2NTMwZTZlZjNlYm9keS50eHQiIHN6PSI0NDU1IiB0PSIxMzE5NzAzMjQ2NDY4MTgwMzYiIGg9Ik5Cd3lqYm9VbElqeFJJb1RJajJ1ZFBTVWJOQT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
x-originating-ip: [14.143.9.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5ba0a46-f94f-4b43-115e-08d6a866c5b1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:SN2PR07MB2559;
x-ms-traffictypediagnostic: SN2PR07MB2559:
x-microsoft-antispam-prvs: <SN2PR07MB2559A38BC766735A6DABFD9BC14B0@SN2PR07MB2559.namprd07.prod.outlook.com>
x-forefront-prvs: 09760A0505
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(396003)(376002)(346002)(36092001)(189003)(199004)(8936002)(74316002)(55236004)(55016002)(256004)(6506007)(86362001)(476003)(486006)(66066001)(102836004)(97736004)(106356001)(26005)(105586002)(7696005)(78486014)(71200400001)(71190400001)(4326008)(186003)(107886003)(6116002)(3846002)(54906003)(6246003)(99286004)(6916009)(2906002)(229853002)(53936002)(68736007)(14454004)(52536014)(5660300002)(6436002)(25786009)(305945005)(8676002)(478600001)(316002)(81156014)(81166006)(7736002)(9686003)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR07MB2559;H:SN2PR07MB2480.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: abG42CkKa4+r8sDtJ/GfHggg4w/yFDmcF8k42Ceswh6diQhC8aYPiycp52azjv0W7ka+8rG7iig3MtLclvavrQrbEWRw7Lj9kaNtrxaXZygLQBJDqn59D9T46QOP7KnyRJbFPvWq7KWC54btCAJsN4Dl6gqkRKbKABghEuPzoopx50CFRijA1j23pIfVk7BMQDhtQP6SHpcJ4d1Q4T5n9EQi+me/0pNhsKRdL7Qqd24F7FznrR59qeAVyCugiiBjJiuVS99KtwfR22eAl5M0/nkJ3MtOCw/3cMVmqxXHphRoTX8cpJTJbbptPG9EmOzpTeNUViJ9vTjiSl6JSmxnh8p7J+JRLk6Hn/jg3ERR8iDgOsCiM3r/La8nUo3YWnB9NfjgA+W8a/K8uJJw4df8ta3WrcJL5dKbSFneOFcZX04=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ba0a46-f94f-4b43-115e-08d6a866c5b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2019 10:21:07.4708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR07MB2559
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-14_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=920 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903140072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is version 2 of patch to modify MDIO read/write functions to support
communication with C45 PHY in Cadence ethernet controller driver.

Changes in v2:
	1. Use timeout when waiting for opeartion to complete.
	2. Removed unused operation macro MACB_MAN_C45_POST_READ_INCR

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 drivers/net/ethernet/cadence/macb.h      |   14 +++++--
 drivers/net/ethernet/cadence/macb_main.c |   61 ++++++++++++++++++++++++--=
---
 2 files changed, 60 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cad=
ence/macb.h
index acc66a7..d25fa03 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -629,10 +629,16 @@
 #define GEM_CLK_DIV96				5
=20
 /* Constants for MAN register */
-#define MACB_MAN_SOF				1
-#define MACB_MAN_WRITE				1
-#define MACB_MAN_READ				2
-#define MACB_MAN_CODE				2
+#define MACB_MAN_C22_SOF                        1
+#define MACB_MAN_C22_WRITE                      1
+#define MACB_MAN_C22_READ                       2
+#define MACB_MAN_C22_CODE                       2
+
+#define MACB_MAN_C45_SOF                        0
+#define MACB_MAN_C45_ADDR                       0
+#define MACB_MAN_C45_WRITE                      1
+#define MACB_MAN_C45_READ                       3
+#define MACB_MAN_C45_CODE                       2
=20
 /* Capability mask bits */
 #define MACB_CAPS_ISR_CLEAR_ON_WRITE		0x00000001
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/etherne=
t/cadence/macb_main.c
index ad099fd..17072fd 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -345,11 +345,30 @@ static int macb_mdio_read(struct mii_bus *bus, int mi=
i_id, int regnum)
 	if (status < 0)
 		goto mdio_read_exit;
=20
-	macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_SOF)
-			      | MACB_BF(RW, MACB_MAN_READ)
-			      | MACB_BF(PHYA, mii_id)
-			      | MACB_BF(REGA, regnum)
-			      | MACB_BF(CODE, MACB_MAN_CODE)));
+	if (regnum & MII_ADDR_C45) {
+		macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_C45_SOF)
+			    | MACB_BF(RW, MACB_MAN_C45_ADDR)
+			    | MACB_BF(PHYA, mii_id)
+			    | MACB_BF(REGA, (regnum >> 16) & 0x1F)
+			    | MACB_BF(DATA, regnum & 0xFFFF)
+			    | MACB_BF(CODE, MACB_MAN_C45_CODE)));
+
+		status =3D macb_mdio_wait_for_idle(bp);
+		if (status < 0)
+			goto mdio_read_exit;
+
+		macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_C45_SOF)
+			    | MACB_BF(RW, MACB_MAN_C45_READ)
+			    | MACB_BF(PHYA, mii_id)
+			    | MACB_BF(REGA, (regnum >> 16) & 0x1F)
+			    | MACB_BF(CODE, MACB_MAN_C45_CODE)));
+	} else {
+		macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_C22_SOF)
+				| MACB_BF(RW, MACB_MAN_C22_READ)
+				| MACB_BF(PHYA, mii_id)
+				| MACB_BF(REGA, regnum)
+				| MACB_BF(CODE, MACB_MAN_C22_CODE)));
+	}
=20
 	status =3D macb_mdio_wait_for_idle(bp);
 	if (status < 0)
@@ -378,12 +397,32 @@ static int macb_mdio_write(struct mii_bus *bus, int m=
ii_id, int regnum,
 	if (status < 0)
 		goto mdio_write_exit;
=20
-	macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_SOF)
-			      | MACB_BF(RW, MACB_MAN_WRITE)
-			      | MACB_BF(PHYA, mii_id)
-			      | MACB_BF(REGA, regnum)
-			      | MACB_BF(CODE, MACB_MAN_CODE)
-			      | MACB_BF(DATA, value)));
+	if (regnum & MII_ADDR_C45) {
+		macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_C45_SOF)
+			    | MACB_BF(RW, MACB_MAN_C45_ADDR)
+			    | MACB_BF(PHYA, mii_id)
+			    | MACB_BF(REGA, (regnum >> 16) & 0x1F)
+			    | MACB_BF(DATA, regnum & 0xFFFF)
+			    | MACB_BF(CODE, MACB_MAN_C45_CODE)));
+
+		status =3D macb_mdio_wait_for_idle(bp);
+		if (status < 0)
+			goto mdio_write_exit;
+
+		macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_C45_SOF)
+			    | MACB_BF(RW, MACB_MAN_C45_WRITE)
+			    | MACB_BF(PHYA, mii_id)
+			    | MACB_BF(REGA, (regnum >> 16) & 0x1F)
+			    | MACB_BF(CODE, MACB_MAN_C45_CODE)
+			    | MACB_BF(DATA, value)));
+	} else {
+		macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_C22_SOF)
+				| MACB_BF(RW, MACB_MAN_C22_WRITE)
+				| MACB_BF(PHYA, mii_id)
+				| MACB_BF(REGA, regnum)
+				| MACB_BF(CODE, MACB_MAN_C22_CODE)
+				| MACB_BF(DATA, value)));
+	}
=20
 	status =3D macb_mdio_wait_for_idle(bp);
 	if (status < 0)
--=20
1.7.1
