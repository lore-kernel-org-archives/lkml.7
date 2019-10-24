Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEFFCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D6421655
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGDHXZ6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfJXUXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:23:33 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37488 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfJXUXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 16:23:33 -0400
Received: by mail-qk1-f193.google.com with SMTP id u184so24705184qkd.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 13:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D3JYC/o+KFe4UyHWSlH0O8zD9rqOjkhthU9vb3E+aqo=;
        b=eGDHXZ6NaTDO41WSjnjGaEzIDmHIHBmghitCo1eOT6uRxKf2rxojEbjLkvNyt85oal
         YEemjI0NE4fAfCNK6KLbsI6OOvgBKAwAW/U7XQiL5QX8SjsSSC9ldAoyEbNP3WmIY1J7
         hOKc/RA67MlDHoyzc0A2Mn9h5NptnUYDqPK7uqHvCsmu8DsWVaC7vg4wEAEG+Ijsh4oN
         tPUWPqXnMMUL+YgNCWlqK54kIZfkmA821aum8+ctZH97dYwj4DgaFKMWP0GjCmcNn6bn
         cR2nv9Nk7iI1c+R9nhtS6dfweDO6Y4IlCWdqD9X3poAZVSgbX46Oda5JP3E03Yy7baGW
         PNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D3JYC/o+KFe4UyHWSlH0O8zD9rqOjkhthU9vb3E+aqo=;
        b=nBoyePczt4giCBGOLx3N4ylW7Y7SAHcgfxix0a4L4iDFh2Q2UO6Du7nr63zR9I58fG
         Pxh+K8GoKenX4v24rViXmusPoTeD/KmmMKAGjj52RxlCnLURnFKidUxADFb/iguawjwj
         GnJIEtQyO7FTJrO6SSEUE+swF4FtCdW6/8hLMaNB5OREHM650JiAb2aXZZEXhSjlFoHW
         VuUO3oW5EJWDD0fr1Rgp2N1llV/4CWS35J/Ox7IqaDYU69nLDuBQ3OvRO6bjz3XE9Od6
         fZLpJY7HkG/IVDq0JO39llYKzC1gGxwsMxQL4OlDmBd0Up+STvMnjuhcMZxQ/Apt//n7
         H4mg==
X-Gm-Message-State: APjAAAUroktbr0zC2gLCpiuC2dUrgxU7TIDq/Sgwk0shIXrGachheFrp
        3huJH/9yQgQQRd+kvabaOqw=
X-Google-Smtp-Source: APXvYqzydgErlfxop3YnRs0ugkcD9cG37AXmK7fH8FyIytuhztxhjctbg9+zWpGyIRt4gwfcbB99Nw==
X-Received: by 2002:a05:620a:2144:: with SMTP id m4mr4771549qkm.226.1571948610824;
        Thu, 24 Oct 2019 13:23:30 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id l5sm4018103qtr.44.2019.10.24.13.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 13:23:30 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B81AB41199; Thu, 24 Oct 2019 17:23:27 -0300 (-03)
Date:   Thu, 24 Oct 2019 17:23:27 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [BUGFIX PATCH 0/3] perf/probe: Fix available line bugs
Message-ID: <20191024202327.GA19678@kernel.org>
References: <157190834681.1859.7399361844806238387.stgit@devnote2>
 <20191024134325.GA1666@kernel.org>
 <20191025003648.af4216cbf71bf2d5e60d2932@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025003648.af4216cbf71bf2d5e60d2932@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 25, 2019 at 12:36:48AM +0900, Masami Hiramatsu escreveu:
> On Thu, 24 Oct 2019 10:43:25 -0300 Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> > Em Thu, Oct 24, 2019 at 06:12:27PM +0900, Masami Hiramatsu escreveu:
> > > Here are some bugfixes related to showing available line (--line/-L)
> > > option. I found that gcc generated some subprogram DIE with only
> > > range attribute but no entry_pc or low_pc attributes.
> > > In that case, perf probe failed to show the available lines in that
> > > subprogram (function). To fix that, I introduced some bugfixes to
> > > handle such cases correctly.

> > Thanks, applied, next time please provide concrete examples for things
> > that don't work before and gets fixed with your patches, this way we can
> > more easily reproduce your steps.
 
