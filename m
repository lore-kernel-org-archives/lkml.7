Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C40C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 19:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15192067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 19:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SnHph24t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbfD2Tfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 15:35:40 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44734 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbfD2Tfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 15:35:39 -0400
Received: by mail-pl1-f193.google.com with SMTP id l2so2787736plt.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 12:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MA2pxeJanvGEmBWrFqMsmgG7gA6LwvD5zhcslNBuoIs=;
        b=SnHph24tl5THldKuujF5MGi0qGSD2Z736RK0rifb2SRwsvTKnasXAsbjtzKJzg5S7U
         jOT3KGue0g86zHFGOFzm8oJ8l7Bfvxk6nB6Ued+/HMZMTJXZsFbjfzrkCRSLqNlAoIuG
         C16zq20doJV/Wed3YovXDqnKRnWlMz2aV/CtwoECXDX4Hkfb3O3cb6Qy7wXOj12mXbUO
         UlMlNKu0Gr/kSS1Buv4lMeq4kR7TIFQWt7ZlWApCzht7eyDDE+/U+Xle7iiVfeJQPW29
         31gKQV31tNORj9GOHXyeL1n54sfp2gKRkwxyr1FgescX732CvJdnjwd5HAQbAQDDu7rg
         7T9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MA2pxeJanvGEmBWrFqMsmgG7gA6LwvD5zhcslNBuoIs=;
        b=pacUYFgn4fmvfXqT34X5MdWGhZLkL+5ZLPp5mEJupCMWhoG0dqZs4SplQgZ3hFLosG
         XSCtsLdg7RhQ4xGllKdIrkU0OwqqOhJJc6vnx8b7NmVOgBECZZ0lycHRnb98rMAUkuBg
         63QytxtJXjKe79RYGqdCo5sS2qNHoXJ6FNbCjZmhKxi4HFlvIXKGF3++nXgL+IyUElmQ
         LR0b/9UoH1OyzfF2tWlcwkZl5iwl2qIxWLYgmFqfhQ8oJeK2jxcsVLzAoY3/8lWJU/38
         l+uz9KGtggUyM+eu/Sp7eAF+jqgY38sNV9TcChfEp1XdfVabtggEHnNLF69DhD7uCC6C
         OiFw==
X-Gm-Message-State: APjAAAV0BdfddJTSedqy9c8oo+i69hQuSYM32kO7ESI9oLHewrcF0ZSX
        AQkURNN4iKSFuVAd+Er1jmkBZA1RPEqvzEvVx8te+w==
X-Google-Smtp-Source: APXvYqwpxgFfPjwuWB0owzgyoxf/HEeCo7aYxdc70jVF+oVqns/qMamafl4p2sSkZ9gHdZ6mqsJ1rHDNwpTTb6m4W/8=
X-Received: by 2002:a17:902:864b:: with SMTP id y11mr60477895plt.1.1556566538642;
 Mon, 29 Apr 2019 12:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190423142629.120717-1-venture@google.com> <CAO=notzjzpt0WHfJEWXMGgkoJU8UiLnqZnrGrPs-dRH5GNdJyQ@mail.gmail.com>
 <CAO=notz9QVoqKLrhJ3kx9FHja5+Mh68f36O36+1ewLG+SanmOA@mail.gmail.com>
 <20190425172549.GA12376@kroah.com> <20190429165137.mwj4ehhwerunbef4@localhost>
 <CAO=notwewAeeLz=LsOcSj=DakLGW0KjeDHALP5Nv2ckgkRqnFA@mail.gmail.com> <CAOesGMipoKED=XLg+VtEVG0Os_MUzsPgOfBFJ+qoJs_fNmP+3g@mail.gmail.com>
