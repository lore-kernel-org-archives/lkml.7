Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA90C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B15221852
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbfDEOJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:09:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45546 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727212AbfDEOJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:09:36 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6695044F99;
        Fri,  5 Apr 2019 14:09:36 +0000 (UTC)
Received: from treble (ovpn-123-87.rdu2.redhat.com [10.10.123.87])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 70146604A1;
        Fri,  5 Apr 2019 14:09:31 +0000 (UTC)
Date:   Fri, 5 Apr 2019 09:09:29 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kairui Song <kasong@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Dave Young <dyoung@redhat.com>
Subject: Re: [RFC PATCH] perf/x86: make perf callchain work without
 CONFIG_FRAME_POINTER
Message-ID: <20190405140929.pycfea7drnpb2sug@treble>
References: <20190404172545.20928-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190404172545.20928-1-kasong@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 05 Apr 2019 14:09:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 01:25:45AM +0800, Kairui Song wrote:
> Currently perf callchain is not working properly with ORC unwinder,
> we'll get useless in kernel callchain like this:
> 
> perf  6429 [000]    22.498450:             kmem:mm_page_alloc: page=0x176a17 pfn=1534487 order=0 migratetype=0 gfp_flags=GFP_KERNEL
>         ffffffffbe23e32e __alloc_pages_nodemask+0x22e (/lib/modules/5.1.0-rc3+/build/vmlinux)
>             7efdf7f7d3e8 __poll+0x18 (/usr/lib64/libc-2.28.so)
>             5651468729c1 [unknown] (/usr/bin/perf)
>             5651467ee82a main+0x69a (/usr/bin/perf)
>             7efdf7eaf413 __libc_start_main+0xf3 (/usr/lib64/libc-2.28.so)
>         5541f689495641d7 [unknown] ([unknown])
> 
> Without CONFIG_FRAME_POINTER, bp is not reserved as frame pointer so
> can't get callers frame pointer, instead current frame pointer is
> returned when trying to fetch caller registers. The unwinder will error
> out early, and end the stacktrace early.
> 
> So instead of let the unwinder start with the dumped register, we start
> it right where the unwinding started when the stacktrace is triggered by
> trace event directly. And skip until the frame pointer is reached.
> 
> This makes the callchain get the full in kernel stacktrace again:
> 
> perf  6503 [000]  1567.570191:             kmem:mm_page_alloc: page=0x16c904 pfn=1493252 order=0 migratetype=0 gfp_flags=GFP_KERNEL
>         ffffffffb523e2ae __alloc_pages_nodemask+0x22e (/lib/modules/5.1.0-rc3+/build/vmlinux)
>         ffffffffb52383bd __get_free_pages+0xd (/lib/modules/5.1.0-rc3+/build/vmlinux)
>         ffffffffb52fd28a __pollwait+0x8a (/lib/modules/5.1.0-rc3+/build/vmlinux)
>         ffffffffb521426f perf_poll+0x2f (/lib/modules/5.1.0-rc3+/build/vmlinux)
>         ffffffffb52fe3e2 do_sys_poll+0x252 (/lib/modules/5.1.0-rc3+/build/vmlinux)
>         ffffffffb52ff027 __x64_sys_poll+0x37 (/lib/modules/5.1.0-rc3+/build/vmlinux)
>         ffffffffb500418b do_syscall_64+0x5b (/lib/modules/5.1.0-rc3+/build/vmlinux)
>         ffffffffb5a0008c entry_SYSCALL_64_after_hwframe+0x44 (/lib/modules/5.1.0-rc3+/build/vmlinux)
>             7f71e92d03e8 __poll+0x18 (/usr/lib64/libc-2.28.so)
>             55a22960d9c1 [unknown] (/usr/bin/perf)
>             55a22958982a main+0x69a (/usr/bin/perf)
>             7f71e9202413 __libc_start_main+0xf3 (/usr/lib64/libc-2.28.so)
>         5541f689495641d7 [unknown] ([unknown])
> 
> ----
> 
> Just found with ORC unwinder the perf callchain is unusable, and this
> seems fixes it well, any suggestion is welcome, thanks!

Hi Kairui,

Without CONFIG_FRAME_POINTER, the BP register has no meaning, so I don't
see how this patch could work.

Also, perf stack traces seem to work fine for me with ORC.  Can you give
some details on how to recreate the issue?

-- 
Josh
