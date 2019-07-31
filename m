Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0CEC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F6A208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="dq8VajXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbfGaMiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:38:46 -0400
Received: from mail-eopbgr00137.outbound.protection.outlook.com ([40.107.0.137]:9952
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728174AbfGaMig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:38:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmnFLvIXruYLAPfFyXbGg5k8+YodgXRFfqS5alsKeLzcFdmrn4jwOa230ffVhYjo9hnscN0ouakSid61lEC/A6H4uRbcO9weXbAo81ltzs85Cl9tnIXnBGz18kvMBG8fk8kuSwTpF9+zLcNMjXBak8DRPYpPqu6debOxEnxSNQbWm1UsLQJgmdZ46QHKH6B0nKlxxnf8zBhAsCiTweVVqk0sgDj3P3qCt7z91Ku5/L8AcZYQ2G+clsxGS55A6a8mAym+q7evgHsM9ihJHwD9rpeS6JaBVS68FgUXB6WsrEkSODkUcEm8Y897//47w7y5w2JdeX8lSorjbwt9Ok+oZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbEFXW0sQlwLe/4LYrToOgll4qeOMA5rm+TCeLTJO0Y=;
 b=UHsvhJjRCeUcDGQiL3sKxPhtOgATXHE8O4J6/T7tgF+b4mhimohFxsbgPLJuiGvv9I/csxrTPjU1GFEzL/NibskzfjCBXi+VrEa2c9QR+wgbWrwsKzhoawoYfPrs0u4U8T+VdT+JWLoqkJBpKvFu2kfkIzCdKAvSVrPCV5+5rhnBQvOoN1ZoYXCUWnUZebh/BImxnxumJnUChLh+uxdXbYDYZa4AFYUWZ1ZnGeLTBVeTEmXrR43SfcVab3tGz5piByEMuDBSmtHBX/5/LuRbHki6iFLVIVZxJC12hG+om0bxsFOD0QbeyadUfD6kJKfXtIKztWBHlT0E2lL7ibgU/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbEFXW0sQlwLe/4LYrToOgll4qeOMA5rm+TCeLTJO0Y=;
 b=dq8VajXGRshATrUR3u4/EB+q+5vot/5gVSsQztcrGsRAdwKWUvZlJQ9aWvH2wo+ecSB/pj+gGJBJzfoS0mRVLrc4t7drlr+WveVlSDVnK7pV6/42ad73uG529y9YnxuDNeCxSVAfPsGEE8bTLsVhKbMoL27OUXWql648E+FFxyk=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3615.eurprd05.prod.outlook.com (52.134.7.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 12:38:33 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 12:38:33 +0000
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
Subject: [PATCH v2 18/20] ARM: dts: imx6ull-colibri: Add general wakeup key
 used on Colibri
Thread-Topic: [PATCH v2 18/20] ARM: dts: imx6ull-colibri: Add general wakeup
 key used on Colibri
Thread-Index: AQHVR5zc40ILf8FEYkSqHnnZaYq9tQ==
Date:   Wed, 31 Jul 2019 12:38:31 +0000
Message-ID: <20190731123750.25670-19-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: 042c47cd-d31b-477d-f69d-08d715b3fee7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3615;
x-ms-traffictypediagnostic: VI1PR0502MB3615:
x-microsoft-antispam-prvs: <VI1PR0502MB361550724871F860B2CA8AE4F4DF0@VI1PR0502MB3615.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(4636009)(39850400004)(376002)(136003)(396003)(366004)(346002)(199004)(189003)(66946007)(52116002)(66446008)(64756008)(66556008)(66476007)(76176011)(4744005)(99286004)(53936002)(6512007)(6436002)(5660300002)(4326008)(7416002)(66066001)(6486002)(25786009)(478600001)(14454004)(7736002)(305945005)(71190400001)(71200400001)(3846002)(6116002)(36756003)(2501003)(68736007)(2906002)(2201001)(44832011)(486006)(476003)(86362001)(446003)(2616005)(11346002)(256004)(186003)(81166006)(81156014)(26005)(102836004)(50226002)(8936002)(8676002)(6506007)(386003)(316002)(54906003)(110136005)(1076003)(32563001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3615;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Qcw8rR/lu4ex7ya1/Zm668/mQC2DpNMxp2na8QeWUVtkRRrshS8psrIatLnrOtogHkvVTCL0spoBVrsN/GrOGf1Pm2Vv08JgSMHWzrARFWMzqsFWuItpryF4W91KzSpHBfr6l9SEFA2gPz72qRyscAidZ2bN2j85uG7c8SQFSTQAT1lScKu4cUzJI8wkU3yGvY5oK6sLMdGsBh4V/Km6wBhmlioekz5P/66ljA7eA2vvdu+76I33Hb/w8n8EWODLTwRx3I4o2Xp/+Wsb1zxdXiMgYkdRqFX2PiBl2fWcVWsJRaFH+K564568QXq2h2y+/578pv4W5X193AY3RPhVDoVG61Z2Z6NUKwT0iGisA/xizsQ18VDi7b5mwoj0U1IzHhMAMU1Hhr7tYjsMbpLCWLMEEqHF+XLCi8WtR4lCFZ8=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 042c47cd-d31b-477d-f69d-08d715b3fee7
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 12:38:31.8167
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

This adds the possibility to wake the module with an external signal
as defined in the Colibri standard

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

Changes in v2: None

 arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi b/arch/arm/boot=
/dts/imx6ull-colibri-eval-v3.dtsi
index 3bee37c75aa6..d3c4809f140e 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
@@ -8,6 +8,20 @@
 		stdout-path =3D "serial0:115200n8";
 	};
=20
+	gpio-keys {
+		compatible =3D "gpio-keys";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_snvs_gpiokeys>;
+
+		power {
+			label =3D "Wake-Up";
+			gpios =3D <&gpio5 1 GPIO_ACTIVE_HIGH>;
+			linux,code =3D <KEY_WAKEUP>;
+			debounce-interval =3D <10>;
+			wakeup-source;
+		};
+	};
+
 	/* fixed crystal dedicated to mcp2515 */
 	clk16m: clk16m {
 		compatible =3D "fixed-clock";
--=20
2.22.0

