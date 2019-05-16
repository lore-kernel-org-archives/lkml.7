Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF98DC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947472082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lucidpixels.com header.i=@lucidpixels.com header.b="d1wxCWB0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfEPOSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 10:18:04 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:37701 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfEPOSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:18:04 -0400
Received: by mail-ot1-f42.google.com with SMTP id r10so3584278otd.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 07:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0bLairRZJzQV1zIbtg3quWAePEMGX7OXk9Z1aPHA36k=;
        b=d1wxCWB0kHauPJp6I7uDsspc1mEKEDUX0K0aT/OHFb/H1EMXsOZ5zMzY5/Q++zeFgi
         GOJxsn47xI1ySyI1VsYeMPJEptjREWHwXf+TWFKIGScbiTumU0ylde52Ez8wpK4Cz0cA
         gOug/hBtjKR/SiaGtDJP8CmxFQbgX3EXOuV6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0bLairRZJzQV1zIbtg3quWAePEMGX7OXk9Z1aPHA36k=;
        b=W9omZ6YA4ejk7mZG7M2+tSt8bOpD1H3V+rIOkhyphyPjwFhUH4L3RyhKKSERKikMU6
         TT/1NWrOXqWnS6igmR0ffnw21KNjiIgXsFDuYLPLr6kUWfXlpxUgiC32/MFaBm0wYKec
         rKXzF5kKxv0WT7cSuyfSxRADKP1zE+HVJlStfPjXrg6T/oC9fNDbt8lzaymDKg9E5/V5
         18EOU1RuuM/MMk/EnbTfMJnl47SiOnrn6VX85PTDxW10ySkf+VEW6Oz2S+/8JEDFPh/7
         dOUax7FNPRbYGRTPNQvYaWen2z6cd70g/6oNwkc+as65jk+Z3jbCWNAb1VwMsZTu2vgL
         DNjg==
X-Gm-Message-State: APjAAAXClm/S4esy9VbkauWH8RRYVr/uycJFkdYbvnx3xYdNjMDFMxoH
        2xPVE6wwCEyxN37uuB56W9gKR3qAXwZ1zxzFde6fbwVjZ5MtIQ==
X-Google-Smtp-Source: APXvYqwqv+LCOFbz7JrMlz+Hn49bRHmpn2lt0MB6+nVTZLkAR2Bi6IlLGMf83shuuqxMB+SaXs3NkrvYU9N1/XiSaNA=
X-Received: by 2002:a9d:37ca:: with SMTP id x68mr785626otb.347.1558016282832;
 Thu, 16 May 2019 07:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <002901d5064d$42355ea0$c6a01be0$@lucidpixels.com>
 <20190509111343.rvmy5noqlf4os3zk@box> <CAO9zADww2v2ckHsNDwRgiyMr9b3JH1xOOSiRJ0Uh2XZT5c=MEQ@mail.gmail.com>
In-Reply-To: <CAO9zADww2v2ckHsNDwRgiyMr9b3JH1xOOSiRJ0Uh2XZT5c=MEQ@mail.gmail.com>
From:   Justin Piszcz <jpiszcz@lucidpixels.com>
Date:   Thu, 16 May 2019 10:17:51 -0400
Message-ID: <CAO9zADyq44Sn0kYZBC55C0ykpHaASzp+27K3BofbkEniK6af-w@mail.gmail.com>
Subject: Re: 5.1 kernel: khugepaged stuck at 100%
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 10:14 AM Justin Piszcz <jpiszcz@lucidpixels.com> wrote:
>
> On Tue, May 14, 2019 at 9:16 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> > Could you check what khugepaged doing?
> >
> > cat /proc/$(pidof khugepaged)/stack
>
> It is doing it again, 10:12am - 2019-05-16
>
>   PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
>    77 root      39  19       0      0      0 R 100.0   0.0  92:06.94 khugepaged
>
> Kernel: 5.1.2
>
> $ sudo cat /proc/$(pidof khugepaged)/stack
> [<0>] 0xffffffffffffffff
>
> $ perf top
>
>    PerfTop:    3716 irqs/sec  kernel:92.9%  exact: 99.1% lost: 68/68
> drop: 0/0 [4000Hz cycles],  (all, 12 CPUs)
> -------------------------------------------------------------------------------
>
>     47.53%  [kernel]                 [k] compaction_alloc
>     38.88%  [kernel]                 [k] __pageblock_pfn_to_page
>      6.68%  [kernel]                 [k] nmi
>      0.58%  [kernel]                 [k] __list_del_entry_valid
>      0.48%  [kernel]                 [k] format_decode
>      0.39%  [kernel]                 [k] __rb_insert_augmented
>      0.25%  libdbus-1.so.3.19.9      [.] _dbus_string_hex_decode
>      0.24%  [kernel]                 [k] entry_SYSCALL_64_after_hwframe
>      0.20%  perf                     [.] rb_next
>      0.19%  perf                     [.] __symbols__insert

