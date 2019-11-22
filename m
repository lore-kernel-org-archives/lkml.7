Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50559C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 09:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1616620708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 09:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P+pipmz6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfKVJrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 04:47:23 -0500
Received: from mail-eopbgr20085.outbound.protection.outlook.com ([40.107.2.85]:29287
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726500AbfKVJrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 04:47:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lj0ncJ854SALDAy0Xp78p7gQ1/txKJ/9aAEqutAVFY+Gp0h3D7T5+I7VLAcF6uIi548ldHQtpmd16SBYRbOZ7muyn2RqLk0kkuCIJnRkTUaYHaHLmk1+6igi+Iy8ELxqNiaT2SqQ1/1mRxTa9lWEkX2vTJUI8Pe0PkqjehOCDj25r+0uKb1r47phxysD1FlbbfQsg3Co1XPcQpJY+988IfRLKOOxTj5HMrCVKcxbE2wwFLHQw4O5Zv2xvSnJrXgQm3zMUSckoUF+wWRLNQR8zp20nazw6rD1rNEVTV7jcRUAaG70uzbr6jz8sekL/HYiCqIBo1F3G6TTx1KQADqIsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wI4EhuNmGgVKWavBvhGoygwrltpEbuYvA1/W3qBonEM=;
 b=LAYDjGEZWdUk73KU9/+HobjIIvkHRwNzSYm/Pcq2hO2m7s+ojaYS+2H0Jr/6ofvF4ZiU5bUCF+f+v9RnOoYiW/eNdT3ecJIBWqHJgEHzVGAC9OXC7wbkhbilw+m6E41Xz/dQ7Fq9lbzctJ/MynssuWD54Ur8jcNY+4sFfQ+iAwXVvx13Suf/qdTKVuNe/T6j9bPpacjaeypGgCUbMPkKpMhZRXQnQZe6Mbs5plwcxHwyKXr4RA/3TQXBi6zuE4TIxSdTPXDh6205fkTokacx0YasLwkzWotplgm5aB0AjTJOdVkCO7kdtmzZNpWRmplgvNru4dos9X1dVquMpSkQiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wI4EhuNmGgVKWavBvhGoygwrltpEbuYvA1/W3qBonEM=;
 b=P+pipmz6N1XKTnPbk2Z2KbpKzAF3ukGY2Oht6pkRfrSc8KEaJSLNfcsDm65oDJb/K7mGBLgoWXuXhrIiwcnkwNQKOv3DfoyNp6LvSwn/Q5IsXKd7iE4sf4OUOWRt0gx2HiYr5yJ9jpLrZhBOENDPD8laGdfdI8NPs+yx9V8bK4M=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6577.eurprd04.prod.outlook.com (20.179.255.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Fri, 22 Nov 2019 09:47:17 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2474.021; Fri, 22 Nov 2019
 09:47:17 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Andre Przywara <andre.przywara@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V10 2/2] mailbox: introduce ARM SMC based mailbox
Thread-Topic: [PATCH V10 2/2] mailbox: introduce ARM SMC based mailbox
Thread-Index: AQHVd1cfT8QFyxAbm0eWywLWz3Kfz6eBxl+AgAXiXwCAD5uG0A==
Date:   Fri, 22 Nov 2019 09:47:17 +0000
Message-ID: <AM0PR04MB4481463F6F6A57E564CB025A88490@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1569824287-4263-1-git-send-email-peng.fan@nxp.com>
 <1569824287-4263-3-git-send-email-peng.fan@nxp.com>
 <2c8fa412-33c2-57c7-20b7-37b3b70ce524@gmail.com>
 <20191112112414.10f3f88e@donnerap.cambridge.arm.com>
In-Reply-To: <20191112112414.10f3f88e@donnerap.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7750a7b5-0efc-4c8b-1b04-08d76f30f642
x-ms-traffictypediagnostic: AM0PR04MB6577:|AM0PR04MB6577:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB65776180F4EF2713230EB93288490@AM0PR04MB6577.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02296943FF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(199004)(189003)(4326008)(66066001)(9686003)(229853002)(186003)(6246003)(25786009)(3846002)(7696005)(55016002)(64756008)(6116002)(6436002)(2906002)(66446008)(66946007)(53546011)(446003)(44832011)(66476007)(11346002)(102836004)(26005)(76116006)(6506007)(5660300002)(76176011)(71200400001)(71190400001)(52536014)(66556008)(110136005)(15650500001)(14454004)(316002)(256004)(54906003)(81166006)(33656002)(8936002)(8676002)(81156014)(305945005)(86362001)(7736002)(74316002)(99286004)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6577;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sMbPYjUAsMza7tcVwfkyXKo5RuPuKjiXLnJS4r4GSICp6JPYKrOaDXXVU+HEVNgBrXFBNmSIyA+yRtGMfQcJFomgoulIYUT7BWtHYrgM5hIqsdtv5Mp/QGclW5UTdyzP3RejfyufUkiZQ3KG0xsEx7+kUP9C9p2wmat8UScaSWQ0ttr5SlYDiEh2PRG1AYXHUrxoKY729hcSKxBUy3YoLxnfqvgkrhik3lGpgOKY66f38koDRBpKg7U+YJLRwRAzHCzlgZK5NwZwdtlB5/FfKYgGmIcmgO8pVjEu1F+kYGq09zOUk1sqsVVgpRp2zZrZqnCoNzIxqMv5uxcgfmLd8PEiXqBegccisiJ5HqtkUCSZUGZFgloog78Xnh1Tag5KxP4TIvAbMKIkNYdxS0ehwKtLpoE1Kf8oJKCsBXX9Dm++UXvYCE1iZj89CBVbGnJl
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7750a7b5-0efc-4c8b-1b04-08d76f30f642
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 09:47:17.6055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vvoSGRxP29pGdnwYzIYlvfXW04TirHfRVVL0qTSuhbzBdDjScaWTF7/BfR9NZJnIhnGW3d1DOggl3dmizCbvAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6577
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V10 2/2] mailbox: introduce ARM SMC based mailbox
>=20
> On Fri, 8 Nov 2019 09:32:43 -0800
> Florian Fainelli <f.fainelli@gmail.com> wrote:
>=20
> Hi Florian,
>=20
> > On 9/29/19 11:20 PM, Peng Fan wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > This mailbox driver implements a mailbox which signals transmitted
> > > data via an ARM smc (secure monitor call) instruction. The mailbox
> > > receiver is implemented in firmware and can synchronously return
> > > data when it returns execution to the non-secure world again.
> > > An asynchronous receive path is not implemented.
> > > This allows the usage of a mailbox to trigger firmware actions on
> > > SoCs which either don't have a separate management processor or on
> > > which such a core is not available. A user of this mailbox could be
> > > the SCP interface.
> >
> > Sorry for not spotting this, or rather asking this earlier, but I do
> > have one question below.
> >
> > [snip]
> >
> > > +static int arm_smc_send_data(struct mbox_chan *link, void *data) {
> > > +	struct arm_smc_chan_data *chan_data =3D link->con_priv;
> > > +	struct arm_smccc_mbox_cmd *cmd =3D data;
> > > +	unsigned long ret;
> > > +
> > > +	if (ARM_SMCCC_IS_64(chan_data->function_id)) {
> > > +		ret =3D
> chan_data->invoke_smc_mbox_fn(chan_data->function_id,
> > > +						    cmd->args_smccc64[0],
> > > +						    cmd->args_smccc64[1],
> > > +						    cmd->args_smccc64[2],
> > > +						    cmd->args_smccc64[3],
> > > +						    cmd->args_smccc64[4],
> > > +						    cmd->args_smccc64[5]);
> > > +	} else {
> > > +		ret =3D
> chan_data->invoke_smc_mbox_fn(chan_data->function_id,
> > > +						    cmd->args_smccc32[0],
> > > +						    cmd->args_smccc32[1],
> > > +						    cmd->args_smccc32[2],
> > > +						    cmd->args_smccc32[3],
> > > +						    cmd->args_smccc32[4],
> > > +						    cmd->args_smccc32[5]);
> > > +	}
> >
> > Why did not we use unsigned long for the args_smccc[] array to be bit
> > width independent, this is what the PSCI infrastructure does and it
> > looks a lot nicer IMHO. More question below.
>=20
> Huh, interestingly I think this comes from the combination of the two
> problems you point out, which evolved separately:
> Earlier we had no exported interface between the transport driver and the
> mailbox client, just a void pointer. So using "long" in the structure wou=
ld not
> work, because it would behave differently between arm32 and arm64 kernels=
.
> But the firmware interface would always be fixed to one of the two callin=
g
> conventions, regardless of the kernel "bitness", as advertised by the upp=
er bits
> of the function ID.
> So we introduced explicit types that are used depending on the
> firmware-advertised calling convention. The idea was that any packed data
> any client would provide would always end up in consecutive registers in =
the
> firmware.
> Now we explicitly advertise the expected message structure in the new
> header file, so we could go back to unsigned long here, indeed. A 32-bit =
kernel
> could never use the 64-bit calling convention, so long would fit. In a 64=
-bit
> kernel the compiler would either downgrade the long argument to the 32-bi=
t
> arguments the firmware expects, or keep it long.
> So it might be worth a short to go back to long.

I'll drop the check ARM_SMCCC_IS_64(chan_data->function_id) and
Directly
 chan_data->invoke_smc_mbox_fn(chan_data->function_id,
						    cmd->args_smccc[0],
						    cmd->args_smccc[1],
						    cmd->args_smccc[2],
						    cmd->args_smccc[3],
						    cmd->args_smccc[4],
						    cmd->args_smccc[5]);

Is this ok for you?

>=20
> >
> > [snip]
> >
> > > +
> > > +#ifndef _LINUX_ARM_SMCCC_MBOX_H_
> > > +#define _LINUX_ARM_SMCCC_MBOX_H_
> > > +
> > > +#include <linux/types.h>
> > > +
> > > +/**
> > > + * struct arm_smccc_mbox_cmd - ARM SMCCC message structure
> > > + * @args_smccc32/64:	actual usage of registers is up to the protocol
> > > + *			(within the SMCCC limits)
> > > + */
> > > +struct arm_smccc_mbox_cmd {
> > > +	union {
> > > +		u32 args_smccc32[6];
> > > +		u64 args_smccc64[6];
> > > +	};
> > > +};
> >
> > Why is this being moved to a separate header file and not within the
> > driver's main file? It is not like we offer the ability for a driver
> > to embed this ARM SMC mailbox driver as a library, and customize the
> > values of the SMC arguments (maybe we should do that, as a later
> > patch) except for the function_id.
>=20
> I wouldn't call it a "library", but indeed we expose the transport protoc=
ol to
> the mailbox client. It seems that the mailbox framework is not really cle=
ar
> here, it just states that (at least in many cases) the mailbox client kno=
ws about
> the transport protocol, even though the separation between the two sugges=
ts
> otherwise. This probably stems back from the days, where mailboxes were
> directly used by their users, without providing any kind of abstraction.
> So going with this, the SMC mailbox transport driver enforces a specific
> transport protocol for the payload, namely the six SMCCC defined register=
s. So
> we make this available, so any mailbox client knows what to expect. At th=
e
> end of the day on the other end there will be some firmware probably
> expecting specific data in specific registers - or no data at all, as in =
the simple
> doorbell case we intend to use for SCPI/SCMI.

struct arm_smccc_mbox_cmd {
	unsigned long args_smccc[6];
};

Is this ok for you?

Thanks,
Peng.


>=20
> > If you have a "public" header, there is usually a service or some
> > configuration that your driver would offer, which is not the case
> > here.
>=20
> If you want to use the mailbox just as a doorbell (as in our case), it do=
esn't
> matter, so we can as well expose the underlying transport protocol.
>=20
> Cheers,
> Andre.
