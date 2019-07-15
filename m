Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05805C7618A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 05:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D4620644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 05:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="f8669SJe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfGOFex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 01:34:53 -0400
Received: from mail-eopbgr60074.outbound.protection.outlook.com ([40.107.6.74]:41056
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725385AbfGOFex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 01:34:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvEBsPYsSyA2gpllmmcOovvFKP7MZynzMPTjcvSGZI8XP2yuUNC1R8sBE4yrx+bbv0KQ4MgipaVzY12sj1qwfIUsGMvcO7iAPrZGPQrKCWcJXHCUkqnhV3e/FzhNBPnC+kX75rH31pX/bhwK9hqgsF5ikc0/sRCDNvyWMDNZbuHyEYvw7L0PowdjNY8FSuGcLPMWNW1+QWFclCiAZ0abENR03o/5sYg3qORJY1EdRCUvf/++kFqHFcV4eqyW8TEpXOb6Bjzgi5XMlXzd3+NGkIeZyFiexE+Jd9hlWMyqPVIKcVjbSgBWQwHtkBHyYjlLomQngGUKp7998mZV/8AdIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHSg0xbskismv0sHAxrny6SNSNaMq9SklH0dHjD35pc=;
 b=VqfYQBv+ukfaQ8iKDvSlnoRPmpd7VGnS3E7N5dSMTtey7gbcSEPfnKgiauILro7uUxUtOOsvBrQuYxwLh09bYjQLr9zC3d9kZIgax4s1DYhWJK9NAt+qDGd8mHGLGWt7suHuuCC7352vA2lKKlGBEGt5VK9CL2OKV9M5fqheeyLFo6lypCoxzoRK4dstijkVP0MqTTKDeCgi+G9AAbCu6ZmNYnG3DpOUlIVHyeVKioMOv47FP3DJjwh/PZPE4JhJ+pzkJjv4vqv52K5gkg4Q32Ue4RAkJWJOnsmRcmflyGBawBwxfPpOX7cQFaWVxIEsX8t5xtDDuEqe/JStmSt7bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHSg0xbskismv0sHAxrny6SNSNaMq9SklH0dHjD35pc=;
 b=f8669SJe2tlUwKMPngSN3qmOyqOeJ4h3ZpyBhWtwutPFtiEVGOvhNNQ88811xUQavOP35t3JMS6d/7aLSAFnSZ31e+Th5PXEme66WkkBCpI08zYpI8hywh3eoMbwneRTpj2NOBuhvm2Sui28/mQy+Yk9fP6rzDSl+sJ6DEMMZSk=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.5.23) by
 VI1PR0402MB3741.eurprd04.prod.outlook.com (52.134.15.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Mon, 15 Jul 2019 05:34:47 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::c539:7bdc:7eea:2a52]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::c539:7bdc:7eea:2a52%7]) with mapi id 15.20.2073.012; Mon, 15 Jul 2019
 05:34:47 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Andy Duan <fugang.duan@nxp.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH nvmem 1/1] nvmem: imx: add i.MX8QM platform support
Thread-Topic: [PATCH nvmem 1/1] nvmem: imx: add i.MX8QM platform support
Thread-Index: AQHVMnTq2F+gGEqIWEi9imTz4TJ3wKbLOOvg
Date:   Mon, 15 Jul 2019 05:34:47 +0000
Message-ID: <VI1PR0402MB36009610A9F1CCB9D9006349FFCF0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <20190704142032.10745-1-fugang.duan@nxp.com>
In-Reply-To: <20190704142032.10745-1-fugang.duan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d28d5a4-1c3e-4d0a-0fb9-08d708e6266a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3741;
x-ms-traffictypediagnostic: VI1PR0402MB3741:
x-microsoft-antispam-prvs: <VI1PR0402MB374104A494CE2E4355369FB8FFCF0@VI1PR0402MB3741.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:261;
x-forefront-prvs: 00997889E7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(199004)(189003)(316002)(229853002)(2201001)(110136005)(8936002)(81166006)(81156014)(2501003)(25786009)(7736002)(68736007)(55016002)(6436002)(3846002)(6246003)(4326008)(6116002)(256004)(8676002)(66066001)(486006)(33656002)(53936002)(9686003)(54906003)(478600001)(14454004)(476003)(11346002)(186003)(446003)(2906002)(76116006)(26005)(71190400001)(71200400001)(99286004)(6506007)(7696005)(102836004)(76176011)(74316002)(305945005)(86362001)(66946007)(66476007)(66556008)(64756008)(66446008)(5660300002)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3741;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eLBnGX3+0Xi2oSddRH8TG4nvFnmKvfY5d43MQq5RbddsBFFJaIQJExJIV/hdY2furWvbei7TMpH3PR6++nLH5uMNBhrAlDrSlyLwmgSu9IL1CEp0XOgCou4lx31735aGQ4iYQ9OOlo0cglL11v9SRmlRfD8c1r/xEGPU1p4YVsHQly1znpQHp8L4uDElUvPb3jmuaquuVug5Kvgc5dYrq/VmwU8KPHuBFFVI4/06/X9BzP16pFgKWwqWZwUWJLgq7XhMvtMhd86O1XawXBkP0GCx0a173Mk1u7A/BwUGL0fSZivN1J3OQqxINzHUtSowr35qLoAcnd1vk3YU3ohRh3bldcMhN1zXn+JwdpNtKbLUlCBZq+UiAZC/jizvlJEaq1LmrlBECUHeKj7Z4NuKL+x3/m7qdW06L3ARPxjfVLE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d28d5a4-1c3e-4d0a-0fb9-08d708e6266a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2019 05:34:47.4161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fugang.duan@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping...

> From: Fugang Duan <fugang.duan@nxp.com>
>=20
> i.MX8QM efuse table has some difference with i.MX8QXP platform, so add
> i.MX8QM platform support.
>=20
> Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
> ---
>  drivers/nvmem/imx-ocotp-scu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/nvmem/imx-ocotp-scu.c b/drivers/nvmem/imx-ocotp-scu.=
c
> index be2f5f0..0d78ab4 100644
> --- a/drivers/nvmem/imx-ocotp-scu.c
> +++ b/drivers/nvmem/imx-ocotp-scu.c
> @@ -16,6 +16,7 @@
>=20
>  enum ocotp_devtype {
>  	IMX8QXP,
> +	IMX8QM,
>  };
>=20
>  struct ocotp_devtype_data {
> @@ -39,6 +40,11 @@ static struct ocotp_devtype_data imx8qxp_data =3D {
>  	.nregs =3D 800,
>  };
>=20
> +static struct ocotp_devtype_data imx8qm_data =3D {
> +	.devtype =3D IMX8QM,
> +	.nregs =3D 800,
> +};
> +
>  static int imx_sc_misc_otp_fuse_read(struct imx_sc_ipc *ipc, u32 word,
>  				     u32 *val)
>  {
> @@ -118,6 +124,7 @@ static struct nvmem_config
> imx_scu_ocotp_nvmem_config =3D {
>=20
>  static const struct of_device_id imx_scu_ocotp_dt_ids[] =3D {
>  	{ .compatible =3D "fsl,imx8qxp-scu-ocotp", (void *)&imx8qxp_data },
> +	{ .compatible =3D "fsl,imx8qm-scu-ocotp", (void *)&imx8qm_data },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, imx_scu_ocotp_dt_ids);
> --
> 2.7.4

