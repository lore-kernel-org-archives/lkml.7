Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23160C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C002070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dojujl1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731156AbfCZGw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:52:28 -0400
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:46966
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726171AbfCZGw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyZHZOEwDELPYBt29hYSlHrJ4AT6jlkGGzKJmBM/4TA=;
 b=Dojujl1f201r9ww/nPmjnyAKNV3uNk8f+KdRxOgU59lypVTXffkWQyIzSXkinin9lPPEq+w5RIKv3M/Xr3O8DYjLvNpPiFcZaVeGtg9eCAnHeKfvuxPs1rCqowTIcELX1w6WOHpLCb6SWYh6vWq4jhJ1gDrHewa/Q7o8j/xF2+Y=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3675.eurprd04.prod.outlook.com (52.134.69.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Tue, 26 Mar 2019 06:52:24 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%7]) with mapi id 15.20.1730.019; Tue, 26 Mar 2019
 06:52:24 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V10 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
Thread-Topic: [PATCH V10 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
Thread-Index: AQHU46B3InSwK5isrE2PY/hGaO1igA==
Date:   Tue, 26 Mar 2019 06:52:23 +0000
Message-ID: <1553582817-29519-2-git-send-email-Anson.Huang@nxp.com>
References: <1553582817-29519-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1553582817-29519-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:203:36::20) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 829c11df-f051-4f11-6381-08d6b1b799b2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3675;
x-ms-traffictypediagnostic: DB3PR0402MB3675:
x-microsoft-antispam-prvs: <DB3PR0402MB36750846231CAB4EB6BDE2F1F55F0@DB3PR0402MB3675.eurprd04.prod.outlook.com>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(396003)(366004)(346002)(199004)(189003)(66066001)(486006)(105586002)(186003)(2616005)(68736007)(11346002)(446003)(2906002)(50226002)(6486002)(71190400001)(2501003)(6436002)(256004)(81166006)(8676002)(81156014)(97736004)(106356001)(476003)(14444005)(53936002)(71200400001)(26005)(6512007)(316002)(99286004)(305945005)(6116002)(6506007)(25786009)(386003)(86362001)(2201001)(7736002)(52116002)(478600001)(76176011)(4326008)(14454004)(7416002)(5660300002)(102836004)(8936002)(3846002)(36756003)(110136005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3675;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lPAChHToaSRmw55aKf7DaU6GQaaIcFLrEpNydSJo6vBA+AMqxY6BMdnhvK9rAeqtWJDCyym8vezIcaK40PM9IFblGwm0PlgEqYVjwT9MOcvIpw3msCd7+DTC/21ZBs+r04bLO+8PX12yTAVzHFykWcYxyP+lufhfTy4AqNxR4VN8xtO0/reHg8HQ1UzxC2STAYDMLlnbjbqL2/t1UQtNwN0owrnAeHyi1vZDy7ykvCzGbAHZIlgfIcUoWzrfU/orOyPkl4B2AnOiVfmWorwyShwODl1CTCK1Q+z+eeAwv3aQ2kIpSnt3YrQ3N6AqDxNlQcHL3oO7yECS9ph9x0gbgzVYQzuWWiczYD30xOT6LK0sdhqZlux4HTJ0a4fmCrA8ti52q2UkROW3IhF5UK/x1D7PMR/w0YMeGYgK+JyXQa4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 829c11df-f051-4f11-6381-08d6b1b799b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 06:52:23.9293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3675
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX TPM(Low Power Timer/Pulse Width Modulation Module) PWM binding.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V9:
	- update compatible to contain SoC name;
	- update example;
---
 .../devicetree/bindings/pwm/imx-tpm-pwm.txt        | 22 ++++++++++++++++++=
++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt b/Docume=
ntation/devicetree/bindings/pwm/imx-tpm-pwm.txt
new file mode 100644
index 0000000..e9cc199
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
@@ -0,0 +1,22 @@
+Freescale i.MX TPM PWM controller
+
+Required properties:
+- compatible : Should be "fsl,imx7ulp-pwm".
+- reg: Physical base address and length of the controller's registers.
+- #pwm-cells: Should be 3. See pwm.txt in this directory for a description=
 of the cells format.
+- clocks : The clock provided by the SoC to drive the PWM.
+- interrupts: The interrupt for the PWM controller.
+
+Note: The TPM counter and period counter are shared between multiple chann=
els, so all channels
+should use same period setting.
+
+Example:
+
+tpm4: pwm@40250000 {
+	compatible =3D "fsl,imx7ulp-pwm";
+	reg =3D <0x40250000 0x1000>;
+	assigned-clocks =3D <&pcc2 IMX7ULP_CLK_LPTPM4>;
+	assigned-clock-parents =3D <&scg1 IMX7ULP_CLK_SOSC_BUS_CLK>;
+	clocks =3D <&pcc2 IMX7ULP_CLK_LPTPM4>;
+	#pwm-cells =3D <3>;
+};
--=20
2.7.4

