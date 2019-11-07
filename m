Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA30FC6194
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 03:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F3B2187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 03:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Apvtew3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733047AbfKGDCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 22:02:39 -0500
Received: from mail-eopbgr10048.outbound.protection.outlook.com ([40.107.1.48]:55885
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727665AbfKGDCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 22:02:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2dDzL2winvZ11JdSk6FnEAUBPorxhA2TfGYLlmIjc39MoCidEkenhPPBTfHzDNhkUstT0NjBaoIO1Mzd/g68szpMuQmvrIIQLVeCGLcesq+Gt7tv3pOSDdNX34S/MdhKuvOSY/EBYiXt32wLHcxg3lJCaL2eAj25XDBTYAYcc7SAbZihE73Axkcx2e2I3GPkR6wGg/F3ZxGMwsRb5H792vxVsXCjG2boC9Msgq5KeiSgoaYCJ5wVm4zVroKq55B67N7CuxI4skL9vV1T7y0jB2svjVWzMcfmoPaahDR6gw3HpYfa1i3JMDGcY8ZKzRifhWmhgTcRVGr4J6zcxO4vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZv4NopV23VFj1A5wzNaysOILdV0J0HgwrzEEO+i07I=;
 b=EANzX9FfY/8Gm1UtgXWAcV1piuCbFakytR5VCQF2J7Fc1+Akz87DoMEo+wqyE9rDfTWXlJ7hjbpG0r9QflmHlJsW6NwekpVi//macwS3ms3SUmvSUSTyFT6N0XZk3SZpmdBg2a36m2kb2EuJXJ0TkWICP/noXugmrlrZWJ0r7OSlmdqqxg9nAlKDSYXj9NrJviA7LsETH5DoK6aTbYue1+5/7Cv6fkr/CkteqGzYKhU3yWTV2aja5XMaggptdG7uNq3CoralC/4/ecT4Ldnx2QnIr0RM3MH6eMHIDGYLZwxa6EQczD2ZkkSj92Fr4nSigXlZOZbyInMBrkff1sdTQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZv4NopV23VFj1A5wzNaysOILdV0J0HgwrzEEO+i07I=;
 b=Apvtew3b7rUHHksD+/Spy0L0Eo6kfbDZMZ6G4tvt9wUUCcn9jFVWOVbjvn8ExiZNqOZN/NF+xV/KDHrlRu9vcIsXdIvkFt3Az2C4S11BWqzXgatI7zL59NGi5EJKeWEfy8/BEoLI0+sHp57PXvBvGXkV1u7xwX4tO0QtlehBHDg=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5156.eurprd04.prod.outlook.com (20.177.42.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Thu, 7 Nov 2019 03:02:34 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2408.028; Thu, 7 Nov 2019
 03:02:34 +0000
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
Subject: [PATCH] tty: serial: imx: use the sg count from dma_map_sg
Thread-Topic: [PATCH] tty: serial: imx: use the sg count from dma_map_sg
Thread-Index: AQHVlRfNofENwEaBB0GOB39FR9UWaw==
Date:   Thu, 7 Nov 2019 03:02:34 +0000
Message-ID: <1573095656-749-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:202:2e::16) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 475b17a9-c588-4dd6-c533-08d7632eeffb
x-ms-traffictypediagnostic: AM0PR04MB5156:|AM0PR04MB5156:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB51560C55260D323459F1144988780@AM0PR04MB5156.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(199004)(189003)(99286004)(66476007)(25786009)(50226002)(186003)(6116002)(2906002)(66066001)(52116002)(6486002)(8936002)(81156014)(386003)(8676002)(6506007)(64756008)(81166006)(5660300002)(66556008)(14454004)(4744005)(66446008)(6436002)(3846002)(2501003)(26005)(478600001)(316002)(2201001)(4326008)(66946007)(305945005)(102836004)(86362001)(256004)(14444005)(486006)(2616005)(44832011)(36756003)(110136005)(71190400001)(54906003)(7736002)(6512007)(71200400001)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5156;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IK3P7FK6ckhx6PkXhmK5LUcmscCVilQJOdJmDml+/DI6Bl5FQFjPMgd2bSfyMlrZR40hP/3hIP0weugc0oO9dAM9nsxbhxR2GsbFWi3ihTAVunzH3vnQtwyrAY4RcvA/7chqR6ze83WMAWLJA6oepsTOSGq7nN3pLzxmj3pDjM4bTO8r0sZYoOOLEzHPWigO25cHlFSHKuE5WekBPhNKbVmOJOSjtdlnVLrTgGEx2yXELn62pA0agFIHw+PJ8EnvXy6PMAp1BDi3FT6Howu/+Ojk4vZnj42k/wyon+BRYMUgTLP1/h2FEN9midRfWR5qd+VEvB6kpbzbCI9hSdcJvM9lL5duZ9Gd2rO+zj85kSOq2pRsle6/ZGUEjTpu+J1GII/U7KwyZhuTHdVm6c64Hba2r/MAiKGrDoSyJwE8c+MqVtty1GPjmrH+c/JcF2Aj
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 475b17a9-c588-4dd6-c533-08d7632eeffb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 03:02:34.6662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RPMswWn5PSJFh9+pV87nsP9zGF9Kvx7wIyhuJCHWajwyZoB1uGg3bBK2sg+Rtcw1j3QCh/wn9IpUizADxCu48g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The dmaengine_prep_slave_sg needs to use sg count returned
by dma_map_sg, not use sport->dma_tx_nents, because the return
value of dma_map_sg is not always same with "nents".

And update sport->dma_tx_nents with value from dma_map_sg to avoid
modifing dma_unmap_sg

Fixes: b4cdc8f61beb("serial: imx: add DMA support for imx6q")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/tty/serial/imx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 87c58f9f6390..bda7f59ec60e 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -619,6 +619,9 @@ static void imx_uart_dma_tx(struct imx_port *sport)
 		dev_err(dev, "DMA mapping error for TX.\n");
 		return;
 	}
+
+	sport->dma_tx_nents =3D ret;
+
 	desc =3D dmaengine_prep_slave_sg(chan, sgl, sport->dma_tx_nents,
 					DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT);
 	if (!desc) {
--=20
2.16.4

