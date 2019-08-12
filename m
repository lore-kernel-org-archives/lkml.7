Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0870C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 956232085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="BeXViv0W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbfHLOWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:22:21 -0400
Received: from mail-eopbgr150103.outbound.protection.outlook.com ([40.107.15.103]:19221
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728956AbfHLOWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:22:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzJMiJ0TA6/WIotfTqK6ggqn63X7qPt7J8fRMcO51YgN7oJy5/Hze6jJ6rAqelPH7KI10mgx4TTBObc44dx2rWSw7jouTVn/IWtPT6F3mvAPVVl9Q9gDZvwHzQPmaOdABQ9Z0ui4Pot4S+KPOScRmWkE7Phqfzc0XhsXi1TVLXnrCrXc1AbCMmuwU6Gfqt7fOba5qSfWI/Oq12JTT8o/RFzIPshEkzAyhM4BLcHG1wah+D6uWyAFhsCxgus62vjIqrGn1Qjpm3PepIws20b0T8oR8gzkBRj3k+DvF4vWAzU/HJwEZs5T6F/UAp6OwcCz3F+FrjwNsp6Y9N74J6H4Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmMFf1xaDiXn9Xp9+Hwbl4j2YgT87jCUPpFjYuJi/Hg=;
 b=CmfLKfjStx7a3RbQCYzKfbZ8dv3TSt4sqheM3d0S/5oWE13Bb5X6BXa+Y2g98QtJa41f9CB3DIsutxYPw5/JaUDlgeovoogUPpAhJcOAKaVzoFVzkqmKTKPegq+Fo8+Wpb6jx7sT32zCjVhhxJsMfs/pYAwupi+S4YauLZvI4lKsvPKEtKAxbrxxXiQ3uDMrnRrV/mRREieg5JPPnJ6t9uff3z4lne2jEeS1J0Lmlrqj2Mu6GuBUPvfVdvhRZTh3+8D6LEJOtRhTzv00BnLLLGC6qm+EEx1AHZIY47h9AnAHBwbPAT7HOeUN768pC+ri0AiMIBfQi2MB4AX0hv3pPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmMFf1xaDiXn9Xp9+Hwbl4j2YgT87jCUPpFjYuJi/Hg=;
 b=BeXViv0WWVvecUASh7htFSnqW3879oB/o4wRN63zm7NzuJdh7HpdevLBKi+Z1wvfqR4wyndQaM9aZwAulwukuhE9VHUwITMpwLMjmm2hDiyLLyme+M0pBO3vm++yeh/9pkB8/X7OTvTdAzUfBRlbcXuhyELZYegQZghjtkhxVQI=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB2942.eurprd05.prod.outlook.com (10.175.26.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.21; Mon, 12 Aug 2019 14:21:45 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 14:21:45 +0000
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
Subject: [PATCH v4 20/21] ARM: dts: imx7-colibri: Add UHS support to eval
 board
Thread-Topic: [PATCH v4 20/21] ARM: dts: imx7-colibri: Add UHS support to eval
 board
Thread-Index: AQHVURlFnRbeofYGyEy6mLRVDRVbVA==
Date:   Mon, 12 Aug 2019 14:21:45 +0000
Message-ID: <20190812142105.1995-21-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: 61fc014c-99a9-412e-0c88-08d71f3067c2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB2942;
x-ms-traffictypediagnostic: VI1PR0502MB2942:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB294207B36F196D8456F4927FF4D30@VI1PR0502MB2942.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:196;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(1496009)(376002)(136003)(39850400004)(346002)(366004)(396003)(199004)(189003)(5660300002)(54906003)(110136005)(316002)(478600001)(6486002)(86362001)(2201001)(66066001)(53936002)(6116002)(1076003)(3846002)(2906002)(4326008)(25786009)(66446008)(64756008)(66556008)(66946007)(66476007)(6436002)(8676002)(11346002)(476003)(2616005)(446003)(256004)(81166006)(81156014)(2501003)(44832011)(6512007)(14444005)(486006)(50226002)(71200400001)(71190400001)(7416002)(8936002)(36756003)(52116002)(7736002)(305945005)(99286004)(102836004)(386003)(14454004)(76176011)(186003)(6506007)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2942;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y/xOGY+sgTByHy+63+BRMGkxkiLYVz9hKGtVh9/ULH/xFojDGXfcrsXlVCRcgb9WA3KNLztvHdQ9ovm7oOKYSj6FrD46RbG5/vn0EP7cHJZuIe2xn7FYByEYD9ut+Bh5carUGQphkP4gOuURhPR84HuS+mU8dQCxssMjGD5kVm44Bh7VFL/VNxYzwo/ZDMR//0yXg2GHRnATCOV8A0RYgShO+QPQWepsJ/tsETXZDUUN+Of2qI5l9JudCNLZvcEK0t9wKSXaRTq8Mq7GlI0OHhSBCoKSect1emgUSTd47sJxj6fZiYWER2fgxvuryloidq/nJcuUZCgNtUGqRsBzLxfzmdRy5ZoVxiChZ/9ulTWp1EaOQDbSj0GGdbgOl9DBxxXHPLijKWnvXhn/TrxUuQyyhvqNFRbq2jVeRFJ+Mxg=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61fc014c-99a9-412e-0c88-08d71f3067c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 14:21:45.8144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W0U8NWRNlQ12ehnFdsvyvLKIdlST48lxQeq5RHQ9ccl2Xtlp4hunP8DDpxJ/wVV8FeEByVSnYTL4FkUy6mSLEj/mycbJ5oLWHyxM6IAznU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2942
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds UHS capability to Toradex Eval Boards

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

Changes in v4: None
Changes in v3:
- New patch to make use of ARM: dts: imx7-colibri: fix 1.8V/UHS support

Changes in v2: None

 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dt=
s/imx7-colibri-eval-v3.dtsi
index 576dec9ff81c..90121fbe561f 100644
--- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
@@ -210,9 +210,16 @@
 };
=20
 &usdhc1 {
-	keep-power-in-suspend;
-	wakeup-source;
+	pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 =3D <&pinctrl_usdhc1 &pinctrl_cd_usdhc1>;
+	pinctrl-1 =3D <&pinctrl_usdhc1_100mhz &pinctrl_cd_usdhc1>;
+	pinctrl-2 =3D <&pinctrl_usdhc1_200mhz &pinctrl_cd_usdhc1>;
 	vmmc-supply =3D <&reg_3v3>;
+	vqmmc-supply =3D <&reg_LDO2>;
+	cd-gpios =3D <&gpio1 0 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	enable-sdio-wakeup;
+	keep-power-in-suspend;
 	status =3D "okay";
 };
=20
--=20
2.22.0

