Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3FFC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 06:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0310E20842
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 06:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eCiIV90k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392483AbfIFG5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 02:57:48 -0400
Received: from mail-eopbgr00075.outbound.protection.outlook.com ([40.107.0.75]:18477
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728072AbfIFG5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 02:57:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKdPn86Afqnxa0sC949gg4CYzlmbcaXtqsZgbkbAB3IcN03R7n0dShTUnUbSB0C1tKDcYD59kBhMOTf4V6Cdx0bYE3brjSnermqbnEtYtIIFlKm5pvK+78Jz7ngtYuME394GilCeDiy+S5khNqiM5jUlnZ7xyy3/7rvjCJYo5+MUwAkkYxILJEmKvpTvdpPvZkVy3WNixX0rGerI/OTm58O9FN2aueoXUsSSS92A+tA6lkxafHNcalaHjLcX59tFPhfCsfqXRcH4MaItcFVpGwx8084EDX8fqgupPK+LHJWqpv1jyFPNVRzjlxyhfHcuiiPDpYqJ5yY4OafYMRmnHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuXw6Xkb2fu6HqbDTjc2oIDBJ0JCOvQA9ZY9+takP58=;
 b=Wkq3sx1cO3hgOMsucDh/mRsQPZklCCdaUQcq9ulx3ekHAloc2bLEpUEYB8IGt9QXnez3xsmePbNzAkt+afhVyYCxzEn9fDRKEv3/oy2bPfb1tQhmbOqrw5+0eCxcqNYWw9XTPNJzcosNBR109RFzCqhFX3U0AlxqZTs3B2uwhhGpbyw2/r/AahFXI40Q1u1FQc2mrL07jnyjHBlhk9WePPxNaKGuHl1pN6CX1OfojSX+HIznmwC9pajj9Zg8PDl8eHLx/06qXv5gjdOvgnsStdvzT+KS/Agnf9hpgzZicr0S3LYlnOnKbDbrQQPquSYvGLGNyeXds5LlHPdEq6ge+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuXw6Xkb2fu6HqbDTjc2oIDBJ0JCOvQA9ZY9+takP58=;
 b=eCiIV90kPRa4IzWwXPH92k0aFoQePcc3IqH4eDn7nlWfelGPMNaVNn3qDq+yF+qHXHJZpG6qCnctvCUJUgxRRm0G8Fm3sizRY9nbwPbKvDNctFZP+2IMH6IVx8JFvqSbD4cs7MzyL71H47mxBN6jUjDDEX76rQpEqqQUBvgQdUE=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6530.eurprd04.prod.outlook.com (20.179.252.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Fri, 6 Sep 2019 06:57:03 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8%6]) with mapi id 15.20.2220.022; Fri, 6 Sep 2019
 06:57:03 +0000
From:   Peng Fan <peng.fan@nxp.com>
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
Subject: RE: [PATCH 1/2] nvmem: imx: scu: support hole region check
Thread-Topic: [PATCH 1/2] nvmem: imx: scu: support hole region check
Thread-Index: AQHVV89jBufiQMcQikKEwxbrgUBx8KceUNGA
Date:   Fri, 6 Sep 2019 06:57:03 +0000
Message-ID: <AM0PR04MB448106FD48328C2261260F7E88BA0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1566356496-30493-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1566356496-30493-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b4ca197-9bab-40f8-dc89-08d732976c4d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6530;
x-ms-traffictypediagnostic: AM0PR04MB6530:|AM0PR04MB6530:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6530B75A4E35E8A3367AE9F188BA0@AM0PR04MB6530.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(199004)(189003)(43544003)(81166006)(52536014)(229853002)(81156014)(74316002)(2501003)(256004)(2201001)(14454004)(8676002)(478600001)(44832011)(476003)(486006)(7736002)(33656002)(11346002)(66066001)(446003)(26005)(76176011)(76116006)(2906002)(186003)(66556008)(25786009)(110136005)(54906003)(66946007)(6246003)(6436002)(4326008)(305945005)(5660300002)(71190400001)(71200400001)(6116002)(3846002)(8936002)(316002)(6506007)(9686003)(66476007)(64756008)(66446008)(53936002)(55016002)(86362001)(102836004)(7696005)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6530;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: O4t5UK1WvAprjitqMHhEM3eZg3mTdbESU2rzNTsUKfvg6s/uCA2j2bjTAdYCHAeRnKk0FyE6wiwSQ7O2Sbhw5rDd0Tiuyxj47xEgJMIREm/7Wh3+K8/W/UJF5iT5WgbqwqNKemgmQUR7D7nj2mzUJj7IDEFvYY59W37LvkhK+UAzWdldPPHvqgQkpzNu39mGnbo8qirSOmMOxAheGfw0+9Dncsg02nuGwe8Dy/2wYwOOmKU23WrgNjd+ca3nHHEbUQzRtWDOVGYf03sES44bBjuO10/GYCWrGWBMZcsXA2iCQudleJ9nH5vdaN+rnu+s9eChAruedgMUjgZkIhqHnFzXySYsb1tP6fHETE0x/zdXLTHhbSu9GhZuohjv9acW3Bk+AtiV/cqmgy5pDkefXHYwpwkN0NyjgvPwXAeExYU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4ca197-9bab-40f8-dc89-08d732976c4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 06:57:03.2098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R+IMMwS01N97aEWpPG0g92065AimmgFrVl3p7yyfAQLx3cacsP5KLLClGFX+npoMArw3h2b03AtHpTgg4fYHzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6530
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH 1/2] nvmem: imx: scu: support hole region check

