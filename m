Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBD2C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 22:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C5C2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 22:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="anjqADdv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390205AbfFJWZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 18:25:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39458 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388328AbfFJWZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 18:25:56 -0400
Received: by mail-pg1-f195.google.com with SMTP id 196so5764919pgc.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 15:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:cc:subject:to:user-agent:date;
        bh=9hBqZJD2Tz09wfOJDUxIvJB/XBCbBflZm3IPa1V/vxE=;
        b=anjqADdvlUHgxpXTA/xLq/4vsfjEG1pLhPFxuBOoSnhDfQK/DLla5XumwWWyElC6Pc
         PS/vAaTAZ0X4ENtlyOgXM52+IXMmYlK/mrW38hordPGkJpua0G7qIjeRrGDafXtUX4JO
         TTshciiU8SjktCILESKUC21nDTZENol6TjYeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:cc:subject:to
         :user-agent:date;
        bh=9hBqZJD2Tz09wfOJDUxIvJB/XBCbBflZm3IPa1V/vxE=;
        b=OrCBXWp3aZWba2gOfqi04bw05e2pZhYncUwdP1QO6ENYhOoZkgUBgY7UofjOmjzFlh
         qDMIdfQSHrPZyRxksmiohWajJA/g5ZWulPpsm9yl6lj93u2T/x8QsM6MQREq3/RviPd8
         zgfWdN+nFSohh9CbpQjGAq0w0hORHu7Tu6Ey44GoLOcwSMkICmxnMMpbrL5v775oTIRj
         uMQiR9tXZmAHJ0aabmCRiLrzyZwHWm+cxIQIaUcSKaSx/OS0aAYFJiNXByRdixNCVEF8
         ZYjCzuREFia9176D5ybI/gUtryZhbSoICj8+oZzTM5ADztc54VShrc3Uep6QMwVefd34
         qHTA==
X-Gm-Message-State: APjAAAVW1P/JKYsPu/U06qKfdmufHreo+5eCdbPR3EJFHflIrsJPUjCv
        6MvC50gfLP/GP9WplUrTglYHGg==
X-Google-Smtp-Source: APXvYqywzldrMc5v86IYfA+eXCNafyrhC15q1lAcvIj3lXXvZ4LL1QGrW0wDFfeIOenalH46fBvZdg==
X-Received: by 2002:aa7:8219:: with SMTP id k25mr79051964pfi.38.1560205555034;
        Mon, 10 Jun 2019 15:25:55 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id v138sm8863906pfc.15.2019.06.10.15.25.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 15:25:54 -0700 (PDT)
