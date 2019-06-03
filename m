Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E97CC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447F827DE2
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1pHEck2f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfFCJCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:02:01 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:32722 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfFCJCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:02:00 -0400
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x5391jPm029705
        for <linux-kernel@vger.kernel.org>; Mon, 3 Jun 2019 18:01:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x5391jPm029705
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1559552506;
        bh=eEI7m3wkZyuLRC5t4Dr95mXISCNX++0zsNC/lTShoE4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1pHEck2f7Y+LBk01WGT5fV+b3uCw5Avq+YOte/65/u1tg+kQ5LAe4240pktOPQUU/
         /2UOObCVWgbGJnYC8wL0L5tjwKhlamV2WR0WWq0/czrACWj83rCljylcP+F1m//Gcc
         QMApTGozC+ZX5oNbg7JpXl1+3iguK0I4X/3OhhOcjdKu1xyJwpmkORFKEBgzduSXzB
         wFBS2VGeP7tRvEdqA6eBs/ncCCe8ShZMc7zodDbi+HWicyBe21rKEQ87RwZfd7AQB9
         YzGNYPDL2QUIu3XioQ5VCVZ0XCfb7jyJbE1K2s5K7uIqI8eu3Wrk1H7rGHFRNiQEFl
         QLp9mPooUXQow==
X-Nifty-SrcIP: [209.85.217.49]
Received: by mail-vs1-f49.google.com with SMTP id d128so10733530vsc.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 02:01:45 -0700 (PDT)
X-Gm-Message-State: APjAAAXH0AvHlFqIQf6prMmLhEi8+yYNrB65lEX+suMcxyMSVIcxtMH5
        nMO4KtasoqS1G9Czo25H0E90ixIWb07S1za5JnE=
X-Google-Smtp-Source: APXvYqwwfK8QVTnBMsGDfnmDcFgNqwES3z8jc8ADFv5osapsAFa/v12FAeIQphukw2jg6Z04KTZvNIUGWHhtQZHiK2c=
X-Received: by 2002:a67:de99:: with SMTP id r25mr12068520vsk.215.1559552504781;
 Mon, 03 Jun 2019 02:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190603063119.36544-1-abrodkin@synopsys.com> <CAK7LNASiHzar3JmzGB1fgUYUC91F3FPsALj3iMhANTjGgnux5w@mail.gmail.com>
 <CY4PR1201MB012004A6281FFE93B8191F30A1140@CY4PR1201MB0120.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR1201MB012004A6281FFE93B8191F30A1140@CY4PR1201MB0120.namprd12.prod.outlook.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 3 Jun 2019 18:01:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNATaLmeeeftK9AGfohEpYKhbgcXSp+GEgW46BeeAHnpqiQ@mail.gmail.com>
Message-ID: <CAK7LNATaLmeeeftK9AGfohEpYKhbgcXSp+GEgW46BeeAHnpqiQ@mail.gmail.com>
Subject: Re: [PATCH] ARC: build: Try to guess CROSS_COMPILE with cc-cross-prefix
To:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc:     arcml <linux-snps-arc@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey,

On Mon, Jun 3, 2019 at 5:34 PM Alexey Brodkin
<Alexey.Brodkin@synopsys.com> wrote:
>
> Hi Masahiro-san,
>
> > -----Original Message-----
> > From: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Sent: Monday, June 3, 2019 11:18 AM
> > To: Alexey Brodkin <abrodkin@synopsys.com>
> > Cc: arcml <linux-snps-arc@lists.infradead.org>; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>; Vineet Gupta <Vineet.Gupta1@synopsys.com>
> > Subject: Re: [PATCH] ARC: build: Try to guess CROSS_COMPILE with cc-cross-prefix
> >
> > Hi Alexey,
> >
> > On Mon, Jun 3, 2019 at 3:42 PM Alexey Brodkin
> > <Alexey.Brodkin@synopsys.com> wrote:
>
> [snip]
>
> > > A side note: even though "cc-cross-prefix" does its job it pollutes
> > > console with output of "which" for all the prefixes it didn't manage to find
> > > a matching cross-compiler for like that:
> > > | # ARCH=arc make defconfig
> > > | which: no arceb-linux-gcc in (~/.local/bin:~/bin:/usr/bin:/usr/sbin)
> > > | *** Default configuration is based on 'nsim_hs_defconfig'
> >
> >
> > Oh really?
> >
> > masahiro@pug:~$ which arc-linux-gcc
> > /home/masahiro/tools/arc/bin/arc-linux-gcc
> > masahiro@pug:~$ which dummy-linux-gcc
> > masahiro@pug:~$ echo $?
> > 1
> >
> >
> > When 'which' cannot find the given command,
> > it does not print anything to stderr.
> >
> > Does it work differently on your machine?
>
> Well on Ubuntu 18.04 indeed which doesn't show anything
> but on my build-server with CentOS 7 I'm getting mentioned verbose output:
> | # cat /etc/redhat-release
> | CentOS Linux release 7.3.1611 (Core)
>
> | # /usr/bin/which -v
> | GNU which v2.20, Copyright (C) 1999 - 2008 Carlo Wood.
> | GNU which comes with ABSOLUTELY NO WARRANTY;
> | This program is free software; your freedom to use, change
> | and distribute this program is protected by the GPL.


OK, confirmed.

Probably using 'which' is a bad idea
since this is not portable.

I will send a fix-up patch soon.



-- 
Best Regards
Masahiro Yamada
