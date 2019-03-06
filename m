Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EC7C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF2A206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="EM/i5hZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfCFXQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:16:35 -0500
Received: from mail-eopbgr80121.outbound.protection.outlook.com ([40.107.8.121]:12356
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725788AbfCFXQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 18:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slsS03ejtOmf8TTg9jT7a+19WEOqrpVOJATPfAwJwxI=;
 b=EM/i5hZSDh3dYBZYLDFp3UsRezeLc0OEC8GkRmlc40kHT1lB0YvJa1mPzZt54IdXruMOwGudKpHZ46A8iF3n21oc3RglcrSUxOaX0HgPk1LJhqz0x8LpjJQKtuy5HP3+/o96nt5O2KSPzySmn9rHs/hI6bLa60Hwo/hTw0spfwM=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1PR02MB4592.eurprd02.prod.outlook.com (20.178.12.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Wed, 6 Mar 2019 23:15:35 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::38db:37eb:b43e:e4c1]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::38db:37eb:b43e:e4c1%6]) with mapi id 15.20.1665.020; Wed, 6 Mar 2019
 23:15:35 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ken Chen <chen.kenyy@inventec.com>,
        Pradeep Srinivasan <pradeeps@cumulusnetworks.com>
Subject: [PATCH v2 1/5] i2c: mux: pca9541: use the BIT macro
Thread-Topic: [PATCH v2 1/5] i2c: mux: pca9541: use the BIT macro
Thread-Index: AQHU1HKAw6Qt9CwT4UqEobY8yAcuKg==
Date:   Wed, 6 Mar 2019 23:15:35 +0000
Message-ID: <20190306231521.29367-2-peda@axentia.se>
References: <20190306231521.29367-1-peda@axentia.se>
In-Reply-To: <20190306231521.29367-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR1001CA0016.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::26) To VI1PR02MB4542.eurprd02.prod.outlook.com
 (2603:10a6:803:b1::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e96e442a-353f-4417-ce85-08d6a289a32f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB4592;
x-ms-traffictypediagnostic: VI1PR02MB4592:
x-microsoft-antispam-prvs: <VI1PR02MB459249BC7B7EB74712051A82BC730@VI1PR02MB4592.eurprd02.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39830400003)(396003)(366004)(346002)(136003)(189003)(199004)(5640700003)(53936002)(6486002)(71200400001)(6436002)(2501003)(71190400001)(99286004)(4326008)(6916009)(476003)(102836004)(76176011)(256004)(446003)(486006)(52116002)(3846002)(86362001)(386003)(74482002)(6506007)(6512007)(26005)(6116002)(97736004)(66066001)(305945005)(7736002)(2351001)(186003)(2616005)(11346002)(25786009)(106356001)(36756003)(8936002)(8676002)(68736007)(81156014)(81166006)(5660300002)(508600001)(2906002)(54906003)(1076003)(50226002)(316002)(14454004)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB4592;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR02MB4592;23:pKBrbR+Za753uv7RNgCyykwhhna9HVcCFe8/E5Z?=
 =?iso-8859-1?Q?3HakBCPTC/vuLFvvenHHGI9JUf13Wx7XbItn/pjn6z1puuSYDb/XbFAIXp?=
 =?iso-8859-1?Q?77K+KYDU/4Ggh3LGrcGqXrMytBM6BoS8OyNwJFRbZOtXuWojjnlXet47IB?=
 =?iso-8859-1?Q?hC0nuyA7rqlk6b36frF7vdYV5EWzuWevOVK8HcyuiajTps+brfykEvtqtv?=
 =?iso-8859-1?Q?/x+UCfZy8RQC9jPAugmDM6KT8ofJku89ITMCA8Z+9bHgBQMdFhn4yckjSJ?=
 =?iso-8859-1?Q?aGsDHdoOjOEAcDVMeXxsbcY4N0WC/VTnWBRCpf2mewWJ+wp0Q5l1X4McL7?=
 =?iso-8859-1?Q?KheA5hgUGFSxdFMvcyTFOE+llooZSTmEhSq6NIHO2/wNTEfU+BXl2l7UOk?=
 =?iso-8859-1?Q?Dqvw3zQrYxJbLw8ymgHrGoTahCwbpCYWuB8wLjmTDmG8k5uR48UFAB+qBt?=
 =?iso-8859-1?Q?cNK9iVEw+tMIcCiKW8LYTCA82qG26+qdXrqVW7ApHiwKFRqiahb2c4+dN3?=
 =?iso-8859-1?Q?c/byMwHxCeZqMjM0rPbtQirAiaxSFI/EiiJdpQcBQ0NIyFsn1u8x9u+vDM?=
 =?iso-8859-1?Q?MUAat4dEVs4SlK1mM6p+n2FZGJdusuWYnl2AEoxyVCrbnXel55hRdKomaO?=
 =?iso-8859-1?Q?H5zTg2Dsy3y5j7TABbG9G8jeADhqJ1EOkuuvvoRH+X4qu2PT4ltXTcbZsQ?=
 =?iso-8859-1?Q?4dJUrXiSmTR5F2G6SKWbzonUdMQJmG4bWOwL3xnyymGB5R6ktvTZhy0d55?=
 =?iso-8859-1?Q?MqAtfGjzAkaR5nbpNCpFmF4pdVf1gyWALjrME9vRVmg2qebgMdoRjiEA50?=
 =?iso-8859-1?Q?VxJ45AvinxMTlWFWYDWaF4yjyOu0h8/4PSaJMATI/GphDHDL7SeWGWchj0?=
 =?iso-8859-1?Q?A9bhimJZ+sOZkXB2ikwyFq7wATMyRrmsDKlHPrXaT1wksIT6m86EbVMlhI?=
 =?iso-8859-1?Q?7Z6O9W0OBK85RCcA1ySohoxotK1sgAMxEEun9d0jw7FhKoUJbslVISpTUD?=
 =?iso-8859-1?Q?sAA2WryyAqPmBjWWLUSHGp4YZBo2X2zLxCuYaOXdXLCygh4RdGsCHaPd1A?=
 =?iso-8859-1?Q?5Z53xqftmWAYxhdtXo2BiSMaUJ9igD6WIKTle6Cr4cfkXE7GgXPEZnqeB4?=
 =?iso-8859-1?Q?jeh6nGPwerFFkAMYDM7H44PIGPu8KSXMuGu+aN6tl+S5YW9bhYMde8meJ8?=
 =?iso-8859-1?Q?N5QklAP7Tah3beUwGbXmi1FiXku3pHA+EfdqRRmW8NKrLDAdCcH/EuGHwG?=
 =?iso-8859-1?Q?1b83M0WuBuwg6tXkU0rnuKMkXEP1OfJj1Ut48zsstVNMiL2XyV7gWW80O+?=
 =?iso-8859-1?Q?fln0QVskLSQZigJEg8e11T0Bdcg94OPmSBIOY0d2zFBqw=3D=3D?=
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZblX8nqpgS/sNNJ6Qm6tDGAmmu17QcWBpe4+f0XF92joTNyTj9mFc+Eddu6DYGH/SMfVl6uv5t821w4WUw4p2oO0+pVZmPnvKRwz38KHVh5QMitunEvNrkwuHddsYvKVOeevJPogAy4euk7cuGBKJWvmu8mK19HBtXqA/dhKA7HRBFZdbu9UAfBJJtpQD5XNptzF4YECBE6nZcniHZTMFUyQJ4bkYz4Cu0L+D9thG8+6nILHDUIPxgjFlJBUHDQO5lwP9UkiVvpA4T6/oCTAF/NwLvmapBKKIrp6m1tkI1+oMB1pzOYgzfbC6YJcSep4u1XD4iBoV31/xah8zfG7W9DrTfWJKTrp59nL8pDIThxMm6Bo4X0cVvCRgJh5/meycqFCJDuBLRP+cHJuXLM/uhvLHrTyWj1ky4xxg6FIih8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: e96e442a-353f-4417-ce85-08d6a289a32f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 23:15:35.3613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4592
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because it looks nice!

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-pca9541.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mu=
x-pca9541.c
index 9e75d6b9140b..30cabf482985 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -16,6 +16,7 @@
  * warranty of any kind, whether express or implied.
  */
