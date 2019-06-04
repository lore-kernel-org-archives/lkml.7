Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434E8C28CC3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC77216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559651543;
	bh=mQdOZZdjwnnzpAJPKdYd3WuB5icZFW/aX0zjXI6udbw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=K0AF/KlROuaqSXu+kiwU/0L1vKuP61wAoN2gOD8bQNWTgfALUpeFbMBn8Uf1ZpA2u
	 TIJUzzoePWZDUPw6ETECRY5ibqY/asF9MAO5BKCs0ygVW3SWQzVqvcyezAvKilufzM
	 +FU9veVj1k8bX+P6xiiY71kCOWw5chy1Y0r1xVPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbfFDMcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 08:32:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727403AbfFDMcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 08:32:22 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4309724B7E;
        Tue,  4 Jun 2019 12:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559651541;
        bh=mQdOZZdjwnnzpAJPKdYd3WuB5icZFW/aX0zjXI6udbw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NNm+b4jCy+R9bfD2mCX97LmKHmX1zgYOBq7iHxDQsFY1uRnqcaj42F+SBy3Uj4OCi
         FLIC1jGHNYtbmrDZ4ej2I6X+mGB8gjPhJSJ6EGoP1r9Jv9EDBZTq9Bbxr8Bv55jFK1
         bnX+XhS0rJbOGNODFNVAnhJa9CcSRHG/hTBpia4w=
Received: by mail-wm1-f53.google.com with SMTP id s3so7351867wms.2;
        Tue, 04 Jun 2019 05:32:21 -0700 (PDT)
X-Gm-Message-State: APjAAAWICTRPiaiQs7OoO9GndXkdma3yLSFbi3+494nbPBSeM50iZmpd
        NyonBOaLi/Jy6otdR7fyGARY2J7k7HIDiER2eWI=
X-Google-Smtp-Source: APXvYqwDGMccRrpd+YBBy+1wLHwiIMpY3OciWZVO+o2nfKjKJL7Y5KP49u36RWkg2izaLegeuo/FbxKfVCmR68qPoEg=
X-Received: by 2002:a05:600c:20c3:: with SMTP id y3mr2007579wmm.3.1559651539850;
 Tue, 04 Jun 2019 05:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <1559646306-18860-1-git-send-email-guoren@kernel.org>
 <1559646306-18860-4-git-send-email-guoren@kernel.org> <7943816e-1cf0-dbc9-157d-71a83c5016c6@arm.com>
In-Reply-To: <7943816e-1cf0-dbc9-157d-71a83c5016c6@arm.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 4 Jun 2019 20:32:08 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRo5kSjv68X29kNYMhnvd7ByTiiBSR8KwpcoMKUpkN8zQ@mail.gmail.com>
Message-ID: <CAJF2gTRo5kSjv68X29kNYMhnvd7ByTiiBSR8KwpcoMKUpkN8zQ@mail.gmail.com>
Subject: Re: [PATCH V4 3/4] irqchip/irq-csky-mpintc: Support auto irq deliver
 to all cpus
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     mark.rutland@arm.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, jason@lakedaemon.net,
        linux-csky@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marc,

On Tue, Jun 4, 2019 at 7:54 PM Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> On 04/06/2019 12:05, guoren@kernel.org wrote:
> > From: Guo Ren <ren_guo@c-sky.com>
> >
> > The csky,mpintc could deliver a external irq to one cpu or all cpus, but
> > it couldn't deliver a external irq to a group of cpus with cpu_mask. So
> > we only use auto deliver mode when affinity mask_val is equal to
> > cpu_present_mask.
> >
> > There is no limitation for only two cpus in SMP system.
> >
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > ---
> >  drivers/irqchip/irq-csky-mpintc.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-csky-mpintc.c b/drivers/irqchip/irq-csky-mpintc.c
> > index a451a07..2740dd5 100644
> > --- a/drivers/irqchip/irq-csky-mpintc.c
> > +++ b/drivers/irqchip/irq-csky-mpintc.c
> > @@ -143,8 +143,19 @@ static int csky_irq_set_affinity(struct irq_data *d,
> >       if (cpu >= nr_cpu_ids)
> >               return -EINVAL;
> >
> > -     /* Enable interrupt destination */
> > -     cpu |= BIT(31);
> > +     /*
> > +      * The csky,mpintc could support auto irq deliver, but it only
> > +      * could deliver external irq to one cpu or all cpus. So it
> > +      * doesn't support deliver external irq to a group of cpus
> > +      * with cpu_mask.
> > +      * SO we only use auto deliver mode when affinity mask_val is
> > +      * equal to cpu_present_mask.
> > +      *
> > +      */
> > +     if (cpumask_equal(mask_val, cpu_present_mask))
> > +             cpu = 0;
> > +     else
> > +             cpu |= BIT(31);
> >
> >       writel_relaxed(cpu, INTCG_base + INTCG_CIDSTR + offset);
> >
> >
>
> Isn't that the same patch as [1]? In which case, I've queued it as a fix
> already.
Yes, they are the same. It's duplicate.

I think you've queued this one:
https://lore.kernel.org/lkml/1558425245-20995-1-git-send-email-guoren@kernel.org/

That's OK.

Best Regards
 Guo Ren
