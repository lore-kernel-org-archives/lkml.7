Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4F9C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FDFF2084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="cFNkBRzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfKLOTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:19:48 -0500
Received: from mail-eopbgr60054.outbound.protection.outlook.com ([40.107.6.54]:30520
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726988AbfKLOTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:19:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+hDa4w4FVkjVCuLFUs53Jm29DqZXFTbxJxT4E4MH77AvL3f+Av4X74vc73ub8qOQg0nfOgAELHCdUI7+uTui+uIgEa2ZZI2UL42xP4c6bPqjDZ19FyVYLl2QEPNbmTwNZT8+Ogbs5zpz63qX+vZyFb31vhHxxZXiAF/nTyOL4/9nvn/k1LSVrg6ALdVqYuyEJv/AdNJZQ3CDBXGFlyYnULHXpaWACGfERoja5cYcBkn+VF48m9ba+tqEMOsScWZgKpG8WwfmqzjGpgYn0GAB9mWz/uPQcV0Vt1bcj51JZioxngyOpkmOOqgJZBnw+/5+xRsJrZcdyAUvgDTvm3/+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYy7JsrpEVYcwD2IL2OZQ31r0vayf6hsDJOlmOJndu0=;
 b=UlM+ykYoxOW15wJYsnRyO2cN9MK4FKTNRbC+/OChzb9ricvGbpe6ZEJ2dcAQxV2FM/+N3lm4SpSws92aid6IzNaBBjHExtCdlCNzJgwUSds0ZsCWex7LOYmCZS67i5O4A+aE+dskWcWtxygwepl7coMfd7gIUsNrdT1bG67Kq1WOUeR+6ipOfe9GfRJs1qRhgM3nEUIOCW14XfNv/i5bB9cBCxjIiJ6Mk4PBQThFx51ll/U38f9T/cQdGNVDS25UZfRw8ODGeyIHFp320daTVdbzyIRWy0NKvCkaAimY0V4kObAfRGVdaeFM8l1cwSgKc+DOdu0nfFoCez+R+u/1dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYy7JsrpEVYcwD2IL2OZQ31r0vayf6hsDJOlmOJndu0=;
 b=cFNkBRzXKaTMaYbqDFSqH46fyjbZnKry83j0phKcQgpTN2vsxa0SXLcsQ7iW5b7wEHyEHurlkT1DUDT9FqCIGn9DwZiri41J78jEZjRogxGxQjdroZXuN6yTeiZ735NtSgDFVlTwGsE2NRUUB2+0d0gsC4b83Kt2RxXLvnudKZI=
Received: from DB6PR0501MB2712.eurprd05.prod.outlook.com (10.172.225.17) by
 DB6PR0501MB2599.eurprd05.prod.outlook.com (10.168.71.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Tue, 12 Nov 2019 14:19:43 +0000
Received: from DB6PR0501MB2712.eurprd05.prod.outlook.com
 ([fe80::99be:5f3a:9871:ecd1]) by DB6PR0501MB2712.eurprd05.prod.outlook.com
 ([fe80::99be:5f3a:9871:ecd1%12]) with mapi id 15.20.2430.027; Tue, 12 Nov
 2019 14:19:43 +0000
From:   Asmaa Mnebhi <Asmaa@mellanox.com>
To:     "minyard@acm.org" <minyard@acm.org>,
        Vijay Khemka <vijaykhemka@fb.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cminyard@mvista.com" <cminyard@mvista.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "sdasari@fb.com" <sdasari@fb.com>
Subject: RE: [PATCH 1/2] drivers: ipmi: Support raw i2c packet in IPMB
Thread-Topic: [PATCH 1/2] drivers: ipmi: Support raw i2c packet in IPMB
Thread-Index: AQHVmQJhVFa2qHxMQE+ZOphOmDlBEKeHeXcAgAAc2cA=
Date:   Tue, 12 Nov 2019 14:19:43 +0000
Message-ID: <DB6PR0501MB271273D1EC0CF9CAA67A22CCDA770@DB6PR0501MB2712.eurprd05.prod.outlook.com>
References: <20191112023610.3644314-1-vijaykhemka@fb.com>
 <20191112123602.GD2882@minyard.net>
In-Reply-To: <20191112123602.GD2882@minyard.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Asmaa@mellanox.com; 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c3e66bec-4079-4eee-037a-08d7677b5cf8
x-ms-traffictypediagnostic: DB6PR0501MB2599:
x-microsoft-antispam-prvs: <DB6PR0501MB259995E630469798C9AD5026DA770@DB6PR0501MB2599.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(13464003)(199004)(189003)(6246003)(80792005)(2501003)(5660300002)(14454004)(478600001)(6436002)(52536014)(4326008)(229853002)(25786009)(6116002)(3846002)(9686003)(66556008)(66476007)(66946007)(64756008)(66446008)(76116006)(55016002)(110136005)(446003)(486006)(256004)(71190400001)(71200400001)(81156014)(99286004)(7416002)(11346002)(8676002)(54906003)(66066001)(8936002)(476003)(81166006)(74316002)(186003)(7696005)(76176011)(6506007)(53546011)(33656002)(86362001)(7736002)(2906002)(305945005)(316002)(26005)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2599;H:DB6PR0501MB2712.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Obxb6zYgP23kg4SMlT5/dYX+94pH97Y26wwj2q4bUb6m+I4fAZFU19z5JBzVZZhijOi+Qe9vczStMoKjdZkUw3u9lAjrI/tGwLNNYU0vhYjihJBsfluUzu1nHki0X0UbE37mBbXcu1u5x8kOCu8fGXtaImJ7BF4kOb6uxuVs+ERscW8IszGPwwpzlpg8ed28NXpkkty7FjFILl4nL3qL1xg+IAOozSqAniJTigQksKnN//5IwT9mN1K477IDdNwVz16TiHk+L7z7w4v5tjdZhW5Cpah7LCewttEyViZjBHDANQG1cGKdbAYOtHLygTQJzeLv9skEpB2lsp3SVtAJqGww7WJb+Y/ay3RWW8OXsXqbeVJOqof8vayPEGRglcPgK+X3J5fFHeLt7fNyBMS3UL02CWtMHpnc6crn/2OXMflbcY2EbLS1YMHFwGd14sG
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e66bec-4079-4eee-037a-08d7677b5cf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 14:19:43.3471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 16k3ZLW91NV+s9QAiSkiMWB8eC2D2BdsqXC/Ue4Egsrhl7/wkpPmh0KDf5w08FeBwoMbyjVesluloRKI2ziXZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2599
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I agree with corey. You can take a look at the ipmi_ssif.c driver which doe=
s that.

-----Original Message-----
From: Corey Minyard <tcminyard@gmail.com> On Behalf Of Corey Minyard
Sent: Tuesday, November 12, 2019 7:36 AM
To: Vijay Khemka <vijaykhemka@fb.com>
Cc: Arnd Bergmann <arnd@arndb.de>; Greg Kroah-Hartman <gregkh@linuxfoundati=
on.org>; openipmi-developer@lists.sourceforge.net; linux-kernel@vger.kernel=
.org; cminyard@mvista.com; Asmaa Mnebhi <Asmaa@mellanox.com>; joel@jms.id.a=
u; linux-aspeed@lists.ozlabs.org; sdasari@fb.com
Subject: Re: [PATCH 1/2] drivers: ipmi: Support raw i2c packet in IPMB

On Mon, Nov 11, 2019 at 06:36:09PM -0800, Vijay Khemka wrote:
> Many IPMB devices doesn't support smbus protocol and current driver=20
> support only smbus devices. So added support for raw i2c packets.

I haven't reviewed this, really, because I have a more general concern...

Is it possible to not do this with a config item?  Can you add something to=
 the device tree and/or via an ioctl to make this dynamically configurable?=
  That's more flexible (it can support mixed devices) and is friendlier to =
users (don't have to get the config right).

Config items for adding new functionality are generally ok.  Config items f=
or choosing between two mutually exclusive choices are generally not.

-corey

>=20
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  drivers/char/ipmi/Kconfig        |  6 ++++++
>  drivers/char/ipmi/ipmb_dev_int.c | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
>=20
> diff --git a/drivers/char/ipmi/Kconfig b/drivers/char/ipmi/Kconfig=20
> index a9cfe4c05e64..e5268443b478 100644
> --- a/drivers/char/ipmi/Kconfig
> +++ b/drivers/char/ipmi/Kconfig
> @@ -139,3 +139,9 @@ config IPMB_DEVICE_INTERFACE
>  	  Provides a driver for a device (Satellite MC) to
>  	  receive requests and send responses back to the BMC via
>  	  the IPMB interface. This module requires I2C support.
> +
> +config IPMB_SMBUS_DISABLE
> +	bool 'Disable SMBUS protocol for sending packet to IPMB device'
> +	depends on IPMB_DEVICE_INTERFACE
> +	help
> +	  provides functionality of sending raw i2c packets to IPMB device.
> diff --git a/drivers/char/ipmi/ipmb_dev_int.c=20
> b/drivers/char/ipmi/ipmb_dev_int.c
> index ae3bfba27526..2419b9a928b2 100644
> --- a/drivers/char/ipmi/ipmb_dev_int.c
> +++ b/drivers/char/ipmi/ipmb_dev_int.c
> @@ -118,6 +118,10 @@ static ssize_t ipmb_write(struct file *file, const c=
har __user *buf,
>  	struct ipmb_dev *ipmb_dev =3D to_ipmb_dev(file);
>  	u8 rq_sa, netf_rq_lun, msg_len;
>  	union i2c_smbus_data data;
> +#ifdef CONFIG_IPMB_SMBUS_DISABLE
> +	unsigned char *i2c_buf;
> +	struct i2c_msg i2c_msg;
> +#endif
>  	u8 msg[MAX_MSG_LEN];
>  	ssize_t ret;
> =20
> @@ -133,6 +137,31 @@ static ssize_t ipmb_write(struct file *file, const c=
har __user *buf,
>  	rq_sa =3D GET_7BIT_ADDR(msg[RQ_SA_8BIT_IDX]);
>  	netf_rq_lun =3D msg[NETFN_LUN_IDX];
> =20
> +#ifdef CONFIG_IPMB_SMBUS_DISABLE
> +	/*
> +	 * subtract 1 byte (rq_sa) from the length of the msg passed to
> +	 * raw i2c_transfer
> +	 */
> +	msg_len =3D msg[IPMB_MSG_LEN_IDX] - 1;
> +
> +	i2c_buf =3D kzalloc(msg_len, GFP_KERNEL);
> +	if (!i2c_buf)
> +		return -EFAULT;
> +
> +	/* Copy message to buffer except first 2 bytes (length and address) */
> +	memcpy(i2c_buf, msg+2, msg_len);
> +
> +	i2c_msg.addr =3D rq_sa;
> +	i2c_msg.flags =3D ipmb_dev->client->flags &
> +			(I2C_M_TEN | I2C_CLIENT_PEC | I2C_CLIENT_SCCB);
> +	i2c_msg.len =3D msg_len;
> +	i2c_msg.buf =3D i2c_buf;
> +
> +	ret =3D i2c_transfer(ipmb_dev->client->adapter, &i2c_msg, 1);
> +	kfree(i2c_buf);
> +
> +	return (ret =3D=3D 1) ? count : ret;
> +#else
>  	/*
>  	 * subtract rq_sa and netf_rq_lun from the length of the msg passed to
>  	 * i2c_smbus_xfer
> @@ -149,6 +178,7 @@ static ssize_t ipmb_write(struct file *file, const ch=
ar __user *buf,
>  			     I2C_SMBUS_BLOCK_DATA, &data);
> =20
>  	return ret ? : count;
> +#endif
>  }
> =20
>  static unsigned int ipmb_poll(struct file *file, poll_table *wait)
> --
> 2.17.1
>=20
