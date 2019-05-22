Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E930C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFE920881
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbfEVVab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 17:30:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48346 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729896AbfEVVaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 17:30:30 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7C6723082A28;
        Wed, 22 May 2019 21:30:30 +0000 (UTC)
Received: from krava (ovpn-204-104.brq.redhat.com [10.40.204.104])
        by smtp.corp.redhat.com (Postfix) with SMTP id A56891001DE0;
        Wed, 22 May 2019 21:30:27 +0000 (UTC)
Date:   Wed, 22 May 2019 23:30:26 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH 12/12] perf script: Add --show-all-events option
Message-ID: <20190522213026.GB11325@krava>
References: <20190508132010.14512-1-jolsa@kernel.org>
 <20190508132010.14512-13-jolsa@kernel.org>
 <20190522161804.GG30271@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522161804.GG30271@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 22 May 2019 21:30:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 01:18:04PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, May 08, 2019 at 03:20:10PM +0200, Jiri Olsa escreveu:
> > Adding --show-all-events option to show all
> > side-bad events with single option, like:
> > 
> >   $ perf script --show-all-events
> >   swapper     0 [000]     0.000000: PERF_RECORD_MMAP -1/0: [0xffffffffa6000000(0xc00e41) @ 0xffffffffa6000000]: x [kernel.kallsyms]_text
> >   ...
> >   swapper     0 [000]     0.000000: PERF_RECORD_KSYMBOL addr ffffffffc01bc362 len 229 type 1 flags 0x0 name bpf_prog_7be49e3934a125ba
> >   swapper     0 [000]     0.000000: PERF_RECORD_BPF_EVENT type 1, flags 0, id 29
> >   ...
> >   swapper     0 [000]     0.000000: PERF_RECORD_FORK(1:1):(0:0)
> >   systemd     0 [000]     0.000000: PERF_RECORD_COMM: systemd:1/1
> >   ...
> >   swapper     0 [000] 63587.039518:          1 cycles:  ffffffffa60698b4 [unknown] ([kernel.kallsyms])
> >   swapper     0 [000] 63587.039522:          1 cycles:  ffffffffa60698b4 [unknown] ([kernel.kallsyms])
> 
> Strange:
> 
> [root@quaco pt]# 
> [root@quaco pt]# perf evlist -v
> intel_pt//ku: type: 8, size: 112, config: 0x300e601, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU|IDENTIFIER, read_format: ID, disabled: 1, inherit: 1, exclude_hv: 1, sample_id_all: 1
> dummy:u: type: 1, size: 112, config: 0x9, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU|IDENTIFIER, read_format: ID, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, task: 1, sample_id_all: 1, mmap2: 1, comm_exec: 1, context_switch: 1, ksymbol: 1, bpf_event: 1
> [root@quaco pt]# 
> 
> Then:
> 
> [root@quaco pt]# perf script --show-bpf-events  | head
>     0 PERF_RECORD_KSYMBOL addr ffffffffc029a6c3 len 229 type 1 flags 0x0 name bpf_prog_7be49e3934a125ba
>     0 PERF_RECORD_BPF_EVENT type 1, flags 0, id 47
>     0 PERF_RECORD_KSYMBOL addr ffffffffc029c1ae len 229 type 1 flags 0x0 name bpf_prog_2a142ef67aaad174
>     0 PERF_RECORD_BPF_EVENT type 1, flags 0, id 48
>     0 PERF_RECORD_KSYMBOL addr ffffffffc02ddd1c len 229 type 1 flags 0x0 name bpf_prog_7be49e3934a125ba
>     0 PERF_RECORD_BPF_EVENT type 1, flags 0, id 49
>     0 PERF_RECORD_KSYMBOL addr ffffffffc02dfc11 len 229 type 1 flags 0x0 name bpf_prog_2a142ef67aaad174
>     0 PERF_RECORD_BPF_EVENT type 1, flags 0, id 50
>     0 PERF_RECORD_KSYMBOL addr ffffffffc045da0a len 229 type 1 flags 0x0 name bpf_prog_7be49e3934a125ba
>     0 PERF_RECORD_BPF_EVENT type 1, flags 0, id 51
> [root@quaco pt]#
> 
> But:
> 
> [root@quaco pt]# perf script --show-all-events  | head
> Intel Processor Trace requires ordered events
> 0x2a0 [0x60]: failed to process type: 1 [Invalid argument]
> [root@quaco pt]#

hum, so round events disable ordering, which is required by pt

        if (script->show_round_events) {
                script->tool.ordered_events = false;
	..

so the --show-round-events option always fails on intel_pt data:

	[jolsa@krava perf]$ ./perf script --show-round-events
	Intel Processor Trace requires ordered events
	0x2e8 [0x38]: failed to process type: 3 [Invalid argument]

> 
> So I have all patches but this last one, will test and push Ingo's way
> so that we make progress, we can get this one later after we figure this
> out.

thanks,
jirka
