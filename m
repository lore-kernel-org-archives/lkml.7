Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4743C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F3020883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LqajDwjz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfDHKmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:42:39 -0400
Received: from mail-eopbgr140073.outbound.protection.outlook.com ([40.107.14.73]:33283
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726189AbfDHKmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tU04SyzZFDQN+TQLE7gx8BUaxeQLfDd6/zsAd/cGEk=;
 b=LqajDwjzhLLijpYETltkBZZp/ww77kiifB6oV1wF3nI2OiwIfMxLzU1uXmkawSp22D6VLdtUrVbXG9pXnll0/m0UsEPk2rnalGSP2iuF/cnfVAuX3jqSTuZZnb60ajfcGd3GaJwE+JNmaV1lhm+0Y4Gykwrwp5iYt2bKM3t0bwU=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4977.eurprd04.prod.outlook.com (20.177.40.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.21; Mon, 8 Apr 2019 10:42:34 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::880d:a6d1:c29c:8560]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::880d:a6d1:c29c:8560%3]) with mapi id 15.20.1771.016; Mon, 8 Apr 2019
 10:42:34 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
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
        Abel Vesa <abel.vesa@nxp.com>, Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v2] pinctrl: pinctrl-imx8mq: Add suspend/resume ops
Thread-Topic: [PATCH v2] pinctrl: pinctrl-imx8mq: Add suspend/resume ops
Thread-Index: AQHU7ffGuIssFgd2ckqu0X9l+Jf5ew==
Date:   Mon, 8 Apr 2019 10:42:34 +0000
Message-ID: <1554720120-6617-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0501CA0027.eurprd05.prod.outlook.com
 (2603:10a6:800:60::13) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [212.146.100.6]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6cb5eff-9bfd-4264-a2a1-08d6bc0ee8ee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4977;
x-ms-traffictypediagnostic: AM0PR04MB4977:
x-microsoft-antispam-prvs: <AM0PR04MB49776BF6C26EC1AB09881E76F62C0@AM0PR04MB4977.eurprd04.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(346002)(376002)(39860400002)(189003)(199004)(86362001)(305945005)(7736002)(6512007)(25786009)(478600001)(4326008)(14454004)(6116002)(53936002)(3846002)(68736007)(6486002)(6436002)(2906002)(15650500001)(71200400001)(71190400001)(2616005)(486006)(110136005)(316002)(97736004)(54906003)(52116002)(8936002)(81156014)(102836004)(26005)(386003)(186003)(5660300002)(6506007)(50226002)(81166006)(8676002)(256004)(14444005)(36756003)(105586002)(66066001)(106356001)(44832011)(476003)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4977;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hR5L4P/3wBcDkSMbfpKXnUu42LyHGsR7GbVGhKc6kS90/GXuioBRWtvruUBsBP5N+aAw8lnEnHmwC6It9yR9XTlrVoZE0L8smjardJ/IK22sDDL+0C8CRGSBTPiZf9F2pyVjjg3niR2Y8vAEpbG9hj7R0jei61SbOd1aTcPTZ/Weooltaonp4BW9/Tdar8Z2K9+NDcv3TpTguHeuClMfC5/nU+kLaiUywwbv5Ee6SF+/orW2VcT21FPYLVd5RXbQuElG938f/DnEuXNHarvbPjIX+OS0dgzEXbyHyD8xDnTrFjClk4AJKVCFeNBciT6BHi9dWyoP6HQZQ92aZMs/kTklXvBNBlm5gwJg8ZlXe9NwAe10V8Zjb6WNLQQ27IszAF0EjIfzh9AJk4fIDodxyl8X+6wcoXhvldcF5LfbmZY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6cb5eff-9bfd-4264-a2a1-08d6bc0ee8ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 10:42:34.5903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4977
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support pinctl hog restore after LPSR resume back,
add the generic suspend/resume in pinctrl-imx along with the
generic pm opsto be used by platform specific drivers. Then
make use of the newly added ops in i.MX8MQ platform specific
driver.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---

Changes since v1:
 - Replaced the imx8mq specific ops with generic ones.

 drivers/pinctrl/freescale/pinctrl-imx.c    | 25 +++++++++++++++++++++++++
 drivers/pinctrl/freescale/pinctrl-imx.h    |  4 ++++
 drivers/pinctrl/freescale/pinctrl-imx8mq.c |  1 +
 3 files changed, 30 insertions(+)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/free=
scale/pinctrl-imx.c
index 188001b..ee120ee 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -887,3 +887,28 @@ int imx_pinctrl_probe(struct platform_device *pdev,
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
+
+const struct dev_pm_ops imx_pinctrl_pm_ops =3D {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(imx_pinctrl_suspend,
+					imx_pinctrl_resume)
+};
diff --git a/drivers/pinctrl/freescale/pinctrl-imx.h b/drivers/pinctrl/free=
scale/pinctrl-imx.h
index 98a4889..ae78314 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.h
+++ b/drivers/pinctrl/freescale/pinctrl-imx.h
@@ -17,6 +17,7 @@
 struct platform_device;
=20
 extern struct pinmux_ops imx_pmx_ops;
+extern const struct dev_pm_ops imx_pinctrl_pm_ops;
=20
 /**
  * struct imx_pin_mmio - MMIO pin configurations
@@ -136,6 +137,9 @@ struct imx_pinctrl {
 int imx_pinctrl_probe(struct platform_device *pdev,
 			const struct imx_pinctrl_soc_info *info);
=20
+int imx_pinctrl_suspend(struct device *dev);
+int imx_pinctrl_resume(struct device *dev);
+
 #ifdef CONFIG_PINCTRL_IMX_SCU
 #define BM_PAD_CTL_GP_ENABLE		BIT(30)
 #define BM_PAD_CTL_IFMUX_ENABLE		BIT(31)
diff --git a/drivers/pinctrl/freescale/pinctrl-imx8mq.c b/drivers/pinctrl/f=
reescale/pinctrl-imx8mq.c
index 8d39af5..50aa1c0 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx8mq.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx8mq.c
@@ -339,6 +339,7 @@ static struct platform_driver imx8mq_pinctrl_driver =3D=
 {
 	.driver =3D {
 		.name =3D "imx8mq-pinctrl",
 		.of_match_table =3D of_match_ptr(imx8mq_pinctrl_of_match),
+		.pm =3D &imx_pinctrl_pm_ops,
 		.suppress_bind_attrs =3D true,
 	},
 	.probe =3D imx8mq_pinctrl_probe,
--=20
2.7.4

