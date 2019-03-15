Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0243BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D9021871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbfCONMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:12:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:37510 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727071AbfCONMm (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:12:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Mar 2019 06:12:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,482,1544515200"; 
   d="scan'208";a="127236776"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.254.211.155]) ([10.254.211.155])
  by orsmga006.jf.intel.com with ESMTP; 15 Mar 2019 06:12:39 -0700
Subject: Re: [PATCH v2] perf annotate/report: Remove hist__account_cycles from
 callback
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <1552657561-15744-1-git-send-email-yao.jin@linux.intel.com>
 <20190315125443.GG1400@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <7c93fd7d-882e-1d75-39bc-5cb40ed1976a@linux.intel.com>
Date:   Fri, 15 Mar 2019 21:12:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190315125443.GG1400@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/15/2019 8:54 PM, Jiri Olsa wrote:
> On Fri, Mar 15, 2019 at 09:46:01PM +0800, Jin Yao wrote:
>> The hist__account_cycles is executed when the hist_iter__branch_callback
>> is called. But it looks it's not necessary. In hist__account_cycles, it
>> already walks on all branch entries.
>>
>> This patch moves the hist__account_cycles out of callback, now the data
>> processing is much faster than before.
>>
>> Previous code has an issue that the ch[offset].num++
>> (in __symbol__account_cycles) is executed repeatedly since
>> hist__account_cycles is called in each hist_iter__branch_callback,
>> so the counting of ch[offset].num is not correct (too big).
>> With this patch, the issue is fixed. And we don't need the code of
>> "ch->reset >= ch->num / 2" to check if there are too many overlaps
>> (in annotation__count_and_fill), otherwise some data would be
>> hidden.
>>
>> Now, we can try, for example:
>>
>> perf record -b ...
>> perf annotate or perf report -s symbol
> 
> im getting crash in stdio mode:
> 
> [root@krava perf]# ./perf record -b ./perf bench sched pipe
> # Running 'sched/pipe' benchmark:
> # Executed 1000000 pipe operations between two processes
> 
>       Total time: 21.384 [sec]
> 
>        21.384381 usecs/op
>            46763 ops/sec
> [ perf record: Woken up 464 times to write data ]
> [ perf record: Captured and wrote 116.873 MB perf.data (150149 samples) ]
> [root@krava perf]# ./perf report
> File perf.data not owned by current user or root (use -f to override)
> [root@krava perf]# ./perf report -f
> [root@krava perf]# ./perf report -f --stdio
> Segmentation fault (core dumped)
> 
> 
> (gdb) r report -f --stdio
> Starting program: /home/jolsa/kernel/linux-perf/tools/perf/perf report -f --stdio
> Missing separate debuginfos, use: dnf debuginfo-install glibc-2.27-37.fc28.x86_64
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib64/libthread_db.so.1".
> warning: Loadable section ".note.gnu.property" outside of ELF segments
> Detaching after fork from child process 706.
> 
> Program received signal SIGSEGV, Segmentation fault.
> symbol__cycles_hist (sym=0xcfb730) at util/annotate.c:892
> 892             if (!notes->src->cycles_hist) {
> Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-1.0.6-26.fc28.x86_64 elfutils-libelf-0.174-5.fc28.x86_64 elfutils-libs-0.174-5.fc28.x86_64 libgcc-8.3.1-2.fc28.x86_64 libunwind-1.2.1-5.fc28.x86_64 libxcrypt-4.4.4-1.fc28.x86_64 numactl-libs-2.0.11-8.fc28.x86_64 openssl-libs-1.1.0i-1.fc28.x86_64 perl-libs-5.26.3-416.fc28.x86_64 python2-libs-2.7.15-4.fc28.x86_64 slang-2.3.2-2.fc28.x86_64 xz-libs-5.2.4-2.fc28.x86_64 zlib-1.2.11-8.fc28.x86_64
> (gdb) bt
> #0  symbol__cycles_hist (sym=0xcfb730) at util/annotate.c:892
> #1  0x00000000004d91e8 in symbol__account_cycles (addr=140735827492712, start=140735827492708, sym=0xcfb730, cycles=2) at util/annotate.c:942
> #2  0x00000000004d9403 in addr_map_symbol__account_cycles (ams=0xd629d8, start=0xd62a68, cycles=2) at util/annotate.c:989
> #3  0x000000000056fccd in hist__account_cycles (bs=0x7fffed05f230, al=0x7fffffffaac0, sample=0x7fffffffac50, nonany_branch_mode=false) at util/hist.c:2527
> #4  0x0000000000448f6d in process_sample_event (tool=0x7fffffffb7d0, event=0x7fffed05f208, sample=0x7fffffffac50, evsel=0xccc920, machine=0xcc5ee0) at builtin-report.c:279
> #5  0x000000000053e7dd in perf_evlist__deliver_sample (evlist=0xcc5030, tool=0x7fffffffb7d0, event=0x7fffed05f208, sample=0x7fffffffac50, evsel=0xccc920, machine=0xcc5ee0) at util/session.c:1251
> #6  0x000000000053e971 in machines__deliver_event (machines=0xcc5ee0, evlist=0xcc5030, event=0x7fffed05f208, sample=0x7fffffffac50, tool=0x7fffffffb7d0, file_offset=29192) at util/session.c:1288
> #7  0x000000000053edc3 in perf_session__deliver_event (session=0xcc5de0, event=0x7fffed05f208, tool=0x7fffffffb7d0, file_offset=29192) at util/session.c:1361
> #8  0x000000000053b772 in ordered_events__deliver_event (oe=0xccc878, event=0xceae60) at util/session.c:116
> #9  0x0000000000543030 in do_flush (oe=0xccc878, show_progress=false) at util/ordered-events.c:243
> #10 0x000000000054335f in __ordered_events__flush (oe=0xccc878, how=OE_FLUSH__ROUND, timestamp=0) at util/ordered-events.c:320
> #11 0x0000000000543434 in ordered_events__flush (oe=0xccc878, how=OE_FLUSH__ROUND) at util/ordered-events.c:338
> #12 0x000000000053d7dd in process_finished_round (tool=0x7fffffffb7d0, event=0x7fffed106358, oe=0xccc878) at util/session.c:871
> #13 0x000000000053eff3 in perf_session__process_user_event (session=0xcc5de0, event=0x7fffed106358, file_offset=713560) at util/session.c:1401
> #14 0x000000000053f67e in perf_session__process_event (session=0xcc5de0, event=0x7fffed106358, file_offset=713560) at util/session.c:1528
> #15 0x000000000054066d in process_simple (session=0xcc5de0, event=0x7fffed106358, file_offset=713560) at util/session.c:1961
> #16 0x00000000005404d5 in reader__process_events (rd=0x7fffffffb560, session=0xcc5de0, prog=0x7fffffffb580) at util/session.c:1931
> #17 0x0000000000540759 in __perf_session__process_events (session=0xcc5de0) at util/session.c:1984
> #18 0x000000000054088a in perf_session__process_events (session=0xcc5de0) at util/session.c:2017
> #19 0x000000000044a984 in __cmd_report (rep=0x7fffffffb7d0) at builtin-report.c:852
> #20 0x000000000044cc24 in cmd_report (argc=0, argv=0x7fffffffd960) at builtin-report.c:1440
> #21 0x00000000004d408b in run_builtin (p=0xb47d30 <commands+240>, argc=3, argv=0x7fffffffd960) at perf.c:302
> #22 0x00000000004d42f8 in handle_internal_command (argc=3, argv=0x7fffffffd960) at perf.c:354
> #23 0x00000000004d4447 in run_argv (argcp=0x7fffffffd7bc, argv=0x7fffffffd7b0) at perf.c:398
> #24 0x00000000004d47b3 in main (argc=3, argv=0x7fffffffd960) at perf.c:520
> 
> 
> jirka
> 

Oh, like previous code, it needs the checking of ui__has_annotation() 
before hist__account_cycles(), but I forgot to add this. :(

My mistake, sorry about that.

Thanks
Jin Yao