Ping..

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Introduce HOLE/ECC_REGION flag and in_hole helper to ease the check of
> hole region. The ECC_REGION is also introduced here which is preparing fo=
r
> programming support. ECC_REGION could only be programmed once, so need
> take care.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/nvmem/imx-ocotp-scu.c | 42
> +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 37 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/nvmem/imx-ocotp-scu.c b/drivers/nvmem/imx-ocotp-scu.=
c
> index d9dc482ecb2f..2f339d7432e6 100644
> --- a/drivers/nvmem/imx-ocotp-scu.c
> +++ b/drivers/nvmem/imx-ocotp-scu.c
> @@ -18,9 +18,20 @@ enum ocotp_devtype {
>  	IMX8QXP,
>  };
>=20
> +#define ECC_REGION	BIT(0)
> +#define HOLE_REGION	BIT(1)
> +
> +struct ocotp_region {
> +	u32 start;
> +	u32 end;
> +	u32 flag;
> +};
> +
>  struct ocotp_devtype_data {
>  	int devtype;
>  	int nregs;
> +	u32 num_region;
> +	struct ocotp_region region[];
>  };
>=20
>  struct ocotp_priv {
> @@ -37,8 +48,31 @@ struct imx_sc_msg_misc_fuse_read {  static struct
> ocotp_devtype_data imx8qxp_data =3D {
>  	.devtype =3D IMX8QXP,
>  	.nregs =3D 800,
> +	.num_region =3D 3,
> +	.region =3D {
> +		{0x10, 0x10f, ECC_REGION},
> +		{0x110, 0x21F, HOLE_REGION},
> +		{0x220, 0x31F, ECC_REGION},
> +	},
>  };
>=20
> +static bool in_hole(void *context, u32 index) {
> +	struct ocotp_priv *priv =3D context;
> +	const struct ocotp_devtype_data *data =3D priv->data;
> +	int i;
> +
> +	for (i =3D 0; i < data->num_region; i++) {
> +		if (data->region[i].flag & HOLE_REGION) {
> +			if ((index >=3D data->region[i].start) &&
> +			    (index <=3D data->region[i].end))
> +				return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
>  static int imx_sc_misc_otp_fuse_read(struct imx_sc_ipc *ipc, u32 word,
>  				     u32 *val)
>  {
> @@ -85,11 +119,9 @@ static int imx_scu_ocotp_read(void *context,
> unsigned int offset,
>  	buf =3D p;
>=20
>  	for (i =3D index; i < (index + count); i++) {
> -		if (priv->data->devtype =3D=3D IMX8QXP) {
> -			if ((i > 271) && (i < 544)) {
> -				*buf++ =3D 0;
> -				continue;
> -			}
> +		if (in_hole(context, i)) {
> +			*buf++ =3D 0;
> +			continue;
>  		}
>=20
>  		ret =3D imx_sc_misc_otp_fuse_read(priv->nvmem_ipc, i, buf);
> --
> 2.16.4

