Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD31C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81AF1213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8d6P2Lj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731018AbfFYOgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:36:46 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44931 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728710AbfFYOgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:36:46 -0400
Received: by mail-io1-f65.google.com with SMTP id s7so3666655iob.11;
        Tue, 25 Jun 2019 07:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=675OzOy+510rgklrUaR96A8aWWUmnotqZyJprpSFvDY=;
        b=C8d6P2LjPsGOUIC0tsQoXICkz7v3AIjhqBGFbjqHH928L6FdjG1uNi8gPm9Z1CCbwV
         Xzw4VD+dM9v7UVqP2QhYzm7D6YYREj4FneX1uUG8NUumMooHWJXNSCDQSvG64Xg6DbVg
         sAY+9S8x4SkMiCeY0p4EgJqp1i8RthYYi+1ylaNW4MgmNsPEyY68KH8gFjpl6/vjD7nI
         nurfPFrv12oiOHOL7PaG+VSnmAw+Bo79IO3jgbs4yA0Z9zTSHq+7paAUwF5MocNdOmNE
         N1+TvLRKGzrvNYGzzoOrgFBrVv+EE8EhIsy1tpw7rqXz4CWW5OR+HVMhKuyIbnPRZDSX
         fpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=675OzOy+510rgklrUaR96A8aWWUmnotqZyJprpSFvDY=;
        b=VkqViPQFBRY+jsCkNwsG1tzXs0sfzePVYIHHl3m6ZyCO3HYPNcr6DijKsEBV5OxZ5L
         UFQfZ9gadJeS4TvbfPeAsKG010FV2LnTUysQhhad3WEP4gio3ZZMIpKiv2fY1aCZCzN8
         fO+I37R/CBbopAff9JtlSwOK0ZRgUOCqvlY2uC9Wp0A8GiIfEdEXzWug7aRvuVLaegHV
         LtFxkJu/j1oVQcSeSFYUc4IyqRF7hoxo6jNz2OWRrWWGx4Yrqfn4BhMYUkCwdawLdZN7
         kGk8zfVdLv2UKDIb7dCPpxaDUthniBid44tf3BbBIdPh0JBqKFSjTN5TCeMnNuCXVqF+
         rZYA==
X-Gm-Message-State: APjAAAXNR13akbsO4V/a9l/56BknrxcSD/AmuKwQtlUp9nJyTeuWvgYi
        LXuEQGPQOWyS70sQqHkr4UI4dn1yw74863ZTKdA=
X-Google-Smtp-Source: APXvYqyIhHfq9+Y1O90Dc9QCg+QologakcjEJq20JB9jjKKHZ3UFv1CEoNGBNtNqH+gGzl2D3yh6phm+3DUz6D1TNAU=
X-Received: by 2002:a6b:c90c:: with SMTP id z12mr1767390iof.11.1561473405499;
 Tue, 25 Jun 2019 07:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190603083005.4304-1-peng.fan@nxp.com> <20190603083005.4304-3-peng.fan@nxp.com>
 <CABb+yY1wW-arSMQSYjrezXOZ0Ar_shAr78MOyUD3hBxXohWx3g@mail.gmail.com> <AM0PR04MB44813A4DE544E53EB7B6F02B88E30@AM0PR04MB4481.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB44813A4DE544E53EB7B6F02B88E30@AM0PR04MB4481.eurprd04.prod.outlook.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Tue, 25 Jun 2019 09:36:34 -0500
