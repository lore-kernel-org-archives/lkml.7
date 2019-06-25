Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3761CC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDCCE20652
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="U+wKPciD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfFYH2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:28:25 -0400
Received: from mail-eopbgr50069.outbound.protection.outlook.com ([40.107.5.69]:16985
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726835AbfFYH2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1blAqt5cAOHT9hXOKolQMXHrESjh/ARXC3ZF1+d7MnE=;
 b=U+wKPciD+xt3tjYllLSdweQYpEBptI9yK7BGJ9fluuewmQgzOXQNvZFTijLNTicZisZu0dEKXew0dIqITXoGYfxacX7bSanzyDKQ0y09TvRpw+lUETqu7ik1PukvSTqDw2xxy+0Jr3GEUYBS6CO2iQOTQzMOcaPlz43BE+gN4MA=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5682.eurprd04.prod.outlook.com (20.178.202.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 07:28:20 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::2023:c0e5:8a63:2e47]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::2023:c0e5:8a63:2e47%5]) with mapi id 15.20.2008.014; Tue, 25 Jun 2019
 07:28:20 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: RE: [PATCH V2 2/2] mailbox: introduce ARM SMC based mailbox
Thread-Topic: [PATCH V2 2/2] mailbox: introduce ARM SMC based mailbox
Thread-Index: AQHVGeZUO66GnquMY06cfK/cKOI4kaakX7aAgAAODnCAABFTAIAHm4Sw
Date:   Tue, 25 Jun 2019 07:28:20 +0000
Message-ID: <AM0PR04MB4481F27EA9E158C04835505888E30@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190603083005.4304-1-peng.fan@nxp.com>
 <20190603083005.4304-3-peng.fan@nxp.com> <20190620092301.GD1248@e107155-lin>
 <AM0PR04MB4481203DE76D290F311E3BFA88E40@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20190620111520.GB9575@e107155-lin>
