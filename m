Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0056BC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 07:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE62B2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 07:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+Vk/lkF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfLRHrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 02:47:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55753 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725882AbfLRHrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 02:47:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576655239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A/EVIVhLsM644wxvKDnAAovHD5Ty6dbVPaLFVmZnGNI=;
        b=b+Vk/lkF6wfMEsv7jykNr8EgqWgb2EqKDSbgeBWiRvHG5Z463qgKFFI3fvBmYQMFujaVBa
        mVQDHDAXA/fb7x+AId7djf2LyunJF4wy4k3zKJbGhH8QQIiEEri2FLvwfgucSFfcDkROm8
        tUsVsu7oWF2sg3e+4gtwswXefCBpLig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-iDO63b2MPP2BBcWRRT0vug-1; Wed, 18 Dec 2019 02:47:15 -0500
X-MC-Unique: iDO63b2MPP2BBcWRRT0vug-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39415800D48;
        Wed, 18 Dec 2019 07:47:14 +0000 (UTC)
Received: from krava (ovpn-204-177.brq.redhat.com [10.40.204.177])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BDCA868882;
        Wed, 18 Dec 2019 07:47:11 +0000 (UTC)
Date:   Wed, 18 Dec 2019 08:47:08 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4 3/3] perf report: support hotkey to let user select
 any event for sorting
Message-ID: <20191218074708.GC19062@krava>
References: <20191218022443.18958-1-yao.jin@linux.intel.com>
 <20191218022443.18958-3-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218022443.18958-3-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 10:24:43AM +0800, Jin Yao wrote:
> When performing "perf report --group", it shows the event group information
> together. In previous patch, we have supported a new option "--group-sort-idx"
> to sort the output by the event at the index n in event group.
> 
> It would be nice if we can use a hotkey in browser to select a event
> to sort.
> 
> For example,
> 
>   # perf report --group
> 
>  Samples: 12K of events 'cpu/instructions,period=2000003/, cpu/cpu-cycles,period=200003/, ...
>                         Overhead  Command    Shared Object            Symbol
>   92.19%  98.68%   0.00%  93.30%  mgen       mgen                     [.] LOOP1
>    3.12%   0.29%   0.00%   0.16%  gsd-color  libglib-2.0.so.0.5600.4  [.] 0x0000000000049515
>    1.56%   0.03%   0.00%   0.04%  gsd-color  libglib-2.0.so.0.5600.4  [.] 0x00000000000494b7
>    1.56%   0.01%   0.00%   0.00%  gsd-color  libglib-2.0.so.0.5600.4  [.] 0x00000000000494ce
>    1.56%   0.00%   0.00%   0.00%  mgen       [kernel.kallsyms]        [k] task_tick_fair
>    0.00%   0.15%   0.00%   0.04%  perf       [kernel.kallsyms]        [k] smp_call_function_single
>    0.00%   0.13%   0.00%   6.08%  swapper    [kernel.kallsyms]        [k] intel_idle
>    0.00%   0.03%   0.00%   0.00%  gsd-color  libglib-2.0.so.0.5600.4  [.] g_main_context_check
>    0.00%   0.03%   0.00%   0.00%  swapper    [kernel.kallsyms]        [k] apic_timer_interrupt
>    0.00%   0.03%   0.00%   0.00%  swapper    [kernel.kallsyms]        [k] check_preempt_curr
> 
> When user press hotkey '3' (event index, starting from 0), it indicates
> to sort output by the forth event in group.
> 
>   Samples: 12K of events 'cpu/instructions,period=2000003/, cpu/cpu-cycles,period=200003/, ...
>                         Overhead  Command    Shared Object            Symbol
>   92.19%  98.68%   0.00%  93.30%  mgen       mgen                     [.] LOOP1
>    0.00%   0.13%   0.00%   6.08%  swapper    [kernel.kallsyms]        [k] intel_idle
>    3.12%   0.29%   0.00%   0.16%  gsd-color  libglib-2.0.so.0.5600.4  [.] 0x0000000000049515
>    0.00%   0.00%   0.00%   0.06%  swapper    [kernel.kallsyms]        [k] hrtimer_start_range_ns
>    1.56%   0.03%   0.00%   0.04%  gsd-color  libglib-2.0.so.0.5600.4  [.] 0x00000000000494b7
>    0.00%   0.15%   0.00%   0.04%  perf       [kernel.kallsyms]        [k] smp_call_function_single
>    0.00%   0.00%   0.00%   0.02%  mgen       [kernel.kallsyms]        [k] update_curr
>    0.00%   0.00%   0.00%   0.02%  mgen       [kernel.kallsyms]        [k] apic_timer_interrupt
>    0.00%   0.00%   0.00%   0.02%  mgen       [kernel.kallsyms]        [k] native_apic_msr_eoi_write
>    0.00%   0.00%   0.00%   0.02%  mgen       [kernel.kallsyms]        [k] __update_load_avg_se

