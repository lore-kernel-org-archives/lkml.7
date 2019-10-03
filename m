Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABA8C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D2321A4C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732373AbfJCQEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:04:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53288 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731056AbfJCQEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:04:09 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C3F0B3D966;
        Thu,  3 Oct 2019 16:04:08 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-11.phx2.redhat.com [10.3.112.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F30E819C6A;
        Thu,  3 Oct 2019 16:04:07 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 96DF211E4; Thu,  3 Oct 2019 13:04:04 -0300 (BRT)
Date:   Thu, 3 Oct 2019 13:04:04 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Josh Hunt <johunt@akamai.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, john@metanate.com, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com, khlebnikov@yandex-team.ru,
        namhyung@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: 4.19 dwarf unwinding broken
Message-ID: <20191003160404.GG3531@redhat.com>
References: <ab87d20b-526c-9435-0532-c298beeb0318@akamai.com>
 <20191003100300.GA22784@krava>
 <d0e0a675-1344-a47b-c27e-ea05230d88b8@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0e0a675-1344-a47b-c27e-ea05230d88b8@akamai.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 03 Oct 2019 16:04:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 03, 2019 at 08:17:38AM -0700, Josh Hunt escreveu:
> On 10/3/19 3:03 AM, Jiri Olsa wrote:
> >On Thu, Oct 03, 2019 at 12:54:09AM -0700, Josh Hunt wrote:
> >>The following commit is breaking dwarf unwinding on 4.19 kernels:
> >
> >how?
> 
> When doing something like:
> perf record -p $(cat /var/run/app.pid) -g --call-graph dwarf -F 999
> -- sleep 3
> 
> with 4.19.75 perf I see things like:
> 
> app_Thr00 26247 1810131.375329:     168288 cycles:ppp:
> 
> app_Thr01 26767 1810131.377449:     344415 cycles:ppp:
> 
> uvm:WorkerThread 26746 1810131.383052:        504 cycles:ppp:
>         ffffffff9f77cce0 _raw_spin_lock+0x10 (/boot/vmlinux-4.19.46)
>         ffffffff9f181527 __perf_event_task_sched_in+0xf7
> (/boot/vmlinux-4.19.46)
>         ffffffff9f09a7b8 finish_task_switch+0x158 (/boot/vmlinux-4.19.46)
>         ffffffff9f778276 __schedule+0x2f6 (/boot/vmlinux-4.19.46)
>         ffffffff9f7787f2 schedule+0x32 (/boot/vmlinux-4.19.46)
>         ffffffff9f77bb0a schedule_hrtimeout_range_clock+0x8a
> (/boot/vmlinux-4.19.46)
>         ffffffff9f22ea12 poll_schedule_timeout.constprop.6+0x42
> (/boot/vmlinux-4.19.46)
>         ffffffff9f22eeeb do_sys_poll+0x4ab (/boot/vmlinux-4.19.46)
>         ffffffff9f22fb7b __se_sys_poll+0x5b (/boot/vmlinux-4.19.46)
>         ffffffff9f0023de do_syscall_64+0x4e (/boot/vmlinux-4.19.46)
>         ffffffff9f800088 entry_SYSCALL_64+0x68 (/boot/vmlinux-4.19.46)
> ---
> 
> and with 4.19.75 perf with e5adfc3e7e77 reverted those empty call
> stacks go away and also other call stacks show more thread details:
> 
> uvm:WorkerThread 26746 1810207.336391:          1 cycles:ppp:
>         ffffffff9f181505 __perf_event_task_sched_in+0xd5
> (/boot/vmlinux-4.19.46)
>         ffffffff9f09a7b8 finish_task_switch+0x158 (/boot/vmlinux-4.19.46)
>         ffffffff9f778276 __schedule+0x2f6 (/boot/vmlinux-4.19.46)
>         ffffffff9f7787f2 schedule+0x32 (/boot/vmlinux-4.19.46)
>         ffffffff9f77bb0a schedule_hrtimeout_range_clock+0x8a
> (/boot/vmlinux-4.19.46)
>         ffffffff9f22ea12 poll_schedule_timeout.constprop.6+0x42
> (/boot/vmlinux-4.19.46)
>         ffffffff9f22eeeb do_sys_poll+0x4ab (/boot/vmlinux-4.19.46)
>         ffffffff9f22fb7b __se_sys_poll+0x5b (/boot/vmlinux-4.19.46)
>         ffffffff9f0023de do_syscall_64+0x4e (/boot/vmlinux-4.19.46)
>         ffffffff9f800088 entry_SYSCALL_64+0x68 (/boot/vmlinux-4.19.46)
>             7f7ef3f5c90d [unknown] (/lib/x86_64-linux-gnu/libc-2.23.so)
>                  3eb5c99 poll+0xc9 (inlined)
>                  3eb5c99 colib::ipc::EventFd::wait+0xc9
> (/usr/local/bin/app)
>                  3296779 uvm::WorkerThread::run+0x129 (/usr/local/bin/app)
>         ffffffffffffffff [unknown] ([unknown])
> 
> They also look the same as earlier kernel versions we have running.
> 
> In addition reading e8ba2906f6b's changelog sounded very similar to
> what I was seeing. This application launches a # of threads and is
> definitely already running before the invocation of perf.
> 
> Thanks for looking at this.


So, if at __event__synthesize_thread()


                if (pid == tgid &&
                    perf_event__synthesize_mmap_events(tool, mmap_event, pid, tgid,
                                                       process, machine, mmap_data))


We did something like:

	if (pid != tgid && machine__find_thread(tgid, tgid) == NULL) {
		struct thread *t = thread__new(tgid, tgid);

		then use the info for pid to get synthesize the thread
                group leader so that the get the sharing we need?
	}


- Arnaldo
