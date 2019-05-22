Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A56C072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 08:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FCE7206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 08:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbfEVIhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 04:37:33 -0400
Received: from relay.sw.ru ([185.231.240.75]:40988 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728609AbfEVIhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 04:37:33 -0400
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hTMkZ-0001yM-6S; Wed, 22 May 2019 11:37:27 +0300
Subject: Re: [PATCH lttng-modules 4/5] fix: mm: move recent_rotated pages
 calculation to shrink_inactive_list() (v5.2)
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Jeanson <mjeanson@efficios.com>
Cc:     lttng-dev <lttng-dev@lists.lttng.org>,
        rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20190521203314.8577-1-mjeanson@efficios.com>
 <20190521203314.8577-4-mjeanson@efficios.com>
 <1045726286.6695.1558472016130.JavaMail.zimbra@efficios.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <bcb13b3a-44f4-c8da-ab32-2fa3e37ee81e@virtuozzo.com>
Date:   Wed, 22 May 2019 11:37:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1045726286.6695.1558472016130.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.05.2019 23:53, Mathieu Desnoyers wrote:
> ----- On May 21, 2019, at 4:33 PM, Michael Jeanson mjeanson@efficios.com wrote:
> 
>> See upstream commit:
>>
>>  commit 886cf1901db962cee5f8b82b9b260079a5e8a4eb
>>  Author: Kirill Tkhai <ktkhai@virtuozzo.com>
>>  Date:   Mon May 13 17:16:51 2019 -0700
>>
>>    mm: move recent_rotated pages calculation to shrink_inactive_list()
>>
>>    Patch series "mm: Generalize putback functions"]
>>
>>    putback_inactive_pages() and move_active_pages_to_lru() are almost
>>    similar, so this patchset merges them ina single function.
>>
>>    This patch (of 4):
>>
>>    The patch moves the calculation from putback_inactive_pages() to
>>    shrink_inactive_list().  This makes putback_inactive_pages() looking more
>>    similar to move_active_pages_to_lru().
>>
>>    To do that, we account activated pages in reclaim_stat::nr_activate.
>>    Since a page may change its LRU type from anon to file cache inside
>>    shrink_page_list() (see ClearPageSwapBacked()), we have to account pages
>>    for the both types.  So, nr_activate becomes an array.
>>
>>    Previously we used nr_activate to account PGACTIVATE events, but now we
>>    account them into pgactivate variable (since they are about number of
>>    pages in general, not about sum of hpage_nr_pages).
>>
>> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
>> ---
>> instrumentation/events/lttng-module/mm_vmscan.h | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/instrumentation/events/lttng-module/mm_vmscan.h
>> b/instrumentation/events/lttng-module/mm_vmscan.h
>> index 417472c..3f9ffde 100644
>> --- a/instrumentation/events/lttng-module/mm_vmscan.h
>> +++ b/instrumentation/events/lttng-module/mm_vmscan.h
>> @@ -625,7 +625,8 @@ LTTNG_TRACEPOINT_EVENT(mm_vmscan_lru_shrink_inactive,
>> 		ctf_integer(unsigned long, nr_writeback, stat->nr_writeback)
>> 		ctf_integer(unsigned long, nr_congested, stat->nr_congested)
>> 		ctf_integer(unsigned long, nr_immediate, stat->nr_immediate)
>> -		ctf_integer(unsigned long, nr_activate, stat->nr_activate)
>> +		ctf_integer(unsigned long, nr_activate0, stat->nr_activate[0])
>> +		ctf_integer(unsigned long, nr_activate1, stat->nr_activate[1])
> 
> This patch is for lttng-modules, but I'm adding Kirill Tkhai (author of the Linux
> kernel commit causing the need for this change in lttng-modules) and Steven Rostedt
> in CC, because I feel they might want to join this discussion naming of
> userspace-visible TRACE_EVENT() fields.
> 
> Based on the upstream Linux commit, it looks like only the TP_printk() has
> sane names for event fields, but could really improve on the naming for the
> binary version of those fields:
> 
> -       TP_printk("nid=%d nr_scanned=%ld nr_reclaimed=%ld nr_dirty=%ld nr_writeback=%ld nr_congested=%ld nr_immediate=%ld nr_activate=%ld nr_ref_keep=%ld nr_unmap_fail=%ld priority=%d flags=%s",
> +       TP_printk("nid=%d nr_scanned=%ld nr_reclaimed=%ld nr_dirty=%ld nr_writeback=%ld nr_congested=%ld nr_immediate=%ld nr_activate_anon=%d nr_activate_file=%d nr_ref_keep=%ld nr_unmap_fail=%ld priority=%d flags=%s",
>                 __entry->nid,
>                 __entry->nr_scanned, __entry->nr_reclaimed,
>                 __entry->nr_dirty, __entry->nr_writeback,
>                 __entry->nr_congested, __entry->nr_immediate,
> -               __entry->nr_activate, __entry->nr_ref_keep,
> -               __entry->nr_unmap_fail, __entry->priority,
> +               __entry->nr_activate0, __entry->nr_activate1,
> +               __entry->nr_ref_keep, __entry->nr_unmap_fail,
> +               __entry->priority,
>                 show_reclaim_flags(__entry->reclaim_flags))
>  );
> 
> So I recommend we do the following in lttng-modules:
> 
> Rename the field nr_activate0 to nr_activate_anon,
> Rename the field nr_activate1 to nr_activate_file.
> 
> So users can make something out of those tracepoints without digging
> into the kernel source code.
> 
> Even if Steven and Kirill end up choosing to change the name of those
> fields upstream in trace-event, it won't have any impact on lttng-modules.
> 
> It would make sense to change those newly introduced exposed names in the
> upstream kernel as well though.

Yeah, since these are exported to userspace, we should better rename them in the way
you suggested.

Thanks,
Kirill
