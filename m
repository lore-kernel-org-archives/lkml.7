Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4453C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756F620675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfCFOZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 09:25:16 -0500
Received: from mga12.intel.com ([192.55.52.136]:6878 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbfCFOZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 09:25:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2019 06:25:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,448,1544515200"; 
   d="scan'208";a="149131067"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.56]) ([10.237.72.56])
  by fmsmga002.fm.intel.com with ESMTP; 06 Mar 2019 06:25:12 -0800
Subject: Re: [PATCH v4 03/15] perf tools script: Filter COMM/FORK/.. events by
 CPU
To:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
References: <20190305144758.12397-1-andi@firstfloor.org>
 <20190305144758.12397-4-andi@firstfloor.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <6d837d6b-da67-9878-dcc5-a2b0f2dc6826@intel.com>
Date:   Wed, 6 Mar 2019 16:23:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190305144758.12397-4-andi@firstfloor.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/03/19 4:47 PM, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> The --cpu option only filtered samples. Filter other perf events,
> such as COMM, FORK, SWITCH by the CPU too.

Because tasks can migrate from cpu to cpu, we probably need to process most
of the events anyway, even if they are not printed.

> 
> Reported-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/builtin-script.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index fbc440bdf880..3813f60d1dc0 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2038,6 +2038,9 @@ static int process_comm_event(struct perf_tool *tool,
>  	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
>  	int ret = -1;
>  
> +	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
> +		return 0;
> +
>  	thread = machine__findnew_thread(machine, event->comm.pid, event->comm.tid);
>  	if (thread == NULL) {
>  		pr_debug("problem processing COMM event, skipping it.\n");
> @@ -2073,6 +2076,9 @@ static int process_namespaces_event(struct perf_tool *tool,
>  	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
>  	int ret = -1;
>  
> +	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
> +		return 0;
> +
>  	thread = machine__findnew_thread(machine, event->namespaces.pid,
>  					 event->namespaces.tid);
>  	if (thread == NULL) {
> @@ -2108,6 +2114,9 @@ static int process_fork_event(struct perf_tool *tool,
>  	struct perf_session *session = script->session;
>  	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
>  
> +	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
> +		return 0;
> +
>  	if (perf_event__process_fork(tool, event, sample, machine) < 0)
>  		return -1;
>  
> @@ -2141,6 +2150,9 @@ static int process_exit_event(struct perf_tool *tool,
>  	struct perf_session *session = script->session;
>  	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
>  
> +	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
> +		return 0;
> +
>  	thread = machine__findnew_thread(machine, event->fork.pid, event->fork.tid);
>  	if (thread == NULL) {
>  		pr_debug("problem processing EXIT event, skipping it.\n");
> @@ -2174,6 +2186,9 @@ static int process_mmap_event(struct perf_tool *tool,
>  	struct perf_session *session = script->session;
>  	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
>  
> +	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
> +		return 0;
> +
>  	if (perf_event__process_mmap(tool, event, sample, machine) < 0)
>  		return -1;
>  
> @@ -2206,6 +2221,9 @@ static int process_mmap2_event(struct perf_tool *tool,
>  	struct perf_session *session = script->session;
>  	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
>  
> +	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
> +		return 0;
> +
>  	if (perf_event__process_mmap2(tool, event, sample, machine) < 0)
>  		return -1;
>  
> @@ -2238,6 +2256,9 @@ static int process_switch_event(struct perf_tool *tool,
>  	struct perf_session *session = script->session;
>  	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
>  
> +	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
> +		return 0;
> +
>  	if (perf_event__process_switch(tool, event, sample, machine) < 0)
>  		return -1;
>  
> @@ -2266,6 +2287,9 @@ process_lost_event(struct perf_tool *tool,
>  	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
>  	struct thread *thread;
>  
> +	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
> +		return 0;
> +
>  	thread = machine__findnew_thread(machine, sample->pid,
>  					 sample->tid);
>  	if (thread == NULL)
> 