> OK, I'll try, but I found that this kind of examples depend on
> gcc optimization (like build option, gcc version etc.) So even if you
> can not reproduce, don't be disappointed ;)

Don't worry about that, even if I don't manage to reproduce I'm
convinced that having the set of steps to reproduce the problem, with
actual output from tools, and your step-by-step explanations helps
whoever feels like reviewing your patch, so thanks a lot for doing what
I suggested.
 
> Anyway, for this series, I found that clear_tasks_mm_cpumask() caused
> the (triple) issues.

So, lets try to repro...
 
> So, without any patch, I got below error.
 
> $ tools/perf/perf probe -k ../build-x86_64/vmlinux -L clear_tasks_mm_cpumask
> Specified source line is not found.
>   Error: Failed to show lines.

[root@quaco ~]# perf probe clear_tasks_mm_cpumask
Probe point 'clear_tasks_mm_cpumask' not found.
  Error: Failed to add events.
[root@quaco ~]# uname -r
5.2.18-200.fc30.x86_64
[root@quaco ~]# rpm -q kernel-debuginfo
kernel-debuginfo-5.2.15-200.fc30.x86_64
kernel-debuginfo-5.2.17-200.fc30.x86_64
kernel-debuginfo-5.2.18-200.fc30.x86_64
[root@quaco ~]# grep clear_tasks /proc/kallsyms
ffffffffaa0e09a0 T clear_tasks_mm_cpumask
ffffffffaa0e10d3 t clear_tasks_mm_cpumask.cold
[root@quaco ~]#

woah! Seems I'm on the right track :-)

