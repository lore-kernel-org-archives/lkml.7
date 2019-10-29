Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68ED4CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D042217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iHFxJvYu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731686AbfJ2S2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 14:28:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34349 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731627AbfJ2S2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 14:28:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id t16so14787156wrr.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 11:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lc0YR6zDkvJBR1Lmyr78EIEUjbyCrD4ENhnxzUSJhcA=;
        b=iHFxJvYuZq4G9qaQCdumXteszLysWMaL+ueo6DBsLBl3z9HNC1yqtPLD6gCDJbLYqM
         miI2K6+47J3PmvgsRFG+XsCPP09qOfnRSZ2o3fVAQcL6IWq+F0Lb0IVuNVN6LyDMuhWN
         QcyjxJQ5J6fHF0BExW1H737h62yFQrOyNhixlBx7jo+y1a/HGWvG4vsHMkcFzQIBku2c
         nvCLr73gax20ZKvuzP5i84oLfymNJYCk27XQapnmXlrGUYsZcnZvJesVN6wyDdLWfTnh
         vCGc+KlD3c16A7xbdM6tQ4F2q90fB2FvGO2/z2ROvny0qvzWII8MwF+O73vO3S3lMpkR
         WOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lc0YR6zDkvJBR1Lmyr78EIEUjbyCrD4ENhnxzUSJhcA=;
        b=EzrkJwHc/PPEfZIehd13h4K39BqZ/JR5HMGGeVeXKSTB/KNyRjgxlcchR/7CXFT3Id
         ktuzUzdRXXdltD5tThNOROZvNXqresbMuQdAsJXabMSlTlcmx1sUv491PVpnigQeLfHy
         dWI0EIDh8mEMybFOJBMNh9BGpeh1/n7yS5LBjTzuPxpQ4c6mkPd749fdJA1oncjcwFAL
         GO4J602Hx1oGOQ4VkBrnTZxQvow7Rq/YRoj620+dPvk9MmWyL7te0fknLoK/03d2Bfk6
         Jr1NSrUsrWspVUgKC8Fzgrm5Ia+tNChDtvRqHn3GNe/z0Y2rb0OljZbS61RYxq5c5PVA
         Lygg==
X-Gm-Message-State: APjAAAXCfyzK6sfYffAUT8QsRq92g1TbpNnAfrCb7MgtwIlWGTEQ9xPU
        83lQEJVZ8UroQPL54sS/WQ+nMw==
X-Google-Smtp-Source: APXvYqxnoCz8IBto2jLLfwAmwTJ06maD4sFXkbhBzKj0Zkkm55yFIuhz+cjLJm9VDxK2s8TbMVeSPw==
X-Received: by 2002:adf:9799:: with SMTP id s25mr21295633wrb.390.1572373688432;
        Tue, 29 Oct 2019 11:28:08 -0700 (PDT)
Received: from google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id f14sm4059375wmc.22.2019.10.29.11.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 11:28:07 -0700 (PDT)
Date:   Tue, 29 Oct 2019 19:28:02 +0100
From:   Marco Elver <elver@google.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Greg Thelen <gthelen@google.com>,
        syzbot+13f93c99c06988391efe@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm: memcontrol: fix data race in
 mem_cgroup_select_victim_node
Message-ID: <20191029182802.GA193152@google.com>
References: <20191029005405.201986-1-shakeelb@google.com>
 <20191029090347.GG31513@dhcp22.suse.cz>
 <CALvZod648GRvjd_LqViFzLRwxnzSrLZzjaNBOJju4xkDQkvrXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod648GRvjd_LqViFzLRwxnzSrLZzjaNBOJju4xkDQkvrXw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 29 Oct 2019, Shakeel Butt wrote:

> +Marco
> 
> On Tue, Oct 29, 2019 at 2:03 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Mon 28-10-19 17:54:05, Shakeel Butt wrote:
> > > Syzbot reported the following bug:
> > >
> > > BUG: KCSAN: data-race in mem_cgroup_select_victim_node / mem_cgroup_select_victim_node
> > >
> > > write to 0xffff88809fade9b0 of 4 bytes by task 8603 on cpu 0:
> > >  mem_cgroup_select_victim_node+0xb5/0x3d0 mm/memcontrol.c:1686
> > >  try_to_free_mem_cgroup_pages+0x175/0x4c0 mm/vmscan.c:3376
> > >  reclaim_high.constprop.0+0xf7/0x140 mm/memcontrol.c:2349
> > >  mem_cgroup_handle_over_high+0x96/0x180 mm/memcontrol.c:2430
> > >  tracehook_notify_resume include/linux/tracehook.h:197 [inline]
> > >  exit_to_usermode_loop+0x20c/0x2c0 arch/x86/entry/common.c:163
> > >  prepare_exit_to_usermode+0x180/0x1a0 arch/x86/entry/common.c:194
> > >  swapgs_restore_regs_and_return_to_usermode+0x0/0x40
> > >
> > > read to 0xffff88809fade9b0 of 4 bytes by task 7290 on cpu 1:
> > >  mem_cgroup_select_victim_node+0x92/0x3d0 mm/memcontrol.c:1675
> > >  try_to_free_mem_cgroup_pages+0x175/0x4c0 mm/vmscan.c:3376
> > >  reclaim_high.constprop.0+0xf7/0x140 mm/memcontrol.c:2349
> > >  mem_cgroup_handle_over_high+0x96/0x180 mm/memcontrol.c:2430
> > >  tracehook_notify_resume include/linux/tracehook.h:197 [inline]
> > >  exit_to_usermode_loop+0x20c/0x2c0 arch/x86/entry/common.c:163
> > >  prepare_exit_to_usermode+0x180/0x1a0 arch/x86/entry/common.c:194
> > >  swapgs_restore_regs_and_return_to_usermode+0x0/0x40
> > >
> > > mem_cgroup_select_victim_node() can be called concurrently which reads
> > > and modifies memcg->last_scanned_node without any synchrnonization. So,
> > > read and modify memcg->last_scanned_node with READ_ONCE()/WRITE_ONCE()
> > > to stop potential reordering.

Strictly speaking, READ_ONCE/WRITE_ONCE alone avoid various bad compiler
optimizations, including store tearing, load tearing, etc. This does not
add memory barriers to constrain memory ordering.  (If this code needs
some memory ordering guarantees w.r.t. previous loads/stores then this
alone is not enough.)

> > I am sorry but I do not understand the problem and the fix. Why does the
> > race happen and why does _ONCE fixes it? There is still no
> > synchronization. Do you want to prevent from memcg->last_scanned_node
> > reloading?
> >
> 
> The problem is memcg->last_scanned_node can read and modified
> concurrently. Though to me it seems like a tolerable race and not
> worth to add an explicit lock. My aim was to make KCSAN happy here to
> look elsewhere for the concurrency bugs. However I see that it might
> complain next on memcg->scan_nodes.

The plain concurrent reads/writes are a data race, which may manifest in
various undefined behaviour due to compiler optimizations. The _ONCE
will prevent these (KCSAN only reports data races).  Note that, "data
race" does not necessarily imply "race condition"; some data races are
race conditions (usually the more interesting bugs) -- but not *all*
data races are race conditions. If there is no race condition here that
warrants heavier synchronization (locking etc.), then this patch is all
that should be needed.

I can't comment on the rest.

Thanks,
-- Marco
