Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E862DC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 09:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A83F0206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 09:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XnO8h9r6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfIRJJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 05:09:30 -0400
Received: from mail-eopbgr80057.outbound.protection.outlook.com ([40.107.8.57]:49534
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727030AbfIRJJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 05:09:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iE4UdArqCPPFVbCQQGeDF65Yq55GM0/djE6CaSwPtY2SHdsDGklNyGj/P28d4CbnyB0GSMhjsQw9+Wum2M/jvrgghYmDudaKpDJqoRwJwHDRH/0inSOUtRd8//sc8l3g24BgJ4ewa32K6y43FVQvuEFxS8bW36xhqdSWY5dtKu+btK1+/I4LerUykmupQyyJky9vZUkx74KvES5jslTUf1Z/qUWCdkcGg/qs1mhRt23tP9DbTKCvK8Ie3QEWnhXDGShIVtLQ2LVBgxeRK0Wy7J4C2IPks5BAPYP+m/Mcbwo4mw4OyxKOYX/SnEC0hrDEjMcAtQvqGyOW3XdcVauvcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Xr5Idb0X41xRUqAMSXXNpMp+/ttSKqfiFdkykY3AbI=;
 b=LGgAgyu3LU0dJAxGDBblyyT68aNHRVJAVmZmQecmcIO3usqWJG9XPZIRCR+9/DrDyZknBxwXmCGNB2U+mEvFPvjwQ4FXavyPdpouWK/CseWNCsUABJAL2rb8gtkHNHoyU/jtZG9pbYr1kHRpCr4QbnFOzAQa0hKS9xXiKFgI0029ci6mdbz7UE+07oXabYfFKkuKXL6OsdtnyFVrVONQUK0bxqYpU52LMcFt7MM3Zd5O6zgbSP2lXLwcmoUt0Ca+jsSouOd4ZbBcfcZnWRE0gZtHw+h+sNo4e1DQnDxFd9jgRruMPHP6HclRsWi5jy1QrDqw5/W4xiJe0YtAa5807A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Xr5Idb0X41xRUqAMSXXNpMp+/ttSKqfiFdkykY3AbI=;
 b=XnO8h9r62othg+LhBL6hb8XriSNQ/xZ13O6F7USdTSUfQwM0jj3VxlpfoJ+87skkVNTe5/I/U5yWxuTsHIrt8l2PfOJcq8NOWfZFqHGElzvVnx2s4a6Pc01UyaPCvqjq6QPgal724EnokXt4k2pdve0oiXmq9YlsBVY5POLCl40=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5971.eurprd04.prod.outlook.com (20.178.113.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Wed, 18 Sep 2019 09:09:25 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8%6]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 09:09:25 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Andre Przywara <andre.przywara@arm.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V6 2/2] mailbox: introduce ARM SMC based mailbox
Thread-Topic: [PATCH V6 2/2] mailbox: introduce ARM SMC based mailbox
Thread-Index: AQHVbHNdulW1qSzh8kulKbzCOfhGf6cwJKgAgAECNoA=
Date:   Wed, 18 Sep 2019 09:09:25 +0000
Message-ID: <AM0PR04MB44813D62FF7E6762BB17460E888E0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1568626884-5189-1-git-send-email-peng.fan@nxp.com>
        <1568626884-5189-3-git-send-email-peng.fan@nxp.com>
 <20190917183856.2342beed@donnerap.cambridge.arm.com>
