Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3CFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3678A206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbfCZRbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:31:35 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36454 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfCZRbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:31:35 -0400
Received: by mail-ot1-f67.google.com with SMTP id o74so12259940ota.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 10:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=qoGR01Blsxr1nYNpNinV2ykk7p6CnofcdlpSEMZSsw0=;
        b=bjYSXQAB/WrMPF7v6N08WTrj6sa7+V5VG2S7yxx/vLlVa7FXVqnHX+jlWCqNs7F8ew
         8ZRbvTQXv3EfIIC0AqkW0A8m0gg5/2WcFxQDSn9HaYej+J+DMhvtXNr63PNrqeIY6i9Z
         rVIRCOHK513YmiQO8O4wa8SBEbxanX16mDX5yXyFa9dPhxpLlmNcdc6FXsFLRRcSOoJp
         MXQgMsr/X8ZslotcpqnR1h/+KGrs4l//Nrw+I1SpPtj7kCALz3SAqHqvSaSWc8UuVIUx
         pV82aOf5od+mwpORYeccdU2hlASzN/22e2cqfC1RxFrgD00vE/PQxMZr5jejhU/ZuCqA
         pz0w==
X-Gm-Message-State: APjAAAW/Tv8trayujYvfQlT+v/BPENdYJ9IvaEHa+ev0M4Kf7cSaEi3t
        mmEFYlTxnPeOvlAGMGzfeRQ9SQayle0xjuQJlLqfM5Tpfl0=
X-Google-Smtp-Source: APXvYqwvzQffG0wFTwsG2mOM0Jqaprx/5hF5vX9ez9DakMnhc2a+RMog4L/89ZPyMG9uy6eVOPNX5GrNHayijVbkoEY=
X-Received: by 2002:a9d:5a02:: with SMTP id v2mr13447905oth.70.1553621494248;
 Tue, 26 Mar 2019 10:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <1551920088-30685-1-git-send-email-jsavitz@redhat.com> <CAL1p7m5e6HwFQVur+XVKWnpoMRPg0qFs0QkJ_5mnkUoxG_gwMw@mail.gmail.com>
In-Reply-To: <CAL1p7m5e6HwFQVur+XVKWnpoMRPg0qFs0QkJ_5mnkUoxG_gwMw@mail.gmail.com>
From:   Joel Savitz <jsavitz@redhat.com>
Date:   Tue, 26 Mar 2019 13:31:23 -0400
Message-ID: <CAL1p7m7n7+wwHsrxywnUYpOKvT6N+5ewCjaZXLPLCsBk+t+oNw@mail.gmail.com>
Subject: Re: [PATCH] cpuset: restore sanity to cpuset_cpus_allowed_fallback()
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping!

Does anyone have any comments or concerns about this patch?

Best,
Joel Savitz

Best,
Joel Savitz


On Thu, Mar 7, 2019 at 9:42 AM Joel Savitz <jsavitz@redhat.com> wrote:
>
> On Wed, Mar 6, 2019 at 7:55 PM Joel Savitz <jsavitz@redhat.com> wrote:
> >
> > If a process is limited by taskset (i.e. cpuset) to only be allowed to
> > run on cpu N, and then cpu N is offlined via hotplug, the process will
> > be assigned the current value of its cpuset cgroup's effective_cpus field
> > in a call to do_set_cpus_allowed() in cpuset_cpus_allowed_fallback().
> > This argument's value does not makes sense for this case, because
> > task_cs(tsk)->effective_cpus is modified by cpuset_hotplug_workfn()
> > to reflect the new value of cpu_active_mask after cpu N is removed from
> > the mask. While this may make sense for the cgroup affinity mask, it
> > does not make sense on a per-task basis, as a task that was previously
> > limited to only be run on cpu N will be limited to every cpu _except_ for
> > cpu N after it is offlined/onlined via hotplug.
> >
> > Pre-patch behavior:
> >
> >         $ grep Cpus /proc/$$/status
> >         Cpus_allowed:   ff
> >         Cpus_allowed_list:      0-7
> >
> >         $ taskset -p 4 $$
> >         pid 19202's current affinity mask: f
> >         pid 19202's new affinity mask: 4
> >
> >         $ grep Cpus /proc/self/status
> >         Cpus_allowed:   04
> >         Cpus_allowed_list:      2
> >
> >         # echo off > /sys/devices/system/cpu/cpu2/online
> >         $ grep Cpus /proc/$$/status
> >         Cpus_allowed:   0b
> >         Cpus_allowed_list:      0-1,3
> >
> >         # echo on > /sys/devices/system/cpu/cpu2/online
> >         $ grep Cpus /proc/$$/status
> >         Cpus_allowed:   0b
> >         Cpus_allowed_list:      0-1,3
> >
> > On a patched system, the final grep produces the following
> > output instead:
> >
> >         $ grep Cpus /proc/$$/status
> >         Cpus_allowed:   ff
> >         Cpus_allowed_list:      0-7
> >
> > This patch changes the above behavior by instead simply resetting the mask
> > to cpu_possible_mask.
> >
> > Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> > ---
> >  kernel/cgroup/cpuset.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > index 479743db6c37..5f65a2167bdf 100644
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -3243,7 +3243,7 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
> >  void cpuset_cpus_allowed_fallback(struct task_struct *tsk)
> >  {
> >         rcu_read_lock();
> > -       do_set_cpus_allowed(tsk, task_cs(tsk)->effective_cpus);
> > +       do_set_cpus_allowed(tsk, cpu_possible_mask);
> >         rcu_read_unlock();
> >
> >         /*
> > --
> > 2.20.1
> >
