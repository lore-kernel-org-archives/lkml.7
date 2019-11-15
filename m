Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74ACBC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F4720728
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfKORJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 12:09:25 -0500
Received: from mga04.intel.com ([192.55.52.120]:12258 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727528AbfKORJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 12:09:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 09:09:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,308,1569308400"; 
   d="scan'208";a="288608552"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 15 Nov 2019 09:09:23 -0800
Received: from [10.252.8.77] (abudanko-mobl.ccr.corp.intel.com [10.252.8.77])
        by linux.intel.com (Postfix) with ESMTP id 6E48F5803E3;
        Fri, 15 Nov 2019 09:09:21 -0800 (PST)
Subject: Re: [PATCH v1] perf session: fix decompression of
 PERF_RECORD_COMPRESSED records
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <237222f1-9765-dce1-601c-60530a7fc844@linux.intel.com>
 <20191115151124.GA25246@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <2f2b2421-6865-4669-7e30-918d12ae5e01@linux.intel.com>
Date:   Fri, 15 Nov 2019 20:09:19 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191115151124.GA25246@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15.11.2019 18:11, Jiri Olsa wrote:
> On Fri, Nov 15, 2019 at 12:05:14PM +0300, Alexey Budankov wrote:
<SNIP>
>> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
>> index f07b8ecb91bc..3f6f812ec4ed 100644
>> --- a/tools/perf/util/session.c
>> +++ b/tools/perf/util/session.c
>> @@ -1957,9 +1957,31 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
>>  	return err;
>>  }
>>  
>> +static union perf_event *
>> +prefetch_event(char *buf, u64 head, size_t mmap_size,
>> +	       bool needs_swap, union perf_event *ret);
> 
> why not move prefetch_event definition in here?
> I don't see any need for the static declaration..

It is just for the sake of more readable patch formatting 
and, yes, could be avoided and replaced by the definition.

> 
>> +
>>  static union perf_event *
>>  fetch_mmaped_event(struct perf_session *session,
>>  		   u64 head, size_t mmap_size, char *buf)
>> +{
>> +	return prefetch_event(buf, head, mmap_size,
>> +			      session->header.needs_swap,
>> +			      ERR_PTR(-EINVAL));
>> +}
>> +
>> +static union perf_event *
>> +fetch_decomp_event(struct perf_session *session,
>> +		   u64 head, size_t mmap_size, char *buf)
>> +{
> 
> if this is decomp specific, it could take 'struct decomp*' as argument

Well, it makes sense. whole session object is not required here.
Just session->header.needs_swap could be passed as a param.
Shall we make it like this?

static union perf_event * 
fetch_decomp_event(u64 head, size_t mmap_size, char *buf, bool needs_swap)

> 
>> +	return prefetch_event(buf, head, mmap_size,
>> +			      session->header.needs_swap,
>> +			      NULL);
>> +}
>> +
>> +static union perf_event *
>> +prefetch_event(char *buf, u64 head, size_t mmap_size,
>> +	       bool needs_swap, union perf_event *ret)
>>  {
> 
> 'error' might be more suitable then ret in here

Accepted for v2.

~Alexey

> 
> thanks,
> jirka
> 
> 