Incase this is asked for later:

# find . -maxdepth 1 -type f | while read f; do echo "$f
---------------------"; cat $f; echo " "; done
./environ ---------------------

./auxv ---------------------

./status ---------------------
Name: khugepaged
Umask: 0000
State: R (running)
Tgid: 77
Ngid: 0
Pid: 77
PPid: 2
TracerPid: 0
Uid: 0 0 0 0
Gid: 0 0 0 0
FDSize: 64
Groups:
NStgid: 77
NSpid: 77
NSpgid: 0
NSsid: 0
Threads: 1
SigQ: 1/257125
SigPnd: 0000000000000000
ShdPnd: 0000000000000000
SigBlk: 0000000000000000
SigIgn: ffffffffffffffff
SigCgt: 0000000000000000
CapInh: 0000000000000000
CapPrm: 0000003fffffffff
CapEff: 0000003fffffffff
CapBnd: 0000003fffffffff
CapAmb: 0000000000000000
NoNewPrivs: 0
Seccomp: 0
Speculation_Store_Bypass: thread vulnerable
Cpus_allowed: fff
Cpus_allowed_list: 0-11
Mems_allowed: 1
Mems_allowed_list: 0
voluntary_ctxt_switches: 7728
nonvoluntary_ctxt_switches: 94662

./personality ---------------------
00000000

./limits ---------------------
Limit                     Soft Limit           Hard Limit           Units
Max cpu time              unlimited            unlimited            seconds
Max file size             unlimited            unlimited            bytes
Max data size             unlimited            unlimited            bytes
Max stack size            8388608              unlimited            bytes
Max core file size        0                    unlimited            bytes
Max resident set          unlimited            unlimited            bytes
Max processes             257125               257125               processes
Max open files            1024                 4096                 files
Max locked memory         65536                65536                bytes
Max address space         unlimited            unlimited            bytes
Max file locks            unlimited            unlimited            locks
Max pending signals       257125               257125               signals
Max msgqueue size         819200               819200               bytes
Max nice priority         0                    0
Max realtime priority     0                    0
Max realtime timeout      unlimited            unlimited            us

./sched ---------------------
khugepaged (77, #threads: 1)
-------------------------------------------------------------------
se.exec_start                                :      84565632.684623
se.vruntime                                  :      30287808.462012
se.sum_exec_runtime                          :       5808238.978150
se.nr_migrations                             :                  946
nr_switches                                  :               102390
nr_voluntary_switches                        :                 7728
nr_involuntary_switches                      :                94662
se.load.weight                               :                15360
se.runnable_weight                           :                15360
se.avg.load_sum                              :                47454
se.avg.runnable_load_sum                     :                47454
se.avg.util_sum                              :             48835831
se.avg.load_avg                              :                   14
se.avg.runnable_load_avg                     :                   14
se.avg.util_avg                              :                 1024
se.avg.last_update_time                      :       84565632684032
se.avg.util_est.ewma                         :                   25
se.avg.util_est.enqueued                     :                   16
policy                                       :                    0
prio                                         :                  139
clock-delta                                  :                   11

./comm ---------------------
khugepaged

./syscall ---------------------
running

./cmdline ---------------------

./stat ---------------------
77 (khugepaged) R 2 0 0 0 -1 27265088 0 0 0 0 0 580824 0 0 39 19 1 0
725 0 0 18446744073709551615 0 0 0 0 0 0 0 2147483647 0 0 0 0 17 4 0 0
0 0 0 0 0 0 0 0 0 0 0

./statm ---------------------
0 0 0 0 0 0 0

./maps ---------------------

./mem ---------------------

./clear_refs ---------------------
cat: ./clear_refs: Invalid argument

./smaps ---------------------

./smaps_rollup ---------------------
cat: ./smaps_rollup: No such process

./pagemap ---------------------

./wchan ---------------------
0
./stack ---------------------
[<0>] 0xffffffffffffffff

./schedstat ---------------------
5808249976150 707215957352 102392

./latency ---------------------
Latency Top version : v0.1

./cpuset ---------------------
/

./cgroup ---------------------
11:perf_event:/
10:cpuset:/
9:devices:/
8:rdma:/
7:cpu,cpuacct:/
6:blkio:/
5:freezer:/
4:net_cls:/
3:memory:/
2:pids:/
1:name=systemd:/
0::/


./oom_score ---------------------
0

./oom_adj ---------------------
0

./oom_score_adj ---------------------
0

./coredump_filter ---------------------

./io ---------------------
rchar: 0
wchar: 0
syscr: 0
syscw: 0
read_bytes: 0
write_bytes: 0
cancelled_write_bytes: 0

./uid_map ---------------------
         0          0 4294967295

./gid_map ---------------------
         0          0 4294967295

./projid_map ---------------------
         0          0 4294967295

./setgroups ---------------------
allow

./timerslack_ns ---------------------
50000

./stack_depth ---------------------
previous stack depth: 16376
stack depth: 16376
