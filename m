Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE11C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 06:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E45A206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 06:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gCRxyypU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403877AbfIFG5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 02:57:51 -0400
Received: from mail-eopbgr00075.outbound.protection.outlook.com ([40.107.0.75]:18477
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392477AbfIFG5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 02:57:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVYG8zO5STh8534XpgryXGI3+XZ+8vH1bZlEa2SA9Z9PnhGw6oDY6xwdOh0JGRvRg4zO+/68yPQs3/38ZuwPxh9cbidChBA6D8RxunmssHVmtu5UozpeN8KL02960b03lUoLurGU4n54RfZ6lZN9jzYeWp2aP4Vau4N/lgMYlT3SekKeKlNVOwLlSrPVUlzsojl4pKkVwTiYYjVxadxK/BVvJelVwZVuLYMQa/vQfKfDxbwhf/X5M3ckvSpKXp43XO/lc5Zgv1Iy1UuJJ2Zk5h64hJ336+A4br5oMTwP87NoSkNXtPBcmjcs5ZSfOO1lF+WGxxUqojoCNJJx5MX1Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Om36ehWayyehFA2Fs5opitONQ4cadyU9Rr3blLjhoA0=;
 b=XVCWW2aM5XD8VU8RAJEm3x52E5L4HHIFwdulODUIuuVvXA6ZbjwIYhJ0EsaFaDZncCzffR1n1RmAwckxbCkkanyh25epp3PgUesLE3lKK/rCYLCytcgEcfKtPLfkrF3HmLVYBe9Zaby6UPvN7m6lnraTJ3NR+6d7HtdmLo7fEblOt4S2kGIMEh9XvmAmGbFiBNIRP9TZDCZikXIOvmgI1vShnKvV0laLXgcmDei8U4sKrqiNt4BB6UfEMA6PvO5oMip/9+OuwD8yBr6oeH2Neq8uqSX4EloRtrOD78IjKpC/JPL1EMtJW5yWvZZzsykhCC31Vnq4P4fH7c18VRbBtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Om36ehWayyehFA2Fs5opitONQ4cadyU9Rr3blLjhoA0=;
 b=gCRxyypU5IQNuqvMXNX07urSGaim+2e7zcxbfKEuPEcK4KXVn3plNwdIQoA3NBpqIcgNpl6czB5JcXYmh1MW77dwAAP64QctUVxHJopDcLruwBciFa9SqLlAjRLSeKVpzcODcBkJ3XN21cf4d+I8jXdW7yoFj3umnYcIhYS+Cls=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6530.eurprd04.prod.outlook.com (20.179.252.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Fri, 6 Sep 2019 06:57:20 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8%6]) with mapi id 15.20.2220.022; Fri, 6 Sep 2019
 06:57:20 +0000
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
Subject: RE: [PATCH 2/2] nvmem: imx: scu: support write
Thread-Topic: [PATCH 2/2] nvmem: imx: scu: support write
Thread-Index: AQHVV89l2gZHrF0tR0yZfYtuVeLxmqceUPbw
Date:   Fri, 6 Sep 2019 06:57:19 +0000
Message-ID: <AM0PR04MB448144701DB63A3C9F05B3E488BA0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1566356496-30493-1-git-send-email-peng.fan@nxp.com>
 <1566356496-30493-2-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1566356496-30493-2-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ff5ad42-f657-4f52-d67a-08d73297762d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6530;
x-ms-traffictypediagnostic: AM0PR04MB6530:|AM0PR04MB6530:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB65301DBF66DA41D0D723EBDC88BA0@AM0PR04MB6530.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(199004)(189003)(81166006)(52536014)(229853002)(81156014)(74316002)(2501003)(256004)(2201001)(14454004)(8676002)(14444005)(478600001)(44832011)(476003)(486006)(7736002)(33656002)(11346002)(66066001)(446003)(26005)(76176011)(76116006)(2906002)(186003)(66556008)(25786009)(110136005)(54906003)(66946007)(6246003)(6436002)(4326008)(305945005)(5660300002)(71190400001)(71200400001)(6116002)(3846002)(8936002)(316002)(6506007)(9686003)(66476007)(64756008)(66446008)(53936002)(55016002)(86362001)(102836004)(7696005)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6530;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ask0B9TkBnE+YMkq8MlM255mFq8xErqFKUBAukPWmufJjeCrE/KR9x6a4R5TJSsgG4qZavs7AY4LCS5Te8Sk6ZJZ+y3Z4dZ8f1SEnWPyEebuxHQgRqXK/DmMnZVLWdfQwmr4P/RZVGeDDGjf9Bzc/qmi1156zaOFm5DTAhteNuIScdoeUw23byIlFB0VnNEffzN5ftLrWf0JOHIT5RMUy388lEhNr2j3Hv7gUs84ZaH3I99tZ16SQLU6Obmqae20h9FYSZPfm5s5aBt2wjCrVIIR0yHhlOacCS/ADQVz8kBOHxQ7pN2EaMDIFPNo0P+O6aFmPLLMiW1hXqBd2nOC6IQDZEr7DLNKxpz5BMcjx0ge3dPt30zvsESV/fGBiwzw1rvIF72qCx+1W7DCeQKqCrhR8ch8GuhifAasUGIthsE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff5ad42-f657-4f52-d67a-08d73297762d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 06:57:19.8131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4BJf4qyH8jG9iCIqxEpRYcR5lmHN9DmPvf78C8rCWZHRFl4U7kXMgt/MW8lcibhcHpDIHY2i4unoIMen9M7xpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6530
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH 2/2] nvmem: imx: scu: support write

