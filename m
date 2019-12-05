Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645C8C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 01:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133562077B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 01:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kug19nlq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfLEB1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 20:27:24 -0500
Received: from mail-eopbgr130049.outbound.protection.outlook.com ([40.107.13.49]:47590
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727146AbfLEB1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 20:27:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdCec1T0EzTpZJIHfrngVSHtlfKL5dpOj6F4Dac0UruiYp30vHJCw+hRAjjpAJVUn1gHYKrqJHHPL4vfgiaeGKsrBpKpXl0u2/pPOD9H+nTeuOX/hmCnM3dDgiCxiORbGEepRN4Agyn+t4D9nsu0QC3e0BPlXtgOKpMhBm1vxtEpMw/UNvJ8N8MN71z1ymuNRF+y7wQmLxxIgseEshODbQ/dcm6H/LdNKP2NSrL5WyqWEhfbZuZfAdMg4sSfiHQiipNJylkctyt9w/7aRE8P2RpBta8RicPnjHh2Z5NjH+jRU1edPufJC5o6s8pmm63r2EnLU5JLtftoMHCWE78geg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZC5wJF7MyeH/DTVQOW7m0Z0ZnMZHJtUHAFEMZ4f32u8=;
 b=J2sKmkgF18HwYy5b1OU3IRi86b74zdqbB6qyHJEkUFZHLOQPvSNzbQwY+XqntZBLkiu4m3cNiqYLXw2GOeyPyUEbEJWh7wGSE3cpr3eqUa5Epe/6BhFWkkEqgN3voTdVDzyDdiaRCWLxwDTqA7gdEYDLU8ffABB74uqj0Tka9MPK07fmgR4X7n1nDGkNAZEA/hgw0D0lRCylzVWJ7bnOy6BOrj1POVYSnaM6tDXTxyj0P9+eTI7Pa48pX/CYal/J4X0GdoNOS4I+HZYlY98+1bQX5lDKZ3O98SlM1XWJ4qvKvdm2pUma3Zx72C7+LD3HAD4b2Yq8LMzmZ44wG4H5iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZC5wJF7MyeH/DTVQOW7m0Z0ZnMZHJtUHAFEMZ4f32u8=;
 b=Kug19nlq+IC6O101JkN0xScRiQ4GN0o+6b9m8ZZdjLbT280LL8ffXx3YRS+Ej3eDqWDuJCMbGw8syQ9Q499o2g1DsJyLgwzoPrvtCOq6j/B4NTY9ywOjPwDf1dCsbcLCB1XrAgIHrALBQKjX7Y0wkLasUFD5SJsl72LLp7CBpuA=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.3.146) by
 VI1PR0402MB3823.eurprd04.prod.outlook.com (52.134.12.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Thu, 5 Dec 2019 01:27:19 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::30e0:6638:e97c:e625]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::30e0:6638:e97c:e625%7]) with mapi id 15.20.2495.014; Thu, 5 Dec 2019
 01:27:19 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [PATCH] nvmem: imx: scu: correct the fuse word index
