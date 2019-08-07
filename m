Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC22C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BEE5229FA
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="HMpZMlJ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387660AbfHGI0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 04:26:39 -0400
Received: from mail-eopbgr00098.outbound.protection.outlook.com ([40.107.0.98]:5766
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387594AbfHGI0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 04:26:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFyXJjUykdIAondpduJ1YfzoEDKI6JweFJwUVI4wAdCNB8wg9ESwDIys6uspicgRk14GNcJkKcIm1EicvWlJb1sDdtmQs+D5uMHUd/O6BJC211yB8ScvzxFtKuVAmfsHpqJndQBCjq2Mp3tMeRchel9xCJGNWU6CttXokthAxUobihhVgL8Ji85AtRcOmxGmEynOukDNoIo+wZHFGkiqW95eMENON1Ds6Ur4yw7GlLDOTeRtIQDvaBEE1U8cFhe/4DKlzHNj8GxL3r+JFCo2e2iwFnSP4qAFYGnDVAvJDVV5KQ/9mgoL/cES3LEA5JE6VoEs86jlWedzjvMo91uqOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRHA/4DWWpMzbzsnuCoO49iVV/7Uc8G722X7bew4G60=;
 b=Np1NFd/0beXhlUGYcWBQK9nawQXuKQI05wzd5WV60+TMe7DZHKzVAb3DvYtuBRJ+IstUjum+8p0UshotI7XOK4KlsSW5EG1uNUNYtWWdwOpmmfVUxLjEsaEHVDVYKtK6sgRhSbP27p7LLfucrWSj/yT29YweLKMvZaB+UO82dRIeqPnYdew+mRiwSjBUeKj31ekOzJDddIIHpyMZfUU0dcbwpN0u2kc1UGdqKk5rLKAuYJ+PGE/PiLTidYDC1l8BAJwguy4hYpWIBHOEPTfgQgnd82zdGo3vH0nG4HxS70hRruKuUHGumIhBMUKG3CjQ6IJDbNiUKKYJbCS0GajUgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRHA/4DWWpMzbzsnuCoO49iVV/7Uc8G722X7bew4G60=;
 b=HMpZMlJ1psNfqoPW6U6824EDLvZyNtVnKdR80am8x3s9Q4mAOd56aAo93xgY1BzkvOtdWXOl7JLLDgFgRvMBUuisoXdCXfGUo4bpDqiW+CPlSRNXEv9y6pgsTwXF26ZmPTkHQ2RFtM4RYGbGXCODRlKU1etUL8xMP16EtsJMrDw=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB2928.eurprd05.prod.outlook.com (10.175.25.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Wed, 7 Aug 2019 08:26:32 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.015; Wed, 7 Aug 2019
 08:26:32 +0000
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
Subject: [PATCH v3 13/21] ARM: dts: imx6-colibri: Add missing pinmuxing to
 Toradex eval board
Thread-Topic: [PATCH v3 13/21] ARM: dts: imx6-colibri: Add missing pinmuxing
 to Toradex eval board
Thread-Index: AQHVTPnR2GTzah1aRkKyh9gFtK2n0w==
Date:   Wed, 7 Aug 2019 08:26:32 +0000
Message-ID: <20190807082556.5013-14-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: 181154b5-8f9c-4eb1-d4c6-08d71b10f3fe
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB2928;
x-ms-traffictypediagnostic: VI1PR0502MB2928:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB2928F3B052692F885678F80AF4D40@VI1PR0502MB2928.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(366004)(396003)(346002)(136003)(376002)(199004)(189003)(64756008)(66556008)(66476007)(66946007)(36756003)(11346002)(476003)(6436002)(76176011)(2906002)(316002)(305945005)(2616005)(66446008)(1076003)(54906003)(110136005)(68736007)(486006)(14454004)(5660300002)(446003)(256004)(4744005)(86362001)(44832011)(50226002)(4326008)(66066001)(53936002)(6486002)(186003)(8676002)(26005)(71200400001)(99286004)(6512007)(2501003)(2201001)(71190400001)(102836004)(386003)(8936002)(6506007)(478600001)(7736002)(7416002)(52116002)(3846002)(81156014)(81166006)(6116002)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2928;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: W82j5wLwHwW2ufpLHKudU+GU92fsD/5SpDTQg98aKPmnFpqJDZddbadKBQQmj/GjRfEPpyTnKXP0iThwInRcpa/ktMCYvs7Fi3uZE/TGeJHhxBAjq8myyLo2kzv5mQbW9o/ioC13OuQNN1nWeQtLrORARQlnAWu58pKNsURwlYo1RtCPj5A7WIaVBCeF77mxxDt5UCWFcRf/xMTZXI4yFF8HlmN36g2Ncwh9Qe2Iq7BkjykKigvIAUtcJKPjEo8uTEI+40Qp6nWuSGVRAKBR6BOgX3l3bB83ttpAK+FapyHE2XA9FvHQj6yPHSaTO7q9G7kKUp+D+ObikNUFDaP+nRI39JkOL+HH/8pP539SIcE5PY5zKZw9EEqyWzswNqQz5DUG84SZatZyOOp2LpGtOtX/GwIK+zE5itJwDMIf7cI=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 181154b5-8f9c-4eb1-d4c6-08d71b10f3fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 08:26:32.5893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oS2V2L8HTTKMhSuUzGZK31AC33YQ13l5G1gjmzrHgu5jSKIGnUyb+cmWG/sJx/yvygqgR53Sx+Cmtf6aJqi68kGPwvQxOOjOsdwHgZaEmhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2928
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds some missing pinmuxing that is in the colibri
standard to the dts.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

Changes in v3: None
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

