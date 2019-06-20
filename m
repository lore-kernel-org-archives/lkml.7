Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641A5C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D4F2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIkc1i8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732072AbfFTQuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 12:50:25 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33770 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfFTQuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 12:50:25 -0400
Received: by mail-io1-f68.google.com with SMTP id u13so427055iop.0;
        Thu, 20 Jun 2019 09:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pj7QnGqfxKJhNv5xmHnRYoJ7c15L40SNj/XfqDQg5QE=;
        b=UIkc1i8RkXuf32D1QXNLL25YtqzocZ4t0FwZVF1t0taPjaRCwN37ljjc/QrKP0ekCc
         hKHULfygITG9zFJoeXVS6FucqsrcxT9GdVObdRVHb3MiVajQLLkPTzyMZgiNaA5FMuFF
         jArfRuZldWYjjne+lbPew6fMKFIWDAvoHNiSpqhfLj6gf4zFF56gQ5VbeDcYvkkriKoT
         uFJ/ZjkIEB83m0KaYA9zfDsuIyfBCj7R67reODcNP5Xt86ig+NIzG9FPjmjg7FTOj6uj
         nbaD/+OC1SGoU6jskATe+9cZvTrp5UvAd3NEQwFFOteatAMiB3sTvWaElkAgPqI3BzLg
         MF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pj7QnGqfxKJhNv5xmHnRYoJ7c15L40SNj/XfqDQg5QE=;
        b=fj2IxotxDF+T0OuhxUlr+Ly8GmaEu8jMXMimwlOBKZMzul+dB7Ct+Q7G/QAPNL2jFa
         H+kVzu/wFtr5a1qiLoqcnftUcefyt7EYuf5ZdxICHXRHDzNHCmomROe7C8LwE2zWJdDW
         kAxPhbiUvgzu7awc4F6eUGrjnuaQhBmnFDyT6l/sf3BwcqtDJ2cy1cZw7XyxPwNCPCY6
         TEquj37LWFafHB3qaKlKcb7YoQVNghi/T1Xhp7izYD/GmRbxqbM1gVGnAKasRb0AARIo
         tv/30mROD3pf7OKaTdxV+29CGLCBd/IIBgpbyWcUh0HTFrSLjQff8+TJSvyL04xXvaHK
         21Ig==
X-Gm-Message-State: APjAAAUJ5TS/hxU10KaK3QEE/+wYS54gsdUcbjdMBCU82JZscrUZJeXt
        UNTHzD9rdGUTsZgX+jTX3KHJ9Sc8r4fbZUWpcXM=
X-Google-Smtp-Source: APXvYqz2nJi/ZRNSQsIF7u4BDFjwk+S62Zk0YgwOvoGeyPiWNS0gqP02Y6wluW3iu/yvBwVvdotwmo9un38F+GN0LwM=
X-Received: by 2002:a02:a38d:: with SMTP id y13mr98730924jak.68.1561049423864;
 Thu, 20 Jun 2019 09:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190603083005.4304-1-peng.fan@nxp.com> <20190603083005.4304-3-peng.fan@nxp.com>
