Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB619C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8039B218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbfDOWez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 18:34:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbfDOWez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 18:34:55 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97A6020818;
        Mon, 15 Apr 2019 22:34:52 +0000 (UTC)
Date:   Mon, 15 Apr 2019 18:34:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Masanari Iida <standby24x7@gmail.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: [PATCH] docs: trace: fix some Sphinx warnings
Message-ID: <20190415183451.506a4b6a@gandalf.local.home>
In-Reply-To: <466439c96cc753254dc0fab97902d3d12aaf1e6a.1555358399.git.mchehab+samsung@kernel.org>
References: <466439c96cc753254dc0fab97902d3d12aaf1e6a.1555358399.git.mchehab+samsung@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2019 17:00:05 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> There are some warnings produced when building trace. Fix them.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Jon,

Care to take this through your tree?

Thanks,

-- Steve

> ---
>  Documentation/trace/ftrace.rst    |  1 +
>  Documentation/trace/histogram.rst | 86 ++++++++++++++++---------------
>  2 files changed, 45 insertions(+), 42 deletions(-)
> 
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index 809b39d066ee..f60079259669 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -1435,6 +1435,7 @@ trace has provided some very helpful debugging information.
>  
>  If we prefer function graph output instead of function, we can set
>  display-graph option::
> +
>   with echo 1 > options/display-graph
>  
>    # tracer: irqsoff
> diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
> index 7612c7ad5715..2a6b23f779bb 100644
> --- a/Documentation/trace/histogram.rst
> +++ b/Documentation/trace/histogram.rst
> @@ -2121,33 +2121,33 @@ The following commonly-used handler.action pairs are available:
>      the end the event that triggered the snapshot (in this case you
>      can verify the timestamps between the sched_waking and
>      sched_switch events, which should match the time displayed in the
> -    global maximum):
> +    global maximum)::
>  
> -    # cat /sys/kernel/debug/tracing/snapshot
> +     # cat /sys/kernel/debug/tracing/snapshot
>  
> -     <...>-2103  [005] d..3   309.873125: sched_switch: prev_comm=cyclictest prev_pid=2103 prev_prio=19 prev_state=D ==> next_comm=swapper/5 next_pid=0 next_prio=120
> -     <idle>-0     [005] d.h3   309.873611: sched_waking: comm=cyclictest pid=2102 prio=19 target_cpu=005
> -     <idle>-0     [005] dNh4   309.873613: sched_wakeup: comm=cyclictest pid=2102 prio=19 target_cpu=005
> -     <idle>-0     [005] d..3   309.873616: sched_switch: prev_comm=swapper/5 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=cyclictest next_pid=2102 next_prio=19
> -     <...>-2102  [005] d..3   309.873625: sched_switch: prev_comm=cyclictest prev_pid=2102 prev_prio=19 prev_state=D ==> next_comm=swapper/5 next_pid=0 next_prio=120
> -     <idle>-0     [005] d.h3   309.874624: sched_waking: comm=cyclictest pid=2102 prio=19 target_cpu=005
> -     <idle>-0     [005] dNh4   309.874626: sched_wakeup: comm=cyclictest pid=2102 prio=19 target_cpu=005
> -     <idle>-0     [005] dNh3   309.874628: sched_waking: comm=cyclictest pid=2103 prio=19 target_cpu=005
> -     <idle>-0     [005] dNh4   309.874630: sched_wakeup: comm=cyclictest pid=2103 prio=19 target_cpu=005
> -     <idle>-0     [005] d..3   309.874633: sched_switch: prev_comm=swapper/5 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=cyclictest next_pid=2102 next_prio=19
> -     <idle>-0     [004] d.h3   309.874757: sched_waking: comm=gnome-terminal- pid=1699 prio=120 target_cpu=004
> -     <idle>-0     [004] dNh4   309.874762: sched_wakeup: comm=gnome-terminal- pid=1699 prio=120 target_cpu=004
> -     <idle>-0     [004] d..3   309.874766: sched_switch: prev_comm=swapper/4 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=gnome-terminal- next_pid=1699 next_prio=120
> - gnome-terminal--1699  [004] d.h2   309.874941: sched_stat_runtime: comm=gnome-terminal- pid=1699 runtime=180706 [ns] vruntime=1126870572 [ns]
> -     <idle>-0     [003] d.s4   309.874956: sched_waking: comm=rcu_sched pid=9 prio=120 target_cpu=007
> -     <idle>-0     [003] d.s5   309.874960: sched_wake_idle_without_ipi: cpu=7
> -     <idle>-0     [003] d.s5   309.874961: sched_wakeup: comm=rcu_sched pid=9 prio=120 target_cpu=007
> -     <idle>-0     [007] d..3   309.874963: sched_switch: prev_comm=swapper/7 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=rcu_sched next_pid=9 next_prio=120
> -  rcu_sched-9     [007] d..3   309.874973: sched_stat_runtime: comm=rcu_sched pid=9 runtime=13646 [ns] vruntime=22531430286 [ns]
> -  rcu_sched-9     [007] d..3   309.874978: sched_switch: prev_comm=rcu_sched prev_pid=9 prev_prio=120 prev_state=R+ ==> next_comm=swapper/7 next_pid=0 next_prio=120
> -      <...>-2102  [005] d..4   309.874994: sched_migrate_task: comm=cyclictest pid=2103 prio=19 orig_cpu=5 dest_cpu=1
> -      <...>-2102  [005] d..4   309.875185: sched_wake_idle_without_ipi: cpu=1
> -     <idle>-0     [001] d..3   309.875200: sched_switch: prev_comm=swapper/1 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=cyclictest next_pid=2103 next_prio=19
> +         <...>-2103  [005] d..3   309.873125: sched_switch: prev_comm=cyclictest prev_pid=2103 prev_prio=19 prev_state=D ==> next_comm=swapper/5 next_pid=0 next_prio=120
> +         <idle>-0     [005] d.h3   309.873611: sched_waking: comm=cyclictest pid=2102 prio=19 target_cpu=005
> +         <idle>-0     [005] dNh4   309.873613: sched_wakeup: comm=cyclictest pid=2102 prio=19 target_cpu=005
> +         <idle>-0     [005] d..3   309.873616: sched_switch: prev_comm=swapper/5 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=cyclictest next_pid=2102 next_prio=19
> +         <...>-2102  [005] d..3   309.873625: sched_switch: prev_comm=cyclictest prev_pid=2102 prev_prio=19 prev_state=D ==> next_comm=swapper/5 next_pid=0 next_prio=120
> +         <idle>-0     [005] d.h3   309.874624: sched_waking: comm=cyclictest pid=2102 prio=19 target_cpu=005
> +         <idle>-0     [005] dNh4   309.874626: sched_wakeup: comm=cyclictest pid=2102 prio=19 target_cpu=005
> +         <idle>-0     [005] dNh3   309.874628: sched_waking: comm=cyclictest pid=2103 prio=19 target_cpu=005
> +         <idle>-0     [005] dNh4   309.874630: sched_wakeup: comm=cyclictest pid=2103 prio=19 target_cpu=005
> +         <idle>-0     [005] d..3   309.874633: sched_switch: prev_comm=swapper/5 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=cyclictest next_pid=2102 next_prio=19
> +         <idle>-0     [004] d.h3   309.874757: sched_waking: comm=gnome-terminal- pid=1699 prio=120 target_cpu=004
> +         <idle>-0     [004] dNh4   309.874762: sched_wakeup: comm=gnome-terminal- pid=1699 prio=120 target_cpu=004
> +         <idle>-0     [004] d..3   309.874766: sched_switch: prev_comm=swapper/4 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=gnome-terminal- next_pid=1699 next_prio=120
> +     gnome-terminal--1699  [004] d.h2   309.874941: sched_stat_runtime: comm=gnome-terminal- pid=1699 runtime=180706 [ns] vruntime=1126870572 [ns]
> +         <idle>-0     [003] d.s4   309.874956: sched_waking: comm=rcu_sched pid=9 prio=120 target_cpu=007
> +         <idle>-0     [003] d.s5   309.874960: sched_wake_idle_without_ipi: cpu=7
> +         <idle>-0     [003] d.s5   309.874961: sched_wakeup: comm=rcu_sched pid=9 prio=120 target_cpu=007
> +         <idle>-0     [007] d..3   309.874963: sched_switch: prev_comm=swapper/7 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=rcu_sched next_pid=9 next_prio=120
> +      rcu_sched-9     [007] d..3   309.874973: sched_stat_runtime: comm=rcu_sched pid=9 runtime=13646 [ns] vruntime=22531430286 [ns]
> +      rcu_sched-9     [007] d..3   309.874978: sched_switch: prev_comm=rcu_sched prev_pid=9 prev_prio=120 prev_state=R+ ==> next_comm=swapper/7 next_pid=0 next_prio=120
> +          <...>-2102  [005] d..4   309.874994: sched_migrate_task: comm=cyclictest pid=2103 prio=19 orig_cpu=5 dest_cpu=1
> +          <...>-2102  [005] d..4   309.875185: sched_wake_idle_without_ipi: cpu=1
> +         <idle>-0     [001] d..3   309.875200: sched_switch: prev_comm=swapper/1 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=cyclictest next_pid=2103 next_prio=19
>  
>    - onchange(var).save(field,..	.)
>  
> @@ -2201,9 +2201,10 @@ The following commonly-used handler.action pairs are available:
>      following the rest of the fields.
>  
>      If a snaphot was taken, there is also a message indicating that,
> -    along with the value and event that triggered the snapshot:
> +    along with the value and event that triggered the snapshot::
> +
> +      # cat /sys/kernel/debug/tracing/events/tcp/tcp_probe/hist
>  
> -    # cat /sys/kernel/debug/tracing/events/tcp/tcp_probe/hist
>        { dport:       1521 } hitcount:          8
>  	changed:         10  snd_wnd:      35456  srtt:     154262  rcv_wnd:      42112
>  
> @@ -2216,14 +2217,15 @@ The following commonly-used handler.action pairs are available:
>        { dport:        443 } hitcount:        211
>  	changed:         10  snd_wnd:      26960  srtt:      17379  rcv_wnd:      28800
>  
> -    Snapshot taken (see tracing/snapshot).  Details:
> +    Snapshot taken (see tracing/snapshot).  Details::
> +
>          triggering value { onchange($cwnd) }:         10
>          triggered by event with key: { dport:         80 }
>  
> -    Totals:
> -        Hits: 414
> -        Entries: 4
> -        Dropped: 0
> +      Totals:
> +          Hits: 414
> +          Entries: 4
> +          Dropped: 0
>  
>      In the above case, the event that triggered the snapshot has the
>      key with dport == 80.  If you look at the bucket that has 80 as
> @@ -2233,18 +2235,18 @@ The following commonly-used handler.action pairs are available:
>      the global snapshot).
>  
>      And finally, looking at the snapshot data should show at or near
> -    the end the event that triggered the snapshot:
> +    the end the event that triggered the snapshot::
>  
> -    # cat /sys/kernel/debug/tracing/snapshot
> +      # cat /sys/kernel/debug/tracing/snapshot
>  
> -       gnome-shell-1261  [006] dN.3    49.823113: sched_stat_runtime: comm=gnome-shell pid=1261 runtime=49347 [ns] vruntime=1835730389 [ns]
> -     kworker/u16:4-773   [003] d..3    49.823114: sched_switch: prev_comm=kworker/u16:4 prev_pid=773 prev_prio=120 prev_state=R+ ==> next_comm=kworker/3:2 next_pid=135 next_prio=120
> -       gnome-shell-1261  [006] d..3    49.823114: sched_switch: prev_comm=gnome-shell prev_pid=1261 prev_prio=120 prev_state=R+ ==> next_comm=kworker/6:2 next_pid=387 next_prio=120
> -       kworker/3:2-135   [003] d..3    49.823118: sched_stat_runtime: comm=kworker/3:2 pid=135 runtime=5339 [ns] vruntime=17815800388 [ns]
> -       kworker/6:2-387   [006] d..3    49.823120: sched_stat_runtime: comm=kworker/6:2 pid=387 runtime=9594 [ns] vruntime=14589605367 [ns]
> -       kworker/6:2-387   [006] d..3    49.823122: sched_switch: prev_comm=kworker/6:2 prev_pid=387 prev_prio=120 prev_state=R+ ==> next_comm=gnome-shell next_pid=1261 next_prio=120
> -       kworker/3:2-135   [003] d..3    49.823123: sched_switch: prev_comm=kworker/3:2 prev_pid=135 prev_prio=120 prev_state=T ==> next_comm=swapper/3 next_pid=0 next_prio=120
> -            <idle>-0     [004] ..s7    49.823798: tcp_probe: src=10.0.0.10:54326 dest=23.215.104.193:80 mark=0x0 length=32 snd_nxt=0xe3ae2ff5 snd_una=0xe3ae2ecd snd_cwnd=10 ssthresh=2147483647 snd_wnd=28960 srtt=19604 rcv_wnd=29312
> +         gnome-shell-1261  [006] dN.3    49.823113: sched_stat_runtime: comm=gnome-shell pid=1261 runtime=49347 [ns] vruntime=1835730389 [ns]
> +       kworker/u16:4-773   [003] d..3    49.823114: sched_switch: prev_comm=kworker/u16:4 prev_pid=773 prev_prio=120 prev_state=R+ ==> next_comm=kworker/3:2 next_pid=135 next_prio=120
> +         gnome-shell-1261  [006] d..3    49.823114: sched_switch: prev_comm=gnome-shell prev_pid=1261 prev_prio=120 prev_state=R+ ==> next_comm=kworker/6:2 next_pid=387 next_prio=120
> +         kworker/3:2-135   [003] d..3    49.823118: sched_stat_runtime: comm=kworker/3:2 pid=135 runtime=5339 [ns] vruntime=17815800388 [ns]
> +         kworker/6:2-387   [006] d..3    49.823120: sched_stat_runtime: comm=kworker/6:2 pid=387 runtime=9594 [ns] vruntime=14589605367 [ns]
> +         kworker/6:2-387   [006] d..3    49.823122: sched_switch: prev_comm=kworker/6:2 prev_pid=387 prev_prio=120 prev_state=R+ ==> next_comm=gnome-shell next_pid=1261 next_prio=120
> +         kworker/3:2-135   [003] d..3    49.823123: sched_switch: prev_comm=kworker/3:2 prev_pid=135 prev_prio=120 prev_state=T ==> next_comm=swapper/3 next_pid=0 next_prio=120
> +              <idle>-0     [004] ..s7    49.823798: tcp_probe: src=10.0.0.10:54326 dest=23.215.104.193:80 mark=0x0 length=32 snd_nxt=0xe3ae2ff5 snd_una=0xe3ae2ecd snd_cwnd=10 ssthresh=2147483647 snd_wnd=28960 srtt=19604 rcv_wnd=29312
>  
>  3. User space creating a trigger
>  --------------------------------

