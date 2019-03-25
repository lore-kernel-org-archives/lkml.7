Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73454C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37AEA20863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xoL6n4+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfCYN7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:59:33 -0400
Received: from mail-eopbgr40060.outbound.protection.outlook.com ([40.107.4.60]:22462
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725355AbfCYN7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/7aeUajcxNXhUyIoOlHIMqlyxEZUkf7E0NGCmOoAuI=;
 b=xoL6n4+4POnwBDu/37Y7E32/ZZkBAFG1zw4oF7ywx5GyZkfBbity6tGfrv+jB7T214Ey8I16+l2UrOfkcV3POo5Mrgw/7lCB7UXGm+HRGm91wG1Ui5ryJ2Rvdh9gXLBXq9apJsB2XazCMGmqB4ewzQUqCgE9XHmQP0JKhHKnW5c=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB3970.eurprd04.prod.outlook.com (52.134.92.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Mon, 25 Mar 2019 13:59:29 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 13:59:29 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Robin Gong <yibin.gong@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v2 1/2] pinctrl: pinctrl-imx: Add suspend/resume for LPSR
Thread-Topic: [PATCH v2 1/2] pinctrl: pinctrl-imx: Add suspend/resume for LPSR
Thread-Index: AQHU4xL2kxTfcBAwA0CY0U8rwSXJYw==
Date:   Mon, 25 Mar 2019 13:59:29 +0000
Message-ID: <1553522352-20214-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VE1PR03CA0051.eurprd03.prod.outlook.com
 (2603:10a6:803:118::40) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [212.146.100.6]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45b2e862-945e-48b6-ce15-08d6b12a193d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB3970;
x-ms-traffictypediagnostic: AM0PR04MB3970:
x-microsoft-antispam-prvs: <AM0PR04MB3970853C219E72C7E3BAC2D8F65E0@AM0PR04MB3970.eurprd04.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(396003)(136003)(346002)(189003)(199004)(99286004)(86362001)(4326008)(53936002)(106356001)(97736004)(105586002)(14454004)(486006)(68736007)(81166006)(8676002)(36756003)(81156014)(6486002)(15650500001)(7736002)(305945005)(50226002)(476003)(478600001)(2616005)(14444005)(8936002)(256004)(6436002)(66066001)(6512007)(5660300002)(25786009)(71200400001)(71190400001)(316002)(44832011)(386003)(6506007)(102836004)(26005)(6116002)(186003)(3846002)(54906003)(110136005)(2906002)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB3970;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OyK6usfWwJe8ZTEBkyvCQD6/Mt3WfCGhZ5+dAF+ki+OaP89XXBkeFhKNnCUk5z+BQKk4//zL3G0y0UmR4BS8fFkHKOwAHLEwgCaKZiCtRMHh4bziqDMSYEvFzuF9BQaHHaZva333fMCE4ZAE/ZH5QOojxeH6xf9QcF0sgL4zQaAUCizPcX5q42pvCt5pslnBGOKJCGtTX9+fYipJgXQsQzhpW+57RAOWYt0BDCBcLq8oHGvgrQK06B6IiLr29K3TIeC1IxxRxamDP9JCEn358C5KqyfrsiCO1MnpGvbUAlZIZIS6XjHS2LAEcodhtwbZpXoZLuFtXdgewczN5sz7OAoCEsG5nesUhvcCb+Qa7NGDXYL2cEiyq/MTKM58C/hg3yaaiZEqFZYlFEgRUA3AViXaaZncpIGHiyviqkDySFQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b2e862-945e-48b6-ce15-08d6b12a193d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 13:59:29.3209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB3970
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Gong <yibin.gong@nxp.com>

To support pinctl hog restore after LPSR resume back,
add suspend/resume in pinctrl driver.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---

Changes since v1:
 * fixed Robin's email

 drivers/pinctrl/freescale/pinctrl-imx.c | 20 ++++++++++++++++++++
 drivers/pinctrl/freescale/pinctrl-imx.h |  3 +++
 2 files changed, 23 insertions(+)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/free=
scale/pinctrl-imx.c
index 188001b..93c0253 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -887,3 +887,23 @@ int imx_pinctrl_probe(struct platform_device *pdev,
=20
 	return ret;
 }
+
+int imx_pinctrl_suspend(struct device *dev)
+{
+	struct imx_pinctrl *ipctl =3D dev_get_drvdata(dev);
+
+	if (!ipctl)
+		return -EINVAL;
+
+	return pinctrl_force_sleep(ipctl->pctl);
+}
+
+int imx_pinctrl_resume(struct device *dev)
+{
+	struct imx_pinctrl *ipctl =3D dev_get_drvdata(dev);
+
+	if (!ipctl)
+		return -EINVAL;
+
+	return pinctrl_force_default(ipctl->pctl);
+}
diff --git a/drivers/pinctrl/freescale/pinctrl-imx.h b/drivers/pinctrl/free=
scale/pinctrl-imx.h
index 98a4889..795669c 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.h
+++ b/drivers/pinctrl/freescale/pinctrl-imx.h
@@ -136,6 +136,9 @@ struct imx_pinctrl {
 int imx_pinctrl_probe(struct platform_device *pdev,
 			const struct imx_pinctrl_soc_info *info);
=20
+int imx_pinctrl_suspend(struct device *dev);
+int imx_pinctrl_resume(struct device *dev);
+
 #ifdef CONFIG_PINCTRL_IMX_SCU
 #define BM_PAD_CTL_GP_ENABLE		BIT(30)
 #define BM_PAD_CTL_IFMUX_ENABLE		BIT(31)
--=20
2.7.4

