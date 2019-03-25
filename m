Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28510C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC81320643
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ncU3Uc3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbfCYNs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:48:58 -0400
Received: from mail-eopbgr10070.outbound.protection.outlook.com ([40.107.1.70]:57347
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729127AbfCYNs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfoZ9EE3stKLHv402uHMNSBwu2grPs8tEeDeo+bSsHI=;
 b=ncU3Uc3yH4riCNwqrZ9apPtNzwJrpKUUE0ECTC6ilRdE2KJk8F5NzByofPRvKWLX1adWoQAhV4VZtiXT4MPf+8SMS1eTZmFuGA9PJg0IJCQOdttqAp+dl7ujVMr+5tjcbAnCHravrFXXiSEZHacYyiP55HhZ9Q/Dyns/ACJQl38=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6097.eurprd04.prod.outlook.com (20.179.36.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Mon, 25 Mar 2019 13:48:51 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 13:48:51 +0000
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
        "b38343@freescale.com" <b38343@freescale.com>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 2/2] pinctrl: pinctrl-imx8mq: Add support PM operations
Thread-Topic: [PATCH 2/2] pinctrl: pinctrl-imx8mq: Add support PM operations
Thread-Index: AQHU4xF6fE34vAFLP0y+ttoOUtgHUw==
Date:   Mon, 25 Mar 2019 13:48:51 +0000
Message-ID: <1553521721-12061-2-git-send-email-abel.vesa@nxp.com>
References: <1553521721-12061-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1553521721-12061-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0501CA0024.eurprd05.prod.outlook.com
 (2603:10a6:800:92::34) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [212.146.100.6]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cdc42648-6ab5-47d4-f76f-08d6b1289cfd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB6097;
x-ms-traffictypediagnostic: AM0PR04MB6097:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM0PR04MB609709A0B10E7268D3D7E85AF65E0@AM0PR04MB6097.eurprd04.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(66066001)(8936002)(50226002)(99286004)(6506007)(4326008)(71190400001)(386003)(71200400001)(52116002)(478600001)(54906003)(76176011)(53936002)(86362001)(7736002)(256004)(316002)(110136005)(14444005)(6436002)(6486002)(6116002)(3846002)(14454004)(97736004)(6512007)(26005)(476003)(68736007)(102836004)(305945005)(36756003)(25786009)(2616005)(5660300002)(11346002)(8676002)(2906002)(446003)(44832011)(186003)(486006)(81166006)(81156014)(106356001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6097;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yk5HPz7a6qDwAn8EOa5D3RX+i1Z0WWEDFcjMnePqA4sCSzRbiZSatRoNgjZtl+73Yxsm/TDkCUXSLeoomtsWQKf+viL6gW2+fSNCke6ROM5z5hDS+F0rqZhhWsHee7m6VXp7RwvtdMbLHYGOM1QWMclV/rm0P97+Ed15PlzqPj73bQc9mpJVBQpPXtXoy/F2FQE7z/U15cZBEiREc6HnOMBzi+4ihUgZ47s1MXtBkoUUXGrGKU+yzaWPzJ6xs6GopG1GdvNaF2cKcg+E6r0SxR6SuVJXxTc7TN+1d/W1t1MjODMFNAZ9z3xsZWcw7I5UUxSqmXFeWjd/n4mBTPY0ybT2V/q2BV3v4Fc3+umj4cf91wZG0wZZjlJsstloSq5E6Nq6f0jmxMwvYsgiXYAgG8NitC+3pHbZVvmhMwPtXgw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc42648-6ab5-47d4-f76f-08d6b1289cfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 13:48:51.6796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6097
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

