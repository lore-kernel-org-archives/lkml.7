Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5679C2D0C3
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16B721582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mtLFue7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfLRM0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 07:26:13 -0500
Received: from mail-eopbgr20045.outbound.protection.outlook.com ([40.107.2.45]:6400
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726846AbfLRM0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 07:26:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlIGKJG3MjCW27qNdw2OfAtLTGi9R41j4/ufrvwUndb/GLbAP5apgxo0Jx7f1iq7dJ/gQc9x5qfGWXEZe9CEUNByb4wSePD6Pi3ZJHvVCvKDrb+Fyj/HRnzkWjPPGJ/M/Ardqu7jNiHQWzb75D2OFQPw+UMerbmRGcCjLFxxKYbTQbp8Kh4PTtJ8aSCNjyTAUdDN8GB0GhQNLUMYBy1lHgQvq9jaobEdEFHIxWp5tyHhhqyTK/0czu1TOH0qMYDtGRCg9IhuLq2xFCH4nspYSs98S17MkRdyHgvuLm2DC2MGdDtapl4/PsbinarbtDhoM7LdFMjg+VAPo2x9gBKpYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLvUbKN7N4wJzh0HYEMFRu1WTegTh5b3RqUq3BqhskE=;
 b=hln9h68vdyHRyY+ETGVv3uuE5F/k32kNaFc6FoU1Lh7c+KJ3AGnLLogeyjvIDPhXH1UlnvtUxxCfh/HTWbew/tNTJp/KxoWewGW2SOYulS6gwdGfmwX7gxnNxS9lLjQeEcsZjcTexKVp/4z4sgsWctjqYTGm1o1wEGSF/8Ufl8f51/PTGCpuvl2+uMC1XVIN+54dIaeP1LpNPGXxxeDi14ujDGwkY0niaPaeTcsgPCibciY1iA8xCqHGxwlsOJRT2kO4UgmZRzlrECwoZewVQVEoqa+O37g1FxxdY+OYiLWoUone7wh7/NzgODChx/xG89fJzblkK4O6zIAiIq1MuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLvUbKN7N4wJzh0HYEMFRu1WTegTh5b3RqUq3BqhskE=;
 b=mtLFue7zNlz18AADXyUEDYX2UcVQ9Qa4cwdocvoR9IALYVXe6dE1axCBDEARFPZ1E3EK6Yz6M7FNxiHqgD/oD9BESD0usBzGTZdA7y2mhqNHDzCp9xGJV7Qb7f81C7uKhqO5RTGq0kqgjcom0pKwz2mlhHX3hLscnd0bA0d571w=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4339.eurprd04.prod.outlook.com (52.134.126.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Wed, 18 Dec 2019 12:26:09 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29%7]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 12:26:09 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>
Subject: RE: [PATCH 2/3] tty: serial: lpuart: support UPIO_MEM32 for lpuart32
Thread-Topic: [PATCH 2/3] tty: serial: lpuart: support UPIO_MEM32 for lpuart32
Thread-Index: AQHVtU7MbgMKpyTk5UKlUKdGm+4doae/0R6g
Date:   Wed, 18 Dec 2019 12:26:09 +0000
Message-ID: <AM0PR04MB4481D6C5CD27F410359F53A788530@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1576637626-19317-1-git-send-email-peng.fan@nxp.com>
 <1576637626-19317-4-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1576637626-19317-4-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f20afbdc-ebab-40e0-198e-08d783b576aa
x-ms-traffictypediagnostic: AM0PR04MB4339:|AM0PR04MB4339:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4339E7B14B0B32128080AC4288530@AM0PR04MB4339.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(189003)(199004)(5660300002)(6506007)(7696005)(54906003)(186003)(316002)(110136005)(2906002)(4326008)(86362001)(64756008)(26005)(81166006)(81156014)(8676002)(8936002)(52536014)(55016002)(66476007)(66556008)(71200400001)(76116006)(9686003)(44832011)(478600001)(33656002)(66946007)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4339;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dae1DvmSm0TfgvCGAjakeAlOV4UHcrRSj7q1PUqlf+dLPxtnkRKVr0ktTiZgvaYuftoi/Z/B9fjzECDNr/ufgXll4Igik7puYeJtxMU8fEo9nhy1/ALPoaMWJh5vfYPWsGQyCCzUjwKBhQVx9r/RXCEss2PXn0AkR1/0PkSvB9jBh1FWbT1nHqXyvr2d85cQzMzZBqHFrIOOX5UXrABj3LuFCR6aC5GhDT3nEjg5bE6FqWDTgfHCam361TwnSfEGURfa7eTm3E6I9DXwJlkZ/8/sAEFiqttJtr8rSmSPalXVi7+mLSaMBIP/xAQvVI5VO4I/HXSbmpS6+cFwcBkPUdmMLvxBS8b5fiooplFI/dVrbUNxhg3f0P5oGK+QQvecIqjxQvIFopBsw5sHfVsW9HJnJX75IV90IkGJ54Z0HEGruZU/9kCT8omXdjaE75Fs
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f20afbdc-ebab-40e0-198e-08d783b576aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 12:26:09.6944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LD6HJ10KWbJIFufQfkuMUKdMwzd6eJZF7f7LxtuqJwGfhoDVvfV9Q2IUcOhmM5m9v+znG8p3eubMd/bOMpm0kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4339
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> Subject: [PATCH 2/3] tty: serial: lpuart: support UPIO_MEM32 for lpuart32

This patch was sent out wrongly. Not affect the other three patches which
belongs the whole patch set described in cover-letter.

Should I sent out v2? Or you are fine if the other 3 patches are ok?

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> "earlycon" no need to specify the value string since it uses stdout-path
> parameters. However when earlycon and normal console are not using the
> same uart port, we need specify value string to earlycon, this is what we=
 need
> to do when support dual linux using jailhouse hypervisor. The 2nd linux w=
ill
> use the uart of the 1st linux as earlycon.
>=20
> earlycon=3Dlpuart32,mmio32,0x5a060010,115200 not work for i.MX8QXP.
> It is because lpuart32_early_console_setup not support little endian.
>=20
> Since the original code is to support UPIO_MEM32BE, so if not UPIO_MEM32,
> we still take it as UPIO_MEM32BE
>=20
> Acked-by: Fugang Duan <fugang.duan@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpu=
art.c index
> 54c7735406f8..6ad0af073e62 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -2376,7 +2376,9 @@ static int __init
> lpuart32_early_console_setup(struct earlycon_device *device,
>  	if (!device->port.membase)
>  		return -ENODEV;
>=20
> -	device->port.iotype =3D UPIO_MEM32BE;
> +	if (device->port.iotype !=3D UPIO_MEM32)
> +		device->port.iotype =3D UPIO_MEM32BE;
> +
>  	device->con->write =3D lpuart32_early_write;
>  	return 0;
>  }
> --
> 2.16.4