=20
+#include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/i2c.h>
@@ -43,20 +44,20 @@
 #define PCA9541_CONTROL		0x01
 #define PCA9541_ISTAT		0x02
=20
-#define PCA9541_CTL_MYBUS	(1 << 0)
-#define PCA9541_CTL_NMYBUS	(1 << 1)
-#define PCA9541_CTL_BUSON	(1 << 2)
-#define PCA9541_CTL_NBUSON	(1 << 3)
-#define PCA9541_CTL_BUSINIT	(1 << 4)
-#define PCA9541_CTL_TESTON	(1 << 6)
-#define PCA9541_CTL_NTESTON	(1 << 7)
-
-#define PCA9541_ISTAT_INTIN	(1 << 0)
-#define PCA9541_ISTAT_BUSINIT	(1 << 1)
-#define PCA9541_ISTAT_BUSOK	(1 << 2)
-#define PCA9541_ISTAT_BUSLOST	(1 << 3)
-#define PCA9541_ISTAT_MYTEST	(1 << 6)
-#define PCA9541_ISTAT_NMYTEST	(1 << 7)
+#define PCA9541_CTL_MYBUS	BIT(0)
+#define PCA9541_CTL_NMYBUS	BIT(1)
+#define PCA9541_CTL_BUSON	BIT(2)
+#define PCA9541_CTL_NBUSON	BIT(3)
+#define PCA9541_CTL_BUSINIT	BIT(4)
+#define PCA9541_CTL_TESTON	BIT(6)
+#define PCA9541_CTL_NTESTON	BIT(7)
+
+#define PCA9541_ISTAT_INTIN	BIT(0)
+#define PCA9541_ISTAT_BUSINIT	BIT(1)
+#define PCA9541_ISTAT_BUSOK	BIT(2)
+#define PCA9541_ISTAT_BUSLOST	BIT(3)
+#define PCA9541_ISTAT_MYTEST	BIT(6)
+#define PCA9541_ISTAT_NMYTEST	BIT(7)
=20
 #define BUSON		(PCA9541_CTL_BUSON | PCA9541_CTL_NBUSON)
 #define MYBUS		(PCA9541_CTL_MYBUS | PCA9541_CTL_NMYBUS)
--=20
2.11.0