when I press 0...9 I'm getting extra columns:

Samples: 134  of events 'anon group { cycles:u, instructions:u, cache-misses:u, cycles:u, instructions:u }', Event count (approx.): 7107344
                                Overhead  Command  Shared Object     Symbol                                                                  Self
  17.95%  41.20%   0.00%  12.44%  41.30%  ls       libc-2.29.so      [.] __strcoll_l                       17.95%  41.20%   0.00%  12.44%  41.30%       N/A
   0.00%  13.22%   0.00%   0.00%   0.00%  ls       ls                [.] 0x000000000000871c                 0.00%  13.22%   0.00%   0.00%   0.00%       N/A
   8.32%  11.49%   0.00%   2.62%   9.34%  ls       ld-2.29.so        [.] do_lookup_x                        8.32%  11.49%   0.00%   2.62%   9.34%       N/A
   0.00%   8.29%  31.18%  13.34%   3.05%  ls       ld-2.29.so        [.] _dl_lookup_symbol_x                0.00%   8.29%  31.18%  13.34%   3.05%       N/A
   0.00%   6.47%   0.00%   0.00%   0.00%  ls       libc-2.29.so      [.] __strlen_avx2                      0.00%   6.47%   0.00%   0.00%   0.00%       N/A
   0.00%   5.97%   0.00%   0.00%   0.00%  ls       ls                [.] 0x0000000000014001                 0.00%   5.97%   0.00%   0.00%   0.00%       N/A
   5.77%   5.83%   7.79%   4.78%   5.04%  ls       ld-2.29.so        [.] strcmp                             5.77%   5.83%   7.79%   4.78%   5.04%       N/A
   2.31%   4.35%   8.30%   0.00%   0.00%  ls       ld-2.29.so        [.] _dl_map_object_from_fd             2.31%   4.35%   8.30%   0.00%   0.00%       N/A
   0.00%   2.96%   0.00%   1.30%   2.22%  ls       ld-2.29.so        [.] __GI___tunables_init               0.00%   2.96%   0.00%   1.30%   2.22%       N/A
   0.66%   0.22%   0.68%   0.00%   0.21%  ls       ld-2.29.so        [.] _dl_start                          0.66%   0.22%   0.68%   0.00%   0.21%       N/A
   2.42%   0.00%   0.02%   3.16%   0.00%  ls       [unknown]         [k] 0xffffffffa2a012b0                 2.42%   0.00%   0.02%   3.16%   0.00%       N/A
   0.16%   0.00%   0.01%   0.20%   0.00%  ls       ld-2.29.so        [.] _start                             0.16%   0.00%   0.01%   0.20%   0.00%       N/A
   0.00%   0.00%  11.47%   0.00%   0.00%  ls       libcap.so.2.26    [.] 0x0000000000002420                 0.00%   0.00%  11.47%   0.00%   0.00%       N/A
   0.00%   0.00%  10.50%   0.00%   0.00%  ls       libc-2.29.so      [.] __GI___tcgetattr                   0.00%   0.00%  10.50%   0.00%   0.00%       N/A
   0.00%   0.00%   9.14%   0.00%   0.00%  ls       ls                [.] 0x000000000000767a                 0.00%   0.00%   9.14%   0.00%   0.00%       N/A
  13.60%   0.00%   7.14%   2.31%   0.00%  ls       ld-2.29.so        [.] _dl_relocate_object               13.60%   0.00%   7.14%   2.31%   0.00%       N/A
   2.13%   0.00%   6.14%   0.00%   0.00%  ls       ld-2.29.so        [.] _dl_map_object_deps                2.13%   0.00%   6.14%   0.00%   0.00%       N/A
   0.00%   0.00%   5.27%   0.00%   0.00%  ls       ld-2.29.so        [.] strlen                             0.00%   0.00%   5.27%   0.00%   0.00%       N/A
   1.31%   0.00%   2.37%   1.08%   0.00%  ls       ld-2.29.so        [.] _dl_sysdep_start                   1.31%   0.00%   2.37%   1.08%   0.00%       N/A


jirka

