Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52720C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 07:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269512176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 07:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/AC1H5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfLRHoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 02:44:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27000 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726497AbfLRHon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 02:44:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576655082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/7Bu8lRWW0sQ62qo/rCg256wOgb/rW5afbJ5suw1if4=;
        b=O/AC1H5e2mSTD3p9IV9RkcRhwsyh7NhYOsujnsDRZNnOSwq3DVsNYtyqhGiO1xZY7ZEwaM
        TY6b5PnaDjN40bmybUhOUuNU8dYeujipLHPCl15HwYZ7RYVKcjZ9LiSnJmj9OHw4B6xscE
        inAGKvNY9g10ZKwper/JwhAjvEO/sPQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-o9zC6pzLPnqeaXNQwQVgjQ-1; Wed, 18 Dec 2019 02:43:58 -0500
X-MC-Unique: o9zC6pzLPnqeaXNQwQVgjQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 218F5DBA5;
        Wed, 18 Dec 2019 07:43:57 +0000 (UTC)
Received: from krava (ovpn-204-177.brq.redhat.com [10.40.204.177])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A9B3560C63;
        Wed, 18 Dec 2019 07:43:54 +0000 (UTC)
Date:   Wed, 18 Dec 2019 08:43:51 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4 1/3] perf report: Change sort order by a specified
 event in group
Message-ID: <20191218074351.GB19062@krava>
References: <20191218022443.18958-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218022443.18958-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 10:24:41AM +0800, Jin Yao wrote:

SNIP

> After:
> 
>   # perf report --group --stdio --group-sort-idx 3
> 
>   # To display the perf.data header info, please use --header/--header-only options.
>   #
>   #
>   # Total Lost Samples: 0
>   #
>   # Samples: 12K of events 'cpu/instructions,period=2000003/, cpu/cpu-cycles,period=200003/, BR_MISP_RETIRED.ALL_BRANCHES:pp, cpu/event=0xc0,umask=1,cmask=1,
>   # Event count (approx.): 6451235635
>   #
>   #                         Overhead  Command    Shared Object            Symbol
>   # ................................  .........  .......................  ...................................
>   #
>       92.19%  98.68%   0.00%  93.30%  mgen       mgen                     [.] LOOP1
>        0.00%   0.13%   0.00%   6.08%  swapper    [kernel.kallsyms]        [k] intel_idle
>        3.12%   0.29%   0.00%   0.16%  gsd-color  libglib-2.0.so.0.5600.4  [.] 0x0000000000049515
>        0.00%   0.00%   0.00%   0.06%  swapper    [kernel.kallsyms]        [k] hrtimer_start_range_ns
>        1.56%   0.03%   0.00%   0.04%  gsd-color  libglib-2.0.so.0.5600.4  [.] 0x00000000000494b7
>        0.00%   0.15%   0.00%   0.04%  perf       [kernel.kallsyms]        [k] smp_call_function_single
>        0.00%   0.00%   0.00%   0.02%  mgen       [kernel.kallsyms]        [k] update_curr
>        0.00%   0.00%   0.00%   0.02%  mgen       [kernel.kallsyms]        [k] apic_timer_interrupt
>        0.00%   0.00%   0.00%   0.02%  mgen       [kernel.kallsyms]        [k] native_apic_msr_eoi_write
>        0.00%   0.00%   0.00%   0.02%  mgen       [kernel.kallsyms]        [k] __update_load_avg_se
>        0.00%   0.00%   0.00%   0.02%  mgen       [kernel.kallsyms]        [k] scheduler_tick
> 
> Now the output is sorted by the fourth event in group.
> 
>  v4:
>  ---
>  1. Update Documentation/perf-report.txt to mention
>     '--group-sort-idx' support multiple groups with different
>     amount of events and it should be used on grouped events.
> 
>  2. Update __hpp__group_sort_idx(), just return when the
>     idx is out of limit.
> 
>  3. Return failure on symbol_conf.group_sort_idx && !session->evlist->nr_groups.
>     So now we don't need to use together with --group.

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

