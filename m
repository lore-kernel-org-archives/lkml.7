Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C142EC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8245B2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PCPGwWsH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbfD2RXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 13:23:05 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36973 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728920AbfD2RXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:23:04 -0400
Received: by mail-pl1-f194.google.com with SMTP id z8so5396419pln.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 10:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rsw8UPykdorsw4sPVzHVYzdipOf63m0Li/lJqRlHJ28=;
        b=PCPGwWsH2zeGDnz68osLQlxPJg3Mq3ZZ3rJnVkG96kpebaebQeHBm6Fk21rGKM3Iu1
         y5AjtKyIzxFb/lo+UhU4zgbnf1mIQ125i478+JYkFgTyfWa0760MVb5SuDjwIzpEXcYw
         hsuIIjql21Co4qkj8ZGbsKYloGjQna0HcrYVspTiNXKqXDCW+s0aFPBdUg9eTF6+yswM
         /BsGsVhdNvuhHPteCh6HvAaJhM30O7s3iZMC95XQFv/L2lDxLjTMuA3MugRnY75nJgxS
         8WmicA925irBdJLs/VSS2PjmLpw/N5IaDkzrcGu0d1Aa5uivPxMCHlTGFB6rhqzTX0aM
         aydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rsw8UPykdorsw4sPVzHVYzdipOf63m0Li/lJqRlHJ28=;
        b=EeNrhdDoODgZBZUq2LurH7DLvZgS9eY86HTKi5jDBMCeTb1Sch/Ba4dx1wkUcnxJ3y
         Yn+7iXiPnj5eAIAFxBumXB6tCeALndRyPKiLu3NXR7nX5DQKQ0B1GJ7lWHxPsrJ6L0L+
         peB9ZlheS7ZC6iP9vrwulXTNJt931GBy1Nq6ktdF1W5fbQbtgZvX04WdNpqYtr7v21R8
         lxrEwYcs5VbhO+/gzdo3ZjXut6JUErxpK2AJZvfQd9m7JHPGIj7G1ZJAm6fDFoFTl8tz
         29pz1AOEoNUMDX1aHNhhaWEhO2cVboHSIZPoiCaFFLk1i6nSzdt6rMgJbFxLHooh4UMG
         Z/3A==
X-Gm-Message-State: APjAAAX7E+SUOztW9nC6kB3dDoNcnQxXqKbqr1BHFWFAIKMd4JwGDT2v
        KYaEYCJfoYwEvVFesa3MNmKCHYtIv/NBwS6j62/1fg==
X-Google-Smtp-Source: APXvYqwSBXLgxbHxoEnDonqbACyGnvV1ZNezhTU6Vgc6F6Hq4BY3bKyqvj3eDuPWzZi/lzcpQtZLdjpJWlI4n7e056M=
X-Received: by 2002:a17:902:e183:: with SMTP id cd3mr23298888plb.233.1556558583289;
 Mon, 29 Apr 2019 10:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190423142629.120717-1-venture@google.com> <CAO=notzjzpt0WHfJEWXMGgkoJU8UiLnqZnrGrPs-dRH5GNdJyQ@mail.gmail.com>
 <CAO=notz9QVoqKLrhJ3kx9FHja5+Mh68f36O36+1ewLG+SanmOA@mail.gmail.com>
 <20190425172549.GA12376@kroah.com> <20190429165137.mwj4ehhwerunbef4@localhost>
 <CAOesGMg49z4Gip-bLK-h7+LSLa4Fu68r11gT2EV8E8xMCPGDxg@mail.gmail.com>
 <CAO=notwVyTqvxfYRU1XJTwzSNCUAMgYCVpXVvqaN62uSiWyYCQ@mail.gmail.com> <CAOesGMjShorZmVeLL1nJNPVOP+vNTVzcA=arU3qW8ZUDYCtjaQ@mail.gmail.com>
In-Reply-To: <CAOesGMjShorZmVeLL1nJNPVOP+vNTVzcA=arU3qW8ZUDYCtjaQ@mail.gmail.com>
From:   Patrick Venture <venture@google.com>
Date:   Mon, 29 Apr 2019 10:22:51 -0700
Message-ID: <CAO=notw5wcC4ybPhAuwq9n5HCY18Yewt-Wp7nJWP0kaRnOxtwA@mail.gmail.com>
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

