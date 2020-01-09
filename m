Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8BBC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDB520721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMBatKlT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbgAIPLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 10:11:05 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:36068 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729497AbgAIPLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 10:11:05 -0500
Received: by mail-qk1-f169.google.com with SMTP id a203so6267518qkc.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 07:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+c7W9XvpWL52aNhhNKpQwzJEWHAL6DmkGLt5zMHLbC4=;
        b=bMBatKlTlYZE/TezrK1vyLytsOQ+o55b4CpFw8pIbz7heolwYFHnpdpy3SF6MnZJih
         ORK7tHTOywW/keuaXE5m3yZUDaK7ANiSuAkqKsYSxzAjaPIDfUiR+HGjELpQeCCDxxp9
         l174J8tuWBzFmre8vp5RWZvGOx4Y5e8zj/Gl8r2ZOe/ve2IN8LIsFbYNb/K9ggHKPlIu
         BEuPiI4Yzd9VLo2eWqHgEerIpZuiDf11V/rUO+6S2EH/ChkwCZr2HoUbw5UfQZXhGoHE
         4/7B4OWum2IRMCWd8qSXGDQYVyx9cBbErLk/D2x4u7vDElTnTXHOIwJOj0dQHS8FohMP
         2KKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+c7W9XvpWL52aNhhNKpQwzJEWHAL6DmkGLt5zMHLbC4=;
        b=uIWC4iZ5QK5Z9itFKBS6lxPCLbHbT83Ov3cuuJyqpdyGWEF8/bJZkjgDCfij7RHTKw
         wrdGcPVEePxLQQ75JNi3hZl6POqbDWgWSiNMNxXDRM5KTP7+0TW6a3yI6itBD0pj/jKf
         dKjAeFMHSnwLwiaGQ+Q93UPvdcnG2zaGtCCy6AsRnNwC5hYaTjmJw9vb+SqyUqikcoof
         DRWmpagFuRVSMVPUMCn62b2PpWemVaI+WCWX6KmO0udrJOQHaL/hp5Zb33W5qpvyI/zU
         XM+mTHuvjrbqbALz3gUBHQlhPyK8o80U5HYF7yNhn4botPtbMjXMPLP1wt8Yi0CuU8Du
         h2BQ==
X-Gm-Message-State: APjAAAVcZ1pYjigKRGZWjLTPnDrAgK0+T/hwoKuI8OqmQyarIhkBTll0
        AqE3oDp6vZXh5lbUqXoMXCw=
X-Google-Smtp-Source: APXvYqysreA5q3NAOuMRZNmqdG1eFGX4yJ4tXHBUhXAy8h7gVXRqCj5YmycYPTxMc/wp9MXJSFPImw==
X-Received: by 2002:a05:620a:11a3:: with SMTP id c3mr10072756qkk.230.1578582663791;
        Thu, 09 Jan 2020 07:11:03 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id i4sm3097330qki.45.2020.01.09.07.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 07:11:01 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6752140DFD; Thu,  9 Jan 2020 12:10:59 -0300 (-03)
Date:   Thu, 9 Jan 2020 12:10:59 -0300
To:     Jann Horn <jannh@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: "perf ftrace" segfault because ->cpus!=NULL but ->all_cpus==NULL
Message-ID: <20200109151059.GB8602@kernel.org>
References: <CAG48ez0eULP6pH26H9ac-YYa88_RSGt6v_hDhsrZ92iZoRdsoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0eULP6pH26H9ac-YYa88_RSGt6v_hDhsrZ92iZoRdsoQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 09, 2020 at 12:37:14PM +0100, Jann Horn escreveu:
> I was clumsily trying to use "perf ftrace" from git master (I might
> very well be using it wrong), and it's falling over with a NULL deref.
> I don't really understand the perf code, but it looks to me like it
> might be related to Andi Kleen's refactoring that introduced
> evlist->all_cpus?
 