In-Reply-To: <CAOesGMipoKED=XLg+VtEVG0Os_MUzsPgOfBFJ+qoJs_fNmP+3g@mail.gmail.com>
From:   Patrick Venture <venture@google.com>
Date:   Mon, 29 Apr 2019 12:35:27 -0700
Message-ID: <CAO=notwU7LzEiBmzb6AJrgP3RGXE+66OwZVU8CqVE6RSKRvo1w@mail.gmail.com>
Subject: Re: [PATCH v2] soc: add aspeed folder and misc drivers
To:     Olof Johansson <olof@lixom.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org, arm-soc <arm@kernel.org>,
        soc@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 12:27 PM Olof Johansson <olof@lixom.net> wrote:
>
> On Mon, Apr 29, 2019 at 10:12 AM Patrick Venture <venture@google.com> wrote:
> >
> > On Mon, Apr 29, 2019 at 10:08 AM Olof Johansson <olof@lixom.net> wrote:
> > >
> > > On Thu, Apr 25, 2019 at 07:25:49PM +0200, Greg KH wrote:
> > > > On Tue, Apr 23, 2019 at 08:28:14AM -0700, Patrick Venture wrote:
> > > > > On Tue, Apr 23, 2019 at 8:22 AM Patrick Venture <venture@google.com> wrote:
> > > > > >
> > > > > > On Tue, Apr 23, 2019 at 7:26 AM Patrick Venture <venture@google.com> wrote:
> > > > > > >
> > > > > > > Create a SoC folder for the ASPEED parts and place the misc drivers
> > > > > > > currently present into this folder.  These drivers are not generic part
> > > > > > > drivers, but rather only apply to the ASPEED SoCs.
> > > > > > >
> > > > > > > Signed-off-by: Patrick Venture <venture@google.com>
> > > > > >
> > > > > > Accidentally lost the Acked-by when re-sending this patchset as I
> > > > > > didn't see it on v1 before re-sending v2 to the larger audience.
> > > > >
> > > > > Since there was a change between v1 and v2, Arnd, I'd appreciate you
> > > > > Ack this version of the patchset since it changes when the soc/aspeed
> > > > > Makefile is followed.
> > > >
> > > > I have no objection for moving stuff out of drivers/misc/ so the SOC
> > > > maintainers are free to take this.
> > > >
> > > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >
> > > I'm totally confused. This is the second "PATCH v2" of this patch that I came
> > > across, I already applied the first.
> >
> > I think the issue here was that I added to the CC list another email
> > and so you may see the v2  without that mailing list, and a v2 with it
> > --
> >
> > Does this require a v3?  I honestly didn't think so, but this was the
> > first time I had to add more people without needing other changes.
>
> Well, v2 doesn't build. I'll fix it up locally by adding an 'endmenu'
> to drivers/soc/aspeed/Kconfig. But... brings up questions how this was
> tested before submitting?

That's a lost change issue. I'll try to be more diligent in the
future.  My dev workspace  is disconnected from the kernel used for
upstreaming patches, so if i make a change in one it isn't always
reflected in the other.  I'm working on rectifying the underlying
build space issue to let me use the same repo.

>
> scripts/kconfig/conf  --allnoconfig Kconfig
> drivers/soc/Kconfig:24: 'menu' in different file than 'menu'
> drivers/soc/aspeed/Kconfig:1: location of the 'menu'
> drivers/Kconfig:233: 'menu' in different file than 'menu'
> drivers/soc/aspeed/Kconfig:1: location of the 'menu'
> <none>:34: syntax error
>
> > >
> > > Patrick: Follow up with incremental patch in case there's any difference.
> > > Meanwhile, please keep in mind that you're adding a lot of work for people when
> > > you respin patches without following up on the previous version. Thanks!
> >
> > w.r.t this patch series.  I found an issue with v1, and released a v2
> > with the detail of what changed.  I thought that was the correct
> > approach.  I apologize for creating extra work, that's something
> > nobody needs.
>
> It's ok to submit newer versions, but it's convenient when they get
> threaded also in non-gmail mail readers (by using in-reply-to).

Roger that.

>
>
> -Olof