In-Reply-To: <20190917183856.2342beed@donnerap.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89a6eb21-a072-447e-9ec2-08d73c17e72c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5971;
x-ms-traffictypediagnostic: AM0PR04MB5971:|AM0PR04MB5971:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB59715A2F76C52CC987630821888E0@AM0PR04MB5971.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(189003)(199004)(305945005)(2906002)(74316002)(6306002)(9686003)(71190400001)(6506007)(6246003)(6436002)(11346002)(55016002)(14444005)(186003)(26005)(99286004)(86362001)(71200400001)(102836004)(7696005)(15650500001)(76176011)(446003)(256004)(7736002)(6916009)(5660300002)(52536014)(66066001)(229853002)(4326008)(3846002)(81166006)(66446008)(45080400002)(44832011)(486006)(8936002)(81156014)(33656002)(316002)(476003)(54906003)(8676002)(14454004)(76116006)(478600001)(6116002)(966005)(66476007)(66556008)(25786009)(64756008)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5971;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3fsSY39dA+TpFeGxU2DyTsEPcZXnX4RPbOVloEFCF2waD7b/5hFDbfxpMS1o9N5G/ghLnufM9ptkVRoJWyYbQV2oaikQu/tPAvW5iJPBc7FJ2Md2/v2b8vdrikhow7PxSCO0AdTKrk6+x2f0+mhK03li0HqQD39AgAVabvqqVNI/n9JicVGaIm7fi7SYyY4tSYu83qhpfHsKXKK6ee0K5GHfLv+2saKQzt/8NfAqvf/miye8Dre7ZIHOWiyQHHOF3b+MQeVzU5U+ZS42bz5nkfV+o6U8B3M9WWkFhF4S3Sv/eitPNP8EJE39WNw7+2y82pcESWYYqmfqDV2Mwe3KQWw8R+ro0A4uc+CPCQ0Ynzhc9H1L1ZvLO+n+DTfPOU5hLBFL3npwjGqDu1nU9C9pBxQn4yuP0/JaOlwPnU+o8kw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a6eb21-a072-447e-9ec2-08d73c17e72c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 09:09:25.5220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3k9clCQ5s4RBuipucZnJQDZXF+5xgXfR7LggwIKBeSjYd1gnXXdplW9jC9BrEF0w/6ZY4/g14Zc3ANr/c6ds1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5971
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

> Subject: Re: [PATCH V6 2/2] mailbox: introduce ARM SMC based mailbox
>=20
> On Mon, 16 Sep 2019 09:44:41 +0000
> Peng Fan <peng.fan@nxp.com> wrote:
>=20
> Hi,
>=20
> looks quite good now, some smaller comments below.
> I think the only thing left is the "function ID passed by the client" top=
ic.
>=20
> Have you tried using this interface using hvc, for instance in KVM or Xen=
? For

No. I do not have that implementation in hypervisor.

> instance to provide access to a clock for a passed-through platform devic=
e?
> Another use case that pops up from time to time is GPIO for guests. This
> sounds like a use case for using the register interface, also we could us=
e the
> hvc return value.
>=20
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > This mailbox driver implements a mailbox which signals transmitted
> > data via an ARM smc (secure monitor call) instruction. The mailbox
> > receiver is implemented in firmware and can synchronously return data
> > when it returns execution to the non-secure world again.
> > An asynchronous receive path is not implemented.
> > This allows the usage of a mailbox to trigger firmware actions on SoCs
> > which either don't have a separate management processor or on which
> > such a core is not available. A user of this mailbox could be the SCP
> > interface.
> >
> > Modified from Andre Przywara's v2 patch
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> > .kernel.org%2Fpatchwork%2Fpatch%2F812999%2F&amp;data=3D02%7C01%7
> Cpeng.fa
> >
> n%40nxp.com%7C58a1ed4078264d14958f08d73b95ed7e%7C686ea1d3bc2b
> 4c6fa92cd
> >
> 99c5c301635%7C0%7C1%7C637043387484474825&amp;sdata=3DCp1zlhlpQbg
> BsWu9ZDV
> > RKkXmd6kvUR%2BtPO7EPR7YLpA%3D&amp;reserved=3D0
> >
> > Cc: Andre Przywara <andre.przywara@arm.com>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/mailbox/Kconfig           |   7 ++
> >  drivers/mailbox/Makefile          |   2 +
> >  drivers/mailbox/arm-smc-mailbox.c | 167
> > ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 176 insertions(+)
> >  create mode 100644 drivers/mailbox/arm-smc-mailbox.c
> >
> > diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig index
> > ab4eb750bbdd..7707ee26251a 100644
> > --- a/drivers/mailbox/Kconfig
> > +++ b/drivers/mailbox/Kconfig
> > @@ -16,6 +16,13 @@ config ARM_MHU
> >  	  The controller has 3 mailbox channels, the last of which can be
> >  	  used in Secure mode only.
> >
> > +config ARM_SMC_MBOX
> > +	tristate "Generic ARM smc mailbox"
> > +	depends on OF && HAVE_ARM_SMCCC
> > +	help
> > +	  Generic mailbox driver which uses ARM smc calls to call into
> > +	  firmware for triggering mailboxes.
> > +
> >  config IMX_MBOX
> >  	tristate "i.MX Mailbox"
> >  	depends on ARCH_MXC || COMPILE_TEST
> > diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile index
> > c22fad6f696b..93918a84c91b 100644
> > --- a/drivers/mailbox/Makefile
> > +++ b/drivers/mailbox/Makefile
> > @@ -7,6 +7,8 @@ obj-$(CONFIG_MAILBOX_TEST)	+=3D mailbox-test.o
> >
> >  obj-$(CONFIG_ARM_MHU)	+=3D arm_mhu.o
> >
> > +obj-$(CONFIG_ARM_SMC_MBOX)	+=3D arm-smc-mailbox.o
> > +
> >  obj-$(CONFIG_IMX_MBOX)	+=3D imx-mailbox.o
> >
> >  obj-$(CONFIG_ARMADA_37XX_RWTM_MBOX)	+=3D
> armada-37xx-rwtm-mailbox.o
> > diff --git a/drivers/mailbox/arm-smc-mailbox.c
> > b/drivers/mailbox/arm-smc-mailbox.c
> > new file mode 100644
> > index 000000000000..c84aef39c8d9
> > --- /dev/null
> > +++ b/drivers/mailbox/arm-smc-mailbox.c
> > @@ -0,0 +1,167 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2016,2017 ARM Ltd.
> > + * Copyright 2019 NXP
> > + */
> > +
> > +#include <linux/arm-smccc.h>
> > +#include <linux/device.h>
> > +#include <linux/kernel.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/mailbox_controller.h> #include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +
> > +struct arm_smc_chan_data {
> > +	unsigned int function_id;
> > +};
> > +
> > +struct arm_smccc_mbox_cmd {
> > +	unsigned int function_id;
> > +	union {
> > +		unsigned int args_smccc32[6];
> > +		unsigned long args_smccc64[6];
>=20
> Shouldn't this be u32 and u64 here, as the data type has this explicit le=
ngth in
> the SMCCC?

ok

>=20
> > +	};
> > +};
>=20
> If this is the data structure that this mailbox controller uses, I would =
expect
> this to be documented somewhere, or even exported.

