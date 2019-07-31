Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15039C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2EF8206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="Hl9MtaBJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfGaMjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:39:24 -0400
Received: from mail-eopbgr50127.outbound.protection.outlook.com ([40.107.5.127]:9865
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387725AbfGaMiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:38:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzbAxSIbAHelfw4pPXzY2n4xEdmZcWXI2kvntlZJEf9ZYHLqYZY8xb7kAxT6wo6nG4+NJffiiwOCF3F0h5/uOYjuTSX9BZvoyQA9FV6SgDdK7RVpcRTTf2bPT5UQjoWe7cBQ/aocoUDuK1A6sbwk/ZjKBFzfcDl/Z5eUl39gL3ibgNgXrejcAKiji/w9hfScmVHf9DtsDKx5BtxQAyTVEjMcje3HSVSqGpvkNcZWxiPAd0jV02zmm7OJYWeAgKkIigVi3MUjHPYDicHpCCmeSvjSug3nMPGRZ5RlZTr4FLL9F/0fTTsRUksZQgOe9M7zk+amc3VPO1uwkR1PaMP6tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6Is0ZHuQm99/e07O/29KmuMQ6hfh1KsXCyEaIojWLI=;
 b=cgDeG4cmxVzJ3x/oi4/xcixd5zlvSDIV5S9UnFQWO5qMUW+HMOeMthrQriysUE833NwRvf44DwQAiqhtho8hSB1jAs8TaMRY26yvKSL8AOARvPULZTWeRlel3ukHHDwQw2avVedgrq7PiUsP7kdJ+DlUo3plsLt/jLJTe+m3pCQbxnOBaVpxdnzjtju7BBNeo0wXfK6IEnm3XZuYO6Yvyd61gvI+8p8WoLrmpQfGFgVMLxt4mZg5/iGYIL4IO1nK6bqMPypZEdXsL5ezIkO+4P5brZ7ePa4rFZZ4RCJRibh1k68IgBioFiHUlXsR2ykB24e4xp3MMp8T8FOUmDRXnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6Is0ZHuQm99/e07O/29KmuMQ6hfh1KsXCyEaIojWLI=;
 b=Hl9MtaBJLAJFppIcmSDeaVHKws5A2npyyh9Dcv0+TvIjrbJsnjRaDLQaBLD9Dx56NBvFYYiiWwrmRcqnX0hubucAzm0BldiTUkWNJtbFIQWDR+xxQuGoyZqS1a6RVvk+7yuiShY6gSCF/76cxEonVd7VrQklW+Sg3fVOs+C+Yzk=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3615.eurprd05.prod.outlook.com (52.134.7.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 12:38:16 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 12:38:16 +0000
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
Subject: [PATCH v2 09/20] ARM: dts: imx6qdl-colibri: add phy to fec
Thread-Topic: [PATCH v2 09/20] ARM: dts: imx6qdl-colibri: add phy to fec
Thread-Index: AQHVR5zTjHhGAQEKAU+Uj0vLYqGX6Q==
Date:   Wed, 31 Jul 2019 12:38:16 +0000
Message-ID: <20190731123750.25670-10-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: bd1631d4-6cb6-41de-575e-08d715b3f593
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3615;
x-ms-traffictypediagnostic: VI1PR0502MB3615:
x-microsoft-antispam-prvs: <VI1PR0502MB36154C6BFC13E2695ADC6F9AF4DF0@VI1PR0502MB3615.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:632;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(376002)(136003)(396003)(366004)(346002)(199004)(189003)(66946007)(52116002)(66446008)(64756008)(66556008)(66476007)(76176011)(4744005)(99286004)(53936002)(6512007)(6436002)(5660300002)(4326008)(7416002)(66066001)(6486002)(25786009)(478600001)(14454004)(7736002)(305945005)(71190400001)(71200400001)(3846002)(6116002)(36756003)(2501003)(68736007)(2906002)(2201001)(44832011)(486006)(476003)(86362001)(446003)(2616005)(11346002)(256004)(186003)(81166006)(81156014)(26005)(102836004)(50226002)(8936002)(8676002)(6506007)(386003)(316002)(54906003)(110136005)(1076003)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3615;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /dvq8Rto64PBSxLdJ4ZRQQaL5pYib3vzOTy15E5CChU8m57/Sh4Rjx98q9eINtKVdwcEhLhUrLdT90E2Pd39Z3JFO43H3/3uZmHF5SSnzxzxnrXOKHPpy5nHhRQJ6y26d8zOE2tg+gC/9riUumpGJn7Ludg/3zRHrMU9l9TnLZyqXy140k2h5A0wdX98ll2eK0qF89i0lwIfpHccvfBELR9sp5YaEHYkffzwABoNWzwuLdH0qX1/f3swlL5l8a26WP+gKe1ZtkTk5uK/4ylz0qajFbk+agGJaNDSksAoAKbabsfZDHm2Iom2NEEgnbUmBaAdHucGRfFhQos78KjIhw8JKa7IEX5viabUyU+mSwBLQA4SANuuhBJaAS1rI4eFYa2CQZ5vYOAjDYQNIDpFqSf8WgzeQAqYidR16FwTtMQ=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd1631d4-6cb6-41de-575e-08d715b3f593
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 12:38:16.2336
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

Add the phy-node and mdio bus to the fec-node, represented as is on
hardware.
This commit includes micrel,led-mode that is set to the default
value, prepared for someone who wants to change this.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

Changes in v2: None

 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx=
6qdl-colibri.dtsi
index 1beac22266ed..019dda6b88ad 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -140,7 +140,18 @@
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&pinctrl_enet>;
 	phy-mode =3D "rmii";
+	phy-handle =3D <&ethphy>;
 	status =3D "okay";
+
+	mdio {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
+		ethphy: ethernet-phy@0 {
+			reg =3D <0>;
+			micrel,led-mode =3D <0>;
+		};
+	};
 };
=20
 &hdmi {
--=20
2.22.0