In-Reply-To: <20190603083005.4304-3-peng.fan@nxp.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Thu, 20 Jun 2019 11:50:12 -0500
Message-ID: <CABb+yY1wW-arSMQSYjrezXOZ0Ar_shAr78MOyUD3hBxXohWx3g@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] mailbox: introduce ARM SMC based mailbox
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        ", Sascha Hauer" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, festevam@gmail.com,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Andre Przywara <andre.przywara@arm.com>, van.freenix@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 3:28 AM <peng.fan@nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> This mailbox driver implements a mailbox which signals transmitted data
> via an ARM smc (secure monitor call) instruction. The mailbox receiver
> is implemented in firmware and can synchronously return data when it
> returns execution to the non-secure world again.
> An asynchronous receive path is not implemented.
> This allows the usage of a mailbox to trigger firmware actions on SoCs
> which either don't have a separate management processor or on which such
> a core is not available. A user of this mailbox could be the SCP
> interface.
>
> Modified from Andre Przywara's v2 patch
> https://lore.kernel.org/patchwork/patch/812999/
>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>
> V2:
>  Add interrupts notification support.
>
>  drivers/mailbox/Kconfig                 |   7 ++
>  drivers/mailbox/Makefile                |   2 +
>  drivers/mailbox/arm-smc-mailbox.c       | 190 ++++++++++++++++++++++++++++++++
>  include/linux/mailbox/arm-smc-mailbox.h |  10 ++
>  4 files changed, 209 insertions(+)
>  create mode 100644 drivers/mailbox/arm-smc-mailbox.c
>  create mode 100644 include/linux/mailbox/arm-smc-mailbox.h
>
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index 595542bfae85..c3bd0f1ddcd8 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -15,6 +15,13 @@ config ARM_MHU
>           The controller has 3 mailbox channels, the last of which can be
>           used in Secure mode only.
>
> +config ARM_SMC_MBOX
> +       tristate "Generic ARM smc mailbox"
> +       depends on OF && HAVE_ARM_SMCCC
> +       help
> +         Generic mailbox driver which uses ARM smc calls to call into
> +         firmware for triggering mailboxes.
> +
>  config IMX_MBOX
>         tristate "i.MX Mailbox"
>         depends on ARCH_MXC || COMPILE_TEST
> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
> index c22fad6f696b..93918a84c91b 100644
> --- a/drivers/mailbox/Makefile
> +++ b/drivers/mailbox/Makefile
> @@ -7,6 +7,8 @@ obj-$(CONFIG_MAILBOX_TEST)      += mailbox-test.o
>
>  obj-$(CONFIG_ARM_MHU)  += arm_mhu.o
>
> +obj-$(CONFIG_ARM_SMC_MBOX)     += arm-smc-mailbox.o
> +
>  obj-$(CONFIG_IMX_MBOX) += imx-mailbox.o
>
>  obj-$(CONFIG_ARMADA_37XX_RWTM_MBOX)    += armada-37xx-rwtm-mailbox.o
> diff --git a/drivers/mailbox/arm-smc-mailbox.c b/drivers/mailbox/arm-smc-mailbox.c
> new file mode 100644
> index 000000000000..fef6e38d8b98
> --- /dev/null
> +++ b/drivers/mailbox/arm-smc-mailbox.c
> @@ -0,0 +1,190 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2016,2017 ARM Ltd.
> + * Copyright 2019 NXP
> + */
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/interrupt.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/mailbox/arm-smc-mailbox.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#define ARM_SMC_MBOX_USE_HVC   BIT(0)
> +#define ARM_SMC_MBOX_USB_IRQ   BIT(1)
> +
IRQ bit is unused (and unnecessary IMO)

> +struct arm_smc_chan_data {
> +       u32 function_id;
> +       u32 flags;
> +       int irq;
> +};
> +
> +static int arm_smc_send_data(struct mbox_chan *link, void *data)
> +{
> +       struct arm_smc_chan_data *chan_data = link->con_priv;
> +       struct arm_smccc_mbox_cmd *cmd = data;
> +       struct arm_smccc_res res;
> +       u32 function_id;
> +
> +       if (chan_data->function_id != UINT_MAX)
> +               function_id = chan_data->function_id;
> +       else
> +               function_id = cmd->a0;
> +
Not sure about chan_data->function_id.  Why restrict from DT?
'a0' is the function_id register, let the user pass func-id via the
'a0' like other values via 'a[1-7]'


> +       if (chan_data->flags & ARM_SMC_MBOX_USE_HVC)
> +               arm_smccc_hvc(function_id, cmd->a1, cmd->a2, cmd->a3, cmd->a4,
> +                             cmd->a5, cmd->a6, cmd->a7, &res);
> +       else
> +               arm_smccc_smc(function_id, cmd->a1, cmd->a2, cmd->a3, cmd->a4,
> +                             cmd->a5, cmd->a6, cmd->a7, &res);
> +
> +       if (chan_data->irq)
> +               return 0;
> +
This irq thing seems like oob signalling, that is, a protocol thing.
And then it provides lesser info via chan_irq_handler (returns NULL)
than res.a0 - which can always be ignored if not needed.
So the irq should be implemented in the upper layer if the protocol needs it.

> +       mbox_chan_received_data(link, (void *)res.a0);
> +
This is fine.
