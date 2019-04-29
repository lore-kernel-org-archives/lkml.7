Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68351C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3638420675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="WJtEtPJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbfD2RTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 13:19:18 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39561 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728778AbfD2RTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:19:17 -0400
Received: by mail-io1-f68.google.com with SMTP id c3so9674511iok.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 10:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TcHWiD1mzC1uHmKop2kWHjOyjfjQjqGRJXvrFO4NZ0M=;
        b=WJtEtPJw0ligOQLTkD1wdJpW0Xya6+Usnixo6qM6RCmaVuRB6Sw6wj0oxCImo1LiSU
         19ZpSQb6bgjljTeQNsMfJ+Dkk6kINsP22ZduO9o3JEefbuBit3tCiV16cve3eLhpO5td
         V8a7R8RsMk5Yk3qj9DVxD6ISwW+9YBSsNeDXoi264fxd29BQM1fdcUVUufbMTl8f8fcE
         98rFyJ+pJy0G8gcajIbrpNypKbFgTJ7t8QCLvYVwV6WWr61DbX04g2oDc58uLlWTRWvx
         FW0GZFyaO5zbqVX6Hw+8yJxE8cYkhp3fCI/Ox3LRQ2puDTOC3dkRvSZhNkSB+oK8Tzgm
         RuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TcHWiD1mzC1uHmKop2kWHjOyjfjQjqGRJXvrFO4NZ0M=;
        b=sh3Bybirp9EtERQXcTNYELoNnighesF67Wu1be60bxPoFbUIy+B/w1RDsz2nirrpz1
         DoP1JPGpii6vYgmz05SDpvCaKaYIVoBNrqmCWdrNeM94zzyJk9iT4+E3O9T7dmdh/IpK
         NrKuboG4v3WeaqZRBNQPBkj5/XVnp0HN+Vz6ofeLV4m5IJfnumS7tX091vJhuKWl+4hv
         DGJg44LyPQYV4dp6CJxhgNgy5Q4TmL1+Z5EkQWP9ulv+xj7gSR75JtgpMBkDUZoRl21U
         gzDj0J0vM/na7n1N4kwAJ8HEiAHIVggaCu2rpnS65Iha2iuQQtpCdTi8GArwlfp956fB
         yBDA==
X-Gm-Message-State: APjAAAXv8IfPWPtcnLExteOoBbXzgpqgxbJWRmINZqOUuCc2xO+xkVyb
        /PV7UAwBYX+1wymx4GRZ6RElDXNvOYOw0h28S1HwMA==
X-Google-Smtp-Source: APXvYqwr2b6ak9dkpcvCh4y3y7IhGFDCOLPWZnc8qygdB7THWWCzrsfb52Z9YiShfN4rx8ZPHnDzMPYVrnL0fFrmwzc=
X-Received: by 2002:a6b:5910:: with SMTP id n16mr16081346iob.140.1556558356559;
 Mon, 29 Apr 2019 10:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190423142629.120717-1-venture@google.com> <CAO=notzjzpt0WHfJEWXMGgkoJU8UiLnqZnrGrPs-dRH5GNdJyQ@mail.gmail.com>
 <CAO=notz9QVoqKLrhJ3kx9FHja5+Mh68f36O36+1ewLG+SanmOA@mail.gmail.com>
 <20190425172549.GA12376@kroah.com> <20190429165137.mwj4ehhwerunbef4@localhost>
 <CAOesGMg49z4Gip-bLK-h7+LSLa4Fu68r11gT2EV8E8xMCPGDxg@mail.gmail.com> <CAO=notwVyTqvxfYRU1XJTwzSNCUAMgYCVpXVvqaN62uSiWyYCQ@mail.gmail.com>
In-Reply-To: <CAO=notwVyTqvxfYRU1XJTwzSNCUAMgYCVpXVvqaN62uSiWyYCQ@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 29 Apr 2019 10:19:04 -0700
Message-ID: <CAOesGMjShorZmVeLL1nJNPVOP+vNTVzcA=arU3qW8ZUDYCtjaQ@mail.gmail.com>
Subject: Re: [PATCH v2] soc: add aspeed folder and misc drivers
To:     Patrick Venture <venture@google.com>
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

On Mon, Apr 29, 2019 at 10:16 AM Patrick Venture <venture@google.com> wrote:
>
> On Mon, Apr 29, 2019 at 10:13 AM Olof Johansson <olof@lixom.net> wrote:
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
> > >
> > > Patrick: Follow up with incremental patch in case there's any difference.
> > > Meanwhile, please keep in mind that you're adding a lot of work for people when
> > > you respin patches without following up on the previous version. Thanks!
> >
> > Not only that, but subthreads were cc:d to arm@kernel.org and some
> > were not, so I missed the overnight conversation on the topic.
> >
> > If this email thread is any indication of how the code will be
> > flowing, there's definitely need for more structure. Joel, I'm hoping
> > you'll coordinate.
>
> To be honest, this patchset thread was a bit less clear than anyone
> prefers.  I use get_maintainers to get the initial list, and so adding
> arm@ or soc@ per a request tells me that perhaps those should be
> output via that script.

The tools are working as expected, we normally don't take patches
directly to arm@kernel.org, we let them go in through platform
maintainers who then send it on to us.

> >
> > I'm with Arnd on whether the code should be in drivers/soc or not --
> > most of it likely should not.
>
> I think the misc drivers for a SoC that are a single user interface
> that is focused on the use-case that belongs to that SoC only belong
> in soc/, while if there is something we can do in common -- different
> story.  If it makes sense to just have misc/aspeed/ instead of
> soc/aspeed -- would that align more?

Those views are how the "board file hell" started on 32-bit ARM too,
so we're definitely hesitant to jump to that conclusion without
knowing more about what's actually anticipated.


Do you happen to have an estimate on what kind of drivers are
needed/anticipated?


-Olof
