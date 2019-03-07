Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E50C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A70B2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfCGOnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 09:43:11 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35809 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfCGOnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 09:43:10 -0500
Received: by mail-vs1-f68.google.com with SMTP id e81so4601109vsd.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 06:43:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9BNOU1eQnXvarrJnoSbHAXXCUv+Lt1cs6Wfh7qz4T8Q=;
        b=mLX9u+Rulq1LEEzu2wtTXHNcIiQjcAKsG4+ZCopcStBSktEBnT0ZLersV8hwe1FPnt
         f23L0uO2w5OlnPvYb36vVThwozyLSnLgcxnIxgFQ+e0JBAE0QmYnvJWNCSoqVpm3h8Vb
         Q/WoI0MPlk1hc+zU59R5Lz340lGEV30eOQhrg5NaVilPGPtX/zLH/PkIVyPYqGgKvFiZ
         BM3cibrncdVQcUvsQ4X88KaH9fXBKYW3JA6GbIclgUwXmyGrW6Sg/YJsSWVzVUcDrSm5
         3l/CYnXSmgkES7B07wTMVJ/RbQjoA/ht4N+t3WcGdoSVxqrE2/mIFhMZM35Q7VGdhb01
         Msmg==
X-Gm-Message-State: APjAAAU5V3NBGWXVfyrVtr8SB8KK7mUsMcqzJIE4FND8o7ObqlmBYvWB
        Cb7e6bmg7BXlBZzAjPKMwQDvBXts+2pg9ryRvzmplfMLt4c=
X-Google-Smtp-Source: APXvYqy2SgUK880arJbr9y+t3ykEYGgcUGN2UPjhKVWdSKnYq9ffLB6SbP5sa+XtW4E4KRO+Gf0ddGiSTloMQFu5JRg=
X-Received: by 2002:a67:fc13:: with SMTP id o19mr7312628vsq.123.1551969789154;
 Thu, 07 Mar 2019 06:43:09 -0800 (PST)
MIME-Version: 1.0
References: <1551920088-30685-1-git-send-email-jsavitz@redhat.com>
In-Reply-To: <1551920088-30685-1-git-send-email-jsavitz@redhat.com>
From:   Joel Savitz <jsavitz@redhat.com>
Date:   Thu, 7 Mar 2019 09:42:58 -0500
Message-ID: <CAL1p7m5e6HwFQVur+XVKWnpoMRPg0qFs0QkJ_5mnkUoxG_gwMw@mail.gmail.com>
Subject: Re: [PATCH] cpuset: restore sanity to cpuset_cpus_allowed_fallback()
To:     linux-kernel@vger.kernel.org
Cc:     Li Zefan <lizefan@huawei.com>, cgroups@vger.kernel.org,
        Philip Auld <pauld@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 7:55 PM Joel Savitz <jsavitz@redhat.com> wrote:
>
> If a process is limited by taskset (i.e. cpuset) to only be allowed to
> run on cpu N, and then cpu N is offlined via hotplug, the process will
> be assigned the current value of its cpuset cgroup's effective_cpus field
> in a call to do_set_cpus_allowed() in cpuset_cpus_allowed_fallback().
> This argument's value does not makes sense for this case, because
> task_cs(tsk)->effective_cpus is modified by cpuset_hotplug_workfn()
> to reflect the new value of cpu_active_mask after cpu N is removed from
> the mask. While this may make sense for the cgroup affinity mask, it
> does not make sense on a per-task basis, as a task that was previously
> limited to only be run on cpu N will be limited to every cpu _except_ for
> cpu N after it is offlined/onlined via hotplug.
>
> Pre-patch behavior:
>
>         $ grep Cpus /proc/$$/status
>         Cpus_allowed:   ff
>         Cpus_allowed_list:      0-7
>
>         $ taskset -p 4 $$
>         pid 19202's current affinity mask: f
>         pid 19202's new affinity mask: 4
>
>         $ grep Cpus /proc/self/status
>         Cpus_allowed:   04
>         Cpus_allowed_list:      2
>
>         # echo off > /sys/devices/system/cpu/cpu2/online
>         $ grep Cpus /proc/$$/status
>         Cpus_allowed:   0b
>         Cpus_allowed_list:      0-1,3
>
>         # echo on > /sys/devices/system/cpu/cpu2/online
>         $ grep Cpus /proc/$$/status
>         Cpus_allowed:   0b
>         Cpus_allowed_list:      0-1,3
>
> On a patched system, the final grep produces the following
> output instead:
>
>         $ grep Cpus /proc/$$/status
>         Cpus_allowed:   ff
>         Cpus_allowed_list:      0-7
>
> This patch changes the above behavior by instead simply resetting the mask
> to cpu_possible_mask.
>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 479743db6c37..5f65a2167bdf 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3243,7 +3243,7 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
>  void cpuset_cpus_allowed_fallback(struct task_struct *tsk)
>  {
>         rcu_read_lock();
> -       do_set_cpus_allowed(tsk, task_cs(tsk)->effective_cpus);
> +       do_set_cpus_allowed(tsk, cpu_possible_mask);
>         rcu_read_unlock();
>
>         /*
> --
> 2.20.1
>
