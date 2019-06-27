Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66228C48BD9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 15:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2682064A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 15:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmJcIzz2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfF0Pck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 11:32:40 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43606 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfF0Pcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 11:32:39 -0400
Received: by mail-io1-f66.google.com with SMTP id k20so5642073ios.10;
        Thu, 27 Jun 2019 08:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=59Nn5nbRZMXaiSawckn2aQ0fMAxX2U20XTjPkPEFxrM=;
        b=VmJcIzz2oyCbL3ltguvci+laxVDoe5qs6Vvm19EijK1BOvGGG9BGPVrb6Slx88G/8I
         Xw8APQexZMaGSggJhNV/JASgUuylKtgQ/D20Fcp0Nuz/9NTl+/rWjPiHQHZ+Lyl5/8sz
         znKErZCuNbs68f29ekSCZoaATgcvpMTKGrDeguV5jAEoRUqv3RSAAhCAyxeLo+QEtWmC
         p3qnZUzhcusy5LRytRb9DUG5bDqy4/G+F76EmcwSH/CNd8k26UxCBkV6UTKcbXhbzBiC
         etOgLhxJHu8ISguqUZklDcaatKaCS7I2/LIyd9xxfsLk48v8jCnLi8tHIkCSmB+J0MbD
         11jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=59Nn5nbRZMXaiSawckn2aQ0fMAxX2U20XTjPkPEFxrM=;
        b=PZvp63G2TLuBLPCEwkq5eXXDGLoMK4RxjcIdayi4wFGA8/jl6CCHgiCpmppj+tEssc
         I4qtufUcDZ+onASIYLKFqabchP7bO6fQt4sMZ4o39jkXaH4CqAVGRjTglj5RlQBm0ivT
         ZTpsI+FV6Ig5AkAaKQpOdPbyuOTWkQwRekHmOanHxLQ8MdK3ImmSx4tbnZsOlL9PAwKu
         wSu8bS+ZeH8q+gIf1qeA7zhXrGGAb1YNxIMIM0jqAupcSJFLzdRX7bilxVUMyqlZk9Tm
         jLBfisQ+QSwI4KvkmJlsyKC7ClczLDF5+ve3fxKqK3rx1fnTiuf8/3gho/VfBZD1hC0z
         BCeQ==
X-Gm-Message-State: APjAAAWzjgGkiBpNowO7EsXfX0qMUn3Qy/83zEoYhxahgGkxmNru2ntC
        cPQIq/ON9ApCcA6BtPSXKjS7UBUZG4p6GYSm1n0=
X-Google-Smtp-Source: APXvYqws3mmBGC1Nm5BMf5lOqIkEiXBt4nu6Kkfl1ZOPSvzUJsjmwD4gIgkLWMsvDM5nmAawlgv+cqbhhf0ZmY71Jfw=
X-Received: by 2002:a02:a38d:: with SMTP id y13mr5124660jak.68.1561649558019;
 Thu, 27 Jun 2019 08:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190603083005.4304-1-peng.fan@nxp.com> <20190603083005.4304-3-peng.fan@nxp.com>
 <CABb+yY1wW-arSMQSYjrezXOZ0Ar_shAr78MOyUD3hBxXohWx3g@mail.gmail.com>
 <AM0PR04MB44813A4DE544E53EB7B6F02B88E30@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CABb+yY38MAZqVOhjyV+GByPvpFcTfKbNG1rJ8YDRd1vi1F4fqg@mail.gmail.com>
 <AM0PR04MB44814D3BD59033ECDDE3094C88E20@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <e49278ba-f734-e019-ab44-53afe558bd85@gmail.com> <CABb+yY2B_bGqZhd3HRm2qOwGNXG8UYvRo0_uBmwGbx_1gA-vfA@mail.gmail.com>
 <20190627090903.GD13572@e107155-lin>
In-Reply-To: <20190627090903.GD13572@e107155-lin>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Thu, 27 Jun 2019 10:32:27 -0500
Message-ID: <CABb+yY1aVbKfuqX=GvTzyjkgRXB3DXLvgjZARGn8k8m2R2vSqA@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] mailbox: introduce ARM SMC based mailbox
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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

On Thu, Jun 27, 2019 at 4:09 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Jun 26, 2019 at 01:27:41PM -0500, Jassi Brar wrote:
> > On Wed, Jun 26, 2019 at 11:44 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
> > >
> > > On 6/26/19 6:31 AM, Peng Fan wrote:
> > > >>> The firmware driver might not have func-id, such as SCMI/SCPI.
> > > >>> So add an optional func-id to let smc mailbox driver could
> > > >>> use smc SiP func id.
> > > >>>
> > > >> There is no end to conforming to protocols. Controller drivers should
> > > >> be written having no particular client in mind.
> > > >
> > > > If the func-id needs be passed from user, then the chan_id suggested
> > > > by Sudeep should also be passed from user, not in mailbox driver.
> > > >
> > > > Jassi, so from your point, arm_smc_send_data just send a0 - a6
> > > > to firmware, right?
> > > >
> > > > Sudeep, Andre, Florian,
> > > >
> > > > What's your suggestion? SCMI not support, do you have
> > > > plan to add smc transport in SCMI?
> > >
> > > On the platforms that I work with, we have taken the liberty of
> > > implementing SCMI in our monitor firmware because the other MCU we use
> > > for dynamic voltage and frequency scaling did not have enough memory to
> > > support that and we still had the ability to make that firmware be
> > > trusted enough we could give it power management responsibilities. I
> > > would certainly feel more comfortable if the SCMI specification was
> > > amended to indicate that the Agent could be such a software entity,
> > > still residing on the same host CPU as the Platform(s), but if not,
> > > that's fine.
> > >
> > > This has lead us to implement a mailbox driver that uses a proprietary
> > > SMC call for the P2A path ("tx" channel) and the return being done via
> > > either that same SMC or through SGI. You can take a look at it in our
> > > downstream tree here actually:
> > >
> > > https://github.com/Broadcom/stblinux-4.9/blob/master/linux/drivers/mailbox/brcmstb-mailbox.c
> > >
> > > If we can get rid of our own driver and uses a standard SMC based
> > > mailbox driver that supports our use case that involves interrupts (we
> > > can always change their kind without our firmware/boot loader since FDT
> > > is generated from that component), that would be great.
> > >
> > static irqreturn_t brcm_isr(void)
> > {
> >          mbox_chan_received_data(&chans[0], NULL);
> >          return IRQ_HANDLED;
> > }
> >
> > Sorry, I fail to understand why the irq can't be moved inside the
> > client driver itself? There can't be more cost to it and there
> > definitely is no functionality lost.
>
> What if there are multiple clients ?
>
There is a flag IRQF_SHARED for such situations.
(good to see you considering multiple clients per channel as a legit scenario)

> And I assume you are referring to case like this where IRQ is not tied
> to the mailbox IP.
>
Yes, and that is the reason the irq should not be managed by the mailbox driver.
