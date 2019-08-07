Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FDCC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F6D217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="vnEZMCaS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387715AbfHGI0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 04:26:47 -0400
Received: from mail-eopbgr00133.outbound.protection.outlook.com ([40.107.0.133]:13121
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387671AbfHGI0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 04:26:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgiDJq5Bb2Hq2RiU/cE2AhftzWXoPaM5SJdSlF75u/mVhKrHAEtg/mH+ZA72LecGTj3le7biRAC600Z5uStYa30MuwBopAHuz40vjNCY79LCHoheU+CGUDXzt4wj0oW60BwLMKvdHMLm7LKpdE7GF+l1k/PDVSC3VNE4snFKB0IpTQspvXJf3sw+0B5IJULDTjIXdr8tNyWc/rrlQXvsOqgEoQI0i2vYNDbi6acXqi9XZiLwK5mMPN8TMNCIGJdcFGmt9WiilBFYHfoIuTCOojx4vzQTMBEGWB8Zde1DyKqmnJWCTnH+FzKBup8VMMFjKYJiP6pOWHU2ZRpHQGn+/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSYA2XMw0c4cos/mKQV6N6hSv6gQv5QcoovapsN0f1U=;
 b=cO3VwTX5Eniq1+BvOjCmZO4uBpdc1io92sEn8/aNWjSfKPI86eZLrUYFX5IJD95TxKeHuhDWjkrxCRUPlSBNNOcXwbeCguSavdOpp4qFA4m0XQ2SVvJW/1X8czSTGlBe+rZoMGxZMnpXRX58GU0PG2I+/tBbilfzyWZqL3rsAgQ3vtPog2jIKCfTmjXark2y2+dHiLWKjFrnSG0YVg5/zUnUNixBVD6G090ViHERsc9xD+cGYPc/Y4p1VWDwx1E2UXZOkJ0NltrSuQoXSbTSPeLp90idhYFVHyNILZFINvm3Yxy6Wb2f9lcz96ZUwWvFPaqfOFy6TpibTsvdielk7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSYA2XMw0c4cos/mKQV6N6hSv6gQv5QcoovapsN0f1U=;
 b=vnEZMCaSIXaNTO1fRreiwiff2XWmiyU+T3u7wiwFOMwHsX+G8u3bVcRM62bS0l9+Lfq0Hl31GS6ELtAa8r9n4sogD6NCZPWqrSoOzHe+lLz3BbLN4qn9HhRtQqPZkHPSDZ8fpHlV52l6uCBfnFZQa22kySd4b7V3UDFLrFD/df4=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB2928.eurprd05.prod.outlook.com (10.175.25.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Wed, 7 Aug 2019 08:26:36 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.015; Wed, 7 Aug 2019
 08:26:36 +0000
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
Subject: [PATCH v3 15/21] ARM: dts: imx6ull-colibri: reduce v_batt current in
 power off
Thread-Topic: [PATCH v3 15/21] ARM: dts: imx6ull-colibri: reduce v_batt
 current in power off
Thread-Index: AQHVTPnTcZ2VbS3AV0aYQR70nLfXBg==
Date:   Wed, 7 Aug 2019 08:26:36 +0000
Message-ID: <20190807082556.5013-16-philippe.schenker@toradex.com>
References: <20190807082556.5013-1-philippe.schenker@toradex.com>
In-Reply-To: <20190807082556.5013-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR0101CA0044.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::12) To VI1PR0502MB3965.eurprd05.prod.outlook.com
 (2603:10a6:803:23::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9adc53c-4d3a-4738-d4ec-08d71b10f623
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB2928;
x-ms-traffictypediagnostic: VI1PR0502MB2928:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB2928C64B1A65C549529BDBC3F4D40@VI1PR0502MB2928.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(366004)(396003)(346002)(136003)(376002)(199004)(189003)(64756008)(66556008)(66476007)(66946007)(36756003)(11346002)(476003)(6436002)(76176011)(2906002)(316002)(305945005)(2616005)(66446008)(1076003)(54906003)(110136005)(68736007)(486006)(14454004)(5660300002)(446003)(256004)(86362001)(44832011)(50226002)(4326008)(66066001)(53936002)(6486002)(186003)(8676002)(26005)(71200400001)(99286004)(6512007)(2501003)(2201001)(71190400001)(102836004)(386003)(8936002)(6506007)(478600001)(7736002)(7416002)(52116002)(3846002)(81156014)(81166006)(6116002)(25786009)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2928;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MHfgNSzYH6vdebE0kRO0SXv8M6sLs3SyoEnLctAYSi1OyMncDubHUQbbC218iKD7i6La52aTB5cRyMX4eI3BEcbQtxjy5pWjAyuagvEiNCqFEjU+lsBeA7m1xbFc6UGkI6Cg/KeCq1+6EVQxE8lvC+SwEFRRP/E2PFnxqgpTfQIq74MjPGrcCMf7HwsKWZn8WwVOg95DLZZiRHqdBnh150Df8tWcx7GDz1CSXpxgBvqTF/asRDtdmBmrN4igAZ7GGZj1hOjjQhKbswZVrIeUE1Oad8Q7vDZCkdZxssNh1XwAruaOfGHkr9H6AtglXmgEzz1Vs2QbJxhGbFhGOUtFhbreyuc8aVopiccXjYiQ5Zhw2oQ5cDhYrB1TutxCDNXxGSPJ1CLoIsLBc2tHdUHF8KCAoF1wFDdvIAFQBZWrDrk=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9adc53c-4d3a-4738-d4ec-08d71b10f623
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 08:26:36.1073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sO+VGzFbH17U2NSDzdYj1EFUlpPzK86VPKIxOvRQpGZewIUV20B5SQWP44l5sSnwa5sVPqTGpfAoS6wrRwhEdjtL2aItlc8bLdWePdSs+WA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2928
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Krummenacher <max.krummenacher@toradex.com>

Reduce the current drawn from VCC_BATT when the main power on the 3V3
pins to the module are switched off.

This switches off SoC internal pull resistors which are provided on the
module for TAMPER7 and TAMPER9 SoC pin and switches on a pull down
instead of a pullup for the USBC_DET module pin (TAMPER2).

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/imx6ull-colibri.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx=
6ull-colibri.dtsi
index 1019ce69a242..1f112ec55e5c 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -533,19 +533,19 @@
=20
 	pinctrl_snvs_ad7879_int: snvs-ad7879-int-grp { /* TOUCH Interrupt */
 		fsl,pins =3D <
-			MX6ULL_PAD_SNVS_TAMPER7__GPIO5_IO07	0x1b0b0
+			MX6ULL_PAD_SNVS_TAMPER7__GPIO5_IO07	0x100b0
 		>;
 	};
=20
 	pinctrl_snvs_reg_sd: snvs-reg-sd-grp {
 		fsl,pins =3D <
-			MX6ULL_PAD_SNVS_TAMPER9__GPIO5_IO09	0x4001b8b0
+			MX6ULL_PAD_SNVS_TAMPER9__GPIO5_IO09	0x400100b0
 		>;
 	};
=20
 	pinctrl_snvs_usbc_det: snvs-usbc-det-grp {
 		fsl,pins =3D <
-			MX6ULL_PAD_SNVS_TAMPER2__GPIO5_IO02	0x1b0b0
+			MX6ULL_PAD_SNVS_TAMPER2__GPIO5_IO02	0x130b0
 		>;
 	};
=20
--=20
2.22.0

