Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8017C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 08:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FD82146F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 08:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DwgfIf3/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfELIvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 04:51:23 -0400
Received: from mail-eopbgr70079.outbound.protection.outlook.com ([40.107.7.79]:37700
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725934AbfELIvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 04:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDJ/qW6lbDzjrjMOB+Uej4+nV7CPKZuwtBnkVpbpyOI=;
 b=DwgfIf3/MDhUYp/tVMrqf7XFIjt149QtQLnh3XcgAHQNrrHF0iOR+zlQa71Ncr9c/l33dUvUKTcR9iRzu2MsjQyp/XmmzNldikDy1hkzzDKGegKh9kbAWxtXPZGBl0b8WnC9AqQyydzvWPvu+4bIZF8d8p3s0cD3g6/cgHcoWQ8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3739.eurprd04.prod.outlook.com (52.134.67.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.21; Sun, 12 May 2019 08:51:15 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1878.022; Sun, 12 May 2019
 08:51:15 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V12 RESEND 1/3] ARM: imx_v6_v7_defconfig: Add TPM PWM support
 by default
Thread-Topic: [PATCH V12 RESEND 1/3] ARM: imx_v6_v7_defconfig: Add TPM PWM
 support by default
Thread-Index: AQHVCJ/ba2U9z0dY2k6pxI/P2DhoFA==
Date:   Sun, 12 May 2019 08:51:15 +0000
Message-ID: <1557650772-11973-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR03CA0043.apcprd03.prod.outlook.com
 (2603:1096:202:17::13) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b553a5ba-b060-4ace-8b11-08d6d6b6fddf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3739;
x-ms-traffictypediagnostic: DB3PR0402MB3739:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB3PR0402MB37396650EA1D2665169013CEF50E0@DB3PR0402MB3739.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 0035B15214
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(966005)(36756003)(186003)(66556008)(476003)(66446008)(66946007)(66476007)(64756008)(486006)(14454004)(2501003)(66066001)(2906002)(2616005)(256004)(73956011)(478600001)(4326008)(3846002)(6116002)(25786009)(26005)(102836004)(6436002)(7736002)(305945005)(53936002)(6506007)(386003)(6486002)(6512007)(6306002)(7416002)(2201001)(86362001)(4744005)(316002)(110136005)(68736007)(81156014)(81166006)(8676002)(8936002)(50226002)(71190400001)(71200400001)(52116002)(99286004)(5660300002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3739;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uOXkVo64ZCmRcSVwKHFXssUjheR3ubvA3CfMc75m1hs5vZ+zMDy661YrnknEVvn8cKTVZVuzhR6cZ6t/En7qf7ScJ8phaj92FLKSA15TfVwW+rm2q8HY09knzpce91cCJX31h9VjUNiqpcGDKizpy42dtacZxE4i9+1jaRirlA+G2qqTV0Yum5vCWGRxAnV1Cv1mUlpxaeQq4hMh9oJm9oZcLvT0bZC3T/dMDlsXH7Q3vmXqIE27N0+BUFpUTcclv0UwpVpWlm9nVNrmQdDmaO4mzDbKwSPR0qHIKeqjK0L+zh/KpM8hDc+QU9EJ/A0ZQsVpZEpOTOQagnJtGzeHfK9PnLwJM92EQyhnO/kYSOLVwFfnQKkqwRD6N199nOlZEzmVagvecUU7g7dVy6dEdWx4KGAkFN920ZBm9TAWlB0=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <920B8BDFCC09454ABCA20E7BFC63ED42@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b553a5ba-b060-4ace-8b11-08d6d6b6fddf
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2019 08:51:15.7445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3739
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select CONFIG_PWM_IMX_TPM by default to support i.MX7ULP
TPM PWM.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No change change, just resend the patch with correct encoding for patch ser=
ies:
https://patchwork.kernel.org/patch/10937147/
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6=
_v7_defconfig
index ea387cb..cee7c61 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -402,6 +402,7 @@ CONFIG_MPL3115=3Dy
 CONFIG_PWM=3Dy
 CONFIG_PWM_FSL_FTM=3Dy
 CONFIG_PWM_IMX27=3Dy
+CONFIG_PWM_IMX_TPM=3Dy
 CONFIG_NVMEM_IMX_OCOTP=3Dy
 CONFIG_NVMEM_VF610_OCOTP=3Dy
 CONFIG_TEE=3Dy
--=20
2.7.4