Message-ID: <CABb+yY38MAZqVOhjyV+GByPvpFcTfKbNG1rJ8YDRd1vi1F4fqg@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] mailbox: introduce ARM SMC based mailbox
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        ", Sascha Hauer" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Andre Przywara <andre.przywara@arm.com>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 2:30 AM Peng Fan <peng.fan@nxp.com> wrote:
>
> Hi Jassi
>
> > Subject: Re: [PATCH V2 2/2] mailbox: introduce ARM SMC based mailbox
> >
> > On Mon, Jun 3, 2019 at 3:28 AM <peng.fan@nxp.com> wrote:
> > >
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > This mailbox driver implements a mailbox which signals transmitted
> > > data via an ARM smc (secure monitor call) instruction. The mailbox
> > > receiver is implemented in firmware and can synchronously return data
> > > when it returns execution to the non-secure world again.
> > > An asynchronous receive path is not implemented.
> > > This allows the usage of a mailbox to trigger firmware actions on SoCs
> > > which either don't have a separate management processor or on which
> > > such a core is not available. A user of this mailbox could be the SCP
> > > interface.
> > >
> > > Modified from Andre Przywara's v2 patch
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore
> > > .kernel.org%2Fpatchwork%2Fpatch%2F812999%2F&amp;data=02%7C01%7
> > Cpeng.fa
> > >
> > n%40nxp.com%7C1237677cb01044ad714508d6f59f648f%7C686ea1d3bc2b4
> > c6fa92cd
> > >
> > 99c5c301635%7C0%7C0%7C636966462272457978&amp;sdata=Hzgeu43m5
> > ZkeRMtL8Bx
> > > gUm3%2B6FBObib1OPHPlSccE%2B0%3D&amp;reserved=0
> > >
> > > Cc: Andre Przywara <andre.przywara@arm.com>
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >
> > > V2:
> > >  Add interrupts notification support.
> > >
> > >  drivers/mailbox/Kconfig                 |   7 ++
> > >  drivers/mailbox/Makefile                |   2 +
> > >  drivers/mailbox/arm-smc-mailbox.c       | 190
> > ++++++++++++++++++++++++++++++++
> > >  include/linux/mailbox/arm-smc-mailbox.h |  10 ++
> > >  4 files changed, 209 insertions(+)
> > >  create mode 100644 drivers/mailbox/arm-smc-mailbox.c  create mode
> > > 100644 include/linux/mailbox/arm-smc-mailbox.h
> > >
> > > diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig index
> > > 595542bfae85..c3bd0f1ddcd8 100644
> > > --- a/drivers/mailbox/Kconfig
> > > +++ b/drivers/mailbox/Kconfig
> > > @@ -15,6 +15,13 @@ config ARM_MHU
> > >           The controller has 3 mailbox channels, the last of which can be
> > >           used in Secure mode only.
> > >
> > > +config ARM_SMC_MBOX
> > > +       tristate "Generic ARM smc mailbox"
> > > +       depends on OF && HAVE_ARM_SMCCC
> > > +       help
> > > +         Generic mailbox driver which uses ARM smc calls to call into
> > > +         firmware for triggering mailboxes.
> > > +
> > >  config IMX_MBOX
> > >         tristate "i.MX Mailbox"
> > >         depends on ARCH_MXC || COMPILE_TEST diff --git
> > > a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile index
> > > c22fad6f696b..93918a84c91b 100644
> > > --- a/drivers/mailbox/Makefile
> > > +++ b/drivers/mailbox/Makefile
> > > @@ -7,6 +7,8 @@ obj-$(CONFIG_MAILBOX_TEST)      += mailbox-test.o
> > >
> > >  obj-$(CONFIG_ARM_MHU)  += arm_mhu.o
> > >
> > > +obj-$(CONFIG_ARM_SMC_MBOX)     += arm-smc-mailbox.o
> > > +
> > >  obj-$(CONFIG_IMX_MBOX) += imx-mailbox.o
> > >
> > >  obj-$(CONFIG_ARMADA_37XX_RWTM_MBOX)    +=
> > armada-37xx-rwtm-mailbox.o
> > > diff --git a/drivers/mailbox/arm-smc-mailbox.c
> > > b/drivers/mailbox/arm-smc-mailbox.c
> > > new file mode 100644
> > > index 000000000000..fef6e38d8b98
> > > --- /dev/null
> > > +++ b/drivers/mailbox/arm-smc-mailbox.c
> > > @@ -0,0 +1,190 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (C) 2016,2017 ARM Ltd.
> > > + * Copyright 2019 NXP
> > > + */
> > > +
> > > +#include <linux/arm-smccc.h>
> > > +#include <linux/device.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/mailbox_controller.h> #include
> > > +<linux/mailbox/arm-smc-mailbox.h>
> > > +#include <linux/module.h>
> > > +#include <linux/platform_device.h>
> > > +
> > > +#define ARM_SMC_MBOX_USE_HVC   BIT(0)
> > > +#define ARM_SMC_MBOX_USB_IRQ   BIT(1)
> > > +
> > IRQ bit is unused (and unnecessary IMO)
> >
> > > +struct arm_smc_chan_data {
> > > +       u32 function_id;
> > > +       u32 flags;
> > > +       int irq;
> > > +};
> > > +
> > > +static int arm_smc_send_data(struct mbox_chan *link, void *data) {
> > > +       struct arm_smc_chan_data *chan_data = link->con_priv;
> > > +       struct arm_smccc_mbox_cmd *cmd = data;
> > > +       struct arm_smccc_res res;
> > > +       u32 function_id;
> > > +
> > > +       if (chan_data->function_id != UINT_MAX)
> > > +               function_id = chan_data->function_id;
> > > +       else
> > > +               function_id = cmd->a0;
> > > +
> > Not sure about chan_data->function_id.  Why restrict from DT?
> > 'a0' is the function_id register, let the user pass func-id via the 'a0' like other
> > values via 'a[1-7]'
>
> Missed to reply this comment.
>
> The firmware driver might not have func-id, such as SCMI/SCPI.
> So add an optional func-id to let smc mailbox driver could
> use smc SiP func id.
>
There is no end to conforming to protocols. Controller drivers should
be written having no particular client in mind.
