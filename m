Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA44C31E52
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 16:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3889921852
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 16:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ipVwsL7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfFOQLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 12:11:50 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46013 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbfFOQLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 12:11:50 -0400
Received: by mail-yw1-f67.google.com with SMTP id m16so2607717ywh.12
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2019 09:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XfBQUtQbUflzlL5gXoL56FmCXzvbbHidoYyXkMyKoQc=;
        b=ipVwsL7JBtwqQ60y57/QQVRgEPGE1O0zywJzxb44QwpSOZglzFLbY6eUJ1uzLB/sB2
         dcawchwcYNXnetJRQcSW8Qk6DyStfIITaWSTIJ7x0exPSGlxcHc8l1U7v2pcu/F1qfAP
         6lw3TEqIImIF2HpRXN0k3FwfDmPk3N1A8U7ErEPKUo7WETp2TI4S2i8bGuDISjPWspdh
         bQipDoDcKLUcRn4D8TaWICJy+BAVPGBPTFDymCrdHaPgXuZ9bC0uylHuqZTiscz2PlEF
         oY9VM5jTAj72SqVWgHNPndgHiKJq6ePR+vv1uaqiZT7sbppP/H7yNF5JNHzRSaBbMXK9
         NwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XfBQUtQbUflzlL5gXoL56FmCXzvbbHidoYyXkMyKoQc=;
        b=OXAkPaW+Cx30w4VnQoJCQXaubZO3djF4T3VVGmCBWwdXzpmlNSy84slbX3EMzNU34R
         8ASeTuzO2Z7jaXcuUwWO/2hM7YH8+3mLccP7XuJH6/TFhYrDm5b8d31sGGdsWSvr3mZ1
         4kB/bb2+sl7x+uzlZe8mnrxXkrODk7LAolNdwNdCUlE1gWuvyTPHaz3+lAsDjxWmZhSZ
         BYWostoRv2e5xhxcWLF/XSpB6hK6Ke1oPif1Vh/58zwbUeMXw6CPXJecwEIY4SIGaUB6
         lWtnM2LIM4V6TXAuY9mA7zApaposMns6G0zOVSIw/uyjR5Ey5mBcF/yitLwNiizSnBv5
         si2g==
X-Gm-Message-State: APjAAAX94SgiF1HHCy92P/O5MxYilg7SclFSAOrHMmrFbNp+XL2au2dQ
        +uKhgdmgOc71yo7fk2KGp72L52KM4ZKLD6sGuOc5vw==
X-Google-Smtp-Source: APXvYqxqCQwnTjswkopI4Ctw1mHXH/vjwmIBUTDY33SGw8OLfcEmXYLIjHt/aW2ylM/efT8mCZZXjs/edDhY0sis1II=
X-Received: by 2002:a81:90e:: with SMTP id 14mr13071232ywj.4.1560615108857;
 Sat, 15 Jun 2019 09:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004143a5058b526503@google.com> <CALvZod72=KuBZkSd0ey5orJFGFpwx462XY=cZvO3NOXC0MogFw@mail.gmail.com>
 <20190615134955.GA28441@dhcp22.suse.cz>
In-Reply-To: <20190615134955.GA28441@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sat, 15 Jun 2019 09:11:37 -0700
Message-ID: <CALvZod4hT39PfGt9Ohj+g77om5=G0coHK=+G1=GKcm-PowkXsw@mail.gmail.com>
Subject: Re: general protection fault in oom_unkillable_task
To:     Michal Hocko <mhocko@kernel.org>
Cc:     syzbot <syzbot+d0fc9d3c166bc5e4a94b@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        yuzhoujian@didichuxing.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 15, 2019 at 6:50 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 14-06-19 20:15:31, Shakeel Butt wrote:
> > On Fri, Jun 14, 2019 at 6:08 PM syzbot
> > <syzbot+d0fc9d3c166bc5e4a94b@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    3f310e51 Add linux-next specific files for 20190607
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=15ab8771a00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=5d176e1849bbc45
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=d0fc9d3c166bc5e4a94b
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > >
> > > Unfortunately, I don't have any reproducer for this crash yet.
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+d0fc9d3c166bc5e4a94b@syzkaller.appspotmail.com
> > >
> > > kasan: CONFIG_KASAN_INLINE enabled
> > > kasan: GPF could be caused by NULL-ptr deref or user memory access
> > > general protection fault: 0000 [#1] PREEMPT SMP KASAN
> > > CPU: 0 PID: 28426 Comm: syz-executor.5 Not tainted 5.2.0-rc3-next-20190607
> > > #11
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > Google 01/01/2011
> > > RIP: 0010:__read_once_size include/linux/compiler.h:194 [inline]
> > > RIP: 0010:has_intersects_mems_allowed mm/oom_kill.c:84 [inline]
> >
> > It seems like oom_unkillable_task() is broken for memcg OOMs. It
> > should not be calling has_intersects_mems_allowed() for memcg OOMs.
>
> You are right. It doesn't really make much sense to check for the NUMA
> policy/cpusets when the memcg oom is NUMA agnostic. Now that I am
> looking at the code then I am really wondering why do we even call
> oom_unkillable_task from oom_badness. proc_oom_score shouldn't care
> about NUMA either.
>
> In other words the following should fix this unless I am missing
> something (task_in_mem_cgroup seems to be a relict from before the group
> oom handling). But please note that I am still not fully operation and
> laying in the bed.
>

Yes, we need something like this but not exactly.

> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 5a58778c91d4..43eb479a5dc7 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -161,8 +161,8 @@ static bool oom_unkillable_task(struct task_struct *p,
>                 return true;
>
>         /* When mem_cgroup_out_of_memory() and p is not member of the group */
> -       if (memcg && !task_in_mem_cgroup(p, memcg))
> -               return true;
> +       if (memcg)
> +               return false;

This will break the dump_tasks() usage of oom_unkillable_task(). We
can change dump_tasks() to traverse processes like
mem_cgroup_scan_tasks() for memcg OOMs.

>
>         /* p may not have freeable memory in nodemask */
>         if (!has_intersects_mems_allowed(p, nodemask))
> @@ -318,7 +318,7 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
>         struct oom_control *oc = arg;
>         unsigned long points;
>
> -       if (oom_unkillable_task(task, NULL, oc->nodemask))
> +       if (oom_unkillable_task(task, oc->memcg, oc->nodemask))
>                 goto next;
>
> --
> Michal Hocko
> SUSE Labs
