Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C01C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39FBD2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfCRMGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:06:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:11858 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbfCRMGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:06:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 05:06:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,493,1544515200"; 
   d="scan'208";a="127928576"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 18 Mar 2019 05:06:29 -0700
Received: from [10.125.252.163] (abudanko-mobl.ccr.corp.intel.com [10.125.252.163])
        by linux.intel.com (Postfix) with ESMTP id 99D7C58041A;
        Mon, 18 Mar 2019 05:06:27 -0700 (PDT)
Subject: Re: [PATCH v9 10/12] perf report: implement record trace
 decompression
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <c1423198-e474-1739-e800-4615cce501ce@linux.intel.com>
 <f688ddcd-99cf-ee59-06d7-205fa0dd2f3f@linux.intel.com>
 <20190318114619.GA7900@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <fd0e44e1-beec-7ebb-e617-72824dbd3399@linux.intel.com>
Date:   Mon, 18 Mar 2019 15:06:26 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190318114619.GA7900@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.03.2019 14:46, Jiri Olsa wrote:
> On Sat, Mar 16, 2019 at 05:17:06PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>>  static int perf_session__deliver_event(struct perf_session *session,
>>  				       union perf_event *event,
>>  				       struct perf_tool *tool,
>> @@ -198,12 +259,23 @@ static void perf_session__delete_threads(struct perf_session *session)
>>  
>>  void perf_session__delete(struct perf_session *session)
>>  {
>> +	struct decomp *next, *decomp;
>> +	size_t decomp_len;
>>  	if (session == NULL)
>>  		return;
>>  	auxtrace__free(session);
>>  	auxtrace_index__free(&session->auxtrace_index);
>>  	perf_session__destroy_kernel_maps(session);
>>  	perf_session__delete_threads(session);
>> +	next = session->decomp;
>> +	decomp_len = session->header.env.comp_mmap_len;
>> +	do {
>> +		decomp = next;
>> +		if (decomp == NULL)
>> +			break;
>> +		next = decomp->next;
>> +		munmap(decomp, decomp_len + sizeof(struct decomp));
>> +	} while (1);
> 
> please put this to separate function

in v10.

~Alexey

> 
> thanks,
> jirka
> 
