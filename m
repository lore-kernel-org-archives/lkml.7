Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8680C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 02:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDCBF21582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 02:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OZ370daF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfLRC4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 21:56:55 -0500
Received: from mail-eopbgr10047.outbound.protection.outlook.com ([40.107.1.47]:24705
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726587AbfLRC4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 21:56:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+N8sPPNFal0l0zF3wiMZ3k4MOClCc/PmlurA+A2Ne6Q/U3+Wbi5ljYEu3ZeCTSODb9FWnz29GOpD8zp1cPmrbSyivxxi3OQFL+dRfeW3hMMF3ejOZ9uMXmeGqWFkl6U0uVz7iAeOl/Lnyd9vR8ZouP9ZvRkubQ723MN212oNDNq3Is8WoRvlQSlDkME7k1Tn00hqcTbXRnZ9TU2znVyEUWW6dzuxMhl+THge3e0XyMGSgxE68oeXbfzu2Pu8dreGOhtKS4l4REoPYpaKqlxIhY7E67arjiAETnlfmkPP+9tRztjCxPebOvK4DBX/2Us9y02TGWLWocxSvwAvDvK8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdDZuXIFMizBqFt2pPoTZPsYd8mBPP2ZSCynFg9GG3U=;
 b=aXLhYQTR0EbhDDtNNiyLrjwgBT1PemXcP8MngwQZbJ36ac2kBrfwKZIzz/6/+Lx4+lpHAmxlLt880vUgZxssz+bFwCURggwYQZdbmtjAgWeDIQDjk+sN/Ph8QZ5S/KrBnCIixU6pGoUfj2s8Xx4jw8PGCxb4xph4GchaN8UkWq4cJMrKOURsbuuVFM5RySekNU70Yi0mUVtZoAllfqUX8OQ3fGqtkyXCsNaEFttqz5pPdSfBL+rlSWPHpPPfbohe3oaK8FY4PNmBRi04T+jD2rvK2juRBHfd23cyeDjGLO0/uigYs85y3ccjzzLyKgzuxLCklS328ibthkLi+mIlTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdDZuXIFMizBqFt2pPoTZPsYd8mBPP2ZSCynFg9GG3U=;
 b=OZ370daF0w1oLO4HNpKEvaK0uMdIuo5RFHvqcObbiDE2yBXT6S8JxnrRX5Xw+r9tLhzjWnRehsoP0E02FDpl/TsrvCY+5f5gEog3g+jTi37MJmdz3xKMmu/AfKUMw+TmA7HX9AjWfV410yftrXBjwNf9CjyWLqBtS1fWoQ6cGQ8=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5715.eurprd04.prod.outlook.com (20.178.117.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 18 Dec 2019 02:56:49 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29%7]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 02:56:49 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/3] tty: serial: fsl_lpuart: support UPIO_MEM32 for lpuart32
Thread-Topic: [PATCH 2/3] tty: serial: fsl_lpuart: support UPIO_MEM32 for
 lpuart32
Thread-Index: AQHVtU7LiuHFnFngAk26kRoZ/hfTHg==
Date:   Wed, 18 Dec 2019 02:56:49 +0000
Message-ID: <1576637626-19317-3-git-send-email-peng.fan@nxp.com>
References: <1576637626-19317-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1576637626-19317-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: KL1PR01CA0100.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::16) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 486deeee-3b8c-4bee-826b-08d78365ed53
x-ms-traffictypediagnostic: AM0PR04MB5715:|AM0PR04MB5715:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5715ECF7B9A65214DF7BFFEB88530@AM0PR04MB5715.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(189003)(199004)(110136005)(54906003)(316002)(71200400001)(5660300002)(26005)(186003)(66476007)(86362001)(66946007)(64756008)(66446008)(6506007)(52116002)(66556008)(8936002)(81156014)(81166006)(4326008)(2906002)(478600001)(36756003)(44832011)(2616005)(6512007)(6486002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5715;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0WiNHKeT+PMaHXHJfooGSB/KibK568b5zMFhK2p8rxYZUfTvYR0kZZnxMaSCBRoN/2ogB11EzK0VUhHgrahG29LJtWlokZivkBtpoqGBBgTXV9qyP+oI9zHLH2NWUIC6hNaavwc3d9wQzt2ZIm1BIE+LwsmEwPIg2ewdziejwqxex468yKUKjyvwHZ9vCL2Qwtmo2rKSssILPvgVsBjLMFnzVeQJxF2MVrHUPvtaicIjrScwJPVfdoKBCSAmapofDnyD1SkhXX6OmWR+pb6snwgXFd45NBcTF3T6WpdibbuBCzEhLj3JivuVRphLv5fRVn21kgVJ0ctoSi9iGjmEoEv5zpNESDD0RoMkGw5ldrOx6JSrfI8f565eUrfPXMzyU6OczYKuG0UnYMSZ/rYqAitmuE0c/39vu3bK3N1mYx76glTGy0/gQch4VHdvxAQP
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 486deeee-3b8c-4bee-826b-08d78365ed53
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 02:56:49.6700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KIpXBSsXVkVjb7eZFZIaVsmnZ1n5xLTJjISUFPsswJvXW/vpomhBquoo6MPxz1164sA5paYoSl6SeAEuNGNSVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5715
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

"earlycon" no need to specify the value string since it uses
stdout-path parameters. However when earlycon and normal console
are not using the same uart port, we need specify value string
to earlycon, this is what we need to do when support dual linux
using jailhouse hypervisor. The 2nd linux will use the uart
of the 1st linux as earlycon.

earlycon=3Dlpuart32,mmio32,0x5a060010,115200 not work for i.MX8QXP.
It is because lpuart32_early_console_setup not support little endian.

Since the original code is to support UPIO_MEM32BE, so if not
UPIO_MEM32, we still take it as UPIO_MEM32BE

Acked-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuar=
t.c
index 54c7735406f8..6ad0af073e62 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2376,7 +2376,9 @@ static int __init lpuart32_early_console_setup(struct=
 earlycon_device *device,
 	if (!device->port.membase)
 		return -ENODEV;
=20
-	device->port.iotype =3D UPIO_MEM32BE;
+	if (device->port.iotype !=3D UPIO_MEM32)
+		device->port.iotype =3D UPIO_MEM32BE;
+
 	device->con->write =3D lpuart32_early_write;
 	return 0;
 }
--=20
2.16.4

