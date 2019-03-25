Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF191C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D342085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ve+cfDI2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbfCYN7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:59:37 -0400
Received: from mail-eopbgr40060.outbound.protection.outlook.com ([40.107.4.60]:22462
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725747AbfCYN7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfoZ9EE3stKLHv402uHMNSBwu2grPs8tEeDeo+bSsHI=;
 b=ve+cfDI2qbopJssZRHTNKpTAzimWZKBWfdXNbws9NUcB4pAzGPSIRVqYukkE2qpdlXR0QQpshcVzrNEK+CplgZAeA+woQT4C0ei7suxthp2kgIzxsl5pYWBhvHc3UM+6Q6dwtR60HXg3R306aLis0fyGJJ35ouSf/Wl0ySPk2KU=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB3970.eurprd04.prod.outlook.com (52.134.92.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Mon, 25 Mar 2019 13:59:30 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 13:59:30 +0000
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
Subject: [PATCH v2 2/2] pinctrl: pinctrl-imx8mq: Add support PM operations
Thread-Topic: [PATCH v2 2/2] pinctrl: pinctrl-imx8mq: Add support PM
 operations
Thread-Index: AQHU4xL3K5ykV9hQfk+63lOvEQ+eXQ==
Date:   Mon, 25 Mar 2019 13:59:30 +0000
Message-ID: <1553522352-20214-2-git-send-email-abel.vesa@nxp.com>
References: <1553522352-20214-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1553522352-20214-1-git-send-email-abel.vesa@nxp.com>
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
x-ms-office365-filtering-correlation-id: f8326015-4d4a-4c83-2707-08d6b12a19f0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB3970;
x-ms-traffictypediagnostic: AM0PR04MB3970:
x-microsoft-antispam-prvs: <AM0PR04MB397000991C3053D00A9D3B09F65E0@AM0PR04MB3970.eurprd04.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(396003)(136003)(346002)(189003)(199004)(99286004)(86362001)(4326008)(53936002)(106356001)(11346002)(446003)(97736004)(105586002)(14454004)(486006)(68736007)(81166006)(8676002)(36756003)(81156014)(6486002)(7736002)(305945005)(50226002)(476003)(478600001)(2616005)(14444005)(8936002)(256004)(76176011)(6436002)(66066001)(6512007)(5660300002)(25786009)(71200400001)(71190400001)(316002)(44832011)(386003)(6506007)(102836004)(26005)(6116002)(186003)(3846002)(54906003)(110136005)(2906002)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB3970;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JnH+CXiREC7m2uoHE3keSwAHec7NmvkgxoLeL/sFuikrcpNkSxaVAHkOrBHHXotrlKHOgtfnLwzvfpTPas6kPfZdhY3ilqG+aVB5P9AooKBfnw6hVRV1nX7ewVeQrIFqaybXDqwcGxmblv6ukSnx5n7Y3x6zFFTG0bU9kS9szYr92L/zCXYdda/cbPIhCRHglmj8eetfia2oAoHXParPzXMZSDXRZKL2feIuhulSPFkRPtWoawfr710mw4YYqlaOw7eHRUCaGvjOuR9YXJsLgR+P9uHxCU0j0icDa9fx69UdGmcSAS7QOTnx7iEUpftGkLfXJ0nBOaZM7vI39R7yr8866WNSQUucMLQrev9cXDcsMAtuuYZQYLOg5ufnMpPZIJLjwvhT66lP9l27LKoG/ERCTYz4j+qeW/e3uSt9kjY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8326015-4d4a-4c83-2707-08d6b12a19f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 13:59:30.4227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB3970
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suspend/resume pm ops to the pinctrl i.MX8MQ driver.
Make the suspend late and the resume early since some of the
pins might be needed active very late.
These call the pinctrl-imx generic handlers.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/pinctrl/freescale/pinctrl-imx8mq.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx8mq.c b/drivers/pinctrl/f=
reescale/pinctrl-imx8mq.c
index 8d39af5..2a212bc 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx8mq.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx8mq.c
@@ -335,10 +335,26 @@ static int imx8mq_pinctrl_probe(struct platform_devic=
e *pdev)
 	return imx_pinctrl_probe(pdev, &imx8mq_pinctrl_info);
 }
=20
+static int imx8mq_pinctrl_suspend(struct device *dev)
+{
+	return imx_pinctrl_suspend(dev);
+}
+
+static int imx8mq_pinctrl_resume(struct device *dev)
+{
+	return imx_pinctrl_resume(dev);
+}
+
+static const struct dev_pm_ops imx8mq_pinctrl_pm_ops =3D {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(imx8mq_pinctrl_suspend,
+					imx8mq_pinctrl_resume)
+};
+
 static struct platform_driver imx8mq_pinctrl_driver =3D {
 	.driver =3D {
 		.name =3D "imx8mq-pinctrl",
 		.of_match_table =3D of_match_ptr(imx8mq_pinctrl_of_match),
+		.pm =3D &imx8mq_pinctrl_pm_ops,
 		.suppress_bind_attrs =3D true,
 	},
 	.probe =3D imx8mq_pinctrl_probe,
--=20
2.7.4

