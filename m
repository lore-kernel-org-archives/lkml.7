Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AFCC10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47E721874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dYUz2a8g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfCTFGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 01:06:19 -0400
Received: from mail-eopbgr60043.outbound.protection.outlook.com ([40.107.6.43]:31106
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725980AbfCTFGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 01:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5q8zNBUNNnA2yFpYEt2VbAB/5DnROX4Vfj48OF3UY24=;
 b=dYUz2a8gUuZYbxMK/FNjuc415w+8L7BhINPdIgsGjZBafCFP6gcwcst0m+O1fcfiGq8jQbj+jHkDUb4mizONEKkTrfcIf3tbyqjXTOBdt90N9xUznbpQxb09wILhQj0Kd3MeO8cQ05t4NEwpXwvM2C5gkvaVsarcbzZ85BAoZls=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3945.eurprd04.prod.outlook.com (52.134.65.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Wed, 20 Mar 2019 05:06:15 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%6]) with mapi id 15.20.1709.015; Wed, 20 Mar 2019
 05:06:15 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        "stefan@agner.ch" <stefan@agner.ch>,
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
Subject: [PATCH V7 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
Thread-Topic: [PATCH V7 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
Thread-Index: AQHU3tqkkUJZliWU7EyGsp06PsaJAg==
Date:   Wed, 20 Mar 2019 05:06:15 +0000
Message-ID: <1553058067-18793-2-git-send-email-Anson.Huang@nxp.com>
References: <1553058067-18793-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1553058067-18793-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0067.apcprd04.prod.outlook.com
 (2603:1096:202:15::11) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45b832c3-93c1-4920-20cd-08d6acf1c72c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3945;
x-ms-traffictypediagnostic: DB3PR0402MB3945:
x-microsoft-antispam-prvs: <DB3PR0402MB394546E40EEECC01383B0885F5410@DB3PR0402MB3945.eurprd04.prod.outlook.com>
x-forefront-prvs: 098291215C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(396003)(376002)(346002)(199004)(189003)(105586002)(316002)(2906002)(76176011)(186003)(110136005)(53936002)(6486002)(7736002)(26005)(6506007)(8936002)(106356001)(486006)(86362001)(386003)(476003)(11346002)(102836004)(305945005)(6512007)(8676002)(4326008)(50226002)(81156014)(7416002)(446003)(81166006)(6436002)(36756003)(2201001)(68736007)(2501003)(25786009)(2616005)(5660300002)(6116002)(97736004)(99286004)(71200400001)(66066001)(478600001)(256004)(14454004)(71190400001)(3846002)(52116002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3945;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /Rb/aW/Ja+206IppJUTLU5C/J/1NtJ5DLETvgviLfPh+w/8vG4ybCSuZTBH7Au4bS07aCDHHbaqbf7ipRSu++5EP2INeR46HHRNDmwvAoXIPXTB63aqM+CQJ+Kyn3V8rCXImkLcYE7toOBwRSq7pCvWfpoWb8mHqykUaf5coJqo/9gcs/QnEVz/vPK7w3mEjaPbaFXC5hrh5Iy3l61FuMYPQ5rCBSSldQ3aP+rQAOOCPSf/OlJkpvL6XS2ZrdwIZPJ+Zl3E9/j44imYZMFzhNqXAikUlQEjyj/UJ4OW/x3N/2byEVmN39XPc5UFRBysFCYt9ofpsXCo+ByLcM5JLWsYgNbzKWyZRpJ9kazYez0Ggl/PLVnwW7vDSbbBVbk7L/GumbG1F+xrbkem1rQpInqi9i3fGC9g1PLb5uRbFkGA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b832c3-93c1-4920-20cd-08d6acf1c72c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2019 05:06:15.0629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3945
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX TPM(Low Power Timer/Pulse Width Modulation Module) PWM binding.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes.
---
 .../devicetree/bindings/pwm/imx-tpm-pwm.txt        | 22 ++++++++++++++++++=
++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt b/Docume=
ntation/devicetree/bindings/pwm/imx-tpm-pwm.txt
new file mode 100644
index 0000000..94f1ad5
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
@@ -0,0 +1,22 @@
+Freescale i.MX TPM PWM controller
+
+Required properties:
+- compatible : Should be "fsl,imx-tpm".
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
+pwm0: tpm@40250000 {
+	compatible =3D "fsl,imx-tpm";
+	reg =3D <0x40250000 0x1000>;
+	assigned-clocks =3D <&clks IMX7ULP_CLK_LPTPM4>;
+	assigned-clock-parents =3D <&clks IMX7ULP_CLK_SOSC_BUS_CLK>;
+	clocks =3D <&clks IMX7ULP_CLK_LPTPM4>;
+	#pwm-cells =3D <3>;
+};
--=20
2.7.4

