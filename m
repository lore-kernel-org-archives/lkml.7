Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2912EFC6194
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 02:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC8E2187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 02:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V65ECVS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733072AbfKGCWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 21:22:00 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35247 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfKGCWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 21:22:00 -0500
Received: by mail-ot1-f65.google.com with SMTP id z6so679448otb.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 18:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AVyrEZrni1dLrbXqEw5bhMGop7jClZ23YRYHr75eQxw=;
        b=V65ECVS3+COSAS/DOQc5qkG+8WZzTosTbxkmjzhGw5VFI3rzHSlYUgi2/d1y68P+9/
         puLYgzMXrY9hY2K5iJ0SfXEhG9VsdIRofgzgB9Je0NyGiQlTdnmQjbIeVS7qnJTPrTTe
         SsFYBgeREsXiaEORnADtojbuXUXMgUPF9BIIaF07+12LEUyIzOwe2Zxa/ZBbbJW9ThfT
         CAENC1e2BftSC5YEI8uaQztCnlUUSSDl/rlBF5zIhCDVpcXQx2Mvd6yWCpj8aU+kyHvb
         u7bpH6gK+IrBleSMeMeV3U9AHspElVXqJTWmdF+jjKVtA9QNEQzZVY/0zPrILtv9868y
         FnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AVyrEZrni1dLrbXqEw5bhMGop7jClZ23YRYHr75eQxw=;
        b=AIPggGtrvMmQQAxocQdbBU/BCOPrlbYgDqS7GPYqF5Bgo1WA0UEIUhW08TJzzmF6qM
         OilIbIGgQpiHx0ZwlewvMep7ccjEqPu3IqF+ytcddSJkycTs2DGgBhfra45asYCGeMrg
         Jb4EUv0yntQz3MQdrChGZDqRJu/EJndSS27xP7+0FynNg2CCOyTmt/paXOQ1TeaooG1s
         MpEYNqp31NqOUPxPcpjvZJ3IczTzwlrMQFqooExEKLIPHI11sz0t/Aq1KjWNrKhXPb1V
         sJYn63gGK9I4L+BbQEkWjlmStUSU6/Q6JkU6qCyEdPAdrxPGq2ohJaVlTgBf89zn8aFs
         R0pg==
X-Gm-Message-State: APjAAAVVIJns4mTXjJyJupVQTZ5Nnx9vxtSGezYAsGtD5Ykyd6GcIeDV
        gR/atc5ULvrNaMiVfyPF8Vm2o657lHF+ApsEg4OktA==
X-Google-Smtp-Source: APXvYqwEClADNOQli3g121/B+JxWy+IKyrtdZdVs5m3edDk+Nfij0PsJRgg1s6HN4oSegZHs0zljL+56e/WFhP7gsvE=
X-Received: by 2002:a9d:5e10:: with SMTP id d16mr794891oti.191.1573093319136;
 Wed, 06 Nov 2019 18:21:59 -0800 (PST)
MIME-Version: 1.0
References: <20191106225131.3543616-1-guro@fb.com> <20191107002204.GA96548@cmpxchg.org>
 <CALvZod5=g230Lwnjh7qXyLkoknZJpOiv-nLJ4XYC9rSSzL=e6w@mail.gmail.com> <20191107014307.GA1158@castle.dhcp.thefacebook.com>
In-Reply-To: <20191107014307.GA1158@castle.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 6 Nov 2019 18:21:48 -0800
Message-ID: <CALvZod43v4Xx6YzhN8ku3=YrPVGJoK-8mUejg1f29a1jxL1-ug@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: memcg: switch to css_tryget() in get_mem_cgroup_from_mm()
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 5:43 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Wed, Nov 06, 2019 at 05:25:26PM -0800, Shakeel Butt wrote:
> > On Wed, Nov 6, 2019 at 4:22 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > On Wed, Nov 06, 2019 at 02:51:30PM -0800, Roman Gushchin wrote:
> > > > We've encountered a rcu stall in get_mem_cgroup_from_mm():
> > > >
> > > >  rcu: INFO: rcu_sched self-detected stall on CPU
> > > >  rcu: 33-....: (21000 ticks this GP) idle=6c6/1/0x4000000000000002 softirq=35441/35441 fqs=5017
> > > >  (t=21031 jiffies g=324821 q=95837) NMI backtrace for cpu 33
> > > >  <...>
> > > >  RIP: 0010:get_mem_cgroup_from_mm+0x2f/0x90
> > > >  <...>
> > > >  __memcg_kmem_charge+0x55/0x140
> > > >  __alloc_pages_nodemask+0x267/0x320
> > > >  pipe_write+0x1ad/0x400
> > > >  new_sync_write+0x127/0x1c0
> > > >  __kernel_write+0x4f/0xf0
> > > >  dump_emit+0x91/0xc0
> > > >  writenote+0xa0/0xc0
> > > >  elf_core_dump+0x11af/0x1430
> > > >  do_coredump+0xc65/0xee0
> > > >  ? unix_stream_sendmsg+0x37d/0x3b0
> > > >  get_signal+0x132/0x7c0
> > > >  do_signal+0x36/0x640
> > > >  ? recalc_sigpending+0x17/0x50
> > > >  exit_to_usermode_loop+0x61/0xd0
> > > >  do_syscall_64+0xd4/0x100
> > > >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > >
> > > > The problem is caused by an exiting task which is associated with
> > > > an offline memcg. We're iterating over and over in the
> > > > do {} while (!css_tryget_online()) loop, but obviously the memcg won't
> > > > become online and the exiting task won't be migrated to a live memcg.
> > > >
> > > > Let's fix it by switching from css_tryget_online() to css_tryget().
> > > >
> > > > As css_tryget_online() cannot guarantee that the memcg won't go
> > > > offline, the check is usually useless, except some rare cases
> > > > when for example it determines if something should be presented
> > > > to a user.
> > > >
> > > > A similar problem is described by commit 18fa84a2db0e ("cgroup: Use
> > > > css_tryget() instead of css_tryget_online() in task_get_css()").
> > > >
> > > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > > Cc: stable@vger.kernel.org
> > > > Cc: Tejun Heo <tj@kernel.org>
> > >
> > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > >
> > > The bug aside, it doesn't matter whether the cgroup is online for the
> > > callers. It used to matter when offlining needed to evacuate all
> > > charges from the memcg, and so needed to prevent new ones from showing
> > > up, but we don't care now.
> >
> > Should get_mem_cgroup_from_current() and get_mem_cgroup_from_page() be
> > switched to css_tryget() as well then?
>
> In those case it can't cause a rcu stall, so it's not a so urgent.
> But you are right, we should probably do the same here. I'll look
> at all remaining callers and prepare the patchset.
>
> I'll also probably rename it to css_tryget_if_online() to make obvious
> that it doesn't hold the cgroup from being onlined.
>

SGTM
