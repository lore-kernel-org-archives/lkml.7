Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35CACA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CC92070B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571992251;
	bh=qPuBMoxRjvpFkzIBTbK1+Sj7VeGDrKvcqY80diQQkP8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gHWi7YaDCji2O7lbDeB0lzH+Dvmlfb7VP+9CfaHvpEbGBS7foty/cQMcdhNlJSx46
	 L9lRym1p4egn60qagVpFDQncAhQIA030ptddNxqZoEzTkBp6rC5T5DLbyZIMHzlcSg
	 iQC11ISjRqItbURqMaqqR9YtmNFG5JlwyfsKRxOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393079AbfJYIau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:30:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56233 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389290AbfJYIau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:30:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id g24so1091257wmh.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 01:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WbtLEpxURuAgUvWpg00n4NSzJioqm+P4SunJQG8F86k=;
        b=glhwaD7x4wvVUqBGgc2VNTWDk2nHWkStoxGi2/7DzGWd6rmZ50JKeP5Kgw9+yMGoIc
         r3D8WDhKMc+wukrUfmptv/F97gCLm3XAxl6ua0bkkdo8mvWtIE3nxApyf4LywVZKfs6F
         /ooivXkE7HvX6UBcmQc0/DzTpsaSbZQeFHca8kcaiEnYRfatl897rgccfgSBtBLfVqnr
         PDwXJa92kDo0TuAa58KK3sW56rA0E/KPdtAODU3yYVH9SBduGfv1UJBCqSebJInfYy0G
         myPB4w7L+PJi/hZbWStO1ef+46Me/myV0D36D1RgkXLZk+rwM0paxB73VOWZoo30vFZ5
         J1GA==
X-Gm-Message-State: APjAAAV67HOZSxCCEF6wf3SsGEhp8hFFFh/EKJQXrSYCCEdzH726sJFd
        rsQ3IcNf++iaQ/l51S9WqTO9K2Fw+GZzu/FlNz4=
X-Google-Smtp-Source: APXvYqyC8NCbSxEGilZd/aYDNefNH9iMDpvtNEaMy9SYv/fLuXfs4IxPlQiP9A8lJMELvGrFkqbI3YULBvsK/sL8woo=
X-Received: by 2002:a1c:2d49:: with SMTP id t70mr2309007wmt.131.1571992246721;
 Fri, 25 Oct 2019 01:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <20191016125019.157144-1-namhyung@kernel.org> <20191016125019.157144-2-namhyung@kernel.org>
 <20191024174433.GA3622521@devbig004.ftw2.facebook.com>
In-Reply-To: <20191024174433.GA3622521@devbig004.ftw2.facebook.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 25 Oct 2019 17:30:35 +0900
Message-ID: <CAM9d7chWpj105TYR0qP3T8FJ=-2wjp+sh6Rk8zkvJb_ugtL3Dw@mail.gmail.com>
Subject: Re: [PATCH 1/2] cgroup: Add generation number with cgroup id
To:     Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Song Liu <liu.song.a23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On Fri, Oct 25, 2019 at 2:44 AM Tejun Heo <tj@kernel.org> wrote:
> On Wed, Oct 16, 2019 at 09:50:18PM +0900, Namhyung Kim wrote:
> > Later 64 bit system can have a simpler implementation with a single 64
> > bit sequence number and a RB tree.  But it'll need to grab a spinlock
> > during lookup.  I'm not entirely sure it's ok, so I left it as is.
>
> Any chance I can persuade you into making this conversion?  idr is
> exactly the wrong data structure to use for cyclic allocations.  We've
> been doing it mostly for historical reasons but I really hope we can
> move away from it.  These lookups aren't in super hot paths and doing
> locked lookups should be fine.

As you know, it entails change in kernfs id and its users.
And I really want to finish the perf cgroup sampling work first.
Can I work on this after the perf work is done?

>
> >  /*
> >   * A cgroup_root represents the root of a cgroup hierarchy, and may be
> >   * associated with a kernfs_root to form an active hierarchy.  This is
> > @@ -521,7 +529,7 @@ struct cgroup_root {
> >       unsigned int flags;
> >
> >       /* IDs for cgroups in this hierarchy */
> > -     struct idr cgroup_idr;
> > +     struct cgroup_idr cgroup_idr;
>
> Given that there's cgroup->self css, can we get rid of the above?

I don't follow.  Do you want to remove cgroup_idr and share the
css_idr for cgroup id?

Thanks
Namhyung
