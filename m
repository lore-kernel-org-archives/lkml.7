Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BFCC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 20:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFFAB218A6
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 20:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Da2jcKUD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732533AbfGVUN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 16:13:28 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36949 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbfGVUN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 16:13:26 -0400
Received: by mail-io1-f67.google.com with SMTP id q22so76806639iog.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 13:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7l2Wn+FJ2BG0j9D1JF5TbgHPijVR0AsIZvIp2BLcK5g=;
        b=Da2jcKUDozDPsXerQ0RRbZ0Kiy8fI8o4wDzBSauzAKL2ZDmDxnbuy57mb8AJZBI3Rj
         UdTbSFpfOT8v/ncvU5jBApagtN/BgoEM5N8WV5Yh2POwDGHjoYOSysWJEbDGyKGyfKkb
         BkpcRHyIo+/mU3nI8r658R5M3v18lRbVET3vE6PBKb/9usAwEp/IzE45DhfJJrip9uG1
         I+7rvOP/0gtgv/BYXgwc5GWRYDCtyKdZAASvnnLIgmAXtEw0zVwgGpxeKv1WVRXY73SG
         Opniqmwjov6YdZyINl32tlYFrbgGgCI4MX25cuAxXXnAkNaj/IoFJijL8IDSZxcC9KXl
         g65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7l2Wn+FJ2BG0j9D1JF5TbgHPijVR0AsIZvIp2BLcK5g=;
        b=gstG8347lSYDFHAkMLr8bobKjlpZ0tP6+EFJggCWZs/hoONW21webCBIWPh8lsdHdc
         qg/vl76d5OVVjGk7nwQAypZ5/G5bpmq/J1TALUtrhd4iQbPVSwT+Zcc0Kp//OMPa+gNo
         aUuTo9gJwanQuqEvaluJPi0jp/fn1xxIa8ok2BZvHBFcM/187jVVNooySHJmgb/L5Nzi
         djkbiwzDB5lYaDS/rf44u5KmBYmIgIyWVHcteX/iapoMbb8WG/XoFpMOEqTP53CfRryg
         plrPvx5XDzOmZjXlIUzFZfodROHMdNIY+HEZIskWoDH9+kDwCthZ6WTJxMPy6j8tydyk
         Gheg==
X-Gm-Message-State: APjAAAWsXMKEXpLncVvd9VA/eieZwFmmGiGgUCYBSDYID0Fi0mPpIc5O
        +4fVNALHwF37drUmkjU9JNcxvqp+TtU9mpEQCu1gCeq59po=
X-Google-Smtp-Source: APXvYqyiAVhxu4nXny5pvNFjsFJ+z38F8yOUB1vGVezA4DDforKOQu16+Eoz95HvdgDnQBbS1HWonhdzq+Y9/TyPPXs=
X-Received: by 2002:a02:6a22:: with SMTP id l34mr76706311jac.126.1563826405473;
 Mon, 22 Jul 2019 13:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190415202501.941196-1-arnd@arndb.de> <2424c672-e3fb-4c32-4c24-fafc59d03a96@uclinux.org>
 <CACRpkdaJ+2bub_nDp9=5b4kyKjWDnOGKscWg3KsEVixDpk8rzA@mail.gmail.com>
 <20190503170613.GA1783@roeck-us.net> <d8d81aca-722d-8b5f-cd5f-30cc3e4e407b@kernel.org>
 <CAK8P3a0StV==jMq1L9k91qEsvRD1Cw2FB1V25wr1AQqzmjsTVw@mail.gmail.com>
In-Reply-To: <CAK8P3a0StV==jMq1L9k91qEsvRD1Cw2FB1V25wr1AQqzmjsTVw@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 22 Jul 2019 13:13:14 -0700
Message-ID: <CAOesGMjFgR3CWcVF__=nvhHzMsdBDriPJTLX6pqq4PHMDS_OxQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] ARM: ks8695: watchdog: stop using mach/*.h
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Ungerer <gerg@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        arm-soc <arm@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 7:44 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, May 4, 2019 at 4:27 PM Greg Ungerer <gerg@kernel.org> wrote:
> > On 4/5/19 3:06 am, Guenter Roeck wrote:
> > > On Fri, May 03, 2019 at 08:16:05AM +0100, Linus Walleij wrote:
> > >> On Fri, May 3, 2019 at 8:02 AM Greg Ungerer <gerg@uclinux.org> wrote:
> > >>> Ultimately though I am left wondering if the ks8695 support in the
> > >>> kernel is useful to anyone the way it is at the moment. With a minimal
> > >>> kernel configuration I can boot up to a shell - but the system is
> > >>> really unreliable if you try to interactively use it. I don't think
> > >>> it is the hardware - it seems to run reliably with the old code
> > >>> it has running from flash on it. I am only testing the new kernel,
> > >>> running with the existing user space root filesystem on it (which
> > >>> dates from 2004 :-)
> > >>
> > >> Personally I think it is a bad sign that this subarch and boards do
> > >> not have active OpenWrt support, they are routers after all (right?)
> > >> and any active use of networking equipment should use a recent
> > >> userspace as well, given all the security bugs that popped up over
> > >> the years.
>
> Looking around on the internet, I found that Micrel at some point
> had their own openwrt fork for ks8695, but I can't find a copy
> any more, as the micrel.com domain is no longer used after the
> acquisition by Microchip.
>
> https://wikidevi.com/wiki/Micrel has a list of devices based on
> ks8695, and it seems that most of these are rather memory
> limited, which is a problem for recent openwrt builds.
>
> Only two of the 17 listed devices have the absolute minimum of 4MB
> flash and 32MB RAM for openwrt, two more have 8/32 and one
> or two have 4/64, but all these configurations are too limited for the
> web U/I now.
>
> > >> With IXP4xx, Gemini and EP93xx we have found active users and
> > >> companies selling the chips and reference designs and even
> > >> recommending it for new products (!) at times.  If this is not the
> > >> case with KS8695 and no hobbyists are willing to submit it
> > >> to OpenWrt and modernize it to use device tree I think it should be
> > >> deleted from the kernel.
> > >>
> > >
> > > That may be the best approach if indeed no one is using it,
> > > much less maintaining it.
> >
> > Well, I for one don't really use it any more. So I don't have a lot
> > of motivation to maintain it any longer.
>
> I came across my patches while rebasing my backlog to 5.3-rc1.
>
> Should I save the (very small) trouble of sending them out again
> and just remove the platform then?

Given the lack of response/interest from users, I'm OK with removing it.

If someone shows up wanting support, we'll have a good opportunity to
discuss testing/modernization involving someone actively using the
hardware.


-Olof
