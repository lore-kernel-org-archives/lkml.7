Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABD0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7362085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wARcDY5q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfCRHlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 03:41:37 -0400
Received: from mail-eopbgr00044.outbound.protection.outlook.com ([40.107.0.44]:57158
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727086AbfCRHlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 03:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKZbQGKmXMprG/U6J+8vXsk40x3k1U4ZvFk+bQ3EPQY=;
 b=wARcDY5qk47L24PLNDoy8C7DnriXLRqVCOr8dafWJ0iHU93DFZOrZE7nLzFC0WpyIfOBZMPDXa+fxV1ZiMGyddPxg6s+DJKbkrvB9FwAZ9gE3WUefYTCseOM1FOJMJrQa2WctZp8mu7j1+xRkUdtEkG3folsAY7l5y817XG1Ank=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3868.eurprd04.prod.outlook.com (52.134.71.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Mon, 18 Mar 2019 07:41:33 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%6]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 07:41:33 +0000
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
        Robin Gong <yibin.gong@nxp.com>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V5 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
Thread-Topic: [PATCH V5 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
Thread-Index: AQHU3V4B0+Op6lebhUq7cDF33YTb6g==
Date:   Mon, 18 Mar 2019 07:41:32 +0000
Message-ID: <1552894581-3391-2-git-send-email-Anson.Huang@nxp.com>
References: <1552894581-3391-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1552894581-3391-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0401CA0011.apcprd04.prod.outlook.com
 (2603:1096:202:2::21) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a776c782-b22e-4459-ae6f-08d6ab75241d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3868;
x-ms-traffictypediagnostic: DB3PR0402MB3868:
x-microsoft-antispam-prvs: <DB3PR0402MB3868818B4A60D57867C70132F5470@DB3PR0402MB3868.eurprd04.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(39860400002)(346002)(376002)(189003)(199004)(386003)(2501003)(5660300002)(2616005)(68736007)(476003)(14454004)(97736004)(7416002)(486006)(11346002)(446003)(71200400001)(71190400001)(26005)(36756003)(25786009)(105586002)(478600001)(106356001)(4326008)(186003)(86362001)(50226002)(81156014)(6436002)(6512007)(8936002)(2906002)(2201001)(66066001)(6486002)(3846002)(6116002)(305945005)(102836004)(7736002)(76176011)(81166006)(53936002)(6506007)(52116002)(8676002)(256004)(316002)(110136005)(99286004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3868;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qNn/ZSc50jUrx5xMUwGJhYoShz0dFvMKj2rH5n5Kv+qUppjb4jWH/PpKiHlj74Ppq4K2lolYvjFgFnigAgpsZaOLfUp+38WtGVFUtfS1U6vNQHzsG8ghF/LnhcJ/kd80yUL/aAHX+6wQAcH3uK2QF6jzD0v9HtmbWkrzRh8FDgwnA7zmKLDImbaBk4m5NJl77YTXvm9bPTLZV2m1Bc1+1VXywL3hAc+XWeJxQuDUklyb68H0WOwlR59mjIETO2Gh71FajLWbQXFSZR4fZqc65iXe6AN4XDz67vVzFU36x/HqnvKurm5is/bkzg4ibDkp5BEfs8HdGuJOO/mbkzTdGnnL3Ya7cZEp9Snp5b0J+18oslW1lr6HiqoCQJ/I75m1recZG83gWkm+QBBHe/rjj9jZ8oZ6t2Nx5ptgzIjimdw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a776c782-b22e-4459-ae6f-08d6ab75241d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 07:41:33.0195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3868
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX TPM(Low Power Timer/Pulse Width Modulation Module) PWM binding.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes.
---
 Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt | 19 +++++++++++++++=
++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt b/Docume=
ntation/devicetree/bindings/pwm/imx-tpm-pwm.txt
new file mode 100644
index 0000000..d47b8fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
@@ -0,0 +1,19 @@
+Freescale i.MX TPM PWM controller
+
+Required properties:
+- compatible : Should be "fsl,imx-tpm-pwm".
+- reg: Physical base address and length of the controller's registers.
+- #pwm-cells: Should be 2. See pwm.txt in this directory for a description=
 of the cells format.
+- clocks : The clock provided by the SoC to drive the PWM.
+- interrupts: The interrupt for the pwm controller.
+
+Example:
+
+pwm0: tpm@40250000 {
+	compatible =3D "fsl,imx-tpm-pwm";
+	reg =3D <0x40250000 0x1000>;
+	assigned-clocks =3D <&clks IMX7ULP_CLK_LPTPM4>;
+	assigned-clock-parents =3D <&clks IMX7ULP_CLK_SOSC_BUS_CLK>;
+	clocks =3D <&clks IMX7ULP_CLK_LPTPM4>;
+	#pwm-cells =3D <2>;
+};
--=20
2.7.4

