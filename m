Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9632EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692AC2341D
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390713AbfHWC2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 22:28:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33815 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390502AbfHWC2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 22:28:22 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i0zJC-0001AR-FS; Fri, 23 Aug 2019 04:28:10 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1349E1C0883;
        Fri, 23 Aug 2019 04:28:10 +0200 (CEST)
Date:   Fri, 23 Aug 2019 02:28:09 -0000
From:   tip-bot2 for Alexey Budankov <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf record: Enable LBR callstack capture jointly
 with thread stack
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
In-Reply-To: <e9e00090-66fb-d2a4-c90f-1d12344f7788@linux.intel.com>
References: <e9e00090-66fb-d2a4-c90f-1d12344f7788@linux.intel.com>
MIME-Version: 1.0
Message-ID: <156652728996.12710.3122701757092644139.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from
 these emails
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2566349648b40aa3f5edf6af8f7f893ccd6e4eae
Gitweb:        https://git.kernel.org/tip/2566349648b40aa3f5edf6af8f7f893ccd6e4eae
Author:        Alexey Budankov <alexey.budankov@linux.intel.com>
AuthorDate:    Fri, 09 Aug 2019 18:23:58 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 20 Aug 2019 12:18:58 -03:00

perf record: Enable LBR callstack capture jointly with thread stack

Enable '-j stack' applicability together with '--call-graph dwarf'
option so thread stack data and LBR call stack could be captured
jointly:

  $ perf record -g --call-graph dwarf,1024 -j stack,u -- stack_test

Collected LBR call stack can be used to augment DWARF call stack
calculated from the raw thread stack data and to provide more
comprehensive call stack information for cases when collected SIZE is
not enough to cover complete thread stack.

Such cases are typical for workloads that allocate large arrays of data
on its threads stacks or the possible SIZE to collect can't be large
enough due to workload nature or system configuration and this is where
hardware captured LBR call stacks can provide missing stack frames.
Possible DWARF plus LBR call stacks consolidation algorithm description
follows.

