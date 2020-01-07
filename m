Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208FDC33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 07:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F13206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 07:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgAGHjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 02:39:55 -0500
Received: from mga07.intel.com ([134.134.136.100]:33726 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgAGHjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 02:39:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 23:39:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,404,1571727600"; 
   d="scan'208";a="223097653"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by orsmga003.jf.intel.com with ESMTP; 06 Jan 2020 23:39:51 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH] perf: correctly handle failed perf_get_aux_event() (was: Re: [perf] perf_event_open() sometimes returning 0)
In-Reply-To: <20200106120338.GC9630@lakrids.cambridge.arm.com>
References: <alpine.DEB.2.21.2001021349390.11372@macbook-air> <alpine.DEB.2.21.2001021418590.11372@macbook-air> <20200106120338.GC9630@lakrids.cambridge.arm.com>
Date:   Tue, 07 Jan 2020 09:39:51 +0200
Message-ID: <87o8vfbtq0.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Rutland <mark.rutland@arm.com> writes:

> On Thu, Jan 02, 2020 at 02:22:47PM -0500, Vince Weaver wrote:
>> On Thu, 2 Jan 2020, Vince Weaver wrote:
>> 
>> > so I was tracking down some odd behavior in the perf_fuzzer which turns 
>> > out to be because perf_even_open() sometimes returns 0 (indicating a file 
>> > descriptor of 0) even though as far as I can tell stdin is still open.
>
> Yikes.
>
>> error is triggered if aux_sample_size has non-zero value.
>>
>> seems to be this line in kernel/events/core.c:
>> 
>> 
>>  if (perf_need_aux_event(event) && !perf_get_aux_event(event, group_leader))
>>                 goto err_locked;
>> 
>> 
>> (note, err is never set)
>
> Looks like that was introduced in commit:
>
>   ab43762ef010967e ("perf: Allow normal events to output AUX data")
>   
> I guess we should return -EINVAL in this case.

That's right. Thanks for looking into this!

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index a1f8bde19b56..2173c23c25b4 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11465,8 +11465,10 @@ SYSCALL_DEFINE5(perf_event_open,
>  		}
>  	}
>  
> -	if (perf_need_aux_event(event) && !perf_get_aux_event(event, group_leader))
> +	if (perf_need_aux_event(event) && !perf_get_aux_event(event, group_leader)) {
> +		err = -EINVAL;
>  		goto err_locked;
> +	}
>  

FWIW,
Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>

Thanks,
--
Alex
