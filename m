Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA63C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D66AC20665
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="r75kac6v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbfHLOWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:22:25 -0400
Received: from mail-eopbgr140112.outbound.protection.outlook.com ([40.107.14.112]:12097
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728380AbfHLOWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:22:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFjCPDUgG+rkqiRNDRa+W0nLTMpArtFQruZ57SQ2M1Y9UhdXIjrCGjmOxDphuQ2NvWDsgyxMVUnTkgqOQ3YAMtuNBJ6AxyT2yAljLR0R4spp9Mt+9dKaCltb64H790QW286xwksoc64dlS34Af93EeXCxE0twGu6z+A/HVUQKN3hg98S7jlNm8GJCc2rh4qzu7Bog+BSCL7SsyHlUJhbpL4n+ydTG7zDNSGbqPUBcl/CEBaNtJPHurwnc74ZX5xh0w3S+fBmSjjV8oH18JTMzmHqLBga/oGaKOAL+qhWbqumGEleC34euv6qAgQzh4MG+4s1AeLjVfBOfTVq5jcS5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/g2NziN886IodlijNXpq1U//OiPvR5+Qnqn38oXtU4=;
 b=hhu4WndOcqJn0vlPoYAL8pZL3tjVBeMxkn3qvAOXsbOm9wgjFAq3+Fmu5IJca9tJb0i+EhjleyGizGb9QnjeoE3zR6JSQI76kNXXEV7ldENBd9joTlHkJ/Oea63UyLI251TOPQ9/WI4QXA8sPCB7Sh5p1k+wxOV13ksg0Rz3210I7T02okCyq1Ntxr53g1XvM4nbmGmajX/UV5UlUeecDm/y2TiKKWzXAGTshsIXOBf6lKLyNUW4NIzsVMqlKzVqRGSzvuiQayX/MFczm7mEfXvPBAoUFd9sRhEZ1lsk61vNR3xaTfz2haibLV6Io09xp21cEAuRzgXpCDt9hWezxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/g2NziN886IodlijNXpq1U//OiPvR5+Qnqn38oXtU4=;
 b=r75kac6vaaRSRH+v6RGut2w1FO49i2C2C01KSX1qhXeFZSVVPKYJ0VZ+ybOEVWg9Ih4tvxk3hYTOIjYgGEw1fPgzoHvFToDE7Gto/BkfCBG95hEHD+DD4JeppMYZPIRTwTPXbSA1R2ISQJBtW1sygkYpMx67OgmpUM5eU3p7eJI=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB2942.eurprd05.prod.outlook.com (10.175.26.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.21; Mon, 12 Aug 2019 14:21:25 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 14:21:25 +0000
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
CC:     Stefan Agner <stefan.agner@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v4 07/21] ARM: dts: imx7-colibri: fix 1.8V/UHS support
Thread-Topic: [PATCH v4 07/21] ARM: dts: imx7-colibri: fix 1.8V/UHS support
Thread-Index: AQHVURk5IAfU3hfTCUmCBg5Kg1vuIQ==
Date:   Mon, 12 Aug 2019 14:21:25 +0000
Message-ID: <20190812142105.1995-8-philippe.schenker@toradex.com>
References: <20190812142105.1995-1-philippe.schenker@toradex.com>
In-Reply-To: <20190812142105.1995-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P194CA0055.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::44) To VI1PR0502MB3965.eurprd05.prod.outlook.com
 (2603:10a6:803:23::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9fc4e2d-5784-41b7-bc63-08d71f305b76
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB2942;
x-ms-traffictypediagnostic: VI1PR0502MB2942:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB29426CE740DDCF484E712D68F4D30@VI1PR0502MB2942.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:741;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(39840400004)(346002)(366004)(396003)(199004)(189003)(5660300002)(54906003)(110136005)(316002)(478600001)(6486002)(86362001)(2201001)(66066001)(561944003)(53936002)(6116002)(1076003)(3846002)(2906002)(4326008)(25786009)(66446008)(64756008)(66556008)(66946007)(66476007)(6436002)(8676002)(11346002)(476003)(2616005)(446003)(256004)(81166006)(81156014)(2501003)(44832011)(6512007)(14444005)(486006)(50226002)(71200400001)(71190400001)(7416002)(8936002)(36756003)(52116002)(7736002)(305945005)(99286004)(102836004)(386003)(14454004)(76176011)(186003)(6506007)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2942;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: znCSCfK+ACYIcDzDjzLdMiIBxMY4ERgPi8qaCETtUNgdjKidhLsPfMiYRI6Mf56nLNupWlvH294FzvU8qeNn4F/6Nu8ntUW0gmzcMpSJ5Xpq9u8R5+aal9m7NTfLcznrs4tvBfG2PmuLwPOqICaETxtdMbpRgV/5+LmC2qENA+mSGyLtU+NGMfbH8pDfzgnmaSuciD1YY5HPTHi25Ob+VqZhH8fer7NMJFHtKsUn/I6wdaYRGjl5G74xxN3i2P3JVyO3U6IzPjFkQM0lA2ehulqoQDp0kJhOZoh7/eSk1GN56gmiZuvJtGelTTrAiGYg2n6Wg0wA1IDOxjmncFUySN6bX7kE5tcndix5xbo0h/XhkvsEsrLeihK69SxJgQiTglQHr8qHnaDhkok5LO4XCQLmTBNccl9kC1YOFDAWjlc=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9fc4e2d-5784-41b7-bc63-08d71f305b76
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 14:21:25.1472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0b49vt0BhgjDIldZjCImlnE3nbdEgcwUwfZwllx6IeOyLcK7jU2S9NMz+U6SJJrTwD1gXu9iGlYMBasM3gGNgCgWuDfgXfu5l3obbEzH2eQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2942
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan.agner@toradex.com>

Add pinmuxing and do not specify voltage restrictions for the usdhc
instance available on the modules edge connector. This allows to use
SD-cards with higher transfer modes if supported by the carrier board.

Signed-off-by: Stefan Agner <stefan.agner@toradex.com>
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v4:
- Add Marcel Ziswiler's Ack

Changes in v3:
- Add new commit message from Stefan's proposal on ML

Changes in v2: None

 arch/arm/boot/dts/imx7-colibri.dtsi | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-c=
olibri.dtsi
index 5347ed38acb2..c563bb821b5e 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -326,7 +326,6 @@
 &usdhc1 {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&pinctrl_usdhc1 &pinctrl_cd_usdhc1>;
-	no-1-8-v;
 	cd-gpios =3D <&gpio1 0 GPIO_ACTIVE_LOW>;
 	disable-wp;
 	vqmmc-supply =3D <&reg_LDO2>;
@@ -671,6 +670,28 @@
 		>;
 	};
=20
+	pinctrl_usdhc1_100mhz: usdhc1grp_100mhz {
+		fsl,pins =3D <
+			MX7D_PAD_SD1_CMD__SD1_CMD	0x5a
+			MX7D_PAD_SD1_CLK__SD1_CLK	0x1a
+			MX7D_PAD_SD1_DATA0__SD1_DATA0	0x5a
+			MX7D_PAD_SD1_DATA1__SD1_DATA1	0x5a
+			MX7D_PAD_SD1_DATA2__SD1_DATA2	0x5a
+			MX7D_PAD_SD1_DATA3__SD1_DATA3	0x5a
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1grp_200mhz {
+		fsl,pins =3D <
+			MX7D_PAD_SD1_CMD__SD1_CMD	0x5b
+			MX7D_PAD_SD1_CLK__SD1_CLK	0x1b
+			MX7D_PAD_SD1_DATA0__SD1_DATA0	0x5b
+			MX7D_PAD_SD1_DATA1__SD1_DATA1	0x5b
+			MX7D_PAD_SD1_DATA2__SD1_DATA2	0x5b
+			MX7D_PAD_SD1_DATA3__SD1_DATA3	0x5b
+		>;
+	};
+
 	pinctrl_usdhc3: usdhc3grp {
 		fsl,pins =3D <
 			MX7D_PAD_SD3_CMD__SD3_CMD		0x59
--=20
2.22.0

