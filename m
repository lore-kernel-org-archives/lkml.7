Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12058C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD98D206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hNw9LW71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389617AbfC0TCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:02:06 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37886 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389482AbfC0TCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 15:02:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id 8so10140632pfr.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 12:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kinH6oT2tmanQoCK0NPLwfaZCgBAmu6HtM8wXR5Y8ns=;
        b=hNw9LW71dOCzep2hzY7zEBmxdHTXqbiKkwn3WB1wOdhyPlEYaCwxGeFgOpwXfToDCo
         NZWpJpq23TrMlQTox+A2QkwiIQTeXAh/2lDkVTDZir3lHlrKgKURThi6jJ3ytwPRO/hF
         /uhFh653Yj2bCB11pdoA2HFUnt6cQEIdERZOWaKlNamBUKtLC0l7XlV5s1dStzPhmidk
         NQ1qSG/pK5w9R3YqnxMCNif+2CAlQ5LpVdydG6U1E+9O52zunFe5fF7NlcVBuPXVqu/k
         hIl9ydJxKpAOjoC5H7jSSf1v8L7jOAKRex38t/9RwP1xnebGxTGXqF9Bs+Fk46x9V8td
         p8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kinH6oT2tmanQoCK0NPLwfaZCgBAmu6HtM8wXR5Y8ns=;
        b=o2xjshth17e+5cI/OP9ZTvKYGbwniatVd0vvaxvHa8dCnOOucqMYS9JDNpvRmDJZ68
         VZXZI+J6/9Jvz+XhCfk0Ogj3gd0QsPdKwCAE+JGLe9Vt0Dxjhlagb+pI4wpeoYjXYVfm
         lXOVPfwS963PzHf1Stg6bZz0t1PiVNxsuVoVuN5BtFKJHbk9z/xbo9OIzVjteVp8vyli
         09Wts0Ryu5mgOFb3EJTWDMs1XASMVypf7fWYXjz5YiWHfWMhAIOdrJ0XzSVnDz0w3M5a
         28RUCsuLm/lX6k01awWXL+iY+r1lPrDtkZujnA5aF6Y5er+TqINz4KMp13dBrWpaL8ve
         9h4Q==
X-Gm-Message-State: APjAAAVPVEW5Vu62RmI3A+Q8HKTIYhbdCNbxmswuGM0UQBFNxQXYSftn
        efSXN/99PKpMgQZQO0uhejBOHW/uns7YEgTXhgsNXw==
X-Google-Smtp-Source: APXvYqzE/s90FIoJy5VaK+bf6rCPJCAy0yHRKjn36k6ejMeKbEPqEHswSqoy7jTMYBhfMUEVct3D4RnnowjXFFMhDdA=
X-Received: by 2002:a63:e850:: with SMTP id a16mr35831994pgk.195.1553713321817;
 Wed, 27 Mar 2019 12:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190312163101.155910-1-venture@google.com> <20190327164542.GC11712@kroah.com>
 <CAO=notxFvvOmpjMyXvt5PyuWsB92eraN+=8mWk8_aY2w3sK-eQ@mail.gmail.com> <20190327185410.GA14828@kroah.com>
In-Reply-To: <20190327185410.GA14828@kroah.com>
From:   Patrick Venture <venture@google.com>
Date:   Wed, 27 Mar 2019 12:01:50 -0700
Message-ID: <CAO=notzwnDtJ9jmEUDsy_tqVKH-+4rO9gd8rpVjKKvQqJsODTQ@mail.gmail.com>
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

On Wed, Mar 27, 2019 at 11:54 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Mar 27, 2019 at 11:44:36AM -0700, Patrick Venture wrote:
> > On Wed, Mar 27, 2019 at 11:28 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Mar 12, 2019 at 09:31:01AM -0700, Patrick Venture wrote:
> > > > +     phys_addr_t mem_base;
> > >
> > > Is this really a 32bit value?
> >
> > It's going to be a 32-bit value if this is in the dts for one of the
> > correspondingly supported aspeed models.
> >
> > >
> > > Your ioctl thinks it is:
> > >
> > > > +struct aspeed_p2a_ctrl_mapping {
> > > > +     __u32 addr;
> > >
> > > Does this driver not work on a 64bit kernel?
> >
> > This driver is aimed at only 32-bit hardware (ast2400/2500).  I
> > modeled the approach after the aspeed-lpc-ctrl driver as it's
> > providing similar functionality.
> >
> > >
> > > > +     __u32 length;
> > > > +     __u32 flags;
> > > > +};
> > >
> > > addr really should be __u32 here so you don't have to mess with 32/64
> > > bit user/kernel issues, right?
> >
> > Add is __u32 there.  Are you suggesting it shouldn't be?
>
> Ugh, yes, sorry, I meant to say "__u64".
>
> If you all insist that this is all that is ever going to be needed, ok,
> but I reserve the right to complain in 4 years when this needs to be
> changed :)

In the event the ast2600 comes out and is 64-bit -- I can't imagine
that's likely to happen.  I can take solace that this won't be the
only thing that needs retrofitting.  But it wouldn't kill me to just
make the change.  I'll just have to tweak it to return failure in the
event the address provided isn't found in any region...

Is that all that needs to change for 64-bit addressing support - given
your read of the driver?

>
> thanks,
>
> greg k-h
