Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB71C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90421207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Jcsh8ybJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgAFVIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 16:08:49 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:39143 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgAFVIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 16:08:49 -0500
Received: by mail-io1-f68.google.com with SMTP id c16so20261166ioh.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 13:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+eDaek1Ee2kg6Q/8/vv1VdmBerDSTO12+og01hxQgik=;
        b=Jcsh8ybJzR/aCasR9itoZGejP1nwOseFFdufy4+4p0LptMZz5JfxbDs3ROrT3Vd7YE
         lLJyXvyBjGlYLh1Fh3lfvUhLMe326DdxOC5y5Z3slArusvo/HIsq+XEM3J6FtRL2+0O+
         9qylXim4vo6cWM7cI5iwZWdRJkDYma3erAQXiPhu6P0ZW3wFK2fGc5K9wp6KrUygonDO
         VsZzfS1jFubkEATjEFAVIbrAkCrtrcka/QbgwmSdW6R6Jc3gl4UwVayTFnx6PHrePkpR
         q82mrzaSFtFR4eTmwLpoQ2Ea9uP3y+ieYWos79WVthxudoKtk+bSFYOfa49GoSv5XktD
         6JZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+eDaek1Ee2kg6Q/8/vv1VdmBerDSTO12+og01hxQgik=;
        b=qwnkc/BF1Q5xxKKWAYGWMV8+X5+ezMYlL1gJLKUq6t9WVdWsKesAYiNyMQOZey+QDN
         9C3OSfedrZQxJaa/bw2/FNxYVvNlkaKB0fZmPjstKlDyYtQ4Eal22LH/yzMpKdOVPY/B
         iPTTOO9MLSWsDcs3BsIEvEW+Q7ZGHBKeFm5es07QCwn86u4vG4diuFZhwuBbFVABmcza
         uyvlc4hi2Q0bwWLLcWIpFf78Id+E2W3sFAt6wKZWJG6LhNAczs5r1vx48NYyIP7qq78h
         nTL9kZE+WYsNXWumnWMWKKNRc7DM6L/LU3vCXyfW/gvNOYkHT8UinaPTdCrrakC6Hm1J
         qiUA==
X-Gm-Message-State: APjAAAUF9PcMG2zNQN48FaavmxTGsH/5aBzv36BZNSk/H+2oJV0+QK61
        dhck233oVDJu/+5Ts8HTAyVAWoWy3G2uejQRsBruNg==
X-Google-Smtp-Source: APXvYqxbh2lqXLU6Um5AJwW6TpNl2yNRIlMcGFgaeFa3N4xZyVae2eOduhaeZDcZIFaGUdyQH4RtgQzfDUFCF6RsTZo=
X-Received: by 2002:a5e:9907:: with SMTP id t7mr70465866ioj.72.1578344928641;
 Mon, 06 Jan 2020 13:08:48 -0800 (PST)
MIME-Version: 1.0
References: <20191212160622.021517d3@canb.auug.org.au> <CAOesGMiabP7nAPYKrmP=j_8bSj-UfUSFoiD0W+kqzaBp-6J2hQ@mail.gmail.com>
 <20200106181006.GL13449@paulmck-ThinkPad-P72>
In-Reply-To: <20200106181006.GL13449@paulmck-ThinkPad-P72>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 6 Jan 2020 13:08:37 -0800
Message-ID: <CAOesGMjTbrtVTU6ootOrOifKLqY_D0bstgqBKGriE9pVkNcPOQ@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the rcu tree
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 6, 2020 at 10:10 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Mon, Jan 06, 2020 at 09:51:47AM -0800, Olof Johansson wrote:
> > Hi,
> >
> > On Wed, Dec 11, 2019 at 9:06 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Hi all,
> > >
> > > After merging the rcu (I think) tree, today's linux-next build (x86_64
> > > allnoconfig) produced this warning:
> > >
> > > kernel/time/timer.c: In function 'schedule_timeout':
> > > kernel/time/timer.c:969:20: warning: 'timer.expires' may be used uninitialized in this function [-Wmaybe-uninitialized]
> > >   969 |   long diff = timer->expires - expires;
> > >       |               ~~~~~^~~~~~~~~
> > >
> > > Introduced by (bisected to) commit
> > >
> > >   c4127fce1d02 ("timer: Use hlist_unhashed_lockless() in timer_pending()")
> > >
> > > x86_64-linux-gnu-gcc (Debian 9.2.1-21) 9.2.1 20191130
> >
> > This is still there as of last night's -next. Any update on getting a
> > fix queued together with the offending patch?
>
> Hello, Olof,
>
> Thank you, I had indeed lost track of this one.  :-/
>
> Does Eric's patch fix things for you?
>
> https://lore.kernel.org/lkml/CANn89i+xomdo4HFqewrfNf_Z4Q5ayXuW6A4SjSkE46JXP9KuFw@mail.gmail.com/

It does, but it's not a proper patch (whitespace damage, no S-o-b, etc).


-Olof