> 
> Hmm, there should be something wrong... so I fixed it with [1/3].
> (to find appropriate target function, you can use "eu-readelf -w vmlinux"

So I don't know where is this vmlinux, lets try to find it:

[root@quaco ~]# perf probe -v clear_tasks_mm_cpumask
probe-definition(0): clear_tasks_mm_cpumask
symbol:clear_tasks_mm_cpumask file:(null) line:0 offset:0 return:0 lazy:(null)
0 arguments
Looking at the vmlinux_path (8 entries long)
Using /usr/lib/debug/lib/modules/5.2.18-200.fc30.x86_64/vmlinux for symbols
Open Debuginfo file: /usr/lib/debug/lib/modules/5.2.18-200.fc30.x86_64/vmlinux
Try to find probe point from debuginfo.
Matched function: clear_tasks_mm_cpumask [14d33f6]
clear_tasks_mm_cpumask has no entry PC. Skipped
Symbol clear_tasks_mm_cpumask address found : ffffffff810e09a0
Matched function: clear_tasks_mm_cpumask [14d33f6]
clear_tasks_mm_cpumask has no entry PC. Skipped
Probe point 'clear_tasks_mm_cpumask' not found.
  Error: Failed to add events. Reason: No such file or directory (Code: -2)
[root@quaco ~]#

Ok /usr/lib/debug/lib/modules/5.2.18-200.fc30.x86_64/vmlinux, then:

[root@quaco ~]# eu-readelf -w /usr/lib/debug/lib/modules/5.2.18-200.fc30.x86_64/vmlinux | grep clear_tasks_mm_cpumask -B5 -A30
<go grab some coffee>
 [14d3770]      inlined_subroutine   abbrev: 32
               abstract_origin      (ref4) [14d8d01]
               entry_pc             (addr) 0xffffffff810e09b7 <clear_tasks_mm_cpumask+0x17>
               GNU_entry_view       (data2) 7
               ranges               (sec_offset) range list [11e9d0]
               call_file            (data1) cpu.c (1)
               call_line            (data2) 817
               call_column          (data1) 2
               sibling              (ref4) [14d37b0]
 [14d378b]        inlined_subroutine   abbrev: 176
                 abstract_origin      (ref4) [14d8d16]
                 entry_pc             (addr) 0xffffffff810e09b7 <clear_tasks_mm_cpumask+0x17>
                 GNU_entry_view       (data2) 9
                 low_pc               (addr) 0xffffffff810e09b7 <clear_tasks_mm_cpumask+0x17>
                 high_pc              (data8) 0 (0xffffffff810e09b7 <clear_tasks_mm_cpumask+0x17>)
                 call_file            (data1) rcupdate.h (23)
                 call_line            (data2) 591
                 call_column          (data1) 2
 [14d37b0]      inlined_subroutine   abbrev: 53
               abstract_origin      (ref4) [14d8cf6]
               entry_pc             (addr) 0xffffffff810e0a07 <clear_tasks_mm_cpumask+0x67>
               GNU_entry_view       (data2) 2
               ranges               (sec_offset) range list [11ec40]
               call_file            (data1) cpu.c (1)
               call_line            (data2) 831
               call_column          (data1) 2
 [14d37c7]        inlined_subroutine   abbrev: 176
                 abstract_origin      (ref4) [14d8d0c]
                 entry_pc             (addr) 0xffffffff810e0a07 <clear_tasks_mm_cpumask+0x67>
                 GNU_entry_view       (data2) 8
                 low_pc               (addr) 0xffffffff810e0a07 <clear_tasks_mm_cpumask+0x67>
                 high_pc              (data8) 0 (0xffffffff810e0a07 <clear_tasks_mm_cpumask+0x67>)
                 call_file            (data1) rcupdate.h (23)
                 call_line            (data2) 646
                 call_column          (data1


>  and find the subprogram which has no entry_pc nor low_pc but has ranges)
> 
> $ tools/perf/perf probe -k ../build-x86_64/vmlinux -L clear_tasks_mm_cpumask
> <clear_tasks_mm_cpumask@/home/mhiramat/ksrc/mincs/work/linux/linux/kernel/cpu.c:
>          void clear_tasks_mm_cpumask(int cpu)
>       1  {
>       2         struct task_struct *p;
>          
>                 /*
>                  * This function is called after the cpu is taken down and marke
>                  * offline, so its not like new tasks will ever get this cpu set
>                  * their mm mask. -- Peter Zijlstra
>                  * Thus, we may use rcu_read_lock() here, instead of grabbing
>                  * full-fledged tasklist_lock.
>                  */
>      11         WARN_ON(cpu_online(cpu));
>      12         rcu_read_lock();
>      13         for_each_process(p) {
>      14                 struct task_struct *t;
>          
>                         /*
>                          * Main thread might exit, but other threads may still h
>                          * a valid mm. Find one.
>                          */
>      20                 t = find_lock_task_mm(p);
>      21                 if (!t)
>                                 continue;
>                         cpumask_clear_cpu(cpu, mm_cpumask(t->mm));
>                         task_unlock(t);
>                 }
>      26         rcu_read_unlock();
>      27  }
>          
> OK! it looks working... but a bit wired. why line #0, #23 and #24 are not
> available?
> I investigated it and found a wrong logic and fixed it with [2/3]
> 
> $ tools/perf/perf probe -k ../build-x86_64/vmlinux -L clear_tasks_mm_cpumask:20
> <clear_tasks_mm_cpumask@/home/mhiramat/ksrc/mincs/work/linux/linux/kernel/cpu.c:
>      20                 t = find_lock_task_mm(p);
>      21                 if (!t)
>                                 continue;
>      23                 cpumask_clear_cpu(cpu, mm_cpumask(t->mm));
>      24                 task_unlock(t);
>                 }
>      26         rcu_read_unlock();
>      27  }
> 
> OK, it found line #23 and #24. And add [3/3]
> 
> $ tools/perf/perf probe -k ../build-x86_64/vmlinux -L clear_tasks_mm_cpumask
> <clear_tasks_mm_cpumask@/home/mhiramat/ksrc/mincs/work/linux/linux/kernel/cpu.c:
>       0  void clear_tasks_mm_cpumask(int cpu)
>       1  {
>       2         struct task_struct *p;
> 
> OK, so now it works well :)

Ok, so, the above output is with your patches, as well as the following,
which, for -L, matches your results:

