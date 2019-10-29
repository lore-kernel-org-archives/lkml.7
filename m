Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78EECA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A1920830
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r87nwfKh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731933AbfJ2Srq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 14:47:46 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41434 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729528AbfJ2Srp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 14:47:45 -0400
Received: by mail-ot1-f68.google.com with SMTP id 94so10674823oty.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 11:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8iGjeZAGX1vwWCY7RD/pFhK70PaPvjQNMWEcOJ4f58k=;
        b=r87nwfKhRmusQ2AI4jfCx2coti/fu4ZQEHQ3FD0iPQABes7vumfaAmDTeItgrzkWgf
         zPzBAwkyKboPREsnkiS7JZwOYYhkXpnmwGAi6kqPONQ3+47CISJJjViFhmgOBLi/QQ6/
         heF7AbCxS9TTGYlvWzyMN3Xtmw1rnRvj9IabE8GQcqvkO0FVaof9+VGeSOvAsOYZqZyR
         hM9RZMjycn3F9mtgj/By6XxuTO6gbzocaENO765b5d/XApcOB5KOEUKIphu1Ui+8d8JN
         d4CAXFq5fx03GitosTDM7SM/AqpG01mRM38Nj0NRz0DjHH3q32eb5ke17m7SmLXe5rvm
         ZsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8iGjeZAGX1vwWCY7RD/pFhK70PaPvjQNMWEcOJ4f58k=;
        b=UZdvLU3hWuXgd86yOhjnlBuQaomO0+K6QVOmoWSnND4tOt5N3h+dns6kkr+h9sxwzR
         rH1NFJU5hHLAHPtc8gNLj3XdoJBx9LuvpKNq4zwzS5tO/Ew1MiJG+H7a03B1H7dFbxyZ
         cCXomcMIN/W3o2VcFKeRZTbIOQ+8+XbGb8J1NAnOUXhojFucRZRS/ToIes9pdZxKaU/V
         KJVzJJ7+VIF00ZgK5AXMAgL+iXT0GbZ1zCLM3IEsU/S9smVeK/FJs4rFlUDgxNVU878E
         jFnuHk6YK1LUsNuKuMODrPcshY0/LTdDDAGzTU9m7xfJpomIlLtm9C/HRvOBk3Vgme8g
         Ui4g==
X-Gm-Message-State: APjAAAXGz66HPD9dV3ZyV9Itca33WqrsIXl3AI+qDH6DeSHiOESDuV+A
        UGm5jkt+3Dq1aQixM9nSGPkfSopwEUixuDXcrMeBnw==
X-Google-Smtp-Source: APXvYqxQm5uHFCWI33sMMjsd6j1hNQuGfWAFpKsDd478m9r7cbp5gNJOcZJB7olXWnLZqhrKZ5sp543en770ifApaNM=
X-Received: by 2002:a9d:5e10:: with SMTP id d16mr17724258oti.191.1572374863908;
 Tue, 29 Oct 2019 11:47:43 -0700 (PDT)
MIME-Version: 1.0
References: <20191029005405.201986-1-shakeelb@google.com> <20191029090347.GG31513@dhcp22.suse.cz>
 <CALvZod648GRvjd_LqViFzLRwxnzSrLZzjaNBOJju4xkDQkvrXw@mail.gmail.com> <20191029183428.GA38233@cmpxchg.org>
In-Reply-To: <20191029183428.GA38233@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 29 Oct 2019 11:47:32 -0700
Message-ID: <CALvZod4HXGqa_obMTT_UGWnYTvaGutmF3_Xcg79URS1A5gR+xw@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: fix data race in mem_cgroup_select_victim_node
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Greg Thelen <gthelen@google.com>,
        syzbot+13f93c99c06988391efe@syzkaller.appspotmail.com,
        elver@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 11:34 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Tue, Oct 29, 2019 at 11:09:29AM -0700, Shakeel Butt wrote:
