Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56051C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE602075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BhJsGBS2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfC1OOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:14:02 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39727 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfC1OOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:14:01 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3so7976926pga.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 07:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v3Xfpd493Zwb9m11nO5baQncpu4tEQVUIhj058hAhug=;
        b=BhJsGBS26cgQkaXxYZwki+ROGrCBytVfJIWW6h+xWGrJY7bOIxgq+527BjUVHsKbka
         PohbNorMrszauV5azPLRoMgWQRKxL2tt63bDQs4dFIHLojhrrQM6CJ61JiBS+YG8+J0+
         hbcssaEhMkI3KLqGyceTxlBzVak29qlFTI/xjkyK/SJ94R3A8jI5B6PifnXvAUYbQw5D
         8y6jSmetCMrBD010lpSnK3v+/4GAaSKma3mAk7SqsMVEeA7H3O9K3sx7Ej7uVG38KyBV
         rdz8NE8T5ycQIUTCA4EbXRyHa9a5PFP6ODA+c45jBamiDOWhxk5FNpZ7rFCRTg0XhrV+
         R0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v3Xfpd493Zwb9m11nO5baQncpu4tEQVUIhj058hAhug=;
        b=Xoug8OOprhueCp053kPoCisnSndY/B2ekHQU4CUfb0Rj+w5yhft09LJyP+tHNdzEt/
         pE+J36NrSxsU1mwkUqAgAvRIvjniE1OrlClRzsc3RQjyJ9xYjmKv0cMmp/ZP0OMfZtqt
         hXNus0KyO6sEFLKvgKiW7CvvpfMqnWi177SRi/r87AJLcpITbkZ//UeB3F3e0FmW+wzz
         J13CW+X1dzaYIMNacdG6Qst4lyIHzBxoq0I6vtTlI+k2ZF8b3En9Au3aljVI697oKWuP
         D2WL2D1eIQ59qzPtLgf6xgwrH4PCGs4R/bCX+tqEtNedJQD3jx8y+CPfoPmUxD8Rbe0L
         Wz9Q==
X-Gm-Message-State: APjAAAWL0i7vcm4oIXEuGZOxWL9S6/YS1E93aI+rgs6DEsnnCciF6Xtw
        D2szukg+D1/56TaiOFpN8+ABBcYpcTjhzBu/4AfSzG33KTg=
X-Google-Smtp-Source: APXvYqzwqPNQA8qztnAT/EQOWO/FRdesIGemfQolUucxtQSBrCMhnemV1wKzJTMjkSj8eogwm/0faGVObRvMyzt7uiU=
X-Received: by 2002:a63:1749:: with SMTP id 9mr38885951pgx.94.1553782440759;
 Thu, 28 Mar 2019 07:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190312163101.155910-1-venture@google.com> <20190327164542.GC11712@kroah.com>
 <CAO=notxFvvOmpjMyXvt5PyuWsB92eraN+=8mWk8_aY2w3sK-eQ@mail.gmail.com>
 <20190327185410.GA14828@kroah.com> <CAO=notzwnDtJ9jmEUDsy_tqVKH-+4rO9gd8rpVjKKvQqJsODTQ@mail.gmail.com>
 <20190328065231.GB20312@kroah.com>
In-Reply-To: <20190328065231.GB20312@kroah.com>
From:   Patrick Venture <venture@google.com>
Date:   Thu, 28 Mar 2019 07:13:49 -0700
Message-ID: <CAO=notwW=9=DyG-hkzsSJbwC3f3swkrAenYCjHGmqEj8D4F2YA@mail.gmail.com>
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

On Wed, Mar 27, 2019 at 11:52 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Mar 27, 2019 at 12:01:50PM -0700, Patrick Venture wrote:
> > On Wed, Mar 27, 2019 at 11:54 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Mar 27, 2019 at 11:44:36AM -0700, Patrick Venture wrote:
> > > > On Wed, Mar 27, 2019 at 11:28 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Tue, Mar 12, 2019 at 09:31:01AM -0700, Patrick Venture wrote:
> > > > > > +     phys_addr_t mem_base;
> > > > >
> > > > > Is this really a 32bit value?
> > > >
> > > > It's going to be a 32-bit value if this is in the dts for one of the
> > > > correspondingly supported aspeed models.
> > > >
> > > > >
> > > > > Your ioctl thinks it is:
> > > > >
> > > > > > +struct aspeed_p2a_ctrl_mapping {
> > > > > > +     __u32 addr;
> > > > >
> > > > > Does this driver not work on a 64bit kernel?
> > > >
> > > > This driver is aimed at only 32-bit hardware (ast2400/2500).  I
> > > > modeled the approach after the aspeed-lpc-ctrl driver as it's
> > > > providing similar functionality.
> > > >
> > > > >
> > > > > > +     __u32 length;
> > > > > > +     __u32 flags;
> > > > > > +};
> > > > >
> > > > > addr really should be __u32 here so you don't have to mess with 32/64
> > > > > bit user/kernel issues, right?
> > > >
> > > > Add is __u32 there.  Are you suggesting it shouldn't be?
> > >
> > > Ugh, yes, sorry, I meant to say "__u64".
> > >
> > > If you all insist that this is all that is ever going to be needed, ok,
> > > but I reserve the right to complain in 4 years when this needs to be
> > > changed :)
> >
> > In the event the ast2600 comes out and is 64-bit -- I can't imagine
> > that's likely to happen.  I can take solace that this won't be the
> > only thing that needs retrofitting.  But it wouldn't kill me to just
> > make the change.  I'll just have to tweak it to return failure in the
> > event the address provided isn't found in any region...
> >
> > Is that all that needs to change for 64-bit addressing support - given
> > your read of the driver?
>
> That's all that I noticed at first glance, yes.

Thanks, that's addressed in v8.

> I do dislike having
> custom user/kernel apis for random chips like this, but I don't know of
> a way to have a generic api for them at the moment as I really do not
> know what these chips do :(
>
> One would think that the firmware api would work for you, but given the
> complexity here, it does not seem that it would match up.

Yeah, this driver is basically just allowing control over a bridge and
allows for a convenient common use-case for such bridges.  I don't
have enough exposure to see if there's some commonality for
configuration and control of bridges across different chips, and I
would imagine they're very distinct.

>
> thanks,
>
> greg k-h

Thanks
