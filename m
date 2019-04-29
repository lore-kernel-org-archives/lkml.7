Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398C7C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076342147A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iybmumts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbfD2RQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 13:16:27 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43686 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbfD2RQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:16:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id n8so5361759plp.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 10:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yrQv2na9LmyqY09k2tODdC7kNnteQ3ci4lABBeEBPE4=;
        b=iybmumtskaFi13rXf1HJRNM75LC2gfNuVub4KnqHpyiL1nlJvVY3GB8TV+dD9oOuZ/
         Td7MWHJw+K+QcGrg31mzACAPWwL4QK9TNjJ/ke111sr1d6+dXa8wfFcmqkVEQ6DMpUyq
         UDIdWqryCSjDq1vJx3c4OPWD5jKhI6QNy+NbuuddJiWkbWQfziJkYKWaWQk9eRmu5BGL
         tA6a2KN3eeEtZIrlb/5HLrHkP34M29XvN9uPMLtrhrrvUWhIloFTve17Vd4coUsZuKJ/
         l7fFWpeSldhasZPzT8tsU8zGgA2c2eUqXxBeZAbDkI/I02SU6AHbOF1tONzMazP3TBHe
         qLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yrQv2na9LmyqY09k2tODdC7kNnteQ3ci4lABBeEBPE4=;
        b=Jn1xZqJxS8kBfX1gVACwCqFze/6N2nVq0QW1gUFgOtegaKI0EUcwosn9JSp93qJryY
         cV/cupZ7486BQq91FTXzoWpNGZPonnCle5pbvJwI5McGyHtdQ1mZ4nAfyghtwPmlxjw2
         82jeoUVh6YdH1jO4aGX+Ht53yTwj6/SbnfbefOJfstQHyBBS64UvoG7D+15xrqtv0WnO
         YOSDulZcaVkhzVK9WyZ9dfQhyAyuXqsQNaydf+TTJQ1tRiij2PPJUpeLv+PlP94fHWlm
         XN/YlHP28eyK9GZTgAH1sOVN8uyDWhbrzOAMpH+itDEPThDsDJKDMvLFie0uvFQq3xYM
         Rmxw==
X-Gm-Message-State: APjAAAVW7tZ/8gNDfh7iCMeKzJdptdY+r0Pi8CEl43/Jp3rHufm2bw3a
        MgCfvePfQEDC2gPutWjfnDqEIGZUv76HSqZyZD8OWA==
X-Google-Smtp-Source: APXvYqymDIPfBTHbfoLNX9Aw7ZzXqqRyg7AuW+O8cV1ErDsGXn5m1e6K5s0jN81AsooOh/W/UWJLePjyEP9rPiD6dPU=
X-Received: by 2002:a17:902:e183:: with SMTP id cd3mr23254341plb.233.1556558186240;
 Mon, 29 Apr 2019 10:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190423142629.120717-1-venture@google.com> <CAO=notzjzpt0WHfJEWXMGgkoJU8UiLnqZnrGrPs-dRH5GNdJyQ@mail.gmail.com>
 <CAO=notz9QVoqKLrhJ3kx9FHja5+Mh68f36O36+1ewLG+SanmOA@mail.gmail.com>
 <20190425172549.GA12376@kroah.com> <20190429165137.mwj4ehhwerunbef4@localhost>
 <CAOesGMg49z4Gip-bLK-h7+LSLa4Fu68r11gT2EV8E8xMCPGDxg@mail.gmail.com>
In-Reply-To: <CAOesGMg49z4Gip-bLK-h7+LSLa4Fu68r11gT2EV8E8xMCPGDxg@mail.gmail.com>
From:   Patrick Venture <venture@google.com>
Date:   Mon, 29 Apr 2019 10:16:14 -0700
Message-ID: <CAO=notwVyTqvxfYRU1XJTwzSNCUAMgYCVpXVvqaN62uSiWyYCQ@mail.gmail.com>
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

On Mon, Apr 29, 2019 at 10:13 AM Olof Johansson <olof@lixom.net> wrote:
>
> On Mon, Apr 29, 2019 at 10:08 AM Olof Johansson <olof@lixom.net> wrote:
> >
> > On Thu, Apr 25, 2019 at 07:25:49PM +0200, Greg KH wrote:
> > > On Tue, Apr 23, 2019 at 08:28:14AM -0700, Patrick Venture wrote:
> > > > On Tue, Apr 23, 2019 at 8:22 AM Patrick Venture <venture@google.com> wrote:
> > > > >
> > > > > On Tue, Apr 23, 2019 at 7:26 AM Patrick Venture <venture@google.com> wrote:
> > > > > >
> > > > > > Create a SoC folder for the ASPEED parts and place the misc drivers
> > > > > > currently present into this folder.  These drivers are not generic part
> > > > > > drivers, but rather only apply to the ASPEED SoCs.
> > > > > >
> > > > > > Signed-off-by: Patrick Venture <venture@google.com>
> > > > >
> > > > > Accidentally lost the Acked-by when re-sending this patchset as I
> > > > > didn't see it on v1 before re-sending v2 to the larger audience.
> > > >
> > > > Since there was a change between v1 and v2, Arnd, I'd appreciate you
> > > > Ack this version of the patchset since it changes when the soc/aspeed
> > > > Makefile is followed.
> > >
> > > I have no objection for moving stuff out of drivers/misc/ so the SOC
> > > maintainers are free to take this.
> > >
> > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > I'm totally confused. This is the second "PATCH v2" of this patch that I came
> > across, I already applied the first.
> >
> > Patrick: Follow up with incremental patch in case there's any difference.
> > Meanwhile, please keep in mind that you're adding a lot of work for people when
> > you respin patches without following up on the previous version. Thanks!
>
> Not only that, but subthreads were cc:d to arm@kernel.org and some
> were not, so I missed the overnight conversation on the topic.
>
> If this email thread is any indication of how the code will be
> flowing, there's definitely need for more structure. Joel, I'm hoping
> you'll coordinate.

To be honest, this patchset thread was a bit less clear than anyone
prefers.  I use get_maintainers to get the initial list, and so adding
arm@ or soc@ per a request tells me that perhaps those should be
output via that script.

>
> I'm with Arnd on whether the code should be in drivers/soc or not --
> most of it likely should not.

I think the misc drivers for a SoC that are a single user interface
that is focused on the use-case that belongs to that SoC only belong
in soc/, while if there is something we can do in common -- different
story.  If it makes sense to just have misc/aspeed/ instead of
soc/aspeed -- would that align more?

>
>
> -Olof