> > +Marco
> >
> > On Tue, Oct 29, 2019 at 2:03 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Mon 28-10-19 17:54:05, Shakeel Butt wrote:
> > > > Syzbot reported the following bug:
> > > >
> > > > BUG: KCSAN: data-race in mem_cgroup_select_victim_node / mem_cgroup_select_victim_node
> > > >
> > > > write to 0xffff88809fade9b0 of 4 bytes by task 8603 on cpu 0:
> > > >  mem_cgroup_select_victim_node+0xb5/0x3d0 mm/memcontrol.c:1686
> > > >  try_to_free_mem_cgroup_pages+0x175/0x4c0 mm/vmscan.c:3376
> > > >  reclaim_high.constprop.0+0xf7/0x140 mm/memcontrol.c:2349
> > > >  mem_cgroup_handle_over_high+0x96/0x180 mm/memcontrol.c:2430
> > > >  tracehook_notify_resume include/linux/tracehook.h:197 [inline]
> > > >  exit_to_usermode_loop+0x20c/0x2c0 arch/x86/entry/common.c:163
> > > >  prepare_exit_to_usermode+0x180/0x1a0 arch/x86/entry/common.c:194
> > > >  swapgs_restore_regs_and_return_to_usermode+0x0/0x40
> > > >
> > > > read to 0xffff88809fade9b0 of 4 bytes by task 7290 on cpu 1:
> > > >  mem_cgroup_select_victim_node+0x92/0x3d0 mm/memcontrol.c:1675
> > > >  try_to_free_mem_cgroup_pages+0x175/0x4c0 mm/vmscan.c:3376
> > > >  reclaim_high.constprop.0+0xf7/0x140 mm/memcontrol.c:2349
> > > >  mem_cgroup_handle_over_high+0x96/0x180 mm/memcontrol.c:2430
> > > >  tracehook_notify_resume include/linux/tracehook.h:197 [inline]
> > > >  exit_to_usermode_loop+0x20c/0x2c0 arch/x86/entry/common.c:163
> > > >  prepare_exit_to_usermode+0x180/0x1a0 arch/x86/entry/common.c:194
> > > >  swapgs_restore_regs_and_return_to_usermode+0x0/0x40
> > > >
> > > > mem_cgroup_select_victim_node() can be called concurrently which reads
> > > > and modifies memcg->last_scanned_node without any synchrnonization. So,
> > > > read and modify memcg->last_scanned_node with READ_ONCE()/WRITE_ONCE()
> > > > to stop potential reordering.
> > >
> > > I am sorry but I do not understand the problem and the fix. Why does the
> > > race happen and why does _ONCE fixes it? There is still no
> > > synchronization. Do you want to prevent from memcg->last_scanned_node
> > > reloading?
> > >
> >
> > The problem is memcg->last_scanned_node can read and modified
> > concurrently. Though to me it seems like a tolerable race and not
> > worth to add an explicit lock. My aim was to make KCSAN happy here to
> > look elsewhere for the concurrency bugs. However I see that it might
> > complain next on memcg->scan_nodes.
> >
> > Now taking a step back, I am questioning the whole motivation behind
> > mem_cgroup_select_victim_node(). Since we pass ZONELIST_FALLBACK
> > zonelist to the reclaimer, the shrink_node will be called for all
> > potential nodes. Also we don't short circuit the traversal of
> > shrink_node for all nodes on nr_reclaimed and we scan (size_on_node >>
> > priority) for all nodes, I don't see the reason behind having round
> > robin order of node traversal.
>
> It's actually only very recently that we don't bail out of the reclaim
> loop anymore - if I'm not missing anything, it was only 1ba6fc9af35b
> ("mm: vmscan: do not share cgroup iteration between reclaimers") that
> removed the last bailout condition on sc->nr_reclaimed.
>
> > I am thinking of removing the whole mem_cgroup_select_victim_node()
> > heuristic. Please let me know if there are any objections.
>
> In the current state, I don't see any reason to keep it, either. We
> can always just start the zonelist walk from the current node.
>
> A nice cleanup, actually. Good catch!

Thanks, I will follow up with the removal of this heuristic.
