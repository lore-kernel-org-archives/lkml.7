Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD5EC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 05:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C1320663
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 05:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="CDQGQHxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfCEFQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 00:16:56 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:43351 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfCEFQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 00:16:56 -0500
X-IronPort-AV: E=Sophos;i="5.58,442,1544511600"; 
   d="scan'208";a="27261854"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 04 Mar 2019 22:16:55 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 4 Mar 2019 22:16:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7q6TRiyqf0mH2IPMr1z0fQP3pmgQDo5+jUjozZh7arg=;
 b=CDQGQHxSWv1qgkzB+C3Cu5+/MAkvn95foqLHmxBsrdrxa8Bw5AycPFHEXHEkhblYoltshDgZHXfKnOm/tfvY9cKB5cdtAC/Qspdb2VVMrBAkku6XEGmlBFrFSUeHKR8Fp1Y1QTk2fK10rWTqebxhL2fg+Yyx6U6OyA8UZe1IWQk=
Received: from BY5PR11MB4119.namprd11.prod.outlook.com (10.255.162.219) by
 BY5PR11MB3862.namprd11.prod.outlook.com (10.255.72.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.18; Tue, 5 Mar 2019 05:16:52 +0000
Received: from BY5PR11MB4119.namprd11.prod.outlook.com
 ([fe80::14ba:61c:ec32:6c5e]) by BY5PR11MB4119.namprd11.prod.outlook.com
 ([fe80::14ba:61c:ec32:6c5e%3]) with mapi id 15.20.1665.020; Tue, 5 Mar 2019
 05:16:52 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <kishon@ti.com>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <quentin.schulz@bootlin.com>,
        <grygorii.strashko@ti.com>, <gustavo@embeddedor.com>,
        <weiyongjun1@huawei.com>, <Chakri.Ponnuri@microchip.com>,
        <Kavyasree.Kotagiri@microchip.com>, <Steen.Hegelund@microchip.com>
Subject: [PATCH] phy: ocelot-serdes: Add support for SERDES6G muxing
Thread-Topic: [PATCH] phy: ocelot-serdes: Add support for SERDES6G muxing
Thread-Index: AQHU0xKkMTl9sb+TPkKg1BkP0WcJLg==
Date:   Tue, 5 Mar 2019 05:16:52 +0000
Message-ID: <1551762952-10510-1-git-send-email-kavyasree.kotagiri@microchip.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0035.prod.exchangelabs.com (2603:10b6:a02:80::48)
 To BY5PR11MB4119.namprd11.prod.outlook.com (2603:10b6:a03:18f::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kavyasree.Kotagiri@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [182.72.246.220]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e00d88da-8a31-4561-7fe1-08d6a129c696
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BY5PR11MB3862;
x-ms-traffictypediagnostic: BY5PR11MB3862:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;BY5PR11MB3862;23:KqcF6NV8Ciid08Q/SONpQeGA0mnJZut1wdecVVC?=
 =?iso-8859-1?Q?pacZHfn9SplR/uNmritjpm9psctq1/efUo5Rb/cAavYtJ9ACBMA+lwe6jA?=
 =?iso-8859-1?Q?o3n4BEB5suZrIemXxVrmL8FUdi+L3QD00sFOouQLLlZ824/p9K6eAVeOWf?=
 =?iso-8859-1?Q?VFZ/isCJmZLFnaaze/ozVc6hNoSh459soMB7yk7Gijs42vSSuQpCgRiY0U?=
 =?iso-8859-1?Q?mBE9ooHMqJJ0xpBsex6PWOOt8CrNVTScrztaqPYztWSRSwsKqZY7j/Wys0?=
 =?iso-8859-1?Q?7VXfohxSm7fNsLiwOARlOKR1T+8qh3fwFK3qvLjkVYtpSFnMT6bS2Bca6z?=
 =?iso-8859-1?Q?QuY5McPilhh2AWJ8rzTCuwqI3yu735yGpavCr1HxiqoRAx86qpBB5Wxy8I?=
 =?iso-8859-1?Q?8XPqcCxHaohG6ioLbvlPLPfVfvWSxXMxim1F66FCRRBocSQlWj0REqRhMJ?=
 =?iso-8859-1?Q?39gg6UDXrS9CZq1xoEfYeZi1dnba41Uq2U9rE1ng/7tj+CgcMDtN2BdJXc?=
 =?iso-8859-1?Q?O9lQamM5FnG54d9aglkLahgemEgGR2MlzD2zp1pAlYcmnuGP8vESiQsiMk?=
 =?iso-8859-1?Q?24SLLrJGkoaoLhNeJKueoUosdmlD5N4V8O9i3Rn2oNwfssF0RkJZTv1OCT?=
 =?iso-8859-1?Q?EnJ0CfavdYvJxgvuTpWJc8UJM3A3RiTKdxD8wt4d+OOVoRDM4pVMM36Ocq?=
 =?iso-8859-1?Q?ODeRsXsITGYs9TU9TYcp3NIyoFBQc7cXCja0zqmj3xl1mjGsEeeJa3EXAw?=
 =?iso-8859-1?Q?b5rhewJbufEir8udr4rHQDKt40TMGh9qfrjQWikG7XMW9J6EXxai/VLkIS?=
 =?iso-8859-1?Q?13sPxXi3hlUb7ItXEY7z4MGgjfKQjDjjAC2yC0wnpu9K84Pp+EdEh0hW8P?=
 =?iso-8859-1?Q?/KkT+7cZffYyIWl2qGQXuk7emEE/xCfdSimCIYHOg0L2jIkCtzssJ0KiLE?=
 =?iso-8859-1?Q?KdCRqRnW0C6bMLAqEhtnk0261x9JHtnnMXFfg0GvB4uB7PJQYX8GYdiblf?=
 =?iso-8859-1?Q?cMVyrHOgMTBa+vPWsEk03pMIH5/Sv7Co0Ae3CTI9Jh/dhMtoCHiR2vhbK8?=
 =?iso-8859-1?Q?0zcTOCAijTrZIRjODsrGDjToBVq1Nib4oTHl5lIjKzDWkZ2iaepxnY59Y/?=
 =?iso-8859-1?Q?QYCIsINkhnD07jlufhO16fKY1uFHcccBm5epdIAJhEzgPt1bjKBGKVeuW8?=
 =?iso-8859-1?Q?+VfHZ1RLlAOxjpxy2TFrld7jWkHl1F2AODVdNUJ04hqrYu2nP2sAmCdm46?=
 =?iso-8859-1?Q?Am9q8/xeyKP9aZffMMayNFW7GE/Lf8xasLyi2oaZaC3TOd19JdfiQXuN6l?=
 =?iso-8859-1?Q?f59+C47Y5w5y612fFKfOEVp?=
x-microsoft-antispam-prvs: <BY5PR11MB386259744CC4512941798C8192720@BY5PR11MB3862.namprd11.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(39860400002)(396003)(346002)(189003)(199004)(7736002)(97736004)(8936002)(25786009)(305945005)(78486014)(55236004)(26005)(6506007)(4326008)(102836004)(256004)(14444005)(6486002)(68736007)(14454004)(486006)(386003)(81156014)(54906003)(81166006)(107886003)(8676002)(52116002)(3846002)(6116002)(6436002)(106356001)(72206003)(36756003)(6512007)(105586002)(86362001)(53936002)(110136005)(99286004)(2501003)(71200400001)(71190400001)(476003)(478600001)(316002)(2616005)(50226002)(2906002)(186003)(5660300002)(66066001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR11MB3862;H:BY5PR11MB4119.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gcsHkX0Q8mH5CSaRjMvdwkvETHc6MkEowX95kTSN8iRjI/GniRKNQ2XgYb5OW9wulqyV45CKJ279DM3tVHAJnbFNnOKTkSeTHk82qgVA56G94rQrOlAs6dxT6/y/qb6NI51N0UljRVczuujITT1TeKYW3Qtl+E9hxcKIPHOFCnwEHkvgxNj3UNw3hpxqaF+/Tgy4aReR+my9rsTJUWXteu6tbE7eahPmTV3q/cHOyfZNAaOfp6HAMqYepcQk0jzFGkWbWtQdeXzr/Gk56cA6QwMGta22OxlZA6NJAEueEaw28SMkuncdBcajXO1BWUAkyVDUOG06QpGnc+aFoLWWmq4Y5zcyaXCuCUG8vZ8/GryJYnJLfixrUZYRPRumhl7qNeqG8k3FEVRbWxHT1d4MbF69CS4jxHKcJlRw7boP9uE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e00d88da-8a31-4561-7fe1-08d6a129c696
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 05:16:52.4251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3862
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>

Adding support for SERDES6G muxing required for QSGMII mode of operation.

Signed-off-by: Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>
Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
Signed-off-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Co-developed-by: Quentin Schulz <quentin.schulz@bootlin.com>
Co-developed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
---
 drivers/phy/mscc/phy-ocelot-serdes.c | 240 +++++++++++++++++++++++++++++++=
+++-
 1 file changed, 238 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/mscc/phy-ocelot-serdes.c b/drivers/phy/mscc/phy-oc=
elot-serdes.c
index 77c46f6..76f59636 100644
--- a/drivers/phy/mscc/phy-ocelot-serdes.c
+++ b/drivers/phy/mscc/phy-ocelot-serdes.c
@@ -31,6 +31,238 @@ struct serdes_macro {
 	struct serdes_ctrl	*ctrl;
 };
=20
+#define MCB_S6G_CFG_TIMEOUT     50
+
+static int __serdes_write_mcb_s6g(struct regmap *regmap, u8 macro, u32 op)
+{
+	unsigned int regval =3D 0;
+
+	regmap_write(regmap, HSIO_MCB_S6G_ADDR_CFG, op |
+		     HSIO_MCB_S6G_ADDR_CFG_SERDES6G_ADDR(BIT(macro)));
+
+	return regmap_read_poll_timeout(regmap, HSIO_MCB_S6G_ADDR_CFG, regval,
+					(regval & op) !=3D op, 100,
+					MCB_S6G_CFG_TIMEOUT * 1000);
+}
+
+static int serdes_commit_mcb_s6g(struct regmap *regmap, u8 macro)
+{
+	return __serdes_write_mcb_s6g(regmap, macro,
+		HSIO_MCB_S6G_ADDR_CFG_SERDES6G_WR_ONE_SHOT);
+}
+
+static int serdes_update_mcb_s6g(struct regmap *regmap, u8 macro)
+{
+	return __serdes_write_mcb_s6g(regmap, macro,
+		HSIO_MCB_S6G_ADDR_CFG_SERDES6G_RD_ONE_SHOT);
+}
+
+static int serdes_init_s6g(struct regmap *regmap, u8 serdes, int mode)
+{
+	u32 pll_fsm_ctrl_data;
+	u32 ob_ena1v_mode;
+	u32 des_bw_ana;
+	u32 ob_ena_cas;
+	u32 if_mode;
+	u32 ob_lev;
+	u32 qrate;
+	int ret;
+
+	if (mode =3D=3D PHY_INTERFACE_MODE_QSGMII) {
+		pll_fsm_ctrl_data =3D 120;
+		ob_ena1v_mode =3D 0;
+		ob_ena_cas =3D 0;
+		des_bw_ana =3D 5;
+		ob_lev =3D 24;
+		if_mode =3D 3;
+		qrate =3D 0;
+	} else {
+		pll_fsm_ctrl_data =3D 60;
+		ob_ena1v_mode =3D 1;
+		ob_ena_cas =3D 2;
+		des_bw_ana =3D 3;
+		ob_lev =3D 48;
+		if_mode =3D 1;
+		qrate =3D 1;
+	}
+
+	ret =3D serdes_update_mcb_s6g(regmap, serdes);
+	if (ret)
+		return ret;
+
+	/* Test pattern */
+
+	regmap_update_bits(regmap, HSIO_S6G_COMMON_CFG,
+			   HSIO_S6G_COMMON_CFG_SYS_RST, 0);
+
+	regmap_update_bits(regmap, HSIO_S6G_PLL_CFG,
+			   HSIO_S6G_PLL_CFG_PLL_FSM_ENA, 0);
+
+	regmap_update_bits(regmap, HSIO_S6G_IB_CFG,
+			   HSIO_S6G_IB_CFG_IB_SIG_DET_ENA |
+			   HSIO_S6G_IB_CFG_IB_REG_ENA |
+			   HSIO_S6G_IB_CFG_IB_SAM_ENA |
+			   HSIO_S6G_IB_CFG_IB_EQZ_ENA |
+			   HSIO_S6G_IB_CFG_IB_CONCUR |
+			   HSIO_S6G_IB_CFG_IB_CAL_ENA,
+			   HSIO_S6G_IB_CFG_IB_SIG_DET_ENA |
+			   HSIO_S6G_IB_CFG_IB_REG_ENA |
+			   HSIO_S6G_IB_CFG_IB_SAM_ENA |
+			   HSIO_S6G_IB_CFG_IB_EQZ_ENA |
+			   HSIO_S6G_IB_CFG_IB_CONCUR);
+
+	regmap_update_bits(regmap, HSIO_S6G_IB_CFG1,
+			   HSIO_S6G_IB_CFG1_IB_FRC_OFFSET |
+			   HSIO_S6G_IB_CFG1_IB_FRC_LP |
+			   HSIO_S6G_IB_CFG1_IB_FRC_MID |
+			   HSIO_S6G_IB_CFG1_IB_FRC_HP |
+			   HSIO_S6G_IB_CFG1_IB_FILT_OFFSET |
+			   HSIO_S6G_IB_CFG1_IB_FILT_LP |
+			   HSIO_S6G_IB_CFG1_IB_FILT_MID |
+			   HSIO_S6G_IB_CFG1_IB_FILT_HP,
+			   HSIO_S6G_IB_CFG1_IB_FILT_OFFSET |
+			   HSIO_S6G_IB_CFG1_IB_FILT_HP |
+			   HSIO_S6G_IB_CFG1_IB_FILT_LP |
+			   HSIO_S6G_IB_CFG1_IB_FILT_MID);
+
+	regmap_update_bits(regmap, HSIO_S6G_IB_CFG2,
+			   HSIO_S6G_IB_CFG2_IB_UREG_M,
+			   HSIO_S6G_IB_CFG2_IB_UREG(4));
+
+	regmap_update_bits(regmap, HSIO_S6G_IB_CFG3,
+			   HSIO_S6G_IB_CFG3_IB_INI_OFFSET_M |
+			   HSIO_S6G_IB_CFG3_IB_INI_LP_M |
+			   HSIO_S6G_IB_CFG3_IB_INI_MID_M |
+			   HSIO_S6G_IB_CFG3_IB_INI_HP_M,
+			   HSIO_S6G_IB_CFG3_IB_INI_OFFSET(31) |
+			   HSIO_S6G_IB_CFG3_IB_INI_LP(1) |
+			   HSIO_S6G_IB_CFG3_IB_INI_MID(31) |
+			   HSIO_S6G_IB_CFG3_IB_INI_HP(0));
+
+	regmap_update_bits(regmap, HSIO_S6G_MISC_CFG,
+			   HSIO_S6G_MISC_CFG_LANE_RST,
+			   HSIO_S6G_MISC_CFG_LANE_RST);
+
+	ret =3D serdes_commit_mcb_s6g(regmap, serdes);
+	if (ret)
+		return ret;
+
+	/* OB + DES + IB + SER CFG */
+	regmap_update_bits(regmap, HSIO_S6G_OB_CFG,
+			   HSIO_S6G_OB_CFG_OB_IDLE |
+			   HSIO_S6G_OB_CFG_OB_ENA1V_MODE |
+			   HSIO_S6G_OB_CFG_OB_POST0_M |
+			   HSIO_S6G_OB_CFG_OB_PREC_M,
+			   (ob_ena1v_mode ? HSIO_S6G_OB_CFG_OB_ENA1V_MODE : 0) |
+			   HSIO_S6G_OB_CFG_OB_POST0(0) |
+			   HSIO_S6G_OB_CFG_OB_PREC(0));
+
+	regmap_update_bits(regmap, HSIO_S6G_OB_CFG1,
+			   HSIO_S6G_OB_CFG1_OB_ENA_CAS_M |
+			   HSIO_S6G_OB_CFG1_OB_LEV_M,
+			   HSIO_S6G_OB_CFG1_OB_LEV(ob_lev) |
+			   HSIO_S6G_OB_CFG1_OB_ENA_CAS(ob_ena_cas));
+
+	regmap_update_bits(regmap, HSIO_S6G_DES_CFG,
+			   HSIO_S6G_DES_CFG_DES_PHS_CTRL_M |
+			   HSIO_S6G_DES_CFG_DES_CPMD_SEL_M |
+			   HSIO_S6G_DES_CFG_DES_BW_ANA_M,
+			   HSIO_S6G_DES_CFG_DES_PHS_CTRL(2) |
+			   HSIO_S6G_DES_CFG_DES_CPMD_SEL(0) |
+			   HSIO_S6G_DES_CFG_DES_BW_ANA(des_bw_ana));
+
+	regmap_update_bits(regmap, HSIO_S6G_IB_CFG,
+			   HSIO_S6G_IB_CFG_IB_SIG_DET_CLK_SEL_M |
+			   HSIO_S6G_IB_CFG_IB_REG_PAT_SEL_OFFSET_M,
+			   HSIO_S6G_IB_CFG_IB_REG_PAT_SEL_OFFSET(0) |
+			   HSIO_S6G_IB_CFG_IB_SIG_DET_CLK_SEL(0));
+
+	regmap_update_bits(regmap, HSIO_S6G_IB_CFG1,
+			   HSIO_S6G_IB_CFG1_IB_TSDET_M,
+			   HSIO_S6G_IB_CFG1_IB_TSDET(16));
+
+	regmap_update_bits(regmap, HSIO_S6G_SER_CFG,
+			   HSIO_S6G_SER_CFG_SER_ALISEL_M |
+			   HSIO_S6G_SER_CFG_SER_ENALI,
+			   HSIO_S6G_SER_CFG_SER_ALISEL(0));
+
+	regmap_update_bits(regmap, HSIO_S6G_PLL_CFG,
+			   HSIO_S6G_PLL_CFG_PLL_DIV4 |
+			   HSIO_S6G_PLL_CFG_PLL_ENA_ROT |
+			   HSIO_S6G_PLL_CFG_PLL_FSM_CTRL_DATA_M |
+			   HSIO_S6G_PLL_CFG_PLL_ROT_DIR |
+			   HSIO_S6G_PLL_CFG_PLL_ROT_FRQ,
+			   HSIO_S6G_PLL_CFG_PLL_FSM_CTRL_DATA
+			   (pll_fsm_ctrl_data));
+
+	regmap_update_bits(regmap, HSIO_S6G_COMMON_CFG,
+			   HSIO_S6G_COMMON_CFG_SYS_RST |
+			   HSIO_S6G_COMMON_CFG_ENA_LANE |
+			   HSIO_S6G_COMMON_CFG_PWD_RX |
+			   HSIO_S6G_COMMON_CFG_PWD_TX |
+			   HSIO_S6G_COMMON_CFG_HRATE |
+			   HSIO_S6G_COMMON_CFG_QRATE |
+			   HSIO_S6G_COMMON_CFG_ENA_ELOOP |
+			   HSIO_S6G_COMMON_CFG_ENA_FLOOP |
+			   HSIO_S6G_COMMON_CFG_IF_MODE_M,
+			   HSIO_S6G_COMMON_CFG_SYS_RST |
+			   HSIO_S6G_COMMON_CFG_ENA_LANE |
+			   (qrate ? HSIO_S6G_COMMON_CFG_QRATE : 0) |
+			   HSIO_S6G_COMMON_CFG_IF_MODE(if_mode));
+
+	regmap_update_bits(regmap, HSIO_S6G_MISC_CFG,
+			   HSIO_S6G_MISC_CFG_LANE_RST |
+			   HSIO_S6G_MISC_CFG_DES_100FX_CPMD_ENA |
+			   HSIO_S6G_MISC_CFG_RX_LPI_MODE_ENA |
+			   HSIO_S6G_MISC_CFG_TX_LPI_MODE_ENA,
+			   HSIO_S6G_MISC_CFG_LANE_RST |
+			   HSIO_S6G_MISC_CFG_RX_LPI_MODE_ENA);
+
+
+	ret =3D serdes_commit_mcb_s6g(regmap, serdes);
+	if (ret)
+		return ret;
+
+	regmap_update_bits(regmap, HSIO_S6G_PLL_CFG,
+			   HSIO_S6G_PLL_CFG_PLL_FSM_ENA,
+			   HSIO_S6G_PLL_CFG_PLL_FSM_ENA);
+
+	ret =3D serdes_commit_mcb_s6g(regmap, serdes);
+	if (ret)
+		return ret;
+
+	/* Wait for PLL bringup */
+	msleep(20);
+
+	regmap_update_bits(regmap, HSIO_S6G_IB_CFG,
+			   HSIO_S6G_IB_CFG_IB_CAL_ENA,
+			   HSIO_S6G_IB_CFG_IB_CAL_ENA);
+
+	regmap_update_bits(regmap, HSIO_S6G_MISC_CFG,
+			   HSIO_S6G_MISC_CFG_LANE_RST, 0);
+
+	ret =3D serdes_commit_mcb_s6g(regmap, serdes);
+	if (ret)
+		return ret;
+
+	/* Wait for calibration */
+	msleep(60);
+
+	regmap_update_bits(regmap, HSIO_S6G_IB_CFG,
+			   HSIO_S6G_IB_CFG_IB_REG_PAT_SEL_OFFSET_M |
+			   HSIO_S6G_IB_CFG_IB_SIG_DET_CLK_SEL_M,
+			   HSIO_S6G_IB_CFG_IB_REG_PAT_SEL_OFFSET(0) |
+			   HSIO_S6G_IB_CFG_IB_SIG_DET_CLK_SEL(7));
+
+	regmap_update_bits(regmap, HSIO_S6G_IB_CFG1,
+			   HSIO_S6G_IB_CFG1_IB_TSDET_M,
+			   HSIO_S6G_IB_CFG1_IB_TSDET(3));
+
+	/* IB CFG */
+
+	return 0;
+}
+
 #define MCB_S1G_CFG_TIMEOUT     50
=20
 static int __serdes_write_mcb_s1g(struct regmap *regmap, u8 macro, u32 op)
@@ -110,7 +342,7 @@ struct serdes_mux {
 	u32			mux;
 };
=20
-#define SERDES_MUX(_idx, _port, _mode, _submode, _mask, _mux) {		\
+#define SERDES_MUX(_idx, _port, _mode, _submode, _mask, _mux) { \
 	.idx =3D _idx,						\
 	.port =3D _port,						\
 	.mode =3D _mode,						\
@@ -191,8 +423,12 @@ static int serdes_set_mode(struct phy *phy, enum phy_m=
ode mode, int submode)
=20
 		if (macro->idx <=3D SERDES1G_MAX)
 			return serdes_init_s1g(macro->ctrl->regs, macro->idx);
+		else if (macro->idx <=3D SERDES6G_MAX)
+			return serdes_init_s6g(macro->ctrl->regs,
+					       macro->idx - (SERDES1G_MAX + 1),
+					       ocelot_serdes_muxes[i].submode);
=20
-		/* SERDES6G and PCIe not supported yet */
+		/* PCIe not supported yet */
 		return -EOPNOTSUPP;
 	}
=20
--=20
1.9.1

