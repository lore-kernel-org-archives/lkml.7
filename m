Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0994C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 20:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB5C206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 20:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXz0/pxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbfHUUL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 16:11:28 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34435 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfHUUL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 16:11:28 -0400
Received: by mail-io1-f68.google.com with SMTP id s21so7286294ioa.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 13:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2DOTUim7xszpoBzU2nXJGt8etxbT3w7zmjx6UDzqbXU=;
        b=UXz0/pxLpfbJ+/8wDoB0Y7l4WEcoaALBaywsTATMPxdERmlwMg/lFGmHDRFtLLZzBz
         SkEVJMM0tF2zjSunb9BIjk0WyQLSIYZE+fFugI6txHa6/e5m7xFKE/SYZkUOq1SiYQYX
         20jLwLjbKrkpU7KjDWcbl9zUYtE4KBshRsGixr1QVBh6mtAHRanG71hgg0rr2rcjqG9f
         q9ImQndHlYpgYyj+ltasWK5K6apcl9927re5JePwF9K/8Tygzvlk6R/jc1aJAMKUrTmH
         Yb45Xbw+PgnIdmbLv+SJJgBtDod6TvhwpbpK+VveNJP1qtPBdE8TuvGg2vNYoHTVoSwQ
         VvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2DOTUim7xszpoBzU2nXJGt8etxbT3w7zmjx6UDzqbXU=;
        b=VTprG0krdbPvbjkVqguBOG/Z0hpDP3m/elVpFTdSXqT4s2amS1a6jXqyGpl4/kG/4L
         9c5h6p1D7qIy0rLRvRJ81Pb0/IjhsHB/yX17HGoCbsPmiBL43OtjNdRnNXa6m2Ek552Y
         13js/vMMkXTzW0uqUVkUtYWYSis47J0F0ifXVnkb1ebYv4gSy6kwTUH/Kbmc7lYDH8aj
         cCyi7J1xwa72tKwyNWbuabIN+yPm42BGD86i7Dfji7IKjKe9yI50Y73QYGppC2Iw89fo
         ZljTYD07elqHAasdah/cjPVPo8tpvJ3cm4AB4a7fGmE4IgW/MpJQQae+e82yyFyjedUC
         kCcQ==
X-Gm-Message-State: APjAAAVrxkCfrO2dxN4F3Tszz2A93T/bIcQo0r6zs7bYQZc0TDpWBgWa
        tDJ4qNACi2fuaSp32yS2APpsNc8NY5fpf3hd234=
X-Google-Smtp-Source: APXvYqwCG+0NxvpiXWFxLs/BwtVZQxRP5BIDZQdTt/uwkeC0l2jxYg38T7Rp5jmL6lWDqWJbyLDcNugi+gNp95irp3g=
X-Received: by 2002:a5d:8ad0:: with SMTP id e16mr114649iot.262.1566418287345;
 Wed, 21 Aug 2019 13:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <1566346700-28536-1-git-send-email-caitlynannefinn@gmail.com>
 <1566346700-28536-3-git-send-email-caitlynannefinn@gmail.com>
 <7aaca457a3d3feb951082d0659eec568a908971f.camel@perches.com>
 <20190821023122.GA159802@architecture4> <20190821151241.GF12461@ares> <20190821155205.GB5060@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20190821155205.GB5060@hsiangkao-HP-ZHAN-66-Pro-G1>
From:   Caitlyn Finn <caitlynannefinn@gmail.com>
Date:   Wed, 21 Aug 2019 16:11:15 -0400
Message-ID: <CAG2TOUuM+jE2ZTGTCMpPL7U2Q_motkAH6iWZdUOJLsPY8aC8aA@mail.gmail.com>
Subject: Re: [PATCH 2/2] staging/erofs: Balanced braces around a few
 conditional statements.
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     "Tobin C . Harding" <me@tobin.cc>,
        Gao Xiang <gaoxiang25@huawei.com>, devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 11:52 AM Gao Xiang <hsiangkao@aol.com> wrote:
>
> Hi Tobin,
>
> On Wed, Aug 21, 2019 at 08:13:35AM -0700, Tobin C. Harding wrote:
> > On Wed, Aug 21, 2019 at 10:31:22AM +0800, Gao Xiang wrote:
> > > On Tue, Aug 20, 2019 at 07:26:46PM -0700, Joe Perches wrote:
> > > > On Tue, 2019-08-20 at 20:18 -0400, Caitlyn wrote:
> > > > > Balanced braces to fix some checkpath warnings in inode.c and
> > > > > unzip_vle.c
> > > > []
> > > > > diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
> > > > []
> > > > > @@ -915,21 +915,21 @@ static int z_erofs_vle_unzip(struct super_block *sb,
> > > > >         mutex_lock(&work->lock);
> > > > >         nr_pages = work->nr_pages;
> > > > >
> > > > > -       if (likely(nr_pages <= Z_EROFS_VLE_VMAP_ONSTACK_PAGES))
> > > > > +       if (likely(nr_pages <= Z_EROFS_VLE_VMAP_ONSTACK_PAGES)) {
> > > > >                 pages = pages_onstack;
> > > > > -       else if (nr_pages <= Z_EROFS_VLE_VMAP_GLOBAL_PAGES &&
> > > > > -                mutex_trylock(&z_pagemap_global_lock))
> > > > > +       } else if (nr_pages <= Z_EROFS_VLE_VMAP_GLOBAL_PAGES &&
> > > > > +                mutex_trylock(&z_pagemap_global_lock)) {
> > > >
> > > > Extra space after tab
> > >
> > > There is actually balanced braces in linux-next.
> > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/staging/erofs/zdata.c#n762
> >
> > Which tree did these changes go in through please Gao?  I believe
> > Caitlyn was working off of the staging-next branch of Greg's staging
> > tree.
>
> I don't think so, the reason is that unzip_vle.c was renamed to zdata.c
> months ago, see:
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/tree/drivers/staging/erofs?h=staging-next
>
> so I think the patch is outdated when I first look at it.
>
> Thanks,
> Gao Xiang

Gao,

I see now that I was on an outdated revision (Linux 5.3-rc4) of the
staging-next branch of Greg's staging tree, from
before that change was merged. I'll be certain that I'm fully
up-to-date before submitting future patches.

Thanks all for your time and assistance, and Gao and Joe for the
review comments as well, I'll review and submit
an appropriate patch series at a later time.

Thanks,
Caitlyn Finn
