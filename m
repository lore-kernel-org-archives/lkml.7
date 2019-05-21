Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C1DC072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F658217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="qt97iU0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfEUUxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 16:53:39 -0400
Received: from mail.efficios.com ([167.114.142.138]:42768 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbfEUUxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 16:53:38 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 0CED31E60DB;
        Tue, 21 May 2019 16:53:37 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id oFFC6i6eKUdy; Tue, 21 May 2019 16:53:36 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 502281E60D1;
        Tue, 21 May 2019 16:53:36 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 502281E60D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1558472016;
        bh=y7ZGb/2b1DpJ83bp4T+kqmqo/UvZADZeuz55KVArwbs=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=qt97iU0uYz9FReccOYv8m20uBpg49YIn66yLpj7BiPCPnh3+ZTH2cmWNnGbML5oTM
         u5gI3t8vvjGB7vNTqGxNftYjPHF4N6RjDhI4/+Uh+Bp9e3TNtz7Am1yB71JLQyoZK/
         N0wB9WwKMQp9QWFY19Dhx2X60bM9agOOWdJ5hPBv/Sb15Jyt/6qpCVxNX9ap/OqXh9
         zwDerX2K+5kkkGFpzBx1JY4ceZ105b0m2Ma6jK9g61KfdIer7r5DNFgcfwwXbf+2c5
         VFCyu6qMhC68H90UL1tP6Fm5kOeb3r2m6KuJOmjd08oV2NvxrXg9Ng7iTw3nzXkqaY
         IHBulhV6tqvNA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id LowytUWnVUmg; Tue, 21 May 2019 16:53:36 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 341971E60C8;
        Tue, 21 May 2019 16:53:36 -0400 (EDT)
Date:   Tue, 21 May 2019 16:53:36 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Michael Jeanson <mjeanson@efficios.com>
Cc:     lttng-dev <lttng-dev@lists.lttng.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1045726286.6695.1558472016130.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190521203314.8577-4-mjeanson@efficios.com>
References: <20190521203314.8577-1-mjeanson@efficios.com> <20190521203314.8577-4-mjeanson@efficios.com>
Subject: Re: [PATCH lttng-modules 4/5] fix: mm: move recent_rotated pages
 calculation to shrink_inactive_list() (v5.2)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3803 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: move recent_rotated pages calculation to shrink_inactive_list() (v5.2)
Thread-Index: SUdRvQeX+1mub2ju/ncsTEVsJhgEbw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 21, 2019, at 4:33 PM, Michael Jeanson mjeanson@efficios.com wrote:

> See upstream commit:
> 
>  commit 886cf1901db962cee5f8b82b9b260079a5e8a4eb
>  Author: Kirill Tkhai <ktkhai@virtuozzo.com>
>  Date:   Mon May 13 17:16:51 2019 -0700
> 
>    mm: move recent_rotated pages calculation to shrink_inactive_list()
> 
>    Patch series "mm: Generalize putback functions"]
> 
>    putback_inactive_pages() and move_active_pages_to_lru() are almost
>    similar, so this patchset merges them ina single function.
> 
>    This patch (of 4):
> 
>    The patch moves the calculation from putback_inactive_pages() to
>    shrink_inactive_list().  This makes putback_inactive_pages() looking more
>    similar to move_active_pages_to_lru().
> 
>    To do that, we account activated pages in reclaim_stat::nr_activate.
>    Since a page may change its LRU type from anon to file cache inside
>    shrink_page_list() (see ClearPageSwapBacked()), we have to account pages
>    for the both types.  So, nr_activate becomes an array.
> 
>    Previously we used nr_activate to account PGACTIVATE events, but now we
>    account them into pgactivate variable (since they are about number of
>    pages in general, not about sum of hpage_nr_pages).
> 
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> instrumentation/events/lttng-module/mm_vmscan.h | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/instrumentation/events/lttng-module/mm_vmscan.h
> b/instrumentation/events/lttng-module/mm_vmscan.h
> index 417472c..3f9ffde 100644
> --- a/instrumentation/events/lttng-module/mm_vmscan.h
> +++ b/instrumentation/events/lttng-module/mm_vmscan.h
> @@ -625,7 +625,8 @@ LTTNG_TRACEPOINT_EVENT(mm_vmscan_lru_shrink_inactive,
> 		ctf_integer(unsigned long, nr_writeback, stat->nr_writeback)
> 		ctf_integer(unsigned long, nr_congested, stat->nr_congested)
> 		ctf_integer(unsigned long, nr_immediate, stat->nr_immediate)
> -		ctf_integer(unsigned long, nr_activate, stat->nr_activate)
> +		ctf_integer(unsigned long, nr_activate0, stat->nr_activate[0])
> +		ctf_integer(unsigned long, nr_activate1, stat->nr_activate[1])

This patch is for lttng-modules, but I'm adding Kirill Tkhai (author of the Linux
kernel commit causing the need for this change in lttng-modules) and Steven Rostedt
in CC, because I feel they might want to join this discussion naming of
userspace-visible TRACE_EVENT() fields.

Based on the upstream Linux commit, it looks like only the TP_printk() has
sane names for event fields, but could really improve on the naming for the
binary version of those fields:

-       TP_printk("nid=%d nr_scanned=%ld nr_reclaimed=%ld nr_dirty=%ld nr_writeback=%ld nr_congested=%ld nr_immediate=%ld nr_activate=%ld nr_ref_keep=%ld nr_unmap_fail=%ld priority=%d flags=%s",
+       TP_printk("nid=%d nr_scanned=%ld nr_reclaimed=%ld nr_dirty=%ld nr_writeback=%ld nr_congested=%ld nr_immediate=%ld nr_activate_anon=%d nr_activate_file=%d nr_ref_keep=%ld nr_unmap_fail=%ld priority=%d flags=%s",
                __entry->nid,
                __entry->nr_scanned, __entry->nr_reclaimed,
                __entry->nr_dirty, __entry->nr_writeback,
                __entry->nr_congested, __entry->nr_immediate,
-               __entry->nr_activate, __entry->nr_ref_keep,
-               __entry->nr_unmap_fail, __entry->priority,
+               __entry->nr_activate0, __entry->nr_activate1,
+               __entry->nr_ref_keep, __entry->nr_unmap_fail,
+               __entry->priority,
                show_reclaim_flags(__entry->reclaim_flags))
 );

So I recommend we do the following in lttng-modules:

Rename the field nr_activate0 to nr_activate_anon,
Rename the field nr_activate1 to nr_activate_file.

So users can make something out of those tracepoints without digging
into the kernel source code.

Even if Steven and Kirill end up choosing to change the name of those
fields upstream in trace-event, it won't have any impact on lttng-modules.

It would make sense to change those newly introduced exposed names in the
upstream kernel as well though.

Thanks,

Mathieu


> 		ctf_integer(unsigned long, nr_ref_keep, stat->nr_ref_keep)
> 		ctf_integer(unsigned long, nr_unmap_fail, stat->nr_unmap_fail)
> 		ctf_integer(int, priority, priority)
> --
> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
