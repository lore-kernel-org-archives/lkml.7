Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1E6C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F21622CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfICIRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 04:17:02 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:38859 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfICIRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 04:17:02 -0400
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 25DB920001B;
        Tue,  3 Sep 2019 08:16:58 +0000 (UTC)
Date:   Tue, 3 Sep 2019 10:16:58 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Chengyu Song <csong@cs.ucr.edu>, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] clocksource: atmel-st: Variable sr in
 at91rm9200_timer_interrupt() could be uninitialized
Message-ID: <20190903081658.GK21922@piout.net>
References: <20190902222946.20548-1-yzhai003@ucr.edu>
 <20190902223650.GJ21922@piout.net>
 <CABvMjLRjeXAmhBwfZZPbmxdENq=FP9rR0Ld=T3veGXF6cjptxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABvMjLRjeXAmhBwfZZPbmxdENq=FP9rR0Ld=T3veGXF6cjptxA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2019 22:56:48-0700, Yizhuo Zhai wrote:
> In function regmap_read(),  there're two places which could make the read fail.
> 
> First, if "reg" and  "map->reg_stride" are not aligned, then remap_read() will
> return -EINVAL without initialize variable "val".
> 

A quick look at of_syscon_register would show you that this is not
possible.

> Second, _regmap_read() could also fail and return error code if "val" is not
> initialized. The caller remap_read() returns the same error code, but
> at91rm9200_timer_interrupt() does not use this information.
> 

How would _regmap_read fail exactly?

> On Mon, Sep 2, 2019 at 3:37 PM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > On 02/09/2019 15:29:46-0700, Yizhuo wrote:
> > > Inside function at91rm9200_timer_interrupt(), variable sr could
> > > be uninitialized if regmap_read() fails. However, sr is used
> >
> > Could you elaborate on how this could fail?
> >
> > > to decide the control flow later in the if statement, which is
> > > potentially unsafe. We could check the return value of
> > > regmap_read() and print an error here.
> > >
> > > Signed-off-by: Yizhuo <yzhai003@ucr.edu>
> > > ---
> > >  drivers/clocksource/timer-atmel-st.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/clocksource/timer-atmel-st.c b/drivers/clocksource/timer-atmel-st.c
> > > index ab0aabfae5f0..061a3f27847e 100644
> > > --- a/drivers/clocksource/timer-atmel-st.c
> > > +++ b/drivers/clocksource/timer-atmel-st.c
> > > @@ -48,8 +48,14 @@ static inline unsigned long read_CRTR(void)
> > >  static irqreturn_t at91rm9200_timer_interrupt(int irq, void *dev_id)
> > >  {
> > >       u32 sr;
> > > +     int ret;
> > > +
> > > +     ret = regmap_read(regmap_st, AT91_ST_SR, &sr);
> > > +     if (ret) {
> > > +             pr_err("Fail to read AT91_ST_SR.\n");
> > > +             return ret;
> > > +     }
> > >
> > > -     regmap_read(regmap_st, AT91_ST_SR, &sr);
> > >       sr &= irqmask;
> > >
> > >       /*
> > > --
> > > 2.17.1
> > >
> >
> > --
> > Alexandre Belloni, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
> 
> 
> 
> -- 
> Kind Regards,
> 
> Yizhuo Zhai
> 
> Computer Science, Graduate Student
> University of California, Riverside

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
