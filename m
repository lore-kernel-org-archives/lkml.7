Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6C3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 00:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775E621872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 00:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XatGM0MF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfCOAqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 20:46:43 -0400
Received: from mail-eopbgr30069.outbound.protection.outlook.com ([40.107.3.69]:30639
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727004AbfCOAqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 20:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11oFbbhShcbiewhjMrv5WpTncCm0AuyC1+FZeJYNfjM=;
 b=XatGM0MFhyRSidw6ic1Gtz9n8OlmmwuRg1xIQdd0LYiAPvsrB0SQ7X7ZZhAubgm9GoK4ykS/WqHc0XmaFuOhftOKQaV2ig0B6aUnXAPeagHalYc1Ou+ABCju39lEs+yVmhGMHdwHKaZKn7Od5hMDm0McJ7DT8CMQ0/nTfE7LgIo=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3804.eurprd04.prod.outlook.com (52.134.73.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Fri, 15 Mar 2019 00:46:38 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%6]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 00:46:38 +0000
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
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V4 0/5] Add i.MX7ULP EVK PWM backlight support
Thread-Topic: [PATCH V4 0/5] Add i.MX7ULP EVK PWM backlight support
Thread-Index: AQHU2siMBAbc+s+8p06xfQ4kgvUSBA==
Date:   Fri, 15 Mar 2019 00:46:38 +0000
Message-ID: <1552610505-13568-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0045.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::33) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fef61860-e9a9-4b2d-766f-08d6a8dfae7a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3804;
x-ms-traffictypediagnostic: DB3PR0402MB3804:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3804;23:7VJ2BdzD0ILn4x8tB5Zs3jsMvzrf/GDfIEBbA?=
 =?iso-8859-1?Q?zyvKslk+WdUII1Q/qeVd4SA+DKZuCuaf6eJWWGeFmLa+U+Pisi62vDlp1n?=
 =?iso-8859-1?Q?IzR+rFQ93P44sPCK9P2CiHTRMagMPPLwYlOQQI4z/gKy+vMD8Mz7abTSE6?=
 =?iso-8859-1?Q?qATkQ9XFHTaOV/NN4cvsaDLi/cpxOB0cuf3zY9chu8WmZhc2vMcXTe8dCC?=
 =?iso-8859-1?Q?ODS9TvrAj8nXNyUNMfslfS7YBIwig1D8w6GM3fPfEjNzaEomyIvI0dYuXU?=
 =?iso-8859-1?Q?DpCIzG18TbpihP31NG1vGEEkUAgNT2VXGlC9itdSCJUbhuIy/94nGvSdEF?=
 =?iso-8859-1?Q?G94EgTS6Wqxm7Vq+k/VQHajbKqslVx8EKEsQps4BNQDjjpBGMD14S0lhBm?=
 =?iso-8859-1?Q?hdfvDf92MczBMqH+B67rjwvC2bdahDiJ/Ob+trd1rbUg6auf3qne5KTLwf?=
 =?iso-8859-1?Q?oseG6lAbCEHD/Xk+oj3Y//PkCFKRMui571w5lYhV4zAEul0ZomVRKhvg4Q?=
 =?iso-8859-1?Q?wyl06o9a7OdxDldwBzIc7C8lKbV4EpbigITwsWAdjYJRMwf0s8loUmJUcQ?=
 =?iso-8859-1?Q?5+tYicOZ3iAeP8JTwCFTrCCQ67J20CVm/JdzsAmTEnOX17bNEjNllD3wwA?=
 =?iso-8859-1?Q?e41JaQcnGSAnVN6AAcQ8XSsx5iHlNBeIsm54j1H1tT7SxHapOK8oZxGX6P?=
 =?iso-8859-1?Q?GknTxC2p0qnyIJewbr0yXt7kqrIHIfkErcauLUFS0OoY0iYAwQWWizHX/e?=
 =?iso-8859-1?Q?NTTkvZGLaQ6CNuZ5Ms5GHtXhdZztRptXY5pkr7amNPhqI+80KngRL3dVB0?=
 =?iso-8859-1?Q?a+VW2RaynpSDLsUDCyq8X+pwm8hLvdApIkWJPxnRKZNvXT8PqvnT7G8VON?=
 =?iso-8859-1?Q?4tl9xMbzOZu+SN1zD+DO6LO9KaM2MVyVdFK6FoLMLmUKPnZabPDrDes9dP?=
 =?iso-8859-1?Q?lG8RvbbW5jOyEuvFjR73EO4vceTDEXV+0mNPW2fiJAluQkwgL/LZnInr8E?=
 =?iso-8859-1?Q?OyByxsHcMLSUHDjr8tVQhPm1P1t5JzwMzwjeZINnyAg3byGxOj63ASKjhw?=
 =?iso-8859-1?Q?kfzST46bwnXdl683bM466aLKuK40VqRCdcE+3eRGL+ILLV+/ONEwQaE9YB?=
 =?iso-8859-1?Q?nzZM2thcm5lWo9cukcHUMRxgxF79ta5oT2unZlZnn7td67lQnUC/yYbxFb?=
 =?iso-8859-1?Q?TQ944q4PQ5HgODjotcDVTHSCSHAsPdcDeSMeDBJjZYt0qtbSrUw8pEIFJT?=
 =?iso-8859-1?Q?Wq49N5BKyJws97cUhZVrhu3FIlQqIqf+38JtNjl4Q=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB38042586A928B1D2E6D97932F5440@DB3PR0402MB3804.eurprd04.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(366004)(39860400002)(376002)(189003)(199004)(478600001)(102836004)(52116002)(97736004)(105586002)(50226002)(7416002)(8936002)(81156014)(26005)(81166006)(2906002)(86362001)(186003)(8676002)(4744005)(5660300002)(386003)(2201001)(6506007)(2501003)(3846002)(14454004)(256004)(25786009)(476003)(66066001)(2616005)(7736002)(305945005)(486006)(71190400001)(4326008)(6116002)(71200400001)(99286004)(6436002)(106356001)(110136005)(6486002)(36756003)(53936002)(6512007)(316002)(68736007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3804;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ij/9eKate948Xh5o47Fdgg6z6oHcW4WBMsvIRdXIMu+5oMklRjQLAXDJ2tPlkVTilaN99udRZMPAyBIl3MwptVrONr+9GaBMGjAzcT08eM4neN9/NqH3zg/QAgy46/rjD7c4fUZMgcAMQGEJCzPDg1DpDxLeJiztB+BLosjFIMDCzBzPPUNZpMdmXRCmaWopqLBibUr1jIbT0rbdeULB+9Ofa2JI2jdkszk7imv7ef7P5S8x8pqavqvHjTi/fPY4Ya4fzt1rQmrcJM+jau6R1CUxXVM1xlG7RDlLRL8Mn31ifwzVX0AyunPNZ5h7Dqg+ebVV1SPn4FtQbCRm7ywUVBAPLMp8t+PT60vsrTxfa77fP3DZh1JTLxyh2jnbGMX0OyFqoHj9cCvi1p65A/uDLiq6xV6+wFeE32y6Z8I2WAU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fef61860-e9a9-4b2d-766f-08d6a8dfae7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 00:46:38.6514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3804
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX7ULP EVK board has MIPI-DSI display, its backlight is supplied
by TPM PWM module, this patch set enables i.MX7ULP TPM PWM driver
support and also add backlight support for MIPI-DSI display.

Anson Huang (5):
  dt-bindings: pwm: Add i.MX TPM PWM binding
  pwm: Add i.MX TPM PWM driver support
  ARM: imx_v6_v7_defconfig: Add TPM PWM support by default
  ARM: dts: imx7ulp: Add pwm0 support
  ARM: dts: imx7ulp-evk: Add backlight support

 .../devicetree/bindings/pwm/imx-tpm-pwm.txt        |  23 ++
 arch/arm/boot/dts/imx7ulp-evk.dts                  |  20 ++
 arch/arm/boot/dts/imx7ulp.dtsi                     |  11 +
 arch/arm/configs/imx_v6_v7_defconfig               |   1 +
 drivers/pwm/Kconfig                                |   9 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-imx-tpm.c                          | 277 +++++++++++++++++=
++++
 7 files changed, 342 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
 create mode 100644 drivers/pwm/pwm-imx-tpm.c

--=20
2.7.4

