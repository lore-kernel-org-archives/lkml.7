Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1216DC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD6D2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="z+LOohQj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfC2Hii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 03:38:38 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:52675 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbfC2Hif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 03:38:35 -0400
X-IronPort-AV: E=Sophos;i="5.60,283,1549954800"; 
   d="scan'208";a="29258753"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Mar 2019 00:38:33 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 29 Mar 2019 00:38:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9kznU+gnnVP2Ub+ECwNAFOsQPUBYfhZrtBPzwzUecM=;
 b=z+LOohQjLdwlmwkSczXUAl6tPkQLDkUmL/XdCYEFtheV8AaPg5uCOhlWCiuIW47acVEPqVC8EkqePjIhbmz+SqqYmebLOi+gaF5BrGxP5+NtHcsZjQuDrpAa4v/lDJBnIHRhoPSg36n4AcZhXRbfuwvYElSefHQ6vCWAJtvQ5M8=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1484.namprd11.prod.outlook.com (10.172.36.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Fri, 29 Mar 2019 07:38:31 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e8b6:2ae9:9b9c:2ca8]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e8b6:2ae9:9b9c:2ca8%3]) with mapi id 15.20.1750.014; Fri, 29 Mar 2019
 07:38:31 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <hverkuil@xs4all.nl>,
        <Nicolas.Ferre@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mchehab@kernel.org>
CC:     <ksloat@aampglobal.com>, <Eugen.Hristev@microchip.com>
Subject: [PATCH v4 2/2] media: atmel: atmel-isc: removed ARGB32 added ABGR32
 and XBGR32
Thread-Topic: [PATCH v4 2/2] media: atmel: atmel-isc: removed ARGB32 added
 ABGR32 and XBGR32
Thread-Index: AQHU5gJoW/X4Sq0Yokq32D2mG7PfBw==
Date:   Fri, 29 Mar 2019 07:38:31 +0000
Message-ID: <1553844828-21934-2-git-send-email-eugen.hristev@microchip.com>
References: <1553844828-21934-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1553844828-21934-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0118.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::16) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eugen.Hristev@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32c24111-3e93-43c6-5a71-08d6b4198a4f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR11MB1484;
x-ms-traffictypediagnostic: DM5PR11MB1484:
x-microsoft-antispam-prvs: <DM5PR11MB14846DC3EF31921C6061B92FE85A0@DM5PR11MB1484.namprd11.prod.outlook.com>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(346002)(396003)(376002)(366004)(39860400002)(136003)(199004)(189003)(11346002)(110136005)(5660300002)(54906003)(71190400001)(102836004)(2906002)(50226002)(486006)(53936002)(6512007)(66066001)(2501003)(478600001)(36756003)(25786009)(316002)(8936002)(105586002)(99286004)(71200400001)(106356001)(6436002)(6506007)(6486002)(14454004)(72206003)(2201001)(386003)(86362001)(14444005)(6116002)(26005)(446003)(476003)(52116002)(305945005)(256004)(2616005)(81156014)(81166006)(3846002)(186003)(107886003)(4326008)(68736007)(97736004)(8676002)(7736002)(76176011)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1484;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EV4JA9G7aMS2wG+jsQl/WlPLk/JRNHlcBCUL5zY04z4/AN6Xe4PkzCx4FYBaZTqcYxX2cp6XAUTtxUyfcPugCFh7JVkri87uQJVBJg3pSRyqjaJfFQVPgT8o3nohDBD1JXRS2qV6+Jal/rmqebC5Iwe/K7zLmjuiMQRhLNAFgEfEg2O2NJV65VKiqQW2T3o3iWKO8YsN1slJ0CKHKSzFAKVtsLgF7nXpyTSqlFu0ZIAjiry3+EZUDiNbA3h8G2FWSGpVZjmpscARSxKpJtDtQwuFwr1vhfs9eDPbMTQgIdo+ClmvY9FQoVEG/0L0te3mhc1vp88kBc1xaqqFcL8dh9ffqgMuwxVHAYnES0ki/e+GTZmsAjNqivtbYrfYFdb8FG5McRlPLe8LsDbZ95SvAbiW+CSjwLdaFDN5AyqrhGg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c24111-3e93-43c6-5a71-08d6b4198a4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 07:38:31.1285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1484
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

ISC will output the "ARGB32" configuration in byte order: B, G, R, Alpha.
This is in fact the format BGRA, aka ABGR32.
If alpha is missing, the same format is equivalent to XBGR32.
Added both formats and removed ARGB32 which is wrong.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/media/platform/atmel/atmel-isc.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-isc.c b/drivers/media/platf=
orm/atmel/atmel-isc.c
index 3c8b23e..a10db16 100644
--- a/drivers/media/platform/atmel/atmel-isc.c
+++ b/drivers/media/platform/atmel/atmel-isc.c
@@ -228,7 +228,10 @@ static struct isc_format controller_formats[] =3D {
 		.fourcc		=3D V4L2_PIX_FMT_RGB565,
 	},
 	{
-		.fourcc		=3D V4L2_PIX_FMT_ARGB32,
+		.fourcc		=3D V4L2_PIX_FMT_ABGR32,
+	},
+	{
+		.fourcc		=3D V4L2_PIX_FMT_XBGR32,
 	},
 	{
 		.fourcc		=3D V4L2_PIX_FMT_YUV420,
@@ -1099,7 +1102,8 @@ static int isc_try_validate_formats(struct isc_device=
 *isc)
 		break;
=20
 	case V4L2_PIX_FMT_RGB565:
-	case V4L2_PIX_FMT_ARGB32:
+	case V4L2_PIX_FMT_ABGR32:
+	case V4L2_PIX_FMT_XBGR32:
 	case V4L2_PIX_FMT_ARGB444:
 	case V4L2_PIX_FMT_ARGB555:
 		ret =3D 0;
@@ -1187,7 +1191,8 @@ static int isc_try_configure_rlp_dma(struct isc_devic=
e *isc, bool direct_dump)
 		isc->try_config.dctrl_dview =3D ISC_DCTRL_DVIEW_PACKED;
 		isc->try_config.bpp =3D 16;
 		break;
-	case V4L2_PIX_FMT_ARGB32:
+	case V4L2_PIX_FMT_ABGR32:
+	case V4L2_PIX_FMT_XBGR32:
 		isc->try_config.rlp_cfg_mode =3D ISC_RLP_CFG_MODE_ARGB32;
 		isc->try_config.dcfg_imode =3D ISC_DCFG_IMODE_PACKED32;
 		isc->try_config.dctrl_dview =3D ISC_DCTRL_DVIEW_PACKED;
@@ -1233,7 +1238,8 @@ static int isc_try_configure_pipeline(struct isc_devi=
ce *isc)
 	case V4L2_PIX_FMT_RGB565:
 	case V4L2_PIX_FMT_ARGB555:
 	case V4L2_PIX_FMT_ARGB444:
-	case V4L2_PIX_FMT_ARGB32:
+	case V4L2_PIX_FMT_ABGR32:
+	case V4L2_PIX_FMT_XBGR32:
 		/* if sensor format is RAW, we convert inside ISC */
 		if (ISC_IS_FORMAT_RAW(isc->try_config.sd_format->mbus_code)) {
 			isc->try_config.bits_pipeline =3D CFA_ENABLE |
--=20
2.7.4

