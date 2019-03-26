Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D67C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9EB20866
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732430AbfCZRdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:33:14 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43575 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732406AbfCZRdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:33:11 -0400
Received: by mail-oi1-f195.google.com with SMTP id 67so10541542oif.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 10:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DLuJ0wj4n+0ibLZZrTu59HKM35jmmkFdA9L8eoJFKoI=;
        b=DMLEWF6zC6/ibMk1LzlT+q8t++w/QByoFKd2SQB/tvNZzjlwjnflaB/8kmZDq75/NN
         bl6F8RguWM8/GGRumtnsFAoor4Am43I6b8z1KRVA6riu1bC+p9hbX/zxzYTQGK5ixUvH
         U0wSDmNbq3Arpr6DCuZfAydEHdv/bDmFOUTJby985VQwwq1bHRXGTgk0TfHsQ/4zfA+K
         Fxfu+5F0gBfMOKwcMrW4mvXcMR/Ypx3EBhELDV/QXJEz0ljmgRgqXBfh79hQKWt0f7Un
         v5RL5gJc08BtlOiySndhCX6N8/NTNnC3cEY/TmVuwkialkCjh2mglUBLJLyz4frxa6iW
         zR7g==
X-Gm-Message-State: APjAAAXwUJ9WCujQ1VrfXy9RGOu+/oWsUGzSVMnctJe8CGcOmkHJYvVO
        VjzQf2m6XO/MgV4uFqDRc0hK6jMTy2BBGtkFYBvCpqj0Spo=
X-Google-Smtp-Source: APXvYqwIuytPfhe+n/RkAPtIMrXJZ4YLCKPK2Wow3k34QLxB1AIGO91xLdgpHSYF7/tcPYr80iYOFXbEGKFHsXYuLJk=
X-Received: by 2002:aca:af56:: with SMTP id y83mr16730188oie.17.1553621590480;
 Tue, 26 Mar 2019 10:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <1551920088-30685-1-git-send-email-jsavitz@redhat.com>
 <CAL1p7m5e6HwFQVur+XVKWnpoMRPg0qFs0QkJ_5mnkUoxG_gwMw@mail.gmail.com> <CAL1p7m7n7+wwHsrxywnUYpOKvT6N+5ewCjaZXLPLCsBk+t+oNw@mail.gmail.com>
In-Reply-To: <CAL1p7m7n7+wwHsrxywnUYpOKvT6N+5ewCjaZXLPLCsBk+t+oNw@mail.gmail.com>
From:   Joel Savitz <jsavitz@redhat.com>
Date:   Tue, 26 Mar 2019 13:32:59 -0400
Message-ID: <CAL1p7m6e8KgfM79+biL0HPRofnaghJmrUdX6zX4b0ef=cYbEdg@mail.gmail.com>
Subject: Re: [PATCH] cpuset: restore sanity to cpuset_cpus_allowed_fallback()
To:     linux-kernel@vger.kernel.org
Cc:     Li Zefan <lizefan@huawei.com>, cgroups@vger.kernel.org,
        Philip Auld <pauld@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to add cc's... my bad.

Best,
Joel Savitz

On Tue, Mar 26, 2019 at 1:31 PM Joel Savitz <jsavitz@redhat.com> wrote:
>
> Ping!
>
> Does anyone have any comments or concerns about this patch?
>
> Best,
> Joel Savitz
>
> Best,
> Joel Savitz
>
>
> On Thu, Mar 7, 2019 at 9:42 AM Joel Savitz <jsavitz@redhat.com> wrote:
> >
> > On Wed, Mar 6, 2019 at 7:55 PM Joel Savitz <jsavitz@redhat.com> wrote:
> > >
> > > If a process is limited by taskset (i.e. cpuset) to only be allowed to
> > > run on cpu N, and then cpu N is offlined via hotplug, the process will
> > > be assigned the current value of its cpuset cgroup's effective_cpus field
> > > in a call to do_set_cpus_allowed() in cpuset_cpus_allowed_fallback().
> > > This argument's value does not makes sense for this case, because
> > > task_cs(tsk)->effective_cpus is modified by cpuset_hotplug_workfn()
> > > to reflect the new value of cpu_active_mask after cpu N is removed from
> > > the mask. While this may make sense for the cgroup affinity mask, it
> > > does not make sense on a per-task basis, as a task that was previously
> > > limited to only be run on cpu N will be limited to every cpu _except_ for
> > > cpu N after it is offlined/onlined via hotplug.
> > >
> > > Pre-patch behavior:
> > >
> > >         $ grep Cpus /proc/$$/status
> > >         Cpus_allowed:   ff
> > >         Cpus_allowed_list:      0-7
> > >
> > >         $ taskset -p 4 $$
> > >         pid 19202's current affinity mask: f
> > >         pid 19202's new affinity mask: 4
> > >
> > >         $ grep Cpus /proc/self/status
> > >         Cpus_allowed:   04
> > >         Cpus_allowed_list:      2
> > >
> > >         # echo off > /sys/devices/system/cpu/cpu2/online
> > >         $ grep Cpus /proc/$$/status
> > >         Cpus_allowed:   0b
> > >         Cpus_allowed_list:      0-1,3
> > >
> > >         # echo on > /sys/devices/system/cpu/cpu2/online
> > >         $ grep Cpus /proc/$$/status
> > >         Cpus_allowed:   0b
> > >         Cpus_allowed_list:      0-1,3
> > >
> > > On a patched system, the final grep produces the following
> > > output instead:
> > >
> > >         $ grep Cpus /proc/$$/status
> > >         Cpus_allowed:   ff
> > >         Cpus_allowed_list:      0-7
> > >
> > > This patch changes the above behavior by instead simply resetting the mask
> > > to cpu_possible_mask.
> > >
> > > Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> > > ---
> > >  kernel/cgroup/cpuset.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > > index 479743db6c37..5f65a2167bdf 100644
> > > --- a/kernel/cgroup/cpuset.c
> > > +++ b/kernel/cgroup/cpuset.c
> > > @@ -3243,7 +3243,7 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
> > >  void cpuset_cpus_allowed_fallback(struct task_struct *tsk)
> > >  {
> > >         rcu_read_lock();
> > > -       do_set_cpus_allowed(tsk, task_cs(tsk)->effective_cpus);
> > > +       do_set_cpus_allowed(tsk, cpu_possible_mask);
> > >         rcu_read_unlock();
> > >
> > >         /*
> > > --
> > > 2.20.1
> > >
