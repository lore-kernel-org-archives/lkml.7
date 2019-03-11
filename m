Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA065C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E37C206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YVuQFlyv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbfCKRax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:30:53 -0400
Received: from mail-eopbgr10056.outbound.protection.outlook.com ([40.107.1.56]:28219
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727019AbfCKRaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRbqvGLnOt9s+OFiFGW3tH/pZs4KIk7uRFdtFt7ilCU=;
 b=YVuQFlyvNcKXfgvAmgc9h+c2ogo0yRL6BNOEmu1r3vLpGpAwl1AdZZU+7vQWgQbZN2mN6LWhTowN28OEDegvARjXIldKve2t7DojaklwwRcNqmP6vx2SWKdG+5BARb3PyLJ5l+KEVuwfDoE6hYqMjr0ofUhDo5F2C1zeWvQhSOE=
Received: from DB6PR0402MB2727.eurprd04.prod.outlook.com (10.172.247.10) by
 DB6PR0402MB2791.eurprd04.prod.outlook.com (10.172.245.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.21; Mon, 11 Mar 2019 17:30:48 +0000
Received: from DB6PR0402MB2727.eurprd04.prod.outlook.com
 ([fe80::18a2:3eae:e7c:4d42]) by DB6PR0402MB2727.eurprd04.prod.outlook.com
 ([fe80::18a2:3eae:e7c:4d42%5]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 17:30:48 +0000
From:   Roy Pledge <roy.pledge@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Youri Querry <youri.querry_1@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>
Subject: [PATCH] soc: fsl: dpio: Increase timeout for QBMan Management
 Commands
Thread-Topic: [PATCH] soc: fsl: dpio: Increase timeout for QBMan Management
 Commands
Thread-Index: AQHU2DAqo2ZVXjPOF0S2dsdIaslXnQ==
Date:   Mon, 11 Mar 2019 17:30:48 +0000
Message-ID: <1552325436-8907-1-git-send-email-roy.pledge@nxp.com>
Reply-To: Roy Pledge <roy.pledge@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: DM6PR14CA0065.namprd14.prod.outlook.com
 (2603:10b6:5:18f::42) To DB6PR0402MB2727.eurprd04.prod.outlook.com
 (2603:10a6:4:98::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [72.142.119.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 686624ca-3b68-4117-6253-08d6a6474d04
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0402MB2791;
x-ms-traffictypediagnostic: DB6PR0402MB2791:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB6PR0402MB2791;23:c6ZWi3pbWgAXB+W3070rHO6RZRhY4ZKzRnd3D?=
 =?iso-8859-1?Q?444D48IFozddbOByFoVXxMHV4cxHc3f/72fhYK7oT+RC1PlRW1cWMeBOUW?=
 =?iso-8859-1?Q?6PU+ZJSMHLKDT3EJ1yO+fSV5HIgn5aixcCSnk+zSTQOjXpeMCpcCEI/u79?=
 =?iso-8859-1?Q?Ak7LCIYpUlmiHAsgYxumrofSkbBcrZjqoLIm/NDlgUGArUSBL2n6ws+rup?=
 =?iso-8859-1?Q?UnQPOpicgpOtbOcf2wSCBpRwC9d97EqGI6V0aqNOZHe5LBtTxuu59kkdzx?=
 =?iso-8859-1?Q?vWmy/xW8MEmXWJcyP1nZc0E4i+qKUYyiOsaMyNC44fjo7q0YWwrS4RVpvG?=
 =?iso-8859-1?Q?nbcZOf+4tiwsp72e0T/EUGkbBSVEP7+NKM8BSFf0k7p8UFs2norGsclxpQ?=
 =?iso-8859-1?Q?KKlYKuOiNai0lpY2q0a2nPWdxk5LKuSlzAanTAUeLFCYlbfOYZzeBvtVN9?=
 =?iso-8859-1?Q?CFYuSenDqm65J/btEvg73jK24D/9bGI10ts32KxoqAM6CF4oT0AhUH0lGr?=
 =?iso-8859-1?Q?QdyBuLBw8v1XS5TArcERqeo+r3ARWl5WXcJKuF9nBjxLGic3HcbZ29CiSN?=
 =?iso-8859-1?Q?s+00DQP8valbqcNAzE/qs2cr1CmiURLMqzSjef+6QuwtTJSPENWFt+mG2k?=
 =?iso-8859-1?Q?Cj2IAQj6w1giSitRbkz5WhmBksTY/fcqpqr1wontddiDjvcQWHdJJkuUNn?=
 =?iso-8859-1?Q?0WF+g9INBwBgH65gOAqPehCuRUodedu/bAajdsSUYjcGqIINC0trPnwSz3?=
 =?iso-8859-1?Q?4rOdrxYHXCkw7R9vDsX86u5SGXiFG6WVZZ2v9G3819Q571K94ZZtGfzrUN?=
 =?iso-8859-1?Q?kYhnRtvT6AyYSI/5+jWyhuvFUX26kYlmdT0QWUKPETahDlRAqHZ7zQtiMJ?=
 =?iso-8859-1?Q?PSJETicEJ9JvmkzTljrEWDRbFQkjzlWzv7ZhltCPyGZc6q1i2M+y9uvOTc?=
 =?iso-8859-1?Q?MDS2EQI/gM2w6ZfJ73wEgvPRABNTGXh0CISr13hUdbKxbdJddCH/2uwiuc?=
 =?iso-8859-1?Q?tIP1dc3CD0qbE4egj++aMTRFYgBmJE1Szw3ZKll8/s4/cNJeO4OwJPk8cz?=
 =?iso-8859-1?Q?mMErNDU6PlZUiOI/nR5EF2x1VKO7obfelCOHpWPDsmXm4uxz3VUvojtNZU?=
 =?iso-8859-1?Q?gcKxhveIg0hX4HSFMYC5m7srCjo513hIardCVEI5dzeZikEVuBiBlsp36C?=
 =?iso-8859-1?Q?4c0AGnzZMiUdoc0Oc9OreU0rvyQ4BxRCGC3O8XcOO9eLXBA7SeKjkwYgwr?=
 =?iso-8859-1?Q?1+Dv/o7bpQH3tBkV3HLCAcVCvl0MlG/KJdTElkRFg=3D=3D?=
x-microsoft-antispam-prvs: <DB6PR0402MB27915100B8C856F76FF4EBE186480@DB6PR0402MB2791.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(366004)(39860400002)(189003)(199004)(186003)(106356001)(102836004)(386003)(7736002)(316002)(3846002)(6116002)(71200400001)(105586002)(6506007)(256004)(54906003)(3450700001)(110136005)(8676002)(81166006)(2906002)(81156014)(36756003)(97736004)(5660300002)(99286004)(71190400001)(14454004)(52116002)(305945005)(25786009)(2201001)(66066001)(6436002)(4326008)(53936002)(43066004)(6512007)(86362001)(478600001)(6486002)(2501003)(26005)(68736007)(44832011)(486006)(8936002)(50226002)(476003)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0402MB2791;H:DB6PR0402MB2727.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xeK7K+IT/wHkhu10qUbpU9kUndU8PccPvpSNTBXnRAMO/Sgcbg7zwQQW9xiaBd6nId6GFp1F+kyy9GQiVfz3vReqi8WyFNr4UCHUWKYxkydKIehdcHd6Z8AJBNVICvkNG1AqNRWVWvOclL9zLo6v2Yx3pRh+qh/WaJptutTRpFyMftzTKAyvpWK1gsEhBcZ+GyYa+08BsF38+1DEDZJYm4VNgtLdmCzyFLnsCsn33+zXY/quUU6B/CWTECV/0l0c3jv8FvZfHzfNxqh2zj+SlHPnmnfVX45zekfEyzx2WJExZYP3YHQPNR/kr8T1xBLF4JTDa1rht6+rJePiOf5YVGUJv/RSYdW3X9OLlBoGvkIFHSb2O0EGEVwrqF1ohN91T0aOjoyxc3j9y9cf06yUws7vIfkbV5NeTAOa7ii+O6o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 686624ca-3b68-4117-6253-08d6a6474d04
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 17:30:48.8168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2791
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Youri Querry <youri.querry_1@nxp.com>

The timeout for QBMan Management Commands can falsely trigger on a
busy system. This patch doubles the timeout to avoid the
false error reports

Signed-off-by: Youri Querry <youri.querry_1@nxp.com>
Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/dpio/qbman-portal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/dpio/qbman-portal.h b/drivers/soc/fsl/dpio/qbm=
an-portal.h
index 78c700e..f3ec5d2 100644
--- a/drivers/soc/fsl/dpio/qbman-portal.h
+++ b/drivers/soc/fsl/dpio/qbman-portal.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /*
  * Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
- * Copyright 2016 NXP
+ * Copyright 2016-2019 NXP
  *
  */
 #ifndef __FSL_QBMAN_PORTAL_H
@@ -433,7 +433,7 @@ static inline int qbman_swp_CDAN_set_context_enable(str=
uct qbman_swp *s,
 static inline void *qbman_swp_mc_complete(struct qbman_swp *swp, void *cmd=
,
 					  u8 cmd_verb)
 {
-	int loopvar =3D 1000;
+	int loopvar =3D 2000;
=20
 	qbman_swp_mc_submit(swp, cmd, cmd_verb);
=20
--=20
2.7.4