> I think the problem is that evlist_close() assumes that ->cpus!=NULL
> implies ->all_cpus!=NULL, but perf_evlist__propagate_maps() doesn't
> set ->all_cpus if the evlist is empty.
 
> Here's the crash I encountered:

I've reproduced it and Jiri provided a patch, I'll test it, meanwhile
you could alternatively drop an 'f' and try 'perf trace' + 'perf probe'
instead, perhaps that could be enough, some examples:

[root@quaco ~]# perf probe kmem_cache_alloc
Added new event:
  probe:kmem_cache_alloc (on kmem_cache_alloc)

You can now use it in all perf tools, such as:

	perf record -e probe:kmem_cache_alloc -aR sleep 1

[root@quaco ~]# 

Bump the ring buffer size with -m for high freq events, limit the
backtrace size at the kernel so as to reduce the flow of events, limit
the number of events:

[root@quaco ~]# perf trace -m1024 -e probe:kmem_cache_alloc/max-stack=8/ --max-events=4
     0.000 :0/0 probe:kmem_cache_alloc(__probe_ip: -1842593216)
                                       kmem_cache_alloc ([kernel.kallsyms])
                                       __build_skb ([kernel.kallsyms])
                                       __napi_alloc_skb ([kernel.kallsyms])
                                       r8152_poll ([r8152])
                                       net_rx_action ([kernel.kallsyms])
                                       __do_softirq ([kernel.kallsyms])
                                       irq_exit ([kernel.kallsyms])
                                       do_IRQ ([kernel.kallsyms])
     0.869 :0/0 probe:kmem_cache_alloc(__probe_ip: -1842593216)
                                       kmem_cache_alloc ([kernel.kallsyms])
                                       __build_skb ([kernel.kallsyms])
                                       __napi_alloc_skb ([kernel.kallsyms])
                                       r8152_poll ([r8152])
                                       net_rx_action ([kernel.kallsyms])
                                       __do_softirq ([kernel.kallsyms])
                                       irq_exit ([kernel.kallsyms])
                                       do_IRQ ([kernel.kallsyms])
    37.427 :0/0 probe:kmem_cache_alloc(__probe_ip: -1842593216)
                                       kmem_cache_alloc ([kernel.kallsyms])
                                       __build_skb ([kernel.kallsyms])
                                       __napi_alloc_skb ([kernel.kallsyms])
                                       r8152_poll ([r8152])
                                       net_rx_action ([kernel.kallsyms])
                                       __do_softirq ([kernel.kallsyms])
                                       irq_exit ([kernel.kallsyms])
                                       do_IRQ ([kernel.kallsyms])
    37.450 :0/0 probe:kmem_cache_alloc(__probe_ip: -1842593216)
                                       kmem_cache_alloc ([kernel.kallsyms])
                                       __build_skb ([kernel.kallsyms])
                                       __napi_alloc_skb ([kernel.kallsyms])
                                       r8152_poll ([r8152])
                                       net_rx_action ([kernel.kallsyms])
                                       __do_softirq ([kernel.kallsyms])
                                       irq_exit ([kernel.kallsyms])
                                       do_IRQ ([kernel.kallsyms])
[root@quaco ~]#


Mix and match with syscall names, using globs, limit stacks for multiple
events, i.e. you can use 'perf probe kmem_*' to add all kernel functions
with that prefix, for instance:

[root@quaco ~]# perf trace -m1024 -e inotify*,stat*,probe:kmem_*/max-stack=8/ --max-events=4
     0.000 (         ): :0/0 probe:kmem_cache_alloc(__probe_ip: -1842593216)
                                       kmem_cache_alloc ([kernel.kallsyms])
                                       __build_skb ([kernel.kallsyms])
                                       __netdev_alloc_skb ([kernel.kallsyms])
                                       br_send_bpdu.isra.0.constprop.0 ([bridge])
                                       br_send_config_bpdu ([bridge])
                                       br_transmit_config.part.0 ([bridge])
                                       br_config_bpdu_generation ([bridge])
                                       br_hello_timer_expired ([bridge])
    51.901 (         ): weechat/6630 stat(filename: 0xc5be4063, statbuf: 0x7ffdfe73f050)                ...
    51.905 (         ): weechat/6630 probe:kmem_cache_alloc(__probe_ip: -1842593216)
                                       kmem_cache_alloc ([kernel.kallsyms])
                                       getname_flags ([kernel.kallsyms])
                                       user_path_at_empty ([kernel.kallsyms])
                                       vfs_statx ([kernel.kallsyms])
                                       __do_sys_newstat ([kernel.kallsyms])
                                       do_syscall_64 ([kernel.kallsyms])
                                       entry_SYSCALL_64 ([kernel.kallsyms])
                                       __xstat64 (/usr/lib64/libc-2.29.so)
    51.901 ( 0.018 ms): weechat/6630  ... [continued]: stat())                                             = 0
[root@quaco ~]#

Are you interested only in some specific syscall? Use
switch-on/switch-off to mark when to show events when to stop showing,
works for any event, even one that you mark in the middle of some
function and then at some other point in time, need to make it work with
plain syscall names:

[root@quaco ~]# perf trace -m1024 -e syscalls:sys_*_newstat,probe:kmem_*/max-stack=8/ --max-events=4 --switch-on=syscalls:sys_enter_newstat --switch-off=syscalls:sys_exit_newstat
     0.000 weechat/6630 probe:kmem_cache_alloc(__probe_ip: -1842593216)
                                       kmem_cache_alloc ([kernel.kallsyms])
                                       getname_flags ([kernel.kallsyms])
                                       user_path_at_empty ([kernel.kallsyms])
                                       vfs_statx ([kernel.kallsyms])
                                       __do_sys_newstat ([kernel.kallsyms])
                                       do_syscall_64 ([kernel.kallsyms])
                                       entry_SYSCALL_64 ([kernel.kallsyms])
                                       __xstat64 (/usr/lib64/libc-2.29.so)
    75.843 :9367/9367 probe:kmem_cache_alloc(__probe_ip: -1842593216)
                                       kmem_cache_alloc ([kernel.kallsyms])
                                       getname_flags ([kernel.kallsyms])
                                       user_path_at_empty ([kernel.kallsyms])
                                       vfs_statx ([kernel.kallsyms])
                                       __do_sys_newstat ([kernel.kallsyms])
                                       do_syscall_64 ([kernel.kallsyms])
                                       entry_SYSCALL_64 ([kernel.kallsyms])
                                       __xstat64 (/usr/lib64/libc-2.29.so)
   768.592 NetworkManager/9368 probe:kmem_cache_alloc(__probe_ip: -1842593216)
                                       kmem_cache_alloc ([kernel.kallsyms])
                                       getname_flags ([kernel.kallsyms])
                                       user_path_at_empty ([kernel.kallsyms])
                                       vfs_statx ([kernel.kallsyms])
                                       __do_sys_newstat ([kernel.kallsyms])
                                       do_syscall_64 ([kernel.kallsyms])
                                       entry_SYSCALL_64 ([kernel.kallsyms])
                                       __xstat64 (/usr/lib64/libc-2.29.so)
   999.927 weechat/6630 probe:kmem_cache_alloc(__probe_ip: -1842593216)
                                       kmem_cache_alloc ([kernel.kallsyms])
                                       getname_flags ([kernel.kallsyms])
                                       user_path_at_empty ([kernel.kallsyms])
                                       vfs_statx ([kernel.kallsyms])
                                       __do_sys_newstat ([kernel.kallsyms])
                                       do_syscall_64 ([kernel.kallsyms])
                                       entry_SYSCALL_64 ([kernel.kallsyms])
                                       __xstat64 (/usr/lib64/libc-2.29.so)
[root@quaco ~]#

- Arnaldo