Ping..

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> The fuse programming from non-secure world is blocked, so we could only u=
se
> Arm Trusted Firmware SIP call to let ATF program fuse.
>=20
> Because there is ECC region that could only be programmed once, so add a
> heler in_ecc to check the ecc region.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>=20
> The ATF patch will soon be posted to ATF community.
>=20
>  drivers/nvmem/imx-ocotp-scu.c | 73
> ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 72 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/nvmem/imx-ocotp-scu.c b/drivers/nvmem/imx-ocotp-scu.=
c
> index 2f339d7432e6..0f064f2e74a8 100644
> --- a/drivers/nvmem/imx-ocotp-scu.c
> +++ b/drivers/nvmem/imx-ocotp-scu.c
> @@ -7,6 +7,7 @@
>   * Peng Fan <peng.fan@nxp.com>
>   */
>=20
> +#include <linux/arm-smccc.h>
>  #include <linux/firmware/imx/sci.h>
>  #include <linux/module.h>
>  #include <linux/nvmem-provider.h>
> @@ -14,6 +15,9 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>=20
> +#define IMX_SIP_OTP			0xC200000A
> +#define IMX_SIP_OTP_WRITE		0x2
> +
>  enum ocotp_devtype {
>  	IMX8QXP,
>  };
> @@ -45,6 +49,8 @@ struct imx_sc_msg_misc_fuse_read {
>  	u32 word;
>  } __packed;
>=20
> +static DEFINE_MUTEX(scu_ocotp_mutex);
> +
>  static struct ocotp_devtype_data imx8qxp_data =3D {
>  	.devtype =3D IMX8QXP,
>  	.nregs =3D 800,
> @@ -73,6 +79,23 @@ static bool in_hole(void *context, u32 index)
>  	return false;
>  }
>=20
> +static bool in_ecc(void *context, u32 index) {
> +	struct ocotp_priv *priv =3D context;
> +	const struct ocotp_devtype_data *data =3D priv->data;
> +	int i;
> +
> +	for (i =3D 0; i < data->num_region; i++) {
> +		if (data->region[i].flag & ECC_REGION) {
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
> @@ -116,6 +139,8 @@ static int imx_scu_ocotp_read(void *context,
> unsigned int offset,
>  	if (!p)
>  		return -ENOMEM;
>=20
> +	mutex_lock(&scu_ocotp_mutex);
> +
>  	buf =3D p;
>=20
>  	for (i =3D index; i < (index + count); i++) { @@ -126,6 +151,7 @@ stati=
c int
> imx_scu_ocotp_read(void *context, unsigned int offset,
>=20
>  		ret =3D imx_sc_misc_otp_fuse_read(priv->nvmem_ipc, i, buf);
>  		if (ret) {
> +			mutex_unlock(&scu_ocotp_mutex);
>  			kfree(p);
>  			return ret;
>  		}
> @@ -134,18 +160,63 @@ static int imx_scu_ocotp_read(void *context,
> unsigned int offset,
>=20
>  	memcpy(val, (u8 *)p + offset % 4, bytes);
>=20
> +	mutex_unlock(&scu_ocotp_mutex);
> +
>  	kfree(p);
>=20
>  	return 0;
>  }
>=20
> +static int imx_scu_ocotp_write(void *context, unsigned int offset,
> +			       void *val, size_t bytes)
> +{
> +	struct ocotp_priv *priv =3D context;
> +	struct arm_smccc_res res;
> +	u32 *buf =3D val;
> +	u32 tmp;
> +	u32 index;
> +	int ret;
> +
> +	/* allow only writing one complete OTP word at a time */
> +	if ((bytes !=3D 4) || (offset % 4))
> +		return -EINVAL;
> +
> +	index =3D offset >> 2;
> +
> +	if (in_hole(context, index))
> +		return -EINVAL;
> +
> +	if (in_ecc(context, index)) {
> +		pr_warn("ECC region, only program once\n");
> +		mutex_lock(&scu_ocotp_mutex);
> +		ret =3D imx_sc_misc_otp_fuse_read(priv->nvmem_ipc, index, &tmp);
> +		mutex_unlock(&scu_ocotp_mutex);
> +		if (ret)
> +			return ret;
> +		if (tmp) {
> +			pr_warn("ECC region, already has value: %x\n", tmp);
> +			return -EIO;
> +		}
> +	}
> +
> +	mutex_lock(&scu_ocotp_mutex);
> +
> +	arm_smccc_smc(IMX_SIP_OTP, IMX_SIP_OTP_WRITE, index, *buf,
> +		      0, 0, 0, 0, &res);
> +
> +	mutex_unlock(&scu_ocotp_mutex);
> +
> +	return res.a0;
> +}
> +
>  static struct nvmem_config imx_scu_ocotp_nvmem_config =3D {
>  	.name =3D "imx-scu-ocotp",
> -	.read_only =3D true,
> +	.read_only =3D false,
>  	.word_size =3D 4,
>  	.stride =3D 1,
>  	.owner =3D THIS_MODULE,
>  	.reg_read =3D imx_scu_ocotp_read,
> +	.reg_write =3D imx_scu_ocotp_write,
>  };
>=20
>  static const struct of_device_id imx_scu_ocotp_dt_ids[] =3D {
> --
> 2.16.4

