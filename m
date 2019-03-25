Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424A3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1D720830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="e5DB+k8o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbfCYNsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:48:55 -0400
Received: from mail-eopbgr40060.outbound.protection.outlook.com ([40.107.4.60]:38211
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726242AbfCYNsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyvOG3qdSShuQxeiLD1HrKePK8DQCchjIjUGrmtWseg=;
 b=e5DB+k8oJDQm2SHV+0zHWYAkYmlsG0thCLZSJD32l680Kjs6HZ3cqC8HOLWdpWbxf4Qvzk1pMACGYihgRiNj95LNDhIR8qyGu7frVh7q2tbWLUtqshbgLGyEJAZ4oCeKcroi55dqoPcDeGMe5hCrxeHTUx1lKznWjHsMaD6hu2c=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Mon, 25 Mar 2019 13:48:50 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 13:48:50 +0000
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
Subject: [PATCH 1/2] pinctrl: pinctrl-imx: Add suspend/resume for LPSR
Thread-Topic: [PATCH 1/2] pinctrl: pinctrl-imx: Add suspend/resume for LPSR
Thread-Index: AQHU4xF5dEldeuWdf0qD0BEcN/OvIA==
Date:   Mon, 25 Mar 2019 13:48:49 +0000
Message-ID: <1553521721-12061-1-git-send-email-abel.vesa@nxp.com>
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
x-ms-office365-filtering-correlation-id: 6e8292cc-cc23-49a4-acfc-08d6b1289c2f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5779;
x-ms-traffictypediagnostic: AM0PR04MB5779:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM0PR04MB57797942C39C676E57BC4909F65E0@AM0PR04MB5779.eurprd04.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(376002)(346002)(396003)(199004)(189003)(316002)(71200400001)(4326008)(110136005)(53936002)(14454004)(36756003)(102836004)(186003)(105586002)(106356001)(71190400001)(2906002)(81166006)(3846002)(81156014)(54906003)(68736007)(8676002)(6116002)(26005)(6506007)(386003)(52116002)(97736004)(256004)(8936002)(6486002)(50226002)(15650500001)(66066001)(5660300002)(7736002)(86362001)(6436002)(99286004)(305945005)(25786009)(6512007)(2616005)(44832011)(478600001)(476003)(14444005)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5779;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: It7onICsc1p1h+fEqo2X7rEj4Xdj5E6tbnq2Wwi66RtdPOvu9JCkG9ls9d7lprMMKqRNHcbqX63zhpjUJH4aliJJkxdGU5oILAtkrWxmaIcNXudU8AXfpw2+5ZD4zbAdiMXqJvsyqzX9Yj+O5igGDlNyd0IB0/XH9kKczLK1W/DzBd4sLdFU9KUHIziSJ51LpZ0ICENxDQQsmEiQoStUmsq0dC1i+HuXe5SZdq187XSBNgBQUAFIeoklHmR1p4U4rP8xDXZ0sTicW0QSaNDLcQGriamhj9bK9QKlxUZWqvblUfwFsF1Pfi9tp0bUmadb9XDNByRJtn7t4sKOXytPIZywrx763QN5OzLpWuyHMM2hF57puhxdNIFm52iKwDxbATJFL5SoFhwAakiL4UXDBPG4YlcHD/XRAcD7Uxzocrc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e8292cc-cc23-49a4-acfc-08d6b1289c2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 13:48:50.2055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5779
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Gong <b38343@freescale.com>

To support pinctl hog restore after LPSR resume back,
add suspend/resume in pinctrl driver.

Signed-off-by: Robin Gong <b38343@freescale.com>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
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

