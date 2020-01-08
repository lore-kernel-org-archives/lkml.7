Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8566BC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 13:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607E920643
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 13:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbgAHNCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 08:02:07 -0500
Received: from mga03.intel.com ([134.134.136.65]:16900 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgAHNCH (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 08:02:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 05:02:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="211528356"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.254.213.183]) ([10.254.213.183])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2020 05:02:03 -0800
Subject: Re: [PATCH] perf report: Fix no libunwind compiled warning break s390
 issue
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, tmricht@linux.ibm.com
References: <20200107191745.18415-1-yao.jin@linux.intel.com>
 <20200108102708.GC360164@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <7b88fdcc-9603-d3e1-d43b-b8fb8b394f70@linux.intel.com>
Date:   Wed, 8 Jan 2020 21:02:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200108102708.GC360164@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/8/2020 6:27 PM, Jiri Olsa wrote:
> On Wed, Jan 08, 2020 at 03:17:45AM +0800, Jin Yao wrote:
>> Commit 800d3f561659 ("perf report: Add warning when libunwind not compiled in")
>> breaks the s390 platform. S390 uses libdw-dwarf-unwind for call chain
>> unwinding and had no support for libunwind.
>>
>> So the warning "Please install libunwind development packages during the perf build."
>> caused the confusion even if the call-graph is displayed correctly.
>>
>> This patch adds checking for HAVE_DWARF_SUPPORT, which is set when
>> libdw-dwarf-unwind is compiled in.
>>
>> Fixes: 800d3f561659 ("perf report: Add warning when libunwind not compiled in")
>>
>> Reviewed-by: Thomas Richter <tmricht@linux.ibm.com>
>> Tested-by: Thomas Richter <tmricht@linux.ibm.com>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> 
> perfect, I have the same change prepared for sending, but it's
> together with making libdw default dwarf unwinder, which I'm still
> not sure we want to do, so it all got posponed ;-)
>  > would you guys be ok with that? with having libdw picked up as 
default dwarf unwinder..
> 

I've roughly compared the performance between libunwind-dev and 
libdw-dev. While in my test (on KBL desktop), for the same perf report 
command-line, it looks the perf built with libunwind-dev is much faster 
than the perf built with libdw-dev.

The command line is as following:

perf record --call-graph dwarf ./div
perf report -g graph --stdio

Maybe you give it a try. :)

> for the patch:
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> 
Thanks for reviewing the patch.

Thanks
Jin Yao

> thanks,
> jirka
> 
>> ---
>>   tools/perf/builtin-report.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
>> index de988589d99b..66cd97cc8b92 100644
>> --- a/tools/perf/builtin-report.c
>> +++ b/tools/perf/builtin-report.c
>> @@ -412,10 +412,10 @@ static int report__setup_sample_type(struct report *rep)
>>   				PERF_SAMPLE_BRANCH_ANY))
>>   		rep->nonany_branch_mode = true;
>>   
>> -#ifndef HAVE_LIBUNWIND_SUPPORT
>> +#if !defined(HAVE_LIBUNWIND_SUPPORT) && !defined(HAVE_DWARF_SUPPORT)
>>   	if (dwarf_callchain_users) {
>> -		ui__warning("Please install libunwind development packages "
>> -			    "during the perf build.\n");
>> +		ui__warning("Please install libunwind or libdw "
>> +			    "development packages during the perf build.\n");
>>   	}
>>   #endif
>>   
>> -- 
>> 2.17.1
>>
> 