In-Reply-To: <20190620111520.GB9575@e107155-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b01e2f1f-fe09-4149-d6c9-08d6f93eb2e9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5682;
x-ms-traffictypediagnostic: AM0PR04MB5682:
x-microsoft-antispam-prvs: <AM0PR04MB5682CE8EA40B94A0FD494C0988E30@AM0PR04MB5682.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(39860400002)(366004)(376002)(51914003)(189003)(199004)(76094002)(7696005)(81166006)(81156014)(6436002)(33656002)(966005)(3846002)(229853002)(52536014)(54906003)(76176011)(6116002)(478600001)(99286004)(66066001)(256004)(66556008)(66446008)(64756008)(66476007)(4326008)(14444005)(25786009)(74316002)(14454004)(7416002)(73956011)(76116006)(316002)(15650500001)(11346002)(305945005)(9686003)(8936002)(476003)(86362001)(6246003)(2906002)(44832011)(6306002)(6916009)(66946007)(53936002)(186003)(446003)(68736007)(26005)(5660300002)(6506007)(8676002)(55016002)(486006)(7736002)(102836004)(71190400001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5682;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: C3pv9fT7YsrljCLqgYE8nM/JjD9gK61IsU9BBZ0S8cGn4fONMMgpf1cFbhZ28iHnoG113/7MEMPCZRE499mpHXuu9EOM8WeKatRYo4zcaFLIyl4vO4gbgZMUSQbQPGQsHi+dG2EaYewugp4jXscyOXU99Qn4hoNAEGWxJuX85COYyj1vuZyKXOeyriIfyjTv+24aGNMQWc0bBSBzb+TDzzQ5AQmqQgXL5IoANUwZ04Hco3GpPvlEbniFSRig2q5Ydv4qQ3898gIPiNO87swnVd7jRw+VFWGZCptuFamXADV0Kv/yK8+DoXIOjwVMReI5aYsmlDKJhDRgum/fpXXc6K6iooK0x3ZTyXh9je+2InHrKW+eztkUpoRljWWJmyNu9spALvlLuZBorrI0EOclphIx+w+XQgVn4KcGA7Fu0wc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b01e2f1f-fe09-4149-d6c9-08d6f93eb2e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 07:28:20.3472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peng.fan@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5682
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

> Subject: Re: [PATCH V2 2/2] mailbox: introduce ARM SMC based mailbox
>=20
> On Thu, Jun 20, 2019 at 10:21:09AM +0000, Peng Fan wrote:
> > Hi Sudeep,
> >
> > > Subject: Re: [PATCH V2 2/2] mailbox: introduce ARM SMC based mailbox
> > >
> > > On Mon, Jun 03, 2019 at 04:30:05PM +0800, peng.fan@nxp.com wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > This mailbox driver implements a mailbox which signals transmitted
> > > > data via an ARM smc (secure monitor call) instruction. The mailbox
> > > > receiver is implemented in firmware and can synchronously return
> > > > data when it returns execution to the non-secure world again.
> > > > An asynchronous receive path is not implemented.
> > > > This allows the usage of a mailbox to trigger firmware actions on
> > > > SoCs which either don't have a separate management processor or on
> > > > which such a core is not available. A user of this mailbox could
> > > > be the SCP interface.
> > > >
> > > > Modified from Andre Przywara's v2 patch https://lore
> > > > .kernel.org%2Fpatchwork%2Fpatch%2F812999%2F&amp;data=3D02%7C0
> 1%7
> > > Cpeng.fa
> > > >
> > >
> n%40nxp.com%7C6b37f78032e446be750e08d6f560e707%7C686ea1d3bc2b4
> > > c6fa92cd
> > > >
> > >
> 99c5c301635%7C0%7C0%7C636966193913988679&amp;sdata=3DUNM4MTPs
> > > brqoMqWStEy
> > > > YzzwMEWTmX7hHO3TeNEz%2BOAw%3D&amp;reserved=3D0
> > > >
> > > > Cc: Andre Przywara <andre.przywara@arm.com>
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > ---
> > > >
> > > > V2:
> > > >  Add interrupts notification support.
> > > >
> > > >  drivers/mailbox/Kconfig                 |   7 ++
> > > >  drivers/mailbox/Makefile                |   2 +
> > > >  drivers/mailbox/arm-smc-mailbox.c       | 190
> > > ++++++++++++++++++++++++++++++++
> > > >  include/linux/mailbox/arm-smc-mailbox.h |  10 ++
> > > >  4 files changed, 209 insertions(+)
> > > >  create mode 100644 drivers/mailbox/arm-smc-mailbox.c  create
> mode
> > > > 100644 include/linux/mailbox/arm-smc-mailbox.h
> > > >
> > > > diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig inde=
x
> > > > 595542bfae85..c3bd0f1ddcd8 100644
> > > > --- a/drivers/mailbox/Kconfig
> > > > +++ b/drivers/mailbox/Kconfig
> > > > @@ -15,6 +15,13 @@ config ARM_MHU
> > > >  	  The controller has 3 mailbox channels, the last of which can be
> > > >  	  used in Secure mode only.
> > > >
> > > > +config ARM_SMC_MBOX
> > > > +	tristate "Generic ARM smc mailbox"
> > > > +	depends on OF && HAVE_ARM_SMCCC
> > > > +	help
> > > > +	  Generic mailbox driver which uses ARM smc calls to call into
> > > > +	  firmware for triggering mailboxes.
> > > > +
> > > >  config IMX_MBOX
> > > >  	tristate "i.MX Mailbox"
> > > >  	depends on ARCH_MXC || COMPILE_TEST
> > > > diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile in=
dex
> > > > c22fad6f696b..93918a84c91b 100644
> > > > --- a/drivers/mailbox/Makefile
> > > > +++ b/drivers/mailbox/Makefile
> > > > @@ -7,6 +7,8 @@ obj-$(CONFIG_MAILBOX_TEST)	+=3D mailbox-test.o
> > > >
> > > >  obj-$(CONFIG_ARM_MHU)	+=3D arm_mhu.o
> > > >
> > > > +obj-$(CONFIG_ARM_SMC_MBOX)	+=3D arm-smc-mailbox.o
> > > > +
> > > >  obj-$(CONFIG_IMX_MBOX)	+=3D imx-mailbox.o
> > > >
> > > >  obj-$(CONFIG_ARMADA_37XX_RWTM_MBOX)	+=3D
> > > armada-37xx-rwtm-mailbox.o
> > > > diff --git a/drivers/mailbox/arm-smc-mailbox.c
> > > > b/drivers/mailbox/arm-smc-mailbox.c
> > > > new file mode 100644
> > > > index 000000000000..fef6e38d8b98
> > > > --- /dev/null
> > > > +++ b/drivers/mailbox/arm-smc-mailbox.c
> > > > @@ -0,0 +1,190 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Copyright (C) 2016,2017 ARM Ltd.
> > > > + * Copyright 2019 NXP
> > > > + */
> > > > +
> > > > +#include <linux/arm-smccc.h>
> > > > +#include <linux/device.h>
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/interrupt.h>
> > > > +#include <linux/mailbox_controller.h> #include
> > > > +<linux/mailbox/arm-smc-mailbox.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/platform_device.h>
> > > > +
> > > > +#define ARM_SMC_MBOX_USE_HVC	BIT(0)
> > > > +#define ARM_SMC_MBOX_USB_IRQ	BIT(1)
> > > > +
> > > > +struct arm_smc_chan_data {
> > > > +	u32 function_id;
> > > > +	u32 flags;
> > > > +	int irq;
> > > > +};
> > > > +
> > > > +static int arm_smc_send_data(struct mbox_chan *link, void *data) {
> > > > +	struct arm_smc_chan_data *chan_data =3D link->con_priv;
> > > > +	struct arm_smccc_mbox_cmd *cmd =3D data;
> > > > +	struct arm_smccc_res res;
> > > > +	u32 function_id;
> > > > +
> > > > +	if (chan_data->function_id !=3D UINT_MAX)
> > > > +		function_id =3D chan_data->function_id;
> > > > +	else
> > > > +		function_id =3D cmd->a0;
> > > > +
> > > > +	if (chan_data->flags & ARM_SMC_MBOX_USE_HVC)
> > > > +		arm_smccc_hvc(function_id, cmd->a1, cmd->a2, cmd->a3,
> > > cmd->a4,
> > > > +			      cmd->a5, cmd->a6, cmd->a7, &res);
> > > > +	else
> > > > +		arm_smccc_smc(function_id, cmd->a1, cmd->a2, cmd->a3,
> > > cmd->a4,
> > > > +			      cmd->a5, cmd->a6, cmd->a7, &res);
> > > > +
> > >
> > > So how will the SMC/HVC handler in EL3/2 find which mailbox is being
> > > referred with this command ? I prefer 2nd argument to be the mailbox
> > > number.
> > You mean channel number as following?
> >
> > @@ -37,10 +38,10 @@ static int arm_smc_send_data(struct mbox_chan
> *link, void *data)
> >                 function_id =3D cmd->a0;
> >
> >         if (chan_data->flags & ARM_SMC_MBOX_USE_HVC)
> > -               arm_smccc_hvc(function_id, cmd->a1, cmd->a2,
> cmd->a3, cmd->a4,
> > +               arm_smccc_hvc(function_id, chan_data->chan_id,
> cmd->a2, cmd->a3, cmd->a4,
> >                               cmd->a5, cmd->a6, cmd->a7, &res);
> >         else
> > -               arm_smccc_smc(function_id, cmd->a1, cmd->a2,
> cmd->a3, cmd->a4,
> > +               arm_smccc_smc(function_id, chan_data->chan_id,
> cmd->a2, cmd->a3, cmd->a4,
> >                               cmd->a5, cmd->a6, cmd->a7, &res);
> >
>=20
> Yes something like above. There's a brief description of the same in
> latest SCMI specification though it's not related to SCMI, it more
> general note for SMC based mailbox.
>=20
> "In case the doorbell is SMC/HVC based, it should follow the SMC Calling
> Convention [SMCCC] and needs to provide the identifier of the Shared
> Memory
> area that contains the payload. On return from the call, the Shared Memor=
y
> area which contained the payload is now updated with the SCMI return
> response.
> The identifier of the Shared Memory area should be 32-bits and each
> identifier
> should denote a distinct Shared Memory area."

Thanks for the info, it make sense to pass channel id to firmware.

>=20
> > Or should that be passed from firmware driver?
> >
>=20
> No, we can't assume the id's in DT are 1-1 translation to mailbox ID used
> though it may be the same most of the time.

Understand.

>=20
> > If not from firmware driver, just as above, I do not have a good idea w=
hich
> > should be passed to smc, from cmd->a1 to a5 or from cmd->a2 to a6.
> >
>=20
> Also I found copying those registers may not be always needed and can
> be sub-optimal. May be a way to indicate that this in DT whether
> register based transfers are used or using memory. Just a thought.

"reg-transport" or "mem-transport" should help here.

Thanks,
peng.

>=20
> --
> Regards,
> Sudeep
