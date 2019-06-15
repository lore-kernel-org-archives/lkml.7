Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE74C31E50
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 18:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A3C2184B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 18:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DAZVeS1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfFOSuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 14:50:44 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42293 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfFOSuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 14:50:44 -0400
Received: by mail-yw1-f68.google.com with SMTP id s5so2758188ywd.9
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2019 11:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hsw6F/JD0JWJFl9lCNc3fmoZkyiWfJZZGwD/Q8JM96E=;
        b=DAZVeS1q+rG3Nj2CWnwq7DHcMWuAHnWUfvQj4jBHVPsTl5nhWKrgVhJUUzuaF0ESvk
         9eZvFxBsHqnD/OxOhv8KPKD7qenAUU9QH6cyxZ8OswyYoUAg0VAY/YeSsBUHNUyHuJR5
         cTtHZLZJeL3xDglL9EloZvp6FX+pnNYiVLAmZRhrm1DLObhvU9lqguPMwTtsaC+IJAQd
         bh8Z4kq7Sn3K9OphUToOxMdmVxkx+d1IYhPE/ifulxO3wRLtFK3aPQIEx7qhXPgBFKVx
         gBmTgFFfTemmMa9Zgtk+McMQFRqyf86pW/q2zkP6H4vhzPb472GPRtkEjLLVoAusqZBJ
         3KQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hsw6F/JD0JWJFl9lCNc3fmoZkyiWfJZZGwD/Q8JM96E=;
        b=BocMnPvQodn4qfDE6Vu/XI6asKoappIhG7Wgzl4C7MEv4+jQD6u9BKGRmFeqw1XfZA
         6HO2Agr7fGBD3RP4DZjLD2qPV0AICZtjzhaT1E54CCCSlX55+GBs0HttfBScDi7jU59q
         K8x9MFdXIUTzOnkTuc5yWkkT7WqlzirSLX+znWEdb3XQyxSWBd/K5PtFGxDvWPX36DCc
         rzjtME2lUxONE/hCKXcsR6FPwnX9NNqxDSdDO6okxv/3aovjbDDCAOAeSonajeq6Z2EM
         fSBIF4JK9wh9BN3db6gPJ5rDqakL6wODbkyWhk7oLeqClkUGZy3H4F/pdCpulHZI7Sn7
         Qf+g==
X-Gm-Message-State: APjAAAX4W0Urni9wrx+0pl+M1fHLKwLI6t+HuCUZOhSlRNHbpS9i3LAA
        RBrc5MRbS1uqd5Tj3Az2LH66mJcoOPZyajeUAkAcjw==
X-Google-Smtp-Source: APXvYqxF93Zv7RM/vG5muLgCFR7l8abVBfZg9loqw5+gonEsrR4vX5i/9gEWNuseLjVXSacAq3q/fuV7TpoQYxUOrH0=
X-Received: by 2002:a81:3a0f:: with SMTP id h15mr56987138ywa.34.1560624643001;
 Sat, 15 Jun 2019 11:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004143a5058b526503@google.com> <CALvZod72=KuBZkSd0ey5orJFGFpwx462XY=cZvO3NOXC0MogFw@mail.gmail.com>
 <20190615134955.GA28441@dhcp22.suse.cz> <CALvZod4hT39PfGt9Ohj+g77om5=G0coHK=+G1=GKcm-PowkXsw@mail.gmail.com>
 <5bb1fe5d-f0e1-678b-4f64-82c8d5d81f61@i-love.sakura.ne.jp>
In-Reply-To: <5bb1fe5d-f0e1-678b-4f64-82c8d5d81f61@i-love.sakura.ne.jp>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sat, 15 Jun 2019 11:50:31 -0700
Message-ID: <CALvZod4etSv9Hv4UD=E6D7U4vyjCqhxQgq61AoTUCd+VubofFg@mail.gmail.com>
Subject: Re: general protection fault in oom_unkillable_task
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Michal Hocko <mhocko@kernel.org>,
        syzbot <syzbot+d0fc9d3c166bc5e4a94b@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        yuzhoujian@didichuxing.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 15, 2019 at 9:49 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/06/16 1:11, Shakeel Butt wrote:
> > On Sat, Jun 15, 2019 at 6:50 AM Michal Hocko <mhocko@kernel.org> wrote:
> >> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> >> index 5a58778c91d4..43eb479a5dc7 100644
> >> --- a/mm/oom_kill.c
> >> +++ b/mm/oom_kill.c
> >> @@ -161,8 +161,8 @@ static bool oom_unkillable_task(struct task_struct *p,
> >>                 return true;
> >>
> >>         /* When mem_cgroup_out_of_memory() and p is not member of the group */
> >> -       if (memcg && !task_in_mem_cgroup(p, memcg))
> >> -               return true;
> >> +       if (memcg)
> >> +               return false;
> >
> > This will break the dump_tasks() usage of oom_unkillable_task(). We
> > can change dump_tasks() to traverse processes like
> > mem_cgroup_scan_tasks() for memcg OOMs.
>
> While dump_tasks() traverses only each thread group, mem_cgroup_scan_tasks()
> traverses each thread.

I think mem_cgroup_scan_tasks() traversing threads is not intentional
and css_task_iter_start in it should use CSS_TASK_ITER_PROCS as the
oom killer only cares about the processes or more specifically
mm_struct (though two different thread groups can have same mm_struct
but that is fine).

> To avoid printk()ing all threads in a thread group,
> moving that check to
>
>         if (memcg && !task_in_mem_cgroup(p, memcg))
>                 continue;
>
> in dump_tasks() is better?
>
> >
> >>
> >>         /* p may not have freeable memory in nodemask */
> >>         if (!has_intersects_mems_allowed(p, nodemask))
>