[root@quaco ~]# perf probe -L clear_tasks_mm_cpumask
<clear_tasks_mm_cpumask@/usr/src/debug/kernel-5.2.fc30/linux-5.2.18-200.fc30.x86_64/kernel/cpu.c:0>
      0  void clear_tasks_mm_cpumask(int cpu)
      1  {
      2         struct task_struct *p;

                /*
                 * This function is called after the cpu is taken down and marked
                 * offline, so its not like new tasks will ever get this cpu set in
                 * their mm mask. -- Peter Zijlstra
                 * Thus, we may use rcu_read_lock() here, instead of grabbing
                 * full-fledged tasklist_lock.
                 */
     11         WARN_ON(cpu_online(cpu));
     12         rcu_read_lock();
     13         for_each_process(p) {
     14                 struct task_struct *t;

                        /*
                         * Main thread might exit, but other threads may still have
                         * a valid mm. Find one.
                         */
     20                 t = find_lock_task_mm(p);
     21                 if (!t)
                                continue;
     23                 cpumask_clear_cpu(cpu, mm_cpumask(t->mm));
     24                 task_unlock(t);
                }
     26         rcu_read_unlock();
     27  }

         /* Take this CPU down. */
         static int take_cpu_down(void *_param)

[root@quaco ~]# perf probe clear_tasks_mm_cpumask
Probe point 'clear_tasks_mm_cpumask' not found.
  Error: Failed to add events.
[root@quaco ~]#

But why can't I probe this thing again?

[root@quaco ~]# perf probe clear_tasks_mm_cpumask:0
Probe point 'clear_tasks_mm_cpumask' not found.
  Error: Failed to add events.
[root@quaco ~]# perf probe clear_tasks_mm_cpumask:1
Failed to get entry address of clear_tasks_mm_cpumask
  Error: Failed to add events.
[root@quaco ~]# perf probe clear_tasks_mm_cpumask:2
Failed to get entry address of clear_tasks_mm_cpumask
  Error: Failed to add events.
[root@quaco ~]# perf probe clear_tasks_mm_cpumask:11
Failed to get entry address of clear_tasks_mm_cpumask
  Error: Failed to add events.
[root@quaco ~]# perf probe clear_tasks_mm_cpumask:12
Failed to get entry address of clear_tasks_mm_cpumask
  Error: Failed to add events.
[root@quaco ~]# perf probe clear_tasks_mm_cpumask:13
Failed to get entry address of clear_tasks_mm_cpumask
  Error: Failed to add events.
root@quaco ~]#

[root@quaco ~]# rpm -qf /usr/lib/debug/lib/modules/5.2.18-200.fc30.x86_64/vmlinux
kernel-debuginfo-5.2.18-200.fc30.x86_64
[root@quaco ~]#

[root@quaco ~]# readelf -wi /usr/lib/debug/lib/modules/5.2.18-200.fc30.x86_64/vmlinux | grep "DW_AT_producer.*GNU C" -m1 -A6
    <2e>   DW_AT_producer    : (indirect string, offset: 0xf1c6): GNU C89 9.2.1 20190827 (Red Hat 9.2.1-1) -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64 -mno-80387 -mno-fp-ret-in-387 -mpreferred-stack-boundary=3 -mskip-rax-setup -mtune=generic -mno-red-zone -mcmodel=kernel -mindirect-branch=thunk-extern -mindirect-branch-register -mrecord-mcount -mfentry -march=x86-64 -g -O2 -std=gnu90 -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -falign-jumps=1 -falign-loops=1 -fno-asynchronous-unwind-tables -fno-jump-tables -fno-delete-null-pointer-checks -fstack-protector-strong -fvar-tracking-assignments -fno-strict-overflow -fno-merge-all-constants -fmerge-constants -fstack-check=no -fconserve-stack --param allow-store-data-races=0
    <32>   DW_AT_language    : 1	(ANSI C)
    <33>   DW_AT_name        : (indirect string, offset: 0xdfe59): arch/x86/kernel/head64.c
    <37>   DW_AT_comp_dir    : (indirect string, offset: 0x4d33f): /usr/src/debug/kernel-5.2.fc30/linux-5.2.18-200.fc30.x86_64
    <3b>   DW_AT_ranges      : 0x5f0
    <3f>   DW_AT_low_pc      : 0x0
    <47>   DW_AT_stmt_list   : 0x165
[root@quaco ~]#

- Arnaldo
