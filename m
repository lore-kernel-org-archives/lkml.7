Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A54C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B05D2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PfDGXbWL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbfC0TvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:51:03 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45312 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfC0TvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 15:51:03 -0400
Received: by mail-pg1-f195.google.com with SMTP id y3so10421091pgk.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 12:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0pxKWFj97lpSADweGnRaqSJcodaqjbDamDB5eAHuy0w=;
        b=PfDGXbWL18GsKVekZf5YTaiEaokLMJgn1xbJO0qVs5UjZ5iYMyzzotTFaxEapE40bd
         LOEV+ea3ggrq6DsM3liipq8Q22dJLW8hgNmhTMo4dDtezgTx24Wai2eAvi8B28NdCxBJ
         8qSP2jkqiolsUmHnSzX7PKxytHl7uxF0vdghS6s+0aGEK28poLGRGRFzgt5OKAMMgeeD
         KlcW1ObWonO/X+2tgBvXT3M4KxA9kGb8rL9MRfoUQ5p8LDSjNGHc2SIqqKQ04M9zHYNZ
         94T3hVKGRd4WFg8zoBMC2tf4GU+MqRKcIGCsZszqf+P3pztZORLKF7qmHlbPVEwwWwEC
         nnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0pxKWFj97lpSADweGnRaqSJcodaqjbDamDB5eAHuy0w=;
        b=lpGOYGWVXi6Uz8Kw+m4iwh2ClVbjWyOsR5m1ysvM4xmSlafwyE/28Fhgxhyn8XzA1S
         qg0oAWBQzieU/S2sW8VrB2y+J531HdMoAxt3Y80vlhtwi11DMANy8ZOaPs09OZIG3n+i
         +4weAUlj1POOuP/7Dmy3lf0/P8/5WdlVNR8tEqzSM6RLMmX8NZlnME6bcffbHKwXKQh8
         eh+Bjuqv9vsR6NUnmqwaEaO2DGo/DNDerQ6akK4y4wjPtVUUGt2mfdhzh04rmDupvi1s
         EzSD1G0V7XFNsEWRELHeLFhrhM5eZY/LwAbd8lXgwah7idytcUGWaq8/K/2TWKe0p882
         m2nw==
X-Gm-Message-State: APjAAAVs9DjaPaPkUwe/Q6poqPIo9VlzOKwPBsNFEl+On4JAd8MrwcTK
        KUGEi0Iw5Uet1GV5sDcTgPwES6NTglSM7r1YTzcHM7oYyqQ=
X-Google-Smtp-Source: APXvYqyjurYoXxAJBTQDgzCUzB/jbBIZbxz/AU4dydZbkRA/1yxO0OyQaPKDo4Lrr/D/owkefZoSPZ2gkfiYC2/0Vwk=
X-Received: by 2002:a63:1749:: with SMTP id 9mr34883273pgx.94.1553716262481;
 Wed, 27 Mar 2019 12:51:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190312163101.155910-1-venture@google.com> <20190327164542.GC11712@kroah.com>
 <CAO=notxFvvOmpjMyXvt5PyuWsB92eraN+=8mWk8_aY2w3sK-eQ@mail.gmail.com>
 <20190327185410.GA14828@kroah.com> <CAO=notzwnDtJ9jmEUDsy_tqVKH-+4rO9gd8rpVjKKvQqJsODTQ@mail.gmail.com>
In-Reply-To: <CAO=notzwnDtJ9jmEUDsy_tqVKH-+4rO9gd8rpVjKKvQqJsODTQ@mail.gmail.com>
From:   Patrick Venture <venture@google.com>
Date:   Wed, 27 Mar 2019 12:50:50 -0700
Message-ID: <CAO=notwnVoj1KdqBsWU-XXz0jBy990GP4eOVuUStJh8EmpvTQg@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] drivers/misc: Add Aspeed P2A control driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 12:01 PM Patrick Venture <venture@google.com> wrote:
>
> On Wed, Mar 27, 2019 at 11:54 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Mar 27, 2019 at 11:44:36AM -0700, Patrick Venture wrote:
> > > On Wed, Mar 27, 2019 at 11:28 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Tue, Mar 12, 2019 at 09:31:01AM -0700, Patrick Venture wrote:
> > > > > +     phys_addr_t mem_base;
> > > >
> > > > Is this really a 32bit value?
> > >
> > > It's going to be a 32-bit value if this is in the dts for one of the
> > > correspondingly supported aspeed models.
> > >
> > > >
> > > > Your ioctl thinks it is:
> > > >
> > > > > +struct aspeed_p2a_ctrl_mapping {
> > > > > +     __u32 addr;
> > > >
> > > > Does this driver not work on a 64bit kernel?
> > >
> > > This driver is aimed at only 32-bit hardware (ast2400/2500).  I
> > > modeled the approach after the aspeed-lpc-ctrl driver as it's
> > > providing similar functionality.
> > >
> > > >
> > > > > +     __u32 length;
> > > > > +     __u32 flags;
> > > > > +};
> > > >
> > > > addr really should be __u32 here so you don't have to mess with 32/64
> > > > bit user/kernel issues, right?
> > >
> > > Add is __u32 there.  Are you suggesting it shouldn't be?
> >
> > Ugh, yes, sorry, I meant to say "__u64".
> >
> > If you all insist that this is all that is ever going to be needed, ok,
> > but I reserve the right to complain in 4 years when this needs to be
> > changed :)
>
> In the event the ast2600 comes out and is 64-bit -- I can't imagine
> that's likely to happen.  I can take solace that this won't be the
> only thing that needs retrofitting.  But it wouldn't kill me to just
> make the change.  I'll just have to tweak it to return failure in the
> event the address provided isn't found in any region...
>
> Is that all that needs to change for 64-bit addressing support - given
> your read of the driver?

I should have v8 for review shortly.

>
> >
> > thanks,
> >
> > greg k-h