With this patch set perf report command UI currently ignores collected
LBR call stack data and still provides DWARF based call stacks
information.

  ===========================================================================

  Overview:

   Legend:

   THS - thread stack
   CTX - thread register context
   SWS - software stack
   SSF - skipped stack frames
   PSS - Perf sample stack

   ip,sp,bp - HW registers values
   d        - allocated stack regions
   kip      - ip address in the kernel space
   K        - captured thread stack size

        THS

       -----
       |   |<-stack bottom
        ...
       |---|
       |ip4|
       |---|         PSS = SWS(THS(K))
       |   |
   --> |   |
   |   |d3 |                  user/
   |   |---|         user PSS kernel PSS
   |   |ip3|         ------   ------
   |   |---|         |SSF |   |SSF |
   |   |   |          ....     ....
   |   |   |         ------   ------
   |   |d2 |         | -1 |   | -1 |
       |---|   user  ------   ------
   K   |ip2|   CTX   |ip3 |   |ip3 |
       |---|         |----|   |----|
   |   |d1 |   ...   |ip2 | , |ip2 |
   |   |---|  |---|  |----|   |----|
   |   |ip1|  |bp0|  |ip1 |   |ip1 |
   |   |---|  |---|  |----|   |----|
   |   |   |  |ip0|->|ip0 |   |ip0 |<-user stack top
   |   |   |  |---|  ------   ------
   |   |   |<-|sp0|<-stack    |kip0|<-kernel stack bottom
   --> -----  -----   top     |----|
                              |kip1|
                              |----|
		              |kip2|
		              |----|
                               ....
			      |    |<-kernel stack top
                              ------

  Algorithm details:

   Legend:

   HWS - hardware stack
   K-SWS - kernel software stack

			 BRANCH
			 TABLE

		 HWS      ip   ip
			  from to
		 ------  -----------
		 |ip7`|  |ip7`|    |
		 |----|  |----|----|
		 |ip6`|  |ip6`|    |
	user PSS |----|  |----|----|
		 |ip5`|  |ip5`|    |
	------   |----|  |----|----|
	| -1 |   |ip4`|  |ip4`|    |
	------   |----|  |----|----|
	|ip3 |~~~|ip3`|  |ip3`|    |
	|----|   |----|  |----|----|
	|ip2 |~~~|ip2`|  |ip2`|    |
	|----| 	 |----|  |----|----|
	|ip1 |~~~|ip1`|  |ip1`|ip0`|
	|----| 	 |----|  -----------
	|ip0 |~~~|ip0`|<---------'
	------   ------

	1. if (sym(ipj) == sym(ipj`)), j=0-3 ===> user PSS
	2. ipj`                      , j=4-7 ===> user PSS

  Augmented PSS = A_SWS(SWS(THS(K)), HWS):

	         user/
       user PSS  kernel PSS

	------   ------
	|ip7`|   |ip7`|<-user PSS bottom
	|----|   |----|
	|ip6`|   |ip6`|
	|----|   |----|
    HWS	|ip5`|   |ip5`|
	|----|   |----|
	|ip4`|   |ip4`|
	------   ------
	|ip3 |   |ip3 |
	|----|   |----|
    SWS |ip2 |   |ip2 |
	|----|   |----|
	|ip1 |   |ip1 |
	|----|   |----|
	|ip0 |   |ip0 |<-user PSS top
	------   ------
		 |kip0|<-kernel PSS bottom
		 |----|
		 |kip1|
	   K-SWS |----|
		 |kip2|
		 |----|
		 |kip3|<-kernel PSS top
		 ------

                  APSS

Committer testing:

Before:

  # perf record -g --call-graph dwarf,1024 -j stack,u ls > /dev/null
  unknown branch filter stack, check man page

   Usage: perf record [<options>] [<command>]
      or: perf record [<options>] -- <command> [<options>]

      -j, --branch-filter <branch filter mask>
                            branch stack filter modes
  # perf record -g --call-graph dwarf,1024 -j u ls > /dev/null
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.054 MB perf.data (12 samples) ]
  # perf evlist -v
  cycles: size: 112, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|CALLCHAIN|PERIOD|BRANCH_STACK|REGS_USER|STACK_USER|DATA_SRC, read_format: ID, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, enable_on_exec: 1, task: 1, precise_ip: 3, mmap_data: 1, sample_id_all: 1, exclude_guest: 1, exclude_callchain_user: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1, branch_sample_type: ANY, sample_regs_user: 0xff0fff, sample_stack_user: 1024
   #

After:

  # perf record -g --call-graph dwarf,1024 -j stack,u ls > /dev/null
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.044 MB perf.data (11 samples) ]
  [root@quaco ~]# perf evlist -v
  cycles: size: 112, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|CALLCHAIN|PERIOD|BRANCH_STACK|REGS_USER|STACK_USER|DATA_SRC, read_format: ID, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, enable_on_exec: 1, task: 1, precise_ip: 3, mmap_data: 1, sample_id_all: 1, exclude_guest: 1, exclude_callchain_user: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1, branch_sample_type: USER|CALL_STACK, sample_regs_user: 0xff0fff, sample_stack_user: 1024
  #

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/e9e00090-66fb-d2a4-c90f-1d12344f7788@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-branch-options.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/parse-branch-options.c b/tools/perf/util/parse-branch-options.c
index 726e8d9..4ed20c8 100644
--- a/tools/perf/util/parse-branch-options.c
+++ b/tools/perf/util/parse-branch-options.c
@@ -30,6 +30,7 @@ static const struct branch_mode branch_modes[] = {
 	BRANCH_OPT("ind_jmp", PERF_SAMPLE_BRANCH_IND_JUMP),
 	BRANCH_OPT("call", PERF_SAMPLE_BRANCH_CALL),
 	BRANCH_OPT("save_type", PERF_SAMPLE_BRANCH_TYPE_SAVE),
+	BRANCH_OPT("stack", PERF_SAMPLE_BRANCH_CALL_STACK),
 	BRANCH_END
 };
 