Export this structure in include/linux/mailbox/smc-mailbox.h?

>=20
> And again, I don't like the idea of having the function ID in here.

You mean function_id in arm_smccc_mbox_cmd is not good?

>=20
> > +
> > +typedef unsigned long (smc_mbox_fn)(unsigned int, unsigned long,
> > +				    unsigned long, unsigned long,
> > +				    unsigned long, unsigned long,
> > +				    unsigned long);
> > +static smc_mbox_fn *invoke_smc_mbox_fn;
> > +
> > +static int arm_smc_send_data(struct mbox_chan *link, void *data) {
> > +	struct arm_smc_chan_data *chan_data =3D link->con_priv;
> > +	struct arm_smccc_mbox_cmd *cmd =3D data;
> > +	unsigned long ret;
> > +	u32 function_id;
> > +
> > +	function_id =3D chan_data->function_id;
> > +	if (!function_id)
> > +		function_id =3D cmd->function_id;
> > +
> > +	if (function_id & BIT(30)) {
>=20
> 	if (ARM_SMCCC_IS_64(function_id)) {

ok

>=20
> > +		ret =3D invoke_smc_mbox_fn(function_id, cmd->args_smccc64[0],
> > +					 cmd->args_smccc64[1],
> > +					 cmd->args_smccc64[2],
> > +					 cmd->args_smccc64[3],
> > +					 cmd->args_smccc64[4],
> > +					 cmd->args_smccc64[5]);
> > +	} else {
> > +		ret =3D invoke_smc_mbox_fn(function_id, cmd->args_smccc32[0],
> > +					 cmd->args_smccc32[1],
> > +					 cmd->args_smccc32[2],
> > +					 cmd->args_smccc32[3],
> > +					 cmd->args_smccc32[4],
> > +					 cmd->args_smccc32[5]);
> > +	}
> > +
> > +	mbox_chan_received_data(link, (void *)ret);
> > +
> > +	return 0;
> > +}
> > +
> > +static unsigned long __invoke_fn_hvc(unsigned int function_id,
> > +				     unsigned long arg0, unsigned long arg1,
> > +				     unsigned long arg2, unsigned long arg3,
> > +				     unsigned long arg4, unsigned long arg5) {
> > +	struct arm_smccc_res res;
> > +
> > +	arm_smccc_hvc(function_id, arg0, arg1, arg2, arg3, arg4,
> > +		      arg5, 0, &res);
> > +	return res.a0;
> > +}
> > +
> > +static unsigned long __invoke_fn_smc(unsigned int function_id,
> > +				     unsigned long arg0, unsigned long arg1,
> > +				     unsigned long arg2, unsigned long arg3,
> > +				     unsigned long arg4, unsigned long arg5) {
> > +	struct arm_smccc_res res;
> > +
> > +	arm_smccc_smc(function_id, arg0, arg1, arg2, arg3, arg4,
> > +		      arg5, 0, &res);
> > +	return res.a0;
> > +}
> > +
> > +static const struct mbox_chan_ops arm_smc_mbox_chan_ops =3D {
> > +	.send_data	=3D arm_smc_send_data,
> > +};
> > +
> > +static int arm_smc_mbox_probe(struct platform_device *pdev) {
> > +	struct device *dev =3D &pdev->dev;
> > +	struct mbox_controller *mbox;
> > +	struct arm_smc_chan_data *chan_data;
> > +	int ret;
> > +	u32 function_id =3D 0;
> > +
> > +	if (of_device_is_compatible(dev->of_node, "arm,smc-mbox"))
> > +		invoke_smc_mbox_fn =3D __invoke_fn_smc;
> > +	else
> > +		invoke_smc_mbox_fn =3D __invoke_fn_hvc;
> > +
> > +	mbox =3D devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
> > +	if (!mbox)
> > +		return -ENOMEM;
> > +
> > +	mbox->num_chans =3D 1;
> > +	mbox->chans =3D devm_kzalloc(dev, sizeof(*mbox->chans), GFP_KERNEL);
> > +	if (!mbox->chans)
> > +		return -ENOMEM;
> > +
> > +	chan_data =3D devm_kzalloc(dev, sizeof(*chan_data), GFP_KERNEL);
> > +	if (!chan_data)
> > +		return -ENOMEM;
> > +
> > +	of_property_read_u32(dev->of_node, "arm,func-id", &function_id);
> > +	chan_data->function_id =3D function_id;
> > +
> > +	mbox->chans->con_priv =3D chan_data;
> > +
> > +	mbox->txdone_poll =3D false;
> > +	mbox->txdone_irq =3D false;
>=20
> Don't we need to provide something to confirm reception to the client? In=
 our
> case we can set this as soon as the smc/hvc returns.

As smc/hvc returns, it means the transfer is over and receive is done.

Thanks,
Peng.

>=20
> Cheers,
> Andre.
>=20
> > +	mbox->ops =3D &arm_smc_mbox_chan_ops;
> > +	mbox->dev =3D dev;
> > +
> > +	platform_set_drvdata(pdev, mbox);
> > +
> > +	ret =3D devm_mbox_controller_register(dev, mbox);
> > +	if (ret)
> > +		return ret;
> > +
> > +	dev_info(dev, "ARM SMC mailbox enabled.\n");
> > +
> > +	return ret;
> > +}
> > +
> > +static int arm_smc_mbox_remove(struct platform_device *pdev) {
> > +	struct mbox_controller *mbox =3D platform_get_drvdata(pdev);
> > +
> > +	mbox_controller_unregister(mbox);
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id arm_smc_mbox_of_match[] =3D {
> > +	{ .compatible =3D "arm,smc-mbox", },
> > +	{ .compatible =3D "arm,hvc-mbox", },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, arm_smc_mbox_of_match);
> > +
> > +static struct platform_driver arm_smc_mbox_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "arm-smc-mbox",
> > +		.of_match_table =3D arm_smc_mbox_of_match,
> > +	},
> > +	.probe		=3D arm_smc_mbox_probe,
> > +	.remove		=3D arm_smc_mbox_remove,
> > +};
> > +module_platform_driver(arm_smc_mbox_driver);
> > +
> > +MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
> > +MODULE_DESCRIPTION("Generic ARM smc mailbox driver");
> > +MODULE_LICENSE("GPL v2");

