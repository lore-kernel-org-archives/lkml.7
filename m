Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC88C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE7920854
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfCOMys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 08:54:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36515 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbfCOMyr (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 08:54:47 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D60FB301BE96;
        Fri, 15 Mar 2019 12:54:46 +0000 (UTC)
Received: from krava (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id D9FDA1001DC0;
        Fri, 15 Mar 2019 12:54:44 +0000 (UTC)
Date:   Fri, 15 Mar 2019 13:54:43 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2] perf annotate/report: Remove hist__account_cycles
 from callback
Message-ID: <20190315125443.GG1400@krava>
References: <1552657561-15744-1-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552657561-15744-1-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 15 Mar 2019 12:54:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 09:46:01PM +0800, Jin Yao wrote:
> The hist__account_cycles is executed when the hist_iter__branch_callback
> is called. But it looks it's not necessary. In hist__account_cycles, it
> already walks on all branch entries.
> 
> This patch moves the hist__account_cycles out of callback, now the data
> processing is much faster than before.
> 
> Previous code has an issue that the ch[offset].num++
> (in __symbol__account_cycles) is executed repeatedly since
> hist__account_cycles is called in each hist_iter__branch_callback,
> so the counting of ch[offset].num is not correct (too big).
> With this patch, the issue is fixed. And we don't need the code of
> "ch->reset >= ch->num / 2" to check if there are too many overlaps
> (in annotation__count_and_fill), otherwise some data would be
> hidden.
> 
> Now, we can try, for example:
> 
> perf record -b ...
> perf annotate or perf report -s symbol

im getting crash in stdio mode:

[root@krava perf]# ./perf record -b ./perf bench sched pipe
# Running 'sched/pipe' benchmark:
# Executed 1000000 pipe operations between two processes

     Total time: 21.384 [sec]

      21.384381 usecs/op
          46763 ops/sec
[ perf record: Woken up 464 times to write data ]
[ perf record: Captured and wrote 116.873 MB perf.data (150149 samples) ]
[root@krava perf]# ./perf report
File perf.data not owned by current user or root (use -f to override)
[root@krava perf]# ./perf report -f
[root@krava perf]# ./perf report -f --stdio
Segmentation fault (core dumped)


(gdb) r report -f --stdio
Starting program: /home/jolsa/kernel/linux-perf/tools/perf/perf report -f --stdio
Missing separate debuginfos, use: dnf debuginfo-install glibc-2.27-37.fc28.x86_64
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".
warning: Loadable section ".note.gnu.property" outside of ELF segments
Detaching after fork from child process 706.

Program received signal SIGSEGV, Segmentation fault.
symbol__cycles_hist (sym=0xcfb730) at util/annotate.c:892
892             if (!notes->src->cycles_hist) {
Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-1.0.6-26.fc28.x86_64 elfutils-libelf-0.174-5.fc28.x86_64 elfutils-libs-0.174-5.fc28.x86_64 libgcc-8.3.1-2.fc28.x86_64 libunwind-1.2.1-5.fc28.x86_64 libxcrypt-4.4.4-1.fc28.x86_64 numactl-libs-2.0.11-8.fc28.x86_64 openssl-libs-1.1.0i-1.fc28.x86_64 perl-libs-5.26.3-416.fc28.x86_64 python2-libs-2.7.15-4.fc28.x86_64 slang-2.3.2-2.fc28.x86_64 xz-libs-5.2.4-2.fc28.x86_64 zlib-1.2.11-8.fc28.x86_64
(gdb) bt
#0  symbol__cycles_hist (sym=0xcfb730) at util/annotate.c:892
#1  0x00000000004d91e8 in symbol__account_cycles (addr=140735827492712, start=140735827492708, sym=0xcfb730, cycles=2) at util/annotate.c:942
#2  0x00000000004d9403 in addr_map_symbol__account_cycles (ams=0xd629d8, start=0xd62a68, cycles=2) at util/annotate.c:989
#3  0x000000000056fccd in hist__account_cycles (bs=0x7fffed05f230, al=0x7fffffffaac0, sample=0x7fffffffac50, nonany_branch_mode=false) at util/hist.c:2527
#4  0x0000000000448f6d in process_sample_event (tool=0x7fffffffb7d0, event=0x7fffed05f208, sample=0x7fffffffac50, evsel=0xccc920, machine=0xcc5ee0) at builtin-report.c:279
#5  0x000000000053e7dd in perf_evlist__deliver_sample (evlist=0xcc5030, tool=0x7fffffffb7d0, event=0x7fffed05f208, sample=0x7fffffffac50, evsel=0xccc920, machine=0xcc5ee0) at util/session.c:1251
#6  0x000000000053e971 in machines__deliver_event (machines=0xcc5ee0, evlist=0xcc5030, event=0x7fffed05f208, sample=0x7fffffffac50, tool=0x7fffffffb7d0, file_offset=29192) at util/session.c:1288
#7  0x000000000053edc3 in perf_session__deliver_event (session=0xcc5de0, event=0x7fffed05f208, tool=0x7fffffffb7d0, file_offset=29192) at util/session.c:1361
#8  0x000000000053b772 in ordered_events__deliver_event (oe=0xccc878, event=0xceae60) at util/session.c:116
#9  0x0000000000543030 in do_flush (oe=0xccc878, show_progress=false) at util/ordered-events.c:243
#10 0x000000000054335f in __ordered_events__flush (oe=0xccc878, how=OE_FLUSH__ROUND, timestamp=0) at util/ordered-events.c:320
#11 0x0000000000543434 in ordered_events__flush (oe=0xccc878, how=OE_FLUSH__ROUND) at util/ordered-events.c:338
#12 0x000000000053d7dd in process_finished_round (tool=0x7fffffffb7d0, event=0x7fffed106358, oe=0xccc878) at util/session.c:871
#13 0x000000000053eff3 in perf_session__process_user_event (session=0xcc5de0, event=0x7fffed106358, file_offset=713560) at util/session.c:1401
#14 0x000000000053f67e in perf_session__process_event (session=0xcc5de0, event=0x7fffed106358, file_offset=713560) at util/session.c:1528
#15 0x000000000054066d in process_simple (session=0xcc5de0, event=0x7fffed106358, file_offset=713560) at util/session.c:1961
#16 0x00000000005404d5 in reader__process_events (rd=0x7fffffffb560, session=0xcc5de0, prog=0x7fffffffb580) at util/session.c:1931
#17 0x0000000000540759 in __perf_session__process_events (session=0xcc5de0) at util/session.c:1984
#18 0x000000000054088a in perf_session__process_events (session=0xcc5de0) at util/session.c:2017
#19 0x000000000044a984 in __cmd_report (rep=0x7fffffffb7d0) at builtin-report.c:852
#20 0x000000000044cc24 in cmd_report (argc=0, argv=0x7fffffffd960) at builtin-report.c:1440
#21 0x00000000004d408b in run_builtin (p=0xb47d30 <commands+240>, argc=3, argv=0x7fffffffd960) at perf.c:302
#22 0x00000000004d42f8 in handle_internal_command (argc=3, argv=0x7fffffffd960) at perf.c:354
#23 0x00000000004d4447 in run_argv (argcp=0x7fffffffd7bc, argv=0x7fffffffd7b0) at perf.c:398
#24 0x00000000004d47b3 in main (argc=3, argv=0x7fffffffd960) at perf.c:520


jirka
