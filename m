Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D692C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 19:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3492067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 19:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="mkOtiQnY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbfD2T1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 15:27:15 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41793 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbfD2T1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 15:27:14 -0400
Received: by mail-io1-f66.google.com with SMTP id r10so10013735ioc.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 12:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yM+qItkSV7cyOzrR0XusuAc8CsANFg6gCkRKBVgtPLc=;
        b=mkOtiQnY+tvJCO67zt0OTJfLIOW19SiBik3Jn1sSE0wipaqZ4CuUeTsZTMJ8OfKmOW
         TnmafCROZ1COEoBVSrZCsHNaJ7QZXwp5eB8BBM/hfmstC0gRXW6S8gsAkVtyY/kOIquE
         Z7k2wQEx4eQzDuFCenwXp4/9+Rl+u+8YBV1uuk1Xh4XfsYnjPNngdzNjJhUWkDzZQI/M
         uLziucGwmZhjK81QF8kp9SbfjaUM3w+UTTDKt+bcsT0E5mLLnraryYmsqs0slNft/vGM
         F7nVVva4kjQdHT48m4TjAgelo2XBZRYTjLjzqxT1XaqfN3vq1sCvSHzZfPft1sbJ0fGS
         cfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yM+qItkSV7cyOzrR0XusuAc8CsANFg6gCkRKBVgtPLc=;
        b=sUfb76/pwSG9ueUywv2CYCM1dWUOVMXYG7earlVJYvJWNqxhyJUaqLqTfIcEj3bzT9
         DE7wZV3Cq5bfzEuNbHYJxfqn3kLbjroi0jlfjQs9bFUsF3XfhvwDapEpR6kSse6mT9p4
         jjfIlHpnyhKApn80iVawW0E3dcQuCD8mdxLNvfazxcshDV01ewbiFK76Cxw5r/6Lp89h
         qTeoYn/aEH4xBv8qO3wgRHdkn4ZNynbf0QNkZs4MDiVUkpTaAzqehr67F76+2Haya4mf
         AuVwqfJJ+s1m/SucjLkuaZCVgEEOp8byQAtmVj3+GfUu9GYWLT9BUD5/FBjLPRp1vvna
         ul2Q==
X-Gm-Message-State: APjAAAWqRMMM+yPXLuapzJsnqveNPugth7Q0BseA2RcLmYWuU3xSk9Z6
        qNlyJaZAXO/IszhBB14cGIqI0BvOC5pfVlh25j6AbA==
X-Google-Smtp-Source: APXvYqxnpM22Us/BjZc44Va9fpbRb6KCGDpMRCGC9vemv4K7V0RFwjfmFcku2NXR+S4Uf3aARtyunnitr8/59FB8k+M=
X-Received: by 2002:a5e:9307:: with SMTP id k7mr12222114iom.155.1556566033384;
 Mon, 29 Apr 2019 12:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190423142629.120717-1-venture@google.com> <CAO=notzjzpt0WHfJEWXMGgkoJU8UiLnqZnrGrPs-dRH5GNdJyQ@mail.gmail.com>
 <CAO=notz9QVoqKLrhJ3kx9FHja5+Mh68f36O36+1ewLG+SanmOA@mail.gmail.com>
 <20190425172549.GA12376@kroah.com> <20190429165137.mwj4ehhwerunbef4@localhost>
 <CAO=notwewAeeLz=LsOcSj=DakLGW0KjeDHALP5Nv2ckgkRqnFA@mail.gmail.com>
In-Reply-To: <CAO=notwewAeeLz=LsOcSj=DakLGW0KjeDHALP5Nv2ckgkRqnFA@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 29 Apr 2019 12:27:02 -0700
Message-ID: <CAOesGMipoKED=XLg+VtEVG0Os_MUzsPgOfBFJ+qoJs_fNmP+3g@mail.gmail.com>
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

On Mon, Apr 29, 2019 at 10:12 AM Patrick Venture <venture@google.com> wrote:
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
>
> I think the issue here was that I added to the CC list another email
> and so you may see the v2  without that mailing list, and a v2 with it
> --
>
> Does this require a v3?  I honestly didn't think so, but this was the
> first time I had to add more people without needing other changes.

Well, v2 doesn't build. I'll fix it up locally by adding an 'endmenu'
to drivers/soc/aspeed/Kconfig. But... brings up questions how this was
tested before submitting?

scripts/kconfig/conf  --allnoconfig Kconfig
drivers/soc/Kconfig:24: 'menu' in different file than 'menu'
drivers/soc/aspeed/Kconfig:1: location of the 'menu'
drivers/Kconfig:233: 'menu' in different file than 'menu'
drivers/soc/aspeed/Kconfig:1: location of the 'menu'
<none>:34: syntax error

> >
> > Patrick: Follow up with incremental patch in case there's any difference.
> > Meanwhile, please keep in mind that you're adding a lot of work for people when
> > you respin patches without following up on the previous version. Thanks!
>
> w.r.t this patch series.  I found an issue with v1, and released a v2
> with the detail of what changed.  I thought that was the correct
> approach.  I apologize for creating extra work, that's something
> nobody needs.

It's ok to submit newer versions, but it's convenient when they get
threaded also in non-gmail mail readers (by using in-reply-to).


-Olof