On Mon, Apr 29, 2019 at 10:19 AM Olof Johansson <olof@lixom.net> wrote:
>
> On Mon, Apr 29, 2019 at 10:16 AM Patrick Venture <venture@google.com> wrote:
> >
> > On Mon, Apr 29, 2019 at 10:13 AM Olof Johansson <olof@lixom.net> wrote:
> > >
> > > On Mon, Apr 29, 2019 at 10:08 AM Olof Johansson <olof@lixom.net> wrote:
> > > >
> > > > On Thu, Apr 25, 2019 at 07:25:49PM +0200, Greg KH wrote:
> > > > > On Tue, Apr 23, 2019 at 08:28:14AM -0700, Patrick Venture wrote:
> > > > > > On Tue, Apr 23, 2019 at 8:22 AM Patrick Venture <venture@google.com> wrote:
> > > > > > >
> > > > > > > On Tue, Apr 23, 2019 at 7:26 AM Patrick Venture <venture@google.com> wrote:
> > > > > > > >
> > > > > > > > Create a SoC folder for the ASPEED parts and place the misc drivers
> > > > > > > > currently present into this folder.  These drivers are not generic part
> > > > > > > > drivers, but rather only apply to the ASPEED SoCs.
> > > > > > > >
> > > > > > > > Signed-off-by: Patrick Venture <venture@google.com>
> > > > > > >
> > > > > > > Accidentally lost the Acked-by when re-sending this patchset as I
> > > > > > > didn't see it on v1 before re-sending v2 to the larger audience.
> > > > > >
> > > > > > Since there was a change between v1 and v2, Arnd, I'd appreciate you
> > > > > > Ack this version of the patchset since it changes when the soc/aspeed
> > > > > > Makefile is followed.
> > > > >
> > > > > I have no objection for moving stuff out of drivers/misc/ so the SOC
> > > > > maintainers are free to take this.
> > > > >
> > > > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > >
> > > > I'm totally confused. This is the second "PATCH v2" of this patch that I came
> > > > across, I already applied the first.
> > > >
> > > > Patrick: Follow up with incremental patch in case there's any difference.
> > > > Meanwhile, please keep in mind that you're adding a lot of work for people when
> > > > you respin patches without following up on the previous version. Thanks!
> > >
> > > Not only that, but subthreads were cc:d to arm@kernel.org and some
> > > were not, so I missed the overnight conversation on the topic.
> > >
> > > If this email thread is any indication of how the code will be
> > > flowing, there's definitely need for more structure. Joel, I'm hoping
> > > you'll coordinate.
> >
> > To be honest, this patchset thread was a bit less clear than anyone
> > prefers.  I use get_maintainers to get the initial list, and so adding
> > arm@ or soc@ per a request tells me that perhaps those should be
> > output via that script.
>
> The tools are working as expected, we normally don't take patches
> directly to arm@kernel.org, we let them go in through platform
> maintainers who then send it on to us.

Thanks for clarifying.

>
> > >
> > > I'm with Arnd on whether the code should be in drivers/soc or not --
> > > most of it likely should not.
> >
> > I think the misc drivers for a SoC that are a single user interface
> > that is focused on the use-case that belongs to that SoC only belong
> > in soc/, while if there is something we can do in common -- different
> > story.  If it makes sense to just have misc/aspeed/ instead of
> > soc/aspeed -- would that align more?
>
> Those views are how the "board file hell" started on 32-bit ARM too,
> so we're definitely hesitant to jump to that conclusion without
> knowing more about what's actually anticipated.
>
>
> Do you happen to have an estimate on what kind of drivers are
> needed/anticipated?

There is a UART routing control driver for ASPEED that spawned my push
to soc/aspeed.  The advice on that thread was to put such drivers
there.  There's likely to be a few more control-focused aspeed
drivers.

For Nuvoton, we definitely expect some similar LPC control drivers.
Possibly an LPC snoop driver, similar to aspeed-lpc-snoop.  This
supports the idea of creating some form of bmc subsystem as suggested
above (or in a different thread).

>
>
> -Olof
