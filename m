Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB985C17447
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 05:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94BF822459
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 05:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bQ9ZLmeW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfKMFhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 00:37:47 -0500
Received: from mail-eopbgr60045.outbound.protection.outlook.com ([40.107.6.45]:57092
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725976AbfKMFhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 00:37:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aW8wtznXREUs/Ygyhka3sW5q2i3+BtqCh40xlgBTjV7uHMRNCqugHLBTyxII3wr8OEMC7DbzDUc95RsR4JA127uycERh1hfhctFR0eoTwHFzgJzjPi9dr6k9YUcwJl5NPwaXhTzmN1vOaI7BktfH2+Bba5yPJbl/5FKahsJxU7wv4Cc2liFeYBdd/2luW7wrV+mabB9/CtxJi9vGnOLIGhurPU5hwF8SARf7BOtAXa9KzqHmuMjqkARKffSmbfn57QTPYnhOH4Mf5NIK/xfEjznXl6pKT3UUs6KITY0/a64p9vJhWHKHVZBL80tgZKofPPDl0Q15wfyB87yNlwyYCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6PtIXSsYvouOqYN0ds2rqcCpo6/VmIB1E7V3gwciIA=;
 b=SwJX9O+Tpfv13rdGUakpXGaCsYQdS1msS6YROj0ADTJ60KLWPtsEiBn0TbvA+9KvG8EzZwLuGY3R9hRAol5+Km2P5xKTmBT1RiYBVMZHX7QVcSEnmLcCxL3rEYifECTTs7mJUN4HUxWSSnM02tmLTWNSqW30q44VeMRSgUXKSQ/xWp3XyTw7RJjZVNztch2FJfmwikD8DNelxBcCMteCp9wExZIKeJnLW9rWU453ynM50GdnXDgqFU6TYgdc4dBvgAjtWhQQymhopFzsayr7pRfFJnmyzXekxB08mPYezB6YdO0CZ1bVaNgS66fr2Lu7eDLI7PGuNsypYjrlAnAaaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6PtIXSsYvouOqYN0ds2rqcCpo6/VmIB1E7V3gwciIA=;
 b=bQ9ZLmeWFSteem4oEswZTtn8hpJIhCBtBZWQeRckddXVAPS35UN3LZ9xh5vAyz7zMKcR4cvXb+N4nGIJe1nhuEjghmpjKGeK+nRxamRJclsLQ1sVSAR40mFfcKXu4bXQBi+scViesE87WSFjzGn/vnPRjM8OYqy5rNqKucktzU4=
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.150) by
 DB7PR04MB5209.eurprd04.prod.outlook.com (20.176.232.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.23; Wed, 13 Nov 2019 05:37:43 +0000
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::115f:1e4f:9ceb:2a2c]) by DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::115f:1e4f:9ceb:2a2c%7]) with mapi id 15.20.2430.028; Wed, 13 Nov 2019
 05:37:43 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] tty: serial: pch_uart: correct usage of dma_unmap_sg
Thread-Topic: [PATCH] tty: serial: pch_uart: correct usage of dma_unmap_sg
Thread-Index: AQHVmeR4JqxDQDN/nUWmBR6Ye0wD+Q==
Date:   Wed, 13 Nov 2019 05:37:42 +0000
Message-ID: <1573623259-6339-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0180.apcprd02.prod.outlook.com (10.171.31.16) To
 DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.150)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 00b42073-9f51-49b5-4974-08d767fb9acd