Message-ID: <5cfed8f2.1c69fb81.1dcd3.27c1@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAE=gft6jxR9Lt7tLwm6VKy9_shMVW7wf3g6rBGEqtB7oNH0hUA@mail.gmail.com>
References: <20190429035515.73611-1-drinkcat@chromium.org> <20190429035515.73611-3-drinkcat@chromium.org> <155778659317.14659.136626364818483852@swboyd.mtv.corp.google.com> <CANMq1KBMd7eR3dP=V9gJ6G4OgE6DsXad_gzvuNJ25_pee4+6eg@mail.gmail.com> <155786487644.14659.17142525593824613967@swboyd.mtv.corp.google.com> <CANMq1KCNzn-5sYJZGivUedsNaQfVW_MjgDZn27W6sz8Fk3beNA@mail.gmail.com> <CAE=gft6jxR9Lt7tLwm6VKy9_shMVW7wf3g6rBGEqtB7oNH0hUA@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-gpio@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Chuanjia Liu <Chuanjia.Liu@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2] pinctrl: mediatek: Update cur_mask in mask/mask ops
To:     Evan Green <evgreen@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>
User-Agent: alot/0.8.1
Date:   Mon, 10 Jun 2019 15:25:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Evan Green (2019-05-30 10:12:03)
> On Wed, May 15, 2019 at 1:05 AM Nicolas Boichat <drinkcat@chromium.org> w=
rote:
> >
> > On Wed, May 15, 2019 at 4:14 AM Stephen Boyd <swboyd@chromium.org> wrot=
e:
> >
> > > We could immediately unmask those lines in the hardware when the
> > > set_wake() callback is called. That way the genirq layer can use the
> > > driver to do what it wants with the hardware and the driver can make
> > > sure that set_wake() will always cause the wakeup interrupt to be
> > > delivered to genirq even when software has disabled it.
> > >
> > > But I think that there might be a problem with how genirq understands
> > > the masked state of a line when the wakeup implementation conflates
> > > masked state with wakeup armed state. Consider this call-flow:
> > >
> > >         irq masked in hardware, IRQD_IRQ_MASKED is set
> > >         enable_irq_wake()
> > >           unmask_irq in hardware
> > >         IRQD_WAKEUP_ARMED is set
> > >         <suspend and wakeup from irq>
> > >         handle_level_irq()
> > >           mask_ack_irq()
> > >             mask_irq()
> > >               if (irqd_irq_masked()) -> returns true and skips maskin=
g!
> > >             if (desc->irq_data.chip->irq_ack)
> > >               ...
> > >           irq_may_run()
> > >             irq_pm_check_wakeup()
> > >               irq_disable()
> > >                 mask_irq() -> does nothing again
> > >
> > > In the above flow, we never mask the irq because we thought it was
> > > already masked when it was disabled, but the irqchip implementation
> > > unmasked it to make wakeup work. Maybe we should always mask the irq =
if
> > > wakeup is armed and we're trying to call mask_irq()? Looks hacky.
> > >
> > > diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> > > index 51128bea3846..20257d528880 100644
> > > --- a/kernel/irq/chip.c
> > > +++ b/kernel/irq/chip.c
> > > @@ -411,7 +411,7 @@ static inline void mask_ack_irq(struct irq_desc *=
desc)
> > >
> > >  void mask_irq(struct irq_desc *desc)
> > >  {
> > > -       if (irqd_irq_masked(&desc->irq_data))
> > > +       if (!irqd_is_wakeup_armed(&desc->irq_data) && irqd_irq_masked=
(&desc->irq_data))
> > >                 return;
> > >
> > >         if (desc->irq_data.chip->irq_mask) {
> >
> > I'm... really not sure what's the best approach here. But basically,
> > yes, if we can find a way to properly handle wake and interrupt
> > behaviour for drivers with a single mask, that'd be good.
> > IRQCHIP_MASK_ON_SUSPEND only seems to be doing half of the work, since
> > it does not cover the disable+wake source case.
> >
> > Thanks,
>=20
> I finally got around to studying this patch. This series seems okay to
> me. The underlying problem is really that the hardware IRQ enabled
> state is out of sync with what Linux thinks. This happens during
> suspend because Linux thinks the irq is disabled, but due to the
> hardware constraints on this platform, the interrupt has to be enabled
> for it to be a wake source. So the mtk driver re-enables the
> interrupt, and then has to find a way to get back in sync with Linux's
> IRQ mask state.
>=20
> One possible approach is mentioned above by Stephen: stop calling
> disable_irq in the cros EC driver. Then both linux and mtk agree the
> interrupt is enabled at suspend time. I think this ran into other
> problems though, where the EC gets its interrupt but is unable to
> silence it because the underlying SPI bus is still suspended.

Does this happen? I thought the interrupt would only be delivered once
all drivers have resumed from the noirq resume phase. Maybe the SPI
controller needs to resume there instead of in the normal resume path
and then this isn't a problem.

>=20
> The other approach, taken here, is to mask the interrupt when it first
> comes in, getting Linux and mtk back in agreement that yes, the
> interrupt is masked. Outside of enlightening the generic IRQ core
> about these types of interrupts that need to get re-enabled to be wake
> sources, this seems like a reasonable approach.

I prefer we teach the genirq layer about these types of irqchips. That
way the solution is common and not a one-off fix for Mediatek chips. I'm
sure that this same problem will come up again for another SoC vendor
out there so having a chip flag that does the other half of
IRQCHIP_MASK_ON_SUSPEND would be appropriate.

