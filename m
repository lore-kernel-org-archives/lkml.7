Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB996C3A59D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB61B233A2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566329308;
	bh=GbSwGnoYWeKaa3ZCZBbjL3KfjdtyxpDRtHRgWqsG3nI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gvxTV4rKsEgwSuBHBW0UnfR3DDaobRjvYUuIziNNsF0xcgByG8++0JAnmsVPydkeq
	 5vXNbHCGnRr+7dmSaalp4Xygxs9lERp8g+jspmKiIoXpu3oJ1aggTI1fARCabZffij
	 qUlaUnggBpKFCY+1pzBcdlr0eHL04NTSFMmuuu34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730863AbfHTT21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 15:28:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730795AbfHTT2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 15:28:25 -0400
Received: from quaco.ghostprotocols.net (177.206.236.100.dynamic.adsl.gvt.net.br [177.206.236.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D70E322DD6;
        Tue, 20 Aug 2019 19:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566329304;
        bh=GbSwGnoYWeKaa3ZCZBbjL3KfjdtyxpDRtHRgWqsG3nI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EJF1kTzSz3rFedcMkrzWUKc+mr2f+l6JOVINOlPz3QKyyk4mHxAh94zQrsCh7uEyY
         LJogqdhpItiaVDjjG/1Cyqi0aL4O4Fn32nFT5WVjpEDtonTJPCnL5dVxfHfO00QcDB
         kr7cJBQlQdAw3/6+o+p5EwVykiE5x80EDSCh5ZyY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 08/17] perf record: Enable LBR callstack capture jointly with thread stack
Date:   Tue, 20 Aug 2019 16:27:24 -0300
Message-Id: <20190820192733.19180-9-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820192733.19180-1-acme@kernel.org>
References: <20190820192733.19180-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Budankov <alexey.budankov@linux.intel.com>

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
index 726e8d9e8c54..4ed20c833d44 100644
--- a/tools/perf/util/parse-branch-options.c
+++ b/tools/perf/util/parse-branch-options.c
@@ -30,6 +30,7 @@ static const struct branch_mode branch_modes[] = {
 	BRANCH_OPT("ind_jmp", PERF_SAMPLE_BRANCH_IND_JUMP),
 	BRANCH_OPT("call", PERF_SAMPLE_BRANCH_CALL),
 	BRANCH_OPT("save_type", PERF_SAMPLE_BRANCH_TYPE_SAVE),
+	BRANCH_OPT("stack", PERF_SAMPLE_BRANCH_CALL_STACK),
 	BRANCH_END
 };
 
-- 
2.21.0

