Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B2DC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07702171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407237AbfHIPQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:16:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:2361 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfHIPQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:16:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 08:16:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,364,1559545200"; 
   d="scan'208";a="193407232"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 09 Aug 2019 08:16:07 -0700
Received: from [10.252.0.91] (abudanko-mobl.ccr.corp.intel.com [10.252.0.91])
        by linux.intel.com (Postfix) with ESMTP id 302325801AB;
        Fri,  9 Aug 2019 08:16:03 -0700 (PDT)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v1 0/3] collect LBR callstack together with thread stack data
Organization: Intel Corp.
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <ec5fe6b1-a116-fb60-42c6-dc8a9dedfc15@linux.intel.com>
Date:   Fri, 9 Aug 2019 18:16:02 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The patch set unblocks collection of LBR call stack data simultaneously with
raw thread stack data by --call-graph dwarf,SIZE option:

  $perf record -g --call-graph dwarf,1024 -j stack,u -- stack_test

Collected LBR call stack can be used to augment dwarf call stack calculated 
from the raw thread stack data and to provide more comprehensive call stack 
information for cases when collected SIZE is not enough to cover complete 
thread stack.

Such cases are typical for workloads that allocate large arrays of data on 
its threads stacks or the possible SIZE to collect can't be large enough due 
to workload nature or system configuration and this is where hardware 
captured LBR call stacks can provide missing stack frames. Possible dwarf plus 
LBR call stacks consolidation algorithm description follows.

With this patch set perf report command UI currently ignores collected LBR 
call stack data and still provides dwarf based call stacks information.

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

===========================================================================

---
Alexey Budankov (3):
  perf record: enable LBR callstack capture jointly with thread stack
  perf report: dump LBR callstack data by -D jointly with thread stack
  perf report: prefer dwarf callstacks to LBR ones when captured both

 tools/perf/builtin-report.c            |  2 ++
 tools/perf/util/parse-branch-options.c |  1 +
 tools/perf/util/session.c              | 31 ++++++++++++++++----------
 3 files changed, 22 insertions(+), 12 deletions(-)

-- 
2.20.1

