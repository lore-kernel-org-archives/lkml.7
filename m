Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06199C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC4A5206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iDfBmq3u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbfDHSig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:38:36 -0400
Received: from mail-eopbgr70042.outbound.protection.outlook.com ([40.107.7.42]:35718
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727258AbfDHSig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 14:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ltk+tmI19U5acPW0mMj4wl6NHIi8fZceQlh/MNdU+E=;
 b=iDfBmq3ufH2DOolpF8X/K+4bBeXFN6aOz6iFDkAfbu1Lavk36X1mMhFTafFmZlwu6cj0c1ExB45tXqw5C6+HEjxhXm9M9vC7JwZBFmQE22GwCxsipnfzcxMQhGFUbBvZIo9I3anX/h2+5GzT/ikXsgFQCCyRZNZLrUvkSYXhb7U=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5076.eurprd04.prod.outlook.com (20.176.214.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Mon, 8 Apr 2019 18:38:31 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::880d:a6d1:c29c:8560]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::880d:a6d1:c29c:8560%3]) with mapi id 15.20.1771.016; Mon, 8 Apr 2019
 18:38:31 +0000
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
Subject: [PATCH v3] pinctrl: imx8mq: Add suspend/resume ops
Thread-Topic: [PATCH v3] pinctrl: imx8mq: Add suspend/resume ops
Thread-Index: AQHU7jpDrz+M9DfmAkuvRDoTgxvh0w==
Date:   Mon, 8 Apr 2019 18:38:31 +0000
Message-ID: <1554748702-2368-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0208.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::32) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [212.146.100.6]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5fc0a65-01ac-45c4-3431-08d6bc51663b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR04MB5076;
x-ms-traffictypediagnostic: AM0PR04MB5076:
x-microsoft-antispam-prvs: <AM0PR04MB5076F6E8B32A8C1D8397A7ECF62C0@AM0PR04MB5076.eurprd04.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(396003)(136003)(346002)(376002)(39860400002)(366004)(189003)(199004)(4326008)(14454004)(478600001)(110136005)(486006)(15650500001)(25786009)(68736007)(6436002)(3846002)(53936002)(186003)(6116002)(6512007)(6486002)(54906003)(476003)(6506007)(386003)(26005)(2906002)(102836004)(2616005)(97736004)(66066001)(7736002)(71190400001)(71200400001)(316002)(105586002)(44832011)(52116002)(36756003)(50226002)(81166006)(81156014)(8676002)(86362001)(8936002)(305945005)(5660300002)(14444005)(256004)(99286004)(106356001)(32563001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5076;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xRefi/SRtYcIpOrpzAaye41pBQSExwkH+ZuZxMB/VLqL3M651CInPiCuFdaCuJmrzz2GxJ3k01jYmzW7eXzVGZFDF6jxEAPBCgOIvfz3VY1jA5hGpdvOr3ePpcNqM3aveVHOYoaA2LXxxHs0dUhmgEuSwqcOgyfSiLgfPnXTP3+m0ZjOhPb+JtT0tou+i9UvNpETUQwMLdRAVoik8yexoeO3+/WZNorPWKdR9YxtoYDcUcF14eFN/Ho+1dDHw6vI6tjZyhwOwUqrjJJtkgEdbCceIeUxeweu4a4+ERswedsPFn/VKDnaILNZ1x/snB82mbcV1vcUD8a/xxmfy/8rrD6Io91Bk1xd3YQp21Ebrf2BzE+KuRlkdY4fcDhB+8v3RvQR2UUaf6e4LTZ0iLo0N4gMaP2mAM5CyiWgO5FKm4s=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5fc0a65-01ac-45c4-3431-08d6bc51663b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 18:38:31.6505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support pinctl hog restore after LPSR resume back,
add the generic suspend/resume in pinctrl-imx along with the
generic pm ops to be used by platform specific drivers. Then
make use of the newly added ops in i.MX8MQ platform specific
driver.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---

Changes since v2:
 * removed the pinctrl-imx8mq with imx8mq in the subject
 * added static and __maybe_unused to both suspend and resume
 * removed the useless null checks

 drivers/pinctrl/freescale/pinctrl-imx.c    | 19 +++++++++++++++++++
 drivers/pinctrl/freescale/pinctrl-imx.h    |  1 +
 drivers/pinctrl/freescale/pinctrl-imx8mq.c |  1 +
 3 files changed, 21 insertions(+)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/free=
scale/pinctrl-imx.c
index 188001b..93a86d2 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -887,3 +887,22 @@ int imx_pinctrl_probe(struct platform_device *pdev,
=20
 	return ret;
 }
+
+static int __maybe_unused imx_pinctrl_suspend(struct device *dev)
+{
+	struct imx_pinctrl *ipctl =3D dev_get_drvdata(dev);
+
+	return pinctrl_force_sleep(ipctl->pctl);
+}
+
+static int __maybe_unused imx_pinctrl_resume(struct device *dev)
+{
+	struct imx_pinctrl *ipctl =3D dev_get_drvdata(dev);
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
index 98a4889..333d32b 100644
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

