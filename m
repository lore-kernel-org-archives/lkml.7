Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C53CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BD82064A
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634186AbfJROlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 10:41:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:5096 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393962AbfJROlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 10:41:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2019 07:41:07 -0700
X-IronPort-AV: E=Sophos;i="5.67,312,1566889200"; 
   d="scan'208";a="186844268"
Received: from tzanussi-mobl.amr.corp.intel.com (HELO [10.251.31.185]) ([10.251.31.185])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 18 Oct 2019 07:41:06 -0700
Subject: Re: [PATCH v2] tracing: fix "gfp_t" format for synthetic events
To:     Zhengjun Xing <zhengjun.xing@linux.intel.com>, rostedt@goodmis.org,
        mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20191018012034.6404-1-zhengjun.xing@linux.intel.com>
From:   "Zanussi, Tom" <tom.zanussi@linux.intel.com>
Message-ID: <2207cdd0-d44c-1c12-001a-f93203d3ceca@linux.intel.com>
Date:   Fri, 18 Oct 2019 09:41:05 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191018012034.6404-1-zhengjun.xing@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/2019 8:20 PM, Zhengjun Xing wrote:
> In the format of synthetic events, the "gfp_t" is shown as "signed:1",
> but in fact the "gfp_t" is "unsigned", should be shown as "signed:0".
> 
> The issue can be reproduced by the following commands:
> 
> echo 'memlatency u64 lat; unsigned int order; gfp_t gfp_flags; int migratetype' > /sys/kernel/debug/tracing/synthetic_events
> cat  /sys/kernel/debug/tracing/events/synthetic/memlatency/format
> 
> name: memlatency
> ID: 2233
> format:
>          field:unsigned short common_type;       offset:0;       size:2; signed:0;
>          field:unsigned char common_flags;       offset:2;       size:1; signed:0;
>          field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
>          field:int common_pid;   offset:4;       size:4; signed:1;
> 
>          field:u64 lat;  offset:8;       size:8; signed:0;
>          field:unsigned int order;       offset:16;      size:4; signed:0;
>          field:gfp_t gfp_flags;  offset:24;      size:4; signed:1;
>          field:int migratetype;  offset:32;      size:4; signed:1;
> 
> print fmt: "lat=%llu, order=%u, gfp_flags=%x, migratetype=%d", REC->lat, REC->order, REC->gfp_flags, REC->migratetype
> 
> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> ---
>   kernel/trace/trace_events_hist.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 57648c5aa679..7482a1466ebf 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -679,6 +679,8 @@ static bool synth_field_signed(char *type)
>   {
>   	if (str_has_prefix(type, "u"))
>   		return false;
> +	if (strcmp(type, "gfp_t") == 0)
> +		return false;
>   
>   	return true;
>   }
> 

Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>

