Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54C6C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E206208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="W8by5kxb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbfGaMil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:38:41 -0400
Received: from mail-eopbgr00137.outbound.protection.outlook.com ([40.107.0.137]:9952
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387776AbfGaMie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:38:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqsFaMdSIfAIB9S9AzTish3G0bD9lu+Q9eP9K/JfkBTX7JQ9yVmlTj8ldRhwq62zLiUw4W2J1Td64sA+BlWD2mhq3DQ4xNK7SCzXnFWzXRDpXMCXSH5kOxGMrGkVXhWqPD/Mx0Mu3M+viNnHSoPvlTvGBprYs0vva3/wEIkGl81Izc5aiuoL8MMVddO4B7FsTp1xNGl5Yyx95GLfma8mhqxVOBGCx0bxYDJcoLhl6nfgeXfH3NlPjFh/LJ9rf52F3LUEHS3tWBeNMKam9tX1zWVXeAj/UKIXJoI31OjI5jWMvcvqRqfgnbN2d/iBG2U1Y+3pD0edxNKK5M4ruxfYqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7dw0XiaTs4/nA6KbEHdOndagwLgPFZTiqIGvM0dN4A=;
 b=OWIPgGuaOOqQIAx6tdqtB8EcOAtfi2oOkxW8Mokdo9NZAmmh0PFIoIyZ4eS2QdSDi/c7XgpeQ54Es1q3IgldCLiJ9Sd+pTmjjNdkMwlX4CwYaAUd3bAgbBXaunH1lpy5YwfdK9/9g00DpaE3f2gGttzc3N7sL0wHRoHmIV8JRcAiyJC9/XorSJ0q0yJUq1xSYHZw1bWC8fOFYov2rqLIJYb81thm11pG6bkLL4JXQfR16TvDK4SuN8RSbQfQ6M29ftBW+94JLpY1UIP/gZqEGcnM2DmNxT4VKTrC3I3OpnCNwoYVRhgvXKRjCDLA2GVlew4IXcOQl5/Zg+bYoHNk2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7dw0XiaTs4/nA6KbEHdOndagwLgPFZTiqIGvM0dN4A=;
 b=W8by5kxbsL9fyxuNiZ5OnYvFtOGJJaLiLcztDcI3BK/+HzPtLxh1xl1YzApbkMCsDNnuc5+IteiIxRylt5HyXi6v888d2cIE6lp+J+wgWNuDgQarAcSoGjyzNiT7bWnqQlTdgowNW1Xuu86HzGdhMv83ageaCZxQWdNzwDzDB5s=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3615.eurprd05.prod.outlook.com (52.134.7.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 12:38:29 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 12:38:29 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?iso-8859-2?Q?Michal_Vok=E1=E8?= <michal.vokac@ysoft.com>,
        Fabio Estevam <festevam@gmail.com>
CC:     Philippe Schenker <philippe.schenker@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v2 13/20] ARM: dts: imx6-colibri: Add missing pinmuxing to
 Toradex eval board
Thread-Topic: [PATCH v2 13/20] ARM: dts: imx6-colibri: Add missing pinmuxing
 to Toradex eval board
Thread-Index: AQHVR5zXr3rn3LHvDE62zwTrDbL/VA==
Date:   Wed, 31 Jul 2019 12:38:23 +0000
Message-ID: <20190731123750.25670-14-philippe.schenker@toradex.com>
References: <20190731123750.25670-1-philippe.schenker@toradex.com>
In-Reply-To: <20190731123750.25670-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR02CA0012.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::25) To VI1PR0502MB3965.eurprd05.prod.outlook.com
 (2603:10a6:803:23::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 577987e6-c429-4ccf-c7d1-08d715b3f9fa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3615;
x-ms-traffictypediagnostic: VI1PR0502MB3615:
x-microsoft-antispam-prvs: <VI1PR0502MB36151C5B4AEC531950EC1617F4DF0@VI1PR0502MB3615.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(376002)(136003)(396003)(366004)(346002)(199004)(189003)(66946007)(52116002)(66446008)(64756008)(66556008)(66476007)(76176011)(4744005)(99286004)(53936002)(6512007)(6436002)(5660300002)(4326008)(7416002)(66066001)(6486002)(25786009)(478600001)(14454004)(7736002)(305945005)(71190400001)(71200400001)(3846002)(6116002)(36756003)(2501003)(68736007)(2906002)(2201001)(44832011)(486006)(476003)(86362001)(6666004)(446003)(2616005)(11346002)(256004)(186003)(81166006)(81156014)(26005)(102836004)(50226002)(8936002)(8676002)(6506007)(386003)(316002)(54906003)(110136005)(1076003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3615;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HCS+26xAMphoUUa7d8g3pxxl8YJVM3x4ark9mziajGtkQmDI6JLVlQ4TJ0gKfMb/XuHoEkjyLRxlOtUDfSLu6RtcsGTdR6HhWLmA3Ap3CpUzjF4XITSB+ZHgzSTWxIKoKwpjDJbg261t01wx4LUY28GRwfaM4CeMuqGBH2aLpahVby0hW2SLR6J9PBM2DxEUkljt2frkGNOtHqAbQOL3OAvI9AVYxHwKO39zW5KkKGpQ+NRddPTTfkahnSgjc7mqUnu5zftvmKJaoGRWL269hWPfjXV3XjTd/MK58OaMw/thm6oi4BAnLH4Cpjj+8w+PZcBOIBbSq2dJNXdxpHSrVrvQsITh/k/x37kDF9wceY+u7rcpRmfQnfLE8nSqkY50cdK0XEmDz8XtvSErL9Pynwq+VlenV+syuXKOqst6bC0=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 577987e6-c429-4ccf-c7d1-08d715b3f9fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 12:38:23.5524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: philippe.schenker@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3615
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds some missing pinmuxing that is in the colibri
standard to the dts.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

Changes in v2:
- Commit title

 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts b/arch/arm/boot/d=
ts/imx6dl-colibri-eval-v3.dts
index 763fb5e90bd3..e7a2d8c3b2d4 100644
--- a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
@@ -191,6 +191,14 @@
 };
=20
 &iomuxc {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <
+		&pinctrl_weim_gpio_1 &pinctrl_weim_gpio_2
+		&pinctrl_weim_gpio_3 &pinctrl_weim_gpio_4
+		&pinctrl_weim_gpio_5 &pinctrl_weim_gpio_6
+		&pinctrl_usbh_oc_1 &pinctrl_usbc_id_1
+	>;
+
 	pinctrl_pcap_1: pcap-1 {
 		fsl,pins =3D <
 			MX6QDL_PAD_GPIO_9__GPIO1_IO09	0x1b0b0 /* SODIMM 28 */
--=20
2.22.0

