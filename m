Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5C7C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C08E208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="Mjwnu5Nt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387858AbfGaMit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:38:49 -0400
Received: from mail-eopbgr140114.outbound.protection.outlook.com ([40.107.14.114]:6722
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728169AbfGaMig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:38:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPJ5FvebPLAjXGMY4W7r4n1F52sxHJG/+poPkqKwhg+J01RS7aUFxzGdRD3vyZnN+GmAiEmXhHhJU00dSGe+PPD6eg/9cuwu8vqrR85t0URaKh9cdhF7f0Az/vWm050wyLkVg7/CycsVLnLhA82jIdQzX3JOYwyQKBhdcbfawtBC5boj0CAZoxwk6H6o7/Q1vILif22T09K44HasHgSbZDdbPqzxC5ZeWi7QeCjXBcyYkh7PDYXfgEXQ6Tjj0s/WIF4VkICK+EDzbICo3c0wCIDeUtYpDMsSO6m7typ7AkNvsSzlGQnjI7Pn6HBYWYxOBJV6OQY7ez0gRw54+gvfpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKdVqV/SWA672uR0Bgwf3uHyZ+iYlbFbfC1zpSnbmaE=;
 b=TEZvYjA19w18PQIB+icsGZujDkUyDJZiGENvnEdT8vxkyo95SEbEIdJHn8qrMmbcX+KO/NKrBi+qYZXgyIkQr3WQDCUvCIDJqjk1TtoHbwyqcs0tTPitFzI7yf+GJCsW3G21Mpj5lEZG/AFSGzk55WgfDq031m+jhuV41CBgJHHAYQXZKUq4KoHiVGRMzc/vJMXruxKZMFB4gD3NLwcBFPmwt51Kn05yH+lGV6IvFd547Pe77MWo7u33Qn1fTqkNRNl2stkaBbYfy8sYAZVDOoE0zVbSlGZENciyHynxys+4puCN1aX16Pqy3VWI6feb3ogBHmXIoe6mH1+L2Cd/Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKdVqV/SWA672uR0Bgwf3uHyZ+iYlbFbfC1zpSnbmaE=;
 b=Mjwnu5NtRAggk0GSDdYcFejt0wP6G5tId+OgK61xomPPmI+oQUFuIaV5RReoRD7zroh6rko2POJsDK6XLqAbyuj1IPMQ0/SSEIFZV/M1u8vu8NXi175MJ8wO/IptWxLai+TpHqquomGkK4Oe9R/WAg15BVdUTwLsibg9TWYu8p8=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3648.eurprd05.prod.outlook.com (52.134.7.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Wed, 31 Jul 2019 12:38:31 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 12:38:31 +0000
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
Subject: [PATCH v2 15/20] ARM: dts: imx6ull-colibri: reduce v_batt current in
 power off
Thread-Topic: [PATCH v2 15/20] ARM: dts: imx6ull-colibri: reduce v_batt
 current in power off
Thread-Index: AQHVR5zZQocT+NOJxEesVaMyNOrJ1g==
Date:   Wed, 31 Jul 2019 12:38:27 +0000
Message-ID: <20190731123750.25670-16-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: 9ac0f7dc-fb15-4844-42e7-08d715b3fc15
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0502MB3648;
x-ms-traffictypediagnostic: VI1PR0502MB3648:
x-microsoft-antispam-prvs: <VI1PR0502MB3648F1D242BCC0BC9969B08BF4DF0@VI1PR0502MB3648.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(136003)(346002)(396003)(39850400004)(189003)(199004)(64756008)(66446008)(66476007)(66946007)(6512007)(476003)(66556008)(8676002)(86362001)(36756003)(44832011)(478600001)(6666004)(5660300002)(71190400001)(71200400001)(1076003)(53936002)(6486002)(486006)(6436002)(2201001)(446003)(52116002)(50226002)(11346002)(316002)(99286004)(66066001)(2616005)(305945005)(256004)(26005)(14454004)(102836004)(7736002)(3846002)(25786009)(6116002)(76176011)(2906002)(81156014)(81166006)(68736007)(386003)(6506007)(2501003)(4326008)(8936002)(110136005)(54906003)(186003)(7416002)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3648;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qUtRNuUlYV2PlbOegm7s38Nx+LL9cXyN8Isznmdtfv9wAtFzlVKKumtZ3z/hrxAQiWJNPoKX/eWVjJQPK9SeBOWUjdFtgkb+WQbXIemDJSYWwF2exL6B1CUrI9A4bWOVWcylpz5FM+PJUucKrZfjRK3I6EyO49JMaDa0vL1w4YlZkY4eHR0FeiffjiBoz6+anH6eyTDCM1KAdpMM1gkWuiETzLpgNU2HEilDpZCjP7qdH5Uw+Hepxz46n5+U36LqHiCRH1NNNCLQahhNuiX3NNIKrVqtTL7BuHLJi58mHyqRg7d50K/L9Ww0YaA1HAge1JbiA8Z18ekaEe7HBZFlf/csG3g5MsIxwFqX8D9y5b1Ft5vvHhizrTR+4jOkcGMpM55f18XmVl3r6j7xaM8EfLY8u5uOKSZE10jY2Zr8Egk=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac0f7dc-fb15-4844-42e7-08d715b3fc15
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 12:38:27.0444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: philippe.schenker@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3648
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

