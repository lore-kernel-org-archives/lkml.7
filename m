Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158AACA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1CA20679
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbfJULZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 07:25:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:33477 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728384AbfJULZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 07:25:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 04:25:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,323,1566889200"; 
   d="scan'208";a="227286627"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 21 Oct 2019 04:25:03 -0700
Received: from [10.125.253.9] (abudanko-mobl.ccr.corp.intel.com [10.125.253.9])
        by linux.intel.com (Postfix) with ESMTP id 3E0E558029D;
        Mon, 21 Oct 2019 04:25:00 -0700 (PDT)
Subject: Re: [PATCH v3 1/4] perf/core,x86: introduce sync_task_ctx() method at
 struct pmu
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <0b20a07f-d074-d3da-7551-c9a4a94fe8e3@linux.intel.com>
 <c75134ef-b71b-c080-8ee1-c09fb9fae764@linux.intel.com>
 <20191021102706.GE1800@hirez.programming.kicks-ass.net>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <975abbb4-7b3d-32a6-e21d-a9c161aabc01@linux.intel.com>
Date:   Mon, 21 Oct 2019 14:24:59 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191021102706.GE1800@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21.10.2019 13:27, Peter Zijlstra wrote:
> On Fri, Oct 18, 2019 at 12:42:44PM +0300, Alexey Budankov wrote:
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index 61448c19a132..60bf17af69f0 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -409,6 +409,13 @@ struct pmu {
>>  	 */
>>  	size_t				task_ctx_size;
>>  
>> +	/*
>> +	 * PMU specific parts of task perf event context (i.e. ctx->task_ctx_data)
>> +	 * can be synchronized using this function. See Intel LBR callstack support
>> +	 * implementation and Perf core context switch handling callbacks for usage
>> +	 * examples.
> 
> You're forgetting to mark this: Optional

Fixed in v4.

> 
>> +	 */
> 
>> +	void (*sync_task_ctx)		(void *one, void *another);
> 
> The traditional argment names for context switching functions are prev
> and next.

Fixed in v4.

Thanks,
Alexey