x-ms-traffictypediagnostic: DB7PR04MB5209:|DB7PR04MB5209:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB5209D4AE714FC6E2A576D1F488760@DB7PR04MB5209.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(189003)(199004)(386003)(66946007)(36756003)(6436002)(110136005)(26005)(50226002)(316002)(66556008)(6116002)(66476007)(3846002)(64756008)(66446008)(6506007)(25786009)(99286004)(186003)(66066001)(102836004)(2906002)(44832011)(52116002)(54906003)(86362001)(14444005)(6512007)(486006)(71200400001)(2616005)(476003)(71190400001)(5660300002)(478600001)(14454004)(8676002)(6486002)(4326008)(81156014)(81166006)(7736002)(305945005)(8936002)(256004)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5209;H:DB7PR04MB4490.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0DaytV1m6f2J4zBFmtkr3+dzV+PoxKDEHRgwv5AjuSLXBtNGR+adyKWj8CnYJvChY+GwFzVwN7viJO6m5jBOwtTs2v2l8aEQrDtVmQAv488NdFZwGspECjWbKjsVyVGuniTjp4FW6csWVOWHvmD7zeTvy/qL+g/4ToVZSbdJo8VX36DPfTuFPSYcjGgPePM86Lt88mpAFHs+J6zBIRq0RYoGHfBblBCMb24QwYjbQUgSiR/o33gzAP9NBoWRNBfQcFjaFkBEprxYFKvZTrZZwFCB78bR6EDNLllYPRFBp4R94Lbn4lfV8hMksIJebbsix9sHAuof2BBXESfirfBjVdFSOtG4jVOPvqSvmA5gtzPiDqFdOJFmmBbHBwTZYbsHqZkNkovOqt5LP9UdIH4f3FrlakMFtETdUPnA+rQsrUZisutm2OgQBzwLyuxr28GQ
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b42073-9f51-49b5-4974-08d767fb9acd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 05:37:43.0310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B0p/lUoEFRMeI5h2tAB3wwRmu/3q21SptO093O+/zU43tWlOWigibkf2CqnMt4feYZ7l4vJHn6SGzqegzS/7Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5209
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per Documentation/DMA-API-HOWTO.txt,
To unmap a scatterlist, just call:
	dma_unmap_sg(dev, sglist, nents, direction);

.. note::

	The 'nents' argument to the dma_unmap_sg call must be
	the _same_ one you passed into the dma_map_sg call,
	it should _NOT_ be the 'count' value _returned_ from the
	dma_map_sg call.

However in the driver, priv->nent is directly assigned with value
returned from dma_map_sg, and dma_unmap_sg use priv->nent for unmap,
this breaks the API usage.

So introduce a new entry orig_nent to remember 'nents'.

Fixes: da3564ee027e("pch_uart: add multi-scatter processing")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 Code inspection, not tested.

 drivers/tty/serial/pch_uart.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 6157213a8359..c16234bca78f 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -233,6 +233,7 @@ struct eg20t_port {
 	struct dma_chan			*chan_rx;
 	struct scatterlist		*sg_tx_p;
 	int				nent;
+	int				orig_nent;
 	struct scatterlist		sg_rx;
 	int				tx_dma_use;
 	void				*rx_buf_virt;
@@ -787,9 +788,10 @@ static void pch_dma_tx_complete(void *arg)
 	}
 	xmit->tail &=3D UART_XMIT_SIZE - 1;
 	async_tx_ack(priv->desc_tx);
-	dma_unmap_sg(port->dev, sg, priv->nent, DMA_TO_DEVICE);
+	dma_unmap_sg(port->dev, sg, priv->orig_nent, DMA_TO_DEVICE);
 	priv->tx_dma_use =3D 0;
 	priv->nent =3D 0;
+	priv->orig_nent =3D 0;
 	kfree(priv->sg_tx_p);
 	pch_uart_hal_enable_interrupt(priv, PCH_UART_HAL_TX_INT);
 }
@@ -1010,6 +1012,7 @@ static unsigned int dma_handle_tx(struct eg20t_port *=
priv)
 		dev_err(priv->port.dev, "%s:dma_map_sg Failed\n", __func__);
 		return 0;
 	}
+	priv->orig_nent =3D num;
 	priv->nent =3D nent;
=20
 	for (i =3D 0; i < nent; i++, sg++) {
--=20
2.16.4

