Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549A1C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 06:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE882467F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 06:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dU5WP7+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfLTGNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 01:13:48 -0500
Received: from mail-eopbgr130072.outbound.protection.outlook.com ([40.107.13.72]:29146
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727180AbfLTGNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 01:13:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcNq0WEMwwKtzF1xvqcTelbey4UrbJDSQ0+yg9jXXVSrVJO+cDX0PS+zLgRr3cSqFvisiDzAuyNHWhUz5X2nFJQCwJzLJRD6VNI046A9nKhzlCrB86y+NCm8StYJjs45MIk+5pesacKw1YrLDlI5yewLo4tYNbcaE5lpuHvs/++qohlnyCj6mKQw3UkYVWwFtCYXDq4osGk/gPJtJmkzfeWsI1xDpv/gKLtHwwyg1uMZzJxaIoiKZMUQRpeofkh9bBF36oJ4jgMyT8j1lTuf8D6eq9GbdMBYKKEU51RDYxDO05MHsYuIAPe8aWXCPD5o5vURlc6P4D33LkNagmGU9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdDZuXIFMizBqFt2pPoTZPsYd8mBPP2ZSCynFg9GG3U=;
 b=kftWn3zrmQs4LbhzptBH/5TsoYZ88Nsr3IYSwokPKtHIiVLsPScXV0roLv8qXns/+KNi8bRvP0XH9RlvteoFZqXuJ/Z/gXKHBSU3r/QM2+IQrp6R2fCHwJhba4MlJHuOx6OZow3K4ZEcBb7UuFHhQNymV0dbJiyB6k1G5lRE/eXfCIs86Uf6m7T1y7BO9nPYAqH4r4n4nENXTCl6YXz2u+yJCdgI9WfmU7rZY36E7eEqdrygpMW8MgPcKqUQ0f8BeZfcp7o1TRtxyvz4nKu0G4O45Scp3ftD0W+Nhpr+l3K/VXIJnOwILbq0liS6/5+gvmso3DIS2YR6+EaXSpUJdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdDZuXIFMizBqFt2pPoTZPsYd8mBPP2ZSCynFg9GG3U=;
 b=dU5WP7+W/0HiLPmJOs2TcpkdH2RFB85NsXgeZBsNJyliFPv7K3V8doc9ouMu8uM3vBuTEYyRaIf+M6o40DNV9Wdyg8icpV0Wp7eAVPS8paxj1lhEHwnYGuAfXScnSyvD8joqpvmvab6zF79+qr2nugqM1Fn86p8blXnG+PMxQ1U=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4801.eurprd04.prod.outlook.com (20.177.41.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Fri, 20 Dec 2019 06:13:41 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29%7]) with mapi id 15.20.2559.015; Fri, 20 Dec 2019
 06:13:40 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/3] tty: serial: fsl_lpuart: support UPIO_MEM32 for
 lpuart32
Thread-Topic: [PATCH V2 2/3] tty: serial: fsl_lpuart: support UPIO_MEM32 for
 lpuart32
Thread-Index: AQHVtvydb7VxCn4GQkK2pwimF3MhEA==
Date:   Fri, 20 Dec 2019 06:13:36 +0000
Message-ID: <1576822230-23125-3-git-send-email-peng.fan@nxp.com>
References: <1576822230-23125-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1576822230-23125-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR03CA0056.apcprd03.prod.outlook.com
 (2603:1096:202:17::26) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ceeb3b67-3447-4493-baf1-08d78513bf79
x-ms-traffictypediagnostic: AM0PR04MB4801:|AM0PR04MB4801:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4801DAE7685C23C899CB522F882D0@AM0PR04MB4801.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(189003)(199004)(316002)(110136005)(66476007)(66556008)(5660300002)(64756008)(66446008)(26005)(81166006)(81156014)(71200400001)(36756003)(6486002)(4326008)(6512007)(186003)(2906002)(86362001)(54906003)(478600001)(66946007)(8676002)(2616005)(8936002)(6666004)(52116002)(6506007)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4801;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O2ed2CeSkm/qxhTARGyCCb2heGHrjtG6eHusq7KLTierfUG5S5SpXnbtzi3AWZBvyJ9z0ExQOC/eBvCqGVA+GskmJsURWe+3oZ4JpPP2f+AveH0oXKdOCHcXJAiWzuHHC/8BbVM+k0X+2oSdexAc9hV6+zd2jaqDrCedrIXIysQQuYZ+NVQbrsPm0BJK5o/7Usu9NEetePSiJ68jcIK55jEcEhg1kL7ztWnxAGp34t+nveMhfBE0P5/ZtQEcfVws9CqfpFYWDQunRoe/U2Yq06jv9DmV3tNrLLpOlG850+zvr0rk4YDEJ5QH0jndf2QQH4ES1TnZle8AeOcA0AnYDE4RA2yHts22Fy0uwMmssaxXdW+DVHmL7oW3vcpUG8OMZ47S6k11EjqUdQe6PDE0rHSNAILYGsL/vJcChEso8ObF6GIzfLVABqK6o+Fyo23D
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceeb3b67-3447-4493-baf1-08d78513bf79
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 06:13:36.3361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w7y8GdOJoqMm2tGo/1L2JttkbFp8xS9Ak+JBGcc+ndQ5M08ewXUpLEtjGJTyclWgiRL1FpfdKNANvJOGySlFYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4801
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