Thread-Topic: [PATCH] nvmem: imx: scu: correct the fuse word index
Thread-Index: AQHVqmb3nxYwp0MksEa8htHeEretqKeqwU1w
Date:   Thu, 5 Dec 2019 01:27:19 +0000
Message-ID: <VI1PR0402MB3600684CB1E283E73925FE66FF5C0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <1575438591-12409-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1575438591-12409-1-git-send-email-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b958a537-4dff-4353-8325-08d779224564
x-ms-traffictypediagnostic: VI1PR0402MB3823:|VI1PR0402MB3823:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB3823A2980BEF3F9E6170D01DFF5C0@VI1PR0402MB3823.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(199004)(189003)(6246003)(9686003)(55016002)(8936002)(81166006)(81156014)(478600001)(99286004)(3846002)(229853002)(6116002)(110136005)(4326008)(14454004)(8676002)(54906003)(7696005)(71190400001)(14444005)(76176011)(71200400001)(316002)(2201001)(6506007)(5660300002)(186003)(25786009)(102836004)(26005)(33656002)(86362001)(2501003)(66446008)(7736002)(6436002)(66556008)(76116006)(66946007)(2906002)(64756008)(66476007)(74316002)(11346002)(52536014)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3823;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0u9L2VLtPj7YaJaHaPSS3vKwjlkbBt7mWmwT8GZWG1ZoQoa8zddBZId/XHXixHgDd0T/v2/ovkETiqtdwBFVP3cBiQq7AvOSV3ETux8xeyE8w1NSSu2nlm4OJlhDJYO/utfT1SgRvdgwnqKf8bIB1udiE65XGPl1zeKvFNBVkKsEpPAKyiilLovGaFRm4gCI3FChcwREqGVPgkVBZlJkMgfvDEIqKxpCE/hkz2Rr/362aIUg7yK9yGUJT2xRpFkhirgopvhCdlQLkMvmUW7mN02SsVcDtXJC0OI4tl/lvjxeSTyQURE6wZBb7g8LpPIjJZkFu5mkQjHd5hVDqQdsQirXS/S1k0CEljZA8Pyqgy+5gxVz4weYA+ADR+RQs/CeU1ScsA8vAa8HGJeoq+UyH3NNQ9Gacs/vat0dGtLvNuz96HMIy7PmJFeelPsGEhId
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b958a537-4dff-4353-8325-08d779224564
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 01:27:19.3949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrjiCBtYSht+JC5it5xOWssMJVQ4wGNLSeS54LpW2QXuyEyFs79Qh/kKQi50UxVdV7tbZQ+t26vybKJpWuznPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3823
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com> Sent: Wednesday, December 4, 2019 1:52 PM
> From: Peng Fan <peng.fan@nxp.com>
>=20
> i.MX8 fuse word row index represented as one 4-bytes word.
> Exp:
> - MAC0 address layout in fuse:
> offset 708: MAC[3] MAC[2] MAC[1] MAC[0]
> offset 709: XX     xx     MAC[5] MAC[4]
>=20
> The original code takes row index * 4 as the offset, this not exactly mat=
ch
> i.MX8 fuse map documentation.
>=20
> So update code the reflect the truth.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Fugang Duan <fugang.duan@nxp.com>
> ---
>  drivers/nvmem/imx-ocotp-scu.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/nvmem/imx-ocotp-scu.c b/drivers/nvmem/imx-ocotp-scu.=
c
> index 455675dd8efe..399e1eb8b4c1 100644
> --- a/drivers/nvmem/imx-ocotp-scu.c
> +++ b/drivers/nvmem/imx-ocotp-scu.c
> @@ -138,8 +138,8 @@ static int imx_scu_ocotp_read(void *context,
> unsigned int offset,
>  	void *p;
>  	int i, ret;
>=20
> -	index =3D offset >> 2;
> -	num_bytes =3D round_up((offset % 4) + bytes, 4);
> +	index =3D offset;
> +	num_bytes =3D round_up(bytes, 4);
>  	count =3D num_bytes >> 2;
>=20
>  	if (count > (priv->data->nregs - index)) @@ -168,7 +168,7 @@ static int
> imx_scu_ocotp_read(void *context, unsigned int offset,
>  		buf++;
>  	}
>=20
> -	memcpy(val, (u8 *)p + offset % 4, bytes);
> +	memcpy(val, (u8 *)p, bytes);
>=20
>  	mutex_unlock(&scu_ocotp_mutex);
>=20
> @@ -188,10 +188,10 @@ static int imx_scu_ocotp_write(void *context,
> unsigned int offset,
>  	int ret;
>=20
>  	/* allow only writing one complete OTP word at a time */
> -	if ((bytes !=3D 4) || (offset % 4))
> +	if (bytes !=3D 4)
>  		return -EINVAL;
>=20
> -	index =3D offset >> 2;
> +	index =3D offset;
>=20
>  	if (in_hole(context, index))
>  		return -EINVAL;
> --
> 2.16.4

