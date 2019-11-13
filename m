Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32A3C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 18:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1210C20409
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 18:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wGOiwEh1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbfKMS3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 13:29:10 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33497 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfKMS3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 13:29:10 -0500
Received: by mail-qt1-f195.google.com with SMTP id y39so3695622qty.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 10:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AVJp3Nx2fJclkPsZmo5pxsSlY+xokOBoEOQZdALqbJc=;
        b=wGOiwEh11w+CjxmdcSVIkykUGQlX+8qKLxoUiHNR3bfSzC0tPhrY+FxxOOvZ2UlGlg
         8OScpTD/VFjc0VAehdzHunnGxsBuIJcyAQE/EkzaCSuF7VXtvdpXJuh4pySRhZ+5cL8c
         eGjt7lo5TEWfDZzl3eGuLA1EhaF0Nbs6XdmhDynaoRDOakkHjwmz2RQ+8skoU4vgIfq2
         sDdqoRYWZSwKhuqzafEwdCWI8QAZi9rNeWdc4Rsa0mbqBJRrYqufg8RpdWuB7yhpOiaq
         7pPo8FPrRlXqV2yqse4WiWBMkLf07ImLYXAvQfQ//PTSVIu2qYCiHJ0+UdX6nLWGA2li
         YGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AVJp3Nx2fJclkPsZmo5pxsSlY+xokOBoEOQZdALqbJc=;
        b=rBFUokmjgUOW/jWRhyQu/evx4mY2EWeXQWFE3u+JhXnMz9aFnINs5W6n9ZQfUeSkAM
         Y+JyUw48O5u+mZuLXOSE3osS4PfMaDPUgrtdD8k/3Hyz6i7MEELZMaPUsOkeShZsdBvY
         7Y+EL7YtRJfaXluwOXObls2txHI8YliXfIYN5+zchAhKA4NSTUA5m1yhQY6W3bDDab2e
         2ijVVALR+SozoU0GGkXc/C5mmAWiU9LrCuqC1xb2/CKndtaXap5jL86dPAq9+DahUROx
         nTZKW6rjnMG62iHdgcrhpP+sbRMzh6vIyRiP/AIbpE9fkfo3wTaW5puOK4AsXnsmNfja
         9Rew==
X-Gm-Message-State: APjAAAXfLqa5IXnkpN8LN4pOb+2Waetqutj5RW4HKzC7UFxRXqmdh4iq
        /c6Z+iEFaVkWt/RclcTHrC/qgWrUwFi26zIQ39N6
X-Google-Smtp-Source: APXvYqz6RuVgYs5PhvNTlFRRdDmEaTW7hWupakyWdeAFy65CHcki5bkN96cbOf91R30s0af7NR9u3phubPYifusPKnQ=
X-Received: by 2002:ac8:1084:: with SMTP id a4mr4196071qtj.114.1573669748685;
 Wed, 13 Nov 2019 10:29:08 -0800 (PST)
MIME-Version: 1.0
References: <743eecad-9556-a241-546b-c8a66339840e@linux.alibaba.com> <896a7da3-f139-32e7-8a64-b3562df1a091@linux.alibaba.com>
In-Reply-To: <896a7da3-f139-32e7-8a64-b3562df1a091@linux.alibaba.com>
From:   Iurii Zaikin <yzaikin@google.com>
Date:   Wed, 13 Nov 2019 10:28:32 -0800
Message-ID: <CAAXuY3qsckZurUHy5kJUQcmrbn-bmGHnjtPPus5=PrQ+MmJX+g@mail.gmail.com>
Subject: Re: [PATCH 3/3] sched/numa: documentation for per-cgroup numa stat
To:     =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the documentation talks about fairly advanced concepts, every little =
bit
of readability improvement helps. I tried to make suggestions that I feel m=
ake
it easier to read, hopefully my nitpicking is not too annoying.
On Tue, Nov 12, 2019 at 7:46 PM =E7=8E=8B=E8=B4=87 <yun.wang@linux.alibaba.=
com> wrote:
> +On NUMA platforms, remote memory accessing always has a performance pena=
lty,
> +although we have NUMA balancing working hard to maximum the local access=
ing
> +proportion, there are still situations it can't helps.
Nit: working hard to maximize the access locality...
can't helps -> can't help
> +
> +This could happen in modern production environment, using bunch of cgrou=
ps
> +to classify and control resources which introduced complex configuration=
 on
