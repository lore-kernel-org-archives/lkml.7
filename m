Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D25C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 02:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474A421582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 02:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JBLoJlFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfLRC44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 21:56:56 -0500
Received: from mail-eopbgr10047.outbound.protection.outlook.com ([40.107.1.47]:24705
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726518AbfLRC4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 21:56:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRP4cqReEMTMNWMfcb0NFKZ5WCMW4wj8NsDhmNSMo5yzHVhqbr/VYJHujTnYL4D5sgEhStEaQIMvROj407FeF/ec1FNcXtYxD+dD/J/hAtheCeZkQQFn9GyVipxpX6mJaMKhXuUS3Wtslrzd9dbyPleOAzuDwDyT1nZ0jWg6e9QpRNhiLDVczOyzGQ991j1rUnaxH7igjalBb6C6cUtGKiT2/aAS9sm7cvYodcaT2GmE3kQ1GtDHTEKrEo0kgfmZ1bmvlN0db3DKpRwttMClqGUaFwb993HhOonxZHEruUYe7ea+txlyN6DOrR4vBaZykz5meBUDxz2YtO4R1tQK0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdDZuXIFMizBqFt2pPoTZPsYd8mBPP2ZSCynFg9GG3U=;
 b=CkuM7kdZCLsWQZP4752+IclGunjPPgEDOSUHAUwAoV09pPnyX/bx/BioAx/v01B+HLJcg4gTRxlSCu8sfisLz615p5mCIC90aregbGeLra8wMShlboXlpbA6QuCcNztBZ74aKeJy0HKnd3f2bqWR4G6ywOKYlfYwcRln/bqenIVhPatFfHtdK+hwPmVaJBeB/vgdoBXPUaAwQzhuyygYD/epj1bXhtsDge4X7Nsu1KfJBaKl2dcF5T9isJF4Z/eDgXAhoQOy7dQr1JCyl24T9tn39nZdfDWLmDRY3oQmc3Bv46r8oSgXLMQ2N0es1k5dke77MNcsLqRr7QY4Yn5hgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdDZuXIFMizBqFt2pPoTZPsYd8mBPP2ZSCynFg9GG3U=;
 b=JBLoJlFhNI/QdYwAvnBxiuyzYJ8fLJUyoETpgW1tYTLUHTGznzPnl1zMByQykvt6PlC/m5pfHdhb72/Wp6ug+NjqOJec/Vd+mXxSnPhQ47eoc28XIlljCqTPvOoOVwp+nx/ioSOkyNjD+A1qvcCEyVHn1fmnyZmZVVDBFCRCwxc=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5715.eurprd04.prod.outlook.com (20.178.117.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 18 Dec 2019 02:56:52 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29%7]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 02:56:52 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/3] tty: serial: lpuart: support UPIO_MEM32 for lpuart32
Thread-Topic: [PATCH 2/3] tty: serial: lpuart: support UPIO_MEM32 for lpuart32
Thread-Index: AQHVtU7MbgMKpyTk5UKlUKdGm+4doQ==
Date:   Wed, 18 Dec 2019 02:56:52 +0000
Message-ID: <1576637626-19317-4-git-send-email-peng.fan@nxp.com>
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
x-ms-office365-filtering-correlation-id: 6954a49c-5b4a-486c-fe53-08d78365ef0c
x-ms-traffictypediagnostic: AM0PR04MB5715:|AM0PR04MB5715:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5715A47DC7B566EAE5ED9E9588530@AM0PR04MB5715.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(189003)(199004)(110136005)(54906003)(316002)(71200400001)(5660300002)(26005)(186003)(66476007)(86362001)(66946007)(64756008)(66446008)(6506007)(52116002)(66556008)(8936002)(81156014)(81166006)(4326008)(2906002)(478600001)(36756003)(44832011)(2616005)(6512007)(6486002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5715;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: djFkChleeJm6otjuMe8PA7N7XHbV7ebYNunv0k701EwrMY/rFwsTu+d0ZhHIfwWmL/DvQ238JaHIf7Hw+M2VBiOTd9chrHukJr63gW7prDlggm/G+3uOqAOG98QAMz+vsldKB/8EolbVcC78iuBPqQ1sMgZrV4O7GP0gYP5gE/Yic7lHfK4v2jksZrkttUppmr86Y16LxyELrj5se2L/4pyyoMozr51OcTJ6t6dJ4FH9FSmlOabIigqH+MuHtX8FfbDKsV/l98ynH+bqISm8iD50GRmYcjTRrfvFOeKHWCy4KWjRqZedhfZjDPaRQqLN24388ghcbu7BwBYjJhlO8CTTY2TU1kvHjmZcjrz0EXhrliDoQCeogGq75Bmo4lCPXf/5xyJRw8URUsLAuY6y1269XlXjTnobRMsqcEa1S51jEHfGlfJSc85GOVnoGxaY
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6954a49c-5b4a-486c-fe53-08d78365ef0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 02:56:52.5973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bkdd8aiIbRXreFFnyQWXoMQyQPmaubT7Lo3if55SwdjTk+5M2R73FMdc57g6j2JoQDniOoAugjsasNqIb7DRRA==
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

