Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6970EC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 06:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33189218AE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 06:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="k5dSx3sX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKGGnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 01:43:00 -0500
Received: from mail-eopbgr130071.outbound.protection.outlook.com ([40.107.13.71]:37878
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726618AbfKGGnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 01:43:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XA2v9zxEKh/rlQ8CmPk+mH7eFSI/p4dCcMH77v88vBb5o5iaympjSAkIr4wOGUQOjFmdKQoEIlAo+CrTJRiDFkwriAPEraXU+tdxgOBie7yLINifzdJzNe23CkvAoUHACCWWUlansPmYBPQwCzNdBNgpt0o/tbuCDVIQ/CrwwFLMXyc7/a8zqyBLEKwrootdALAGgLmGBGmsQjaWUmBkUKvLXZ09SdhmDftpGqYxejUR0+P+7WogFDRDTlHTeeyBergaD6dQqPQzwNj1y3ODbNIN2JD1iwzw1iIRxfYGEYuwoX9Sj9x8DnRlQlXZE+T7LXkjp0sMWCux5P6pGexyPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsO+SdgsQJ0vwcXoJVGCZfTI5XlTpf1HLFWL+goIKJ0=;
 b=VUJgtEyMHSqEYqchqMSKf7EdrKjEQ4nToJWveAxmsC5gGe0zUJLI19qmIniDjjuZ+l0yx0PRwXJbzA60dYjEKoWQRtKO/dDUgvI1wmFMHCw5q3VIlEQVb7ybaFHdjyQ7Q6iHrKBaaD/NCM7epnDsmnvnx6IZVB3Cr1Zpepelkf/vf74nsLxNOrglNGLSe5Q0pCwxc0eBPC6OGV8ce9XHaFTTpbDejsjUlKKksgDjg1cvswjHrPg/ZgOfAdCtXMlHHwpJLytZWf4D9NEfzxfFIeYmRhlc6rSl6a1eLWB7tAmCQTnKuAK7BTDd+9d2gEUyqGb96hHdgrGar91/LHGBsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsO+SdgsQJ0vwcXoJVGCZfTI5XlTpf1HLFWL+goIKJ0=;
 b=k5dSx3sXyCarXVjFTx7te3yIHomfbfTsR6AQBS7XtZIf5JD79rsIsCVBO9ncl6fk0CbY/3WPb9RLNx1y4WezFi5roghTTwy/b2wXFCf6r4uL/zd6tpU0Sq9tFuhUb9N78bUgZf2MKApJwL99m7LpOyZUgKpF3G22L6chMXykxHY=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6596.eurprd04.prod.outlook.com (20.179.254.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Thu, 7 Nov 2019 06:42:53 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2430.023; Thu, 7 Nov 2019
 06:42:53 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Duan <fugang.duan@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] tty: serial: imx: use the sg count from dma_map_sg
Thread-Topic: [PATCH V2] tty: serial: imx: use the sg count from dma_map_sg
Thread-Index: AQHVlTaUfY6m2IkKwUycHbunFPNYCw==
Date:   Thu, 7 Nov 2019 06:42:53 +0000
Message-ID: <1573108875-26530-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0080.apcprd04.prod.outlook.com
 (2603:1096:202:15::24) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0ef5c962-c809-4412-60e8-08d7634db71a
x-ms-traffictypediagnostic: AM0PR04MB6596:|AM0PR04MB6596:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6596ED7349B35A87703572FE88780@AM0PR04MB6596.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:568;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(189003)(199004)(66556008)(66066001)(66446008)(2616005)(71190400001)(71200400001)(6512007)(6116002)(478600001)(66946007)(66476007)(50226002)(6486002)(64756008)(386003)(6436002)(6506007)(54906003)(3846002)(14454004)(110136005)(305945005)(36756003)(7736002)(2501003)(8936002)(14444005)(2906002)(186003)(102836004)(81156014)(81166006)(5660300002)(99286004)(2201001)(4744005)(25786009)(52116002)(44832011)(476003)(486006)(316002)(4326008)(86362001)(26005)(8676002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6596;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uh6TNZI9/LOoedT31UHjdlCLIk5xzcIwMzDsCU3sDZbUpaOji/SVdNfcS2YOHS+l3c4qaNafudB/aUbOUReInROeg9SA+y8quTKsz3xVfXrT3hRul5MqIjboacOk2PM1qtcixmnN4BT9kGN44D3xsxGlvImVN6M4tyD2yZRxwVPBEEkR+50/R2jb7el3hJjXAwekeRmoPF0eQam1q3r2aAYrrxAVfZTBXc7Wgd777Wj5VWhUq0Kw//Hc8D1OlRKjdgfOF1Rd7RoZWyQsiRnFPAodZrPKHnbtT6+WAArEfxh/R0HE1PVshkBlBx84BnnJoJjS7bYTbmd/SfzRg+mQx/PYagUFXV2KbNpHRxPAPOb9n/jE7BgX8jmwpKBlVDWoZmUyWLzBk2FFnWMQV94HR00MeKxYD9euFELlg9dgJ4fLhiRwxP5wHZde0NP42pXK
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef5c962-c809-4412-60e8-08d7634db71a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 06:42:53.7112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DPeBOibxEGQVitDnHknaati+64s+e4AXKPZvkVE5JDbe95tDvPGag2lsx1ZYd+5a7Zll7XZURkPlDOLSS+Z52g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6596
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The dmaengine_prep_slave_sg needs to use sg count returned
by dma_map_sg, not use sport->dma_tx_nents, because the return
value of dma_map_sg is not always same with "nents".

Fixes: b4cdc8f61beb("serial: imx: add DMA support for imx6q")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Update commit log
 Drop assigning ret to sport->dma_tx_nents, it is wrong.

 drivers/tty/serial/imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 87c58f9f6390..f1ddb2cae31e 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -619,7 +619,7 @@ static void imx_uart_dma_tx(struct imx_port *sport)
 		dev_err(dev, "DMA mapping error for TX.\n");
 		return;
 	}
-	desc =3D dmaengine_prep_slave_sg(chan, sgl, sport->dma_tx_nents,
+	desc =3D dmaengine_prep_slave_sg(chan, sgl, ret,
 					DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT);
 	if (!desc) {
 		dma_unmap_sg(dev, sgl, sport->dma_tx_nents,
--=20
2.16.4

