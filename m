Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055FAC2D0DA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 14:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14CE2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 14:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jacZk/8o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfLZOJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 09:09:22 -0500
Received: from mail-eopbgr30086.outbound.protection.outlook.com ([40.107.3.86]:61700
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726074AbfLZOJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 09:09:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2soy5C08uFGzpgabNbb+jL/on+h8rBJcnDK9ugS8sOFctvdJ3kdD2wjxphkDC0o8lrXdmrTz2dX6dglK/jOpzLhtVEsLQAVsOcniZxcuidmTUpguSujlm5wrojpKP/5wpG53CtlmihkJt9jkfNcB0E0A7S4tI1E1QXAHvAhogD4G66Qb0DFKi6zXgCqJ9au2E7lwtZdrfB3qM7LXXjVpwCgdtm46RfFEh3tM4mZsHA155zPXH9xmsLcg7L9xndlWMTd8QS+Yob4FnCwbV/FsPVuwZdw62IkUP6SYz1tAxYn6zbElmqTabJgGHOrFBQmORJ3LwLwqbQwesIeqrfAKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OxQUTRftMDVvcYmeB2xh34aiKVgU8gffUfw0MuTAuo=;
 b=OgARt3150RKIolp+Bq7c+GCmxOZAi3q3YD8o7ek1IN5aJmSmfpivyTE8v+yAm3Jn34/+IPK+ztsXoJobSuYFwPoVZw710vu1TAtG7Uam1oASOepevgJIPSPyUFaB1/ex6iHMInza2Fn8RueisgrwoQSd4ygrbNBIOTq81rs/o3H9y3WL4eHJ+JyUan8DbAT4RCmT7QUZoSqoosbh6efvvXyR69uJqHd3J6nE4XKx9tIHC3Up67mJnmc6QkZmq/aWVf21f1TrcesKQd/0O+kfVDCUyp8VTjlIifCV0yGontFuZB2N3N9xaDPZ7zcWa63efLjpnZGFwNm4+06oYJKK6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OxQUTRftMDVvcYmeB2xh34aiKVgU8gffUfw0MuTAuo=;
 b=jacZk/8oF22CZnTUMUwJI6JYFrdtccHe2+cRrPYh8zKt42AA9iYzi3xdo5JdkX6523rKoEsCYKtPeI24QiurUdBuq7HS+DHtSU4bCA7/V4rEy25xwcepfDxsbjjc6SaTAzD5CPw/qNkn80zDf8Tr1xJAEx5u97TavDE2wwPaOAA=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6739.eurprd04.prod.outlook.com (20.179.254.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Thu, 26 Dec 2019 14:09:19 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::6d52:5678:e02f:95f4]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::6d52:5678:e02f:95f4%3]) with mapi id 15.20.2581.007; Thu, 26 Dec 2019
 14:09:19 +0000
Received: from localhost (89.37.124.34) by AM5P190CA0014.EURP190.PROD.OUTLOOK.COM (2603:10a6:206:14::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend Transport; Thu, 26 Dec 2019 14:09:19 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] soc: imx: Add i.MX8MP SoC driver support
Thread-Topic: [PATCH] soc: imx: Add i.MX8MP SoC driver support
Thread-Index: AQHVu7fC3Wuy62Zsmk+NxYjiFbeFH6fMdLAA
Date:   Thu, 26 Dec 2019 14:09:19 +0000
Message-ID: <20191226140918.it63mk3l4dlzzxca@fsr-ub1664-175>
References: <1577342402-12329-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1577342402-12329-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P190CA0014.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::27) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8b55fc83-1e1b-46ed-44fa-08d78a0d331e
x-ms-traffictypediagnostic: AM0PR04MB6739:|AM0PR04MB6739:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB673906CEDF0E490F91D67F8DF62B0@AM0PR04MB6739.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:261;
x-forefront-prvs: 02638D901B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(366004)(136003)(346002)(396003)(376002)(189003)(199004)(66476007)(66556008)(66446008)(71200400001)(44832011)(86362001)(2906002)(66946007)(52116002)(186003)(16526019)(956004)(6496006)(64756008)(26005)(53546011)(33716001)(54906003)(316002)(6486002)(6636002)(1076003)(6862004)(8676002)(4326008)(81156014)(478600001)(8936002)(81166006)(9686003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6739;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ASAdGEtIsm24qTBFgO9soKT8T0uWHEDObAeFUzc2omLA9gj+8ZI83BUa7OAVJTWo74/+l4jCkZxaPkMkE8/RVcxMJSyP4qSqsNnOZwPcw+AmwFLXgbGhdPa25hi3/cze8Cipgc1Qd215k1xUlMrnNbUMa1mla8lWPXE3f3b5m/IYsYXb+18IRW+v0bwR76T6NifDZ9ITnoM4Tn5b8GncXLshSEcWrGz9cgOiGtoty/PC0QCBbbG3F4DCe3n0uVEJAKcnccrBJZ5JgCrXWQlUEXaSV/RjXDacjThbCTKxRnjcVzOtgFduOmIFN5bqUHvqwhlpi2O4gfTT3LHqXP0/NEl1/dNBZh2sY3XvCwJddcB644qXJbdKxVvzsqrxb5aLYiZ2y4zKlVQSYxlo7jo3CVycpqgvSMK1VZV5T22K8v1Pzc5CWi0nFS44fGxgZOuX
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AF8C5B6B69BB7846B7AAF7EAE2A2504D@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b55fc83-1e1b-46ed-44fa-08d78a0d331e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2019 14:09:19.4723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X4F7VJOzqlv21aC9Zh/TE8tHjfPw7l5ptUmi0bXEpCu+DgZ/h3p1CmwC2Kmf3Oi8Nb0JgOHFAJgXjNJjzz+MKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6739
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-12-26 14:40:02, Anson Huang wrote:
> Add i.MX8MP SoC driver support:
>=20
> root@imx8mpevk:~# cat /sys/devices/soc0/family
> Freescale i.MX
>=20
> root@imx8mpevk:~# cat /sys/devices/soc0/machine
> FSL i.MX8MP EVK
>=20
> root@imx8mpevk:~# cat /sys/devices/soc0/soc_id
> i.MX8MP
>=20
> root@imx8mpevk:~# cat /sys/devices/soc0/revision
> 1.0
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

> ---
>  drivers/soc/imx/soc-imx8.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/soc/imx/soc-imx8.c b/drivers/soc/imx/soc-imx8.c
> index 964ff84..719e1f18 100644
> --- a/drivers/soc/imx/soc-imx8.c
> +++ b/drivers/soc/imx/soc-imx8.c
> @@ -142,10 +142,16 @@ static const struct imx8_soc_data imx8mn_soc_data =
=3D {
>  	.soc_revision =3D imx8mm_soc_revision,
>  };
> =20
> +static const struct imx8_soc_data imx8mp_soc_data =3D {
> +	.name =3D "i.MX8MP",
> +	.soc_revision =3D imx8mm_soc_revision,
> +};
> +
>  static const struct of_device_id imx8_soc_match[] =3D {
>  	{ .compatible =3D "fsl,imx8mq", .data =3D &imx8mq_soc_data, },
>  	{ .compatible =3D "fsl,imx8mm", .data =3D &imx8mm_soc_data, },
>  	{ .compatible =3D "fsl,imx8mn", .data =3D &imx8mn_soc_data, },
> +	{ .compatible =3D "fsl,imx8mp", .data =3D &imx8mp_soc_data, },
>  	{ }
>  };
> =20
> --=20
> 2.7.4
>=20
