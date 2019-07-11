Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82F8C74A4B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 08:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D1520838
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 08:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbfGKIL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 04:11:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:54893 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727974AbfGKIL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 04:11:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2019 01:11:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,476,1557212400"; 
   d="scan'208";a="166324409"
Received: from xingzhen-mobl1.ccr.corp.intel.com (HELO [10.239.196.76]) ([10.239.196.76])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jul 2019 01:11:55 -0700
Subject: Re: [PATCH] trace:add "gfp_t" support in synthetic_events
To:     Tom Zanussi <zanussi@kernel.org>, rostedt@goodmis.org,
        mingo@redhat.com, tom.zanussi@linux.intel.com
Cc:     linux-kernel@vger.kernel.org
References: <20190704025506.30199-1-zhengjun.xing@linux.intel.com>
 <1562788297.6330.7.camel@kernel.org>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <50bc3608-d68c-da42-367b-a72f8745abd8@linux.intel.com>
Date:   Thu, 11 Jul 2019 16:11:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1562788297.6330.7.camel@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On 7/11/2019 3:51 AM, Tom Zanussi wrote:
> Hi Zhengjun,
> 
> On Thu, 2019-07-04 at 10:55 +0800, Zhengjun Xing wrote:
>> Add "gfp_t" support in synthetic_events, then the "gfp_t" type
>> parameter in some functions can be traced.
>>
>> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>> ---
>>   kernel/trace/trace_events_hist.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/kernel/trace/trace_events_hist.c
>> b/kernel/trace/trace_events_hist.c
>> index ca6b0dff60c5..0d3ab01b7cb5 100644
>> --- a/kernel/trace/trace_events_hist.c
>> +++ b/kernel/trace/trace_events_hist.c
>> @@ -752,6 +752,8 @@ static int synth_field_size(char *type)
>>   		size = sizeof(unsigned long);
>>   	else if (strcmp(type, "pid_t") == 0)
>>   		size = sizeof(pid_t);
>> +	else if (strcmp(type, "gfp_t") == 0)
>> +		size = sizeof(gfp_t);
>>   	else if (synth_field_is_string(type))
>>   		size = synth_field_string_size(type);
>>   
>> @@ -792,6 +794,8 @@ static const char *synth_field_fmt(char *type)
>>   		fmt = "%lu";
>>   	else if (strcmp(type, "pid_t") == 0)
>>   		fmt = "%d";
>> +	else if (strcmp(type, "gfp_t") == 0)
>> +		fmt = "%u";
>>   	else if (synth_field_is_string(type))
>>   		fmt = "%s";
>>   
> 
> This will work, but I think it would be better to display as hex, and
> also show the flags in human-readable form.
> 
> How about adding something like this on top of your patch?:
> 
Thanks, I will add it to the v2 version patch.
> 
> [PATCH] tracing: Add verbose gfp_flag printing to synthetic events
> 
> Add on top of 'trace:add "gfp_t" support in synthetic_events'.
> 
> Prints the gfp flags as hex in addition to the human-readable flag
> string.  Example output:
> 
>    whoopsie-630 [000] ...1 78.969452: testevent: bar=b20 (GFP_ATOMIC|__GFP_ZERO)
>      rcuc/0-11  [000] ...1 81.097555: testevent: bar=a20 (GFP_ATOMIC)
>      rcuc/0-11  [000] ...1 81.583123: testevent: bar=a20 (GFP_ATOMIC)
> 
> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> ---
>   kernel/trace/trace_events_hist.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 0d3ab01..aeb4449 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -13,6 +13,10 @@
>   #include <linux/rculist.h>
>   #include <linux/tracefs.h>
>   
> +/* for gfp flag names */
> +#include <linux/trace_events.h>
> +#include <trace/events/mmflags.h>
> +
>   #include "tracing_map.h"
>   #include "trace.h"
>   #include "trace_dynevent.h"
> @@ -795,7 +799,7 @@ static const char *synth_field_fmt(char *type)
>   	else if (strcmp(type, "pid_t") == 0)
>   		fmt = "%d";
>   	else if (strcmp(type, "gfp_t") == 0)
> -		fmt = "%u";
> +		fmt = "%x";
>   	else if (synth_field_is_string(type))
>   		fmt = "%s";
>   
> @@ -838,9 +842,20 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
>   					 i == se->n_fields - 1 ? "" : " ");
>   			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
>   		} else {
> +			struct trace_print_flags __flags[] =
> +				{ __def_gfpflag_names, { -1, NULL }};
> +
>   			trace_seq_printf(s, print_fmt, se->fields[i]->name,
>   					 entry->fields[n_u64],
>   					 i == se->n_fields - 1 ? "" : " ");
> +
> +			if (strcmp(se->fields[i]->type, "gfp_t") == 0) {
> +				trace_seq_puts(s, " (");
> +				trace_print_flags_seq(s, "|",
> +						      entry->fields[n_u64],
> +						      __flags);
> +				trace_seq_putc(s, ')');
> +			}
>   			n_u64++;
>   		}
>   	}
> 

-- 
Zhengjun Xing
