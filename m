Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF487C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5F4206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UW4+Y8Ez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfCKHRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 03:17:39 -0400
Received: from mail-eopbgr60077.outbound.protection.outlook.com ([40.107.6.77]:18424
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726070AbfCKHRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 03:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKNxi5w5h4s7w2RAQp+5OVKgLRqN32HvIfBiALanVN4=;
 b=UW4+Y8EzRivSvbes2JUFzJvRKN4LtpeAVv47HSXITl8wfEW5Jd/OGwRNc5VHaRsHquaEo30wGUOROW0TYscNNXk0DJL8fIf7wkc4xVYQT+q2GFYMpb/z/qZ1LS2yDNT0Q8ZQcb1xvxD2ceVwNWe9p+srcg3Ez/7yxH/w77J5YlI=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3897.eurprd04.prod.outlook.com (52.134.73.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.19; Mon, 11 Mar 2019 07:16:09 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 07:16:09 +0000
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
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
Thread-Topic: [PATCH 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
Thread-Index: AQHU19pNiXy2wqURpE+vQV+7IcWGgQ==
Date:   Mon, 11 Mar 2019 07:16:09 +0000
Message-ID: <1552288273-31028-2-git-send-email-Anson.Huang@nxp.com>
References: <1552288273-31028-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1552288273-31028-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0090.apcprd03.prod.outlook.com
 (2603:1096:203:72::30) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64d3f851-277f-453b-2b7c-08d6a5f16f5d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3897;
x-ms-traffictypediagnostic: DB3PR0402MB3897:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3897;23:acicm5A0pmxP4K/w7zl/lbvH34YE7q6c7X5fQ?=
 =?iso-8859-1?Q?Wqg+XatHEzGzCBv485P8QHzINcXgyF5J3i0JYkkXvnJln777VJ4XR2cpMd?=
 =?iso-8859-1?Q?SypGdS7zt6YTiABvzv+XSB63MTcfbrSGcvpx2RAl/Mi8uSj0fDTb8FR8UG?=
 =?iso-8859-1?Q?xhYufi9E6NWgZ4ELpCPBju0Qo4Y5QSrkSqqrNzXjKrd26/ls3yRVxRHjUb?=
 =?iso-8859-1?Q?K5/lOtUvoKya7MJ4UAk3G0AXHhzJ1bB4Tx+SD7LNVdM4GxFbZiqfpDRUQP?=
 =?iso-8859-1?Q?ihVvlWHs7PiQbSbn7w+m2Qft/SvlMAtyiYliawLOlXJ7aBI854g+IL5qp6?=
 =?iso-8859-1?Q?ZBJr95gYPMgVOiqXt48kjdRkzAhmtOKNoFQ80o9ZyBGHAnkI2mr4s2Ua1/?=
 =?iso-8859-1?Q?OlViUHi++AHO9ScTakhvBnik7kjX2RlF1hghnn23holyfkB9Bg5qjjFIbm?=
 =?iso-8859-1?Q?LxxAhFvgBaXKR90EFPBT8ji2wwYTzRu3J2R2I/sdkOL0ZahwfIOb/bC5jt?=
 =?iso-8859-1?Q?zdWnWBMA/KPZhXr5TsC48OLm95bhZ/Jz3UcjV7BuB1RwGqD79xF+Ig3msN?=
 =?iso-8859-1?Q?oV4/F1v9A5dZZu9xcWkeM8K+VjgMj6tl18usQz5li+fyokbPxylXhnD5ss?=
 =?iso-8859-1?Q?HOJY6OPlXPhI9coz2NeUmoYLnHz41uA5esTx8iMumRhEKiAJx0SivMAI1G?=
 =?iso-8859-1?Q?JVna79kg6rHAHa0uwrYQqkNOMLcO9eNwOHVXqDYDO4obpgox9SZ8ca5ehh?=
 =?iso-8859-1?Q?50ZSq2oojLogYFUQn1yF9pg6HxppS9pFZhW8KYBhu0A02GksYo5IJi8dAT?=
 =?iso-8859-1?Q?J/mRebflFqP/qNztgmL1CW6qUDlPXBeaHFhYd82NlMWadkBc3pS4ji54RL?=
 =?iso-8859-1?Q?/OuUP9ayJAoj0fFRVL2cUvQjWgd2geH4L+t2WlhAxYnPdwHPJbyvaQoQqD?=
 =?iso-8859-1?Q?pDNjHZUt4Ti2OwfSvJ40l6FnwD1Jc0721iDCLNcaJQbD7ubk3ibEelZeRE?=
 =?iso-8859-1?Q?xMT8bEooQhsl7Woc8FREzk1VYablOfDsxY3pYuoRlnbCyNh4w4ab9mxGUz?=
 =?iso-8859-1?Q?xvrqTicH3TTGtdMOn80tEcbYx4hAT4TysBr14Zo2xmOSWKOkl43jKUbucu?=
 =?iso-8859-1?Q?ILoCimcYoD1DIMQfw71Od/ui2fki8RXqhTpRAQHsXLIvCO5Af33xhLMlP9?=
 =?iso-8859-1?Q?RZK5RTEPcOoIChGc35Qkbf6qDjp8wqmu1eXxXvL1fi9Q8jKEiGNzMgZVMO?=
 =?iso-8859-1?Q?QAfqo/0XOUkJEn0s82LcB0J4FsovL596DWE0791u3SL09ShETxVY8RiQ7R?=
 =?iso-8859-1?Q?0koI=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB38975C16B003987DA615EA2FF5480@DB3PR0402MB3897.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(366004)(396003)(346002)(39860400002)(199004)(189003)(478600001)(86362001)(53936002)(6512007)(71190400001)(71200400001)(76176011)(102836004)(386003)(6506007)(36756003)(68736007)(316002)(256004)(14454004)(2201001)(50226002)(305945005)(66066001)(6116002)(8936002)(105586002)(2501003)(5660300002)(6436002)(7416002)(3846002)(6486002)(26005)(7736002)(186003)(110136005)(52116002)(25786009)(99286004)(2616005)(476003)(446003)(11346002)(4326008)(81166006)(81156014)(8676002)(486006)(106356001)(2906002)(97736004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3897;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: guIAZcZBabBdK9ZdtZo1cixbi6DXddnSjPAnzevFnG8cDeopzpADZ4pav+E6o2y4XgOo6kAYPa2gXwPtGz4Ns7CF22rxRMXj9Pb/p+/RgMnziyvDDBJnmN2+GrdY2EDDe78yHEnJCo1vLCJCF5mtoEJdm3eSdTVVD4a+V76Kc1k9pGjkuCbXNJu6ULh8eTy1llK09AZGC1kq+hiFYL+IKzNmnhVkQGMaTnYrirDozoZomMfrBq6UhF1t/xoU5cGb//PYl3bRZKIZ8oUyGTWCs+t6u7NV3FZQK0XjQJ5UQSrOjMpzMK8Dp0WSZz/m005rfbgSe8ugq7A0vhHxeWfhYeiYkJECd46Zf/CqqLORLzz7HkXcstJ1as44ZiEm7Lhdia06Fhp8KxOQpULp/2z0vKBXkx0Zaf6CmVkrWyJBqf0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d3f851-277f-453b-2b7c-08d6a5f16f5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 07:16:09.6544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3897
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX TPM(Low Power Timer/Pulse Width Modulation Module) PWM binding.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/pwm/imx-tpm-pwm.txt        | 23 ++++++++++++++++++=
++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt b/Docume=
ntation/devicetree/bindings/pwm/imx-tpm-pwm.txt
new file mode 100644
index 0000000..ebec313
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
@@ -0,0 +1,23 @@
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
+Optional properties:
+- fsl,pwm-number : PWM channel number, if not defined, i.MX TPM PWM driver=
 will use 2 by default.
+
+Example:
+
+pwm0: tpm@40250000 {
+	compatible =3D "fsl,imx-tpm-pwm";
+	reg =3D <0x40250000 0x1000>;
+	fsl,pwm-number =3D <6>;
+	assigned-clocks =3D <&clks IMX7ULP_CLK_LPTPM4>;
+	assigned-clock-parents =3D <&clks IMX7ULP_CLK_SOSC_BUS_CLK>;
+	clocks =3D <&clks IMX7ULP_CLK_LPTPM4>;
+	#pwm-cells =3D <2>;
+};
--=20
2.7.4

