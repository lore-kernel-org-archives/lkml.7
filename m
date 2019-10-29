Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D038CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DFE321479
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="xUtlmgfT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbfJ2Sec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 14:34:32 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37016 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfJ2Seb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 14:34:31 -0400
Received: by mail-qt1-f195.google.com with SMTP id g50so21692644qtb.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 11:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uIU7OLCPQwf11UO7remUH85e2MdSUd0Df/No5kThl+Q=;
        b=xUtlmgfTX/z8VFSs9NdfjYD2h7uC3bxMX9c2AFApAHuLU7LT6V7ubs5uXk74wKkkx/
         PJ2uLnbqAvx+8TOq/4JkQXCvAYH/t2uV1hkfDxQQv4ceHZH7Ta/AjZmchGgfTanNnlp5
         NtrxxujwR8dWyTNdCfJSiSCza6w//XxLj2TpNNhUvb8PYNxuf7QXmDzvi7i+ppvNcF2G
         Y//gF7lM27cJmeZ9XiwN2vLDy0qpLyjKuI6ydePXHTokzd0Wa9uzNwMCIAebJUNtY7e4
         mo4P1zqBlD5wVxm/X3fGz8j9J9XPnHJRFFY3NYkb+aB0UfDSVhLMAK8uAJiD1a1xHjlm
         xwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uIU7OLCPQwf11UO7remUH85e2MdSUd0Df/No5kThl+Q=;
        b=jS6L3hEFgMdSQbKHlBJYm4T9KjOv9kITYHTHE9pX4UkQcyeYM8eoP26gq3L8b4UX3v
         c1VmjEAqKBQ5I7yZ88vk5otcCDxKCUSoQV9US+F5kEYBC1/ipT25p8HPXpghppHaNLk4
         wZ2gIM+WNO3v9VfyPjm85I/7tg6LznPw24+4x/k92j2ndR+Jz5fHaIzKYKHzZR6G1MNY
         rWlW4AkNzanOs9ijMw64QeFoPxsqPvvPXIz2LfeseasFZ5doaXX8t4Mfsfh4llj0mn7o
         T3/0nP8yMIm8jchxBOrXrOAASI2jBmklIKNchR3TkUPZ60MELXjaTSNt1ddsVgnJhU9/
         dlFw==
X-Gm-Message-State: APjAAAUEj4hfNk5EgKEPJMsDMWoIn2NDcUpjAt1wPO70WiUkUJhdta6Q
        /ZnNb0vPo6nLB+TVDOY165N+OQ==
X-Google-Smtp-Source: APXvYqz9kg4EYQY0RLUVbwPGIGxrPWbJ4IxQP3b9gI4g2nGc6loAjVWiGAcg76RCo1vI30uYda0BWw==
X-Received: by 2002:a05:6214:803:: with SMTP id df3mr24777703qvb.215.1572374070331;
        Tue, 29 Oct 2019 11:34:30 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::7081])
        by smtp.gmail.com with ESMTPSA id g25sm9088353qtc.90.2019.10.29.11.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 11:34:29 -0700 (PDT)
Date:   Tue, 29 Oct 2019 14:34:28 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Greg Thelen <gthelen@google.com>,
        syzbot+13f93c99c06988391efe@syzkaller.appspotmail.com,
        elver@google.com
Subject: Re: [PATCH] mm: memcontrol: fix data race in
 mem_cgroup_select_victim_node
Message-ID: <20191029183428.GA38233@cmpxchg.org>
References: <20191029005405.201986-1-shakeelb@google.com>
 <20191029090347.GG31513@dhcp22.suse.cz>
 <CALvZod648GRvjd_LqViFzLRwxnzSrLZzjaNBOJju4xkDQkvrXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod648GRvjd_LqViFzLRwxnzSrLZzjaNBOJju4xkDQkvrXw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 11:09:29AM -0700, Shakeel Butt wrote:
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
> >
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
> 
> Now taking a step back, I am questioning the whole motivation behind
> mem_cgroup_select_victim_node(). Since we pass ZONELIST_FALLBACK
> zonelist to the reclaimer, the shrink_node will be called for all
> potential nodes. Also we don't short circuit the traversal of
> shrink_node for all nodes on nr_reclaimed and we scan (size_on_node >>
> priority) for all nodes, I don't see the reason behind having round
> robin order of node traversal.

It's actually only very recently that we don't bail out of the reclaim
loop anymore - if I'm not missing anything, it was only 1ba6fc9af35b
("mm: vmscan: do not share cgroup iteration between reclaimers") that
removed the last bailout condition on sc->nr_reclaimed.

> I am thinking of removing the whole mem_cgroup_select_victim_node()
> heuristic. Please let me know if there are any objections.

In the current state, I don't see any reason to keep it, either. We
can always just start the zonelist walk from the current node.

A nice cleanup, actually. Good catch!