> +memory policy, CPUs and NUMA node, NUMA balancing could facing the wrong
> +memory policy or exhausted local NUMA node, lead into the low local page
> +accessing proportion.
I find the below a bit easier to read.
This could happen in modern production environment. When a large
number of cgroups
are used to classify and control resources, this creates a complex
memory policy configuration
for CPUs and NUMA nodes. In such cases NUMA balancing could end up
with the wrong
memory policy or exhausted local NUMA node, which would lead to low
percentage of local page
accesses.

> +We need to perceive such cases, figure out which workloads from which cg=
roup
> +has introduced the issues, then we got chance to do adjustment to avoid
> +performance damages.
Nit: perceive -> detect, got-> get, damages-> degradation

> +However, there are no hardware counter for per-task local/remote accessi=
ng
> +info, we don't know how many remote page accessing has been done for a
> +particular task.
Nit: counters.
Nit: we don't know how many remote page accesses have occurred for a

> +
> +Statistics
> +----------
> +
> +Fortunately, we have NUMA Balancing which scan task's mapping and trigge=
r PF
> +periodically, give us the opportunity to record per-task page accessing =
info.
Nit: scans, triggers, gives.

> +By "echo 1 > /proc/sys/kernel/cg_numa_stat" on runtime or add boot param=
eter
Nit: at runtime or adding boot parameter
> +To be noticed, the accounting is in a hierarchy way, which means the num=
a
> +statistics representing not only the workload of this group, but also th=
e
> +workloads of all it's descendants.
Note that the accounting is hierarchical, which means the numa
statistics for a given group represents not only the workload of this
group, but also the
workloads of all it's descendants.
> +
> +For example the 'cpu.numa_stat' show:
> +  locality 39541 60962 36842 72519 118605 721778 946553
> +  exectime 1220127 1458684
> +
> +The locality is sectioned into 7 regions, closely as:
> +  0-13% 14-27% 28-42% 43-56% 57-71% 72-85% 86-100%
Nit: closely -> approximately?

> +we can draw a line for region_bad_percent, when the line close to 0 thin=
gs
nit: we can plot?
> +are good, when getting close to 100% something is wrong, we can pick a p=
roper
> +watermark to trigger warning message.

> +You may want to drop the data if the region_all is too small, which impl=
y
Nit: implies
> +there are not much available pages for NUMA Balancing, just ignore would=
 be
Nit: not many... ingoring
> +fine since most likely the workload is insensitive to NUMA.
> +Monitoring root group help you control the overall situation, while you =
may
Nit: helps
> +also want to monitoring all the leaf groups which contain the workloads,=
 this
Nit: monitor
> +help to catch the mouse.
Nit: helps
> +become too small, for NUMA node X we have:
Nit: becomes
> +try put your workload into a memory cgroup which providing per-node memo=
ry
Nit: try to put
> +These two percentage are usually matched on each node, workload should e=
xecute
Nit: percentages
> +Depends on which part of the memory accessed mostly by the workload, loc=
ality
Depending on which part of the memory is accessed.
"mostly by the workload" - not sure what you mean here, the majority
of accesses from the
workload fall into this part of memory or that accesses from processes
other than the workload
are rare?
> +could still be good with just a little piece of memory locally.
?
> +Thus to tell if things are find or not depends on the understanding of s=
ystem
are fine
> +After locate which workloads introduced the bad locality, check:
locate -> indentifying
> +
> +1). Is the workloads bind into a particular NUMA node?
bind into -> bound to
> +2). Is there any NUMA node run out of resources?
Has any .. run out of resources
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 5e27d74e2b74..220df1f0beb8 100644
> +                       lot's of per-cgroup workloads.
lots
