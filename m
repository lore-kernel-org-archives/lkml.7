Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECA9C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2E922CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbfICIP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 04:15:26 -0400
Received: from mga05.intel.com ([192.55.52.43]:32391 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbfICIP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 04:15:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 01:15:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,462,1559545200"; 
   d="scan'208";a="176512353"
Received: from xingzhen-mobl1.ccr.corp.intel.com (HELO [10.239.196.103]) ([10.239.196.103])
  by orsmga008.jf.intel.com with ESMTP; 03 Sep 2019 01:15:24 -0700
Subject: Re: [PATCH v3] trace:Add "gfp_t" support in synthetic_events
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, mingo@redhat.com,
        tom.zanussi@linux.intel.com, linux-kernel@vger.kernel.org
References: <20190712015308.9908-1-zhengjun.xing@linux.intel.com>
 <1562947506.12920.0.camel@kernel.org>
 <ac10cc35-96f4-7f67-a259-2398d3136417@linux.intel.com>
 <20190812230403.01491479@oasis.local.home>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <5706f93f-201c-47d7-fe30-e68c2d668e21@linux.intel.com>
Date:   Tue, 3 Sep 2019 16:15:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812230403.01491479@oasis.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi Steve,

On 8/13/2019 11:04 AM, Steven Rostedt wrote:
> On Tue, 13 Aug 2019 09:04:28 +0800
> Xing Zhengjun <zhengjun.xing@linux.intel.com> wrote:
> 
>> Hi Steve,
>>
>>      Could you help to review? Thanks.
> 
> Thanks for the ping. Yes, I'll take a look at it. I'll be pulling in a
> lot of patches that have queued up.
> 
> -- Steve

Could you help to review? Thanks.

> 
> 
>>
>> On 7/13/2019 12:05 AM, Tom Zanussi wrote:
>>> Hi Zhengjun,
>>>
>>> On Fri, 2019-07-12 at 09:53 +0800, Zhengjun Xing wrote:
>>>> Add "gfp_t" support in synthetic_events, then the "gfp_t" type
>>>> parameter in some functions can be traced.
>>>>
>>>> Prints the gfp flags as hex in addition to the human-readable flag
>>>> string.  Example output:
>>>>
>>>>     whoopsie-630 [000] ...1 78.969452: testevent: bar=b20
>>>> (GFP_ATOMIC|__GFP_ZERO)
>>>>       rcuc/0-11  [000] ...1 81.097555: testevent: bar=a20 (GFP_ATOMIC)
>>>>       rcuc/0-11  [000] ...1 81.583123: testevent: bar=a20 (GFP_ATOMIC)
>>>>
>>>> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
>>>> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>>>
>>> Looks good to me, thanks!
>>>
>>> Tom
>>>    
>>>> ---
>>>>    kernel/trace/trace_events_hist.c | 19 +++++++++++++++++++
>>>>    1 file changed, 19 insertions(+)
>>>>
>>>> diff --git a/kernel/trace/trace_events_hist.c
>>>> b/kernel/trace/trace_events_hist.c
>>>> index ca6b0dff60c5..30f0f32aca62 100644
>>>> --- a/kernel/trace/trace_events_hist.c
>>>> +++ b/kernel/trace/trace_events_hist.c
>>>> @@ -13,6 +13,10 @@
>>>>    #include <linux/rculist.h>
>>>>    #include <linux/tracefs.h>
>>>>    
>>>> +/* for gfp flag names */
>>>> +#include <linux/trace_events.h>
>>>> +#include <trace/events/mmflags.h>
>>>> +
>>>>    #include "tracing_map.h"
>>>>    #include "trace.h"
>>>>    #include "trace_dynevent.h"
>>>> @@ -752,6 +756,8 @@ static int synth_field_size(char *type)
>>>>    		size = sizeof(unsigned long);
>>>>    	else if (strcmp(type, "pid_t") == 0)
>>>>    		size = sizeof(pid_t);
>>>> +	else if (strcmp(type, "gfp_t") == 0)
>>>> +		size = sizeof(gfp_t);
>>>>    	else if (synth_field_is_string(type))
>>>>    		size = synth_field_string_size(type);
>>>>    
>>>> @@ -792,6 +798,8 @@ static const char *synth_field_fmt(char *type)
>>>>    		fmt = "%lu";
>>>>    	else if (strcmp(type, "pid_t") == 0)
>>>>    		fmt = "%d";
>>>> +	else if (strcmp(type, "gfp_t") == 0)
>>>> +		fmt = "%x";
>>>>    	else if (synth_field_is_string(type))
>>>>    		fmt = "%s";
>>>>    
>>>> @@ -834,9 +842,20 @@ static enum print_line_t
>>>> print_synth_event(struct trace_iterator *iter,
>>>>    					 i == se->n_fields - 1 ? ""
>>>> : " ");
>>>>    			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
>>>>    		} else {
>>>> +			struct trace_print_flags __flags[] = {
>>>> +			    __def_gfpflag_names, {-1, NULL} };
>>>> +
>>>>    			trace_seq_printf(s, print_fmt, se-
>>>>> fields[i]->name,
>>>>    					 entry->fields[n_u64],
>>>>    					 i == se->n_fields - 1 ? ""
>>>> : " ");
>>>> +
>>>> +			if (strcmp(se->fields[i]->type, "gfp_t") ==
>>>> 0) {
>>>> +				trace_seq_puts(s, " (");
>>>> +				trace_print_flags_seq(s, "|",
>>>> +						      entry-
>>>>> fields[n_u64],
>>>> +						      __flags);
>>>> +				trace_seq_putc(s, ')');
>>>> +			}
>>>>    			n_u64++;
>>>>    		}
>>>>    	}
>>
> 

-- 
Zhengjun Xing
