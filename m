Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F66C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2638F26678
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YC7v+rg1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfEaJJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 05:09:58 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:38915 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaJJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 05:09:57 -0400
Received: by mail-ot1-f44.google.com with SMTP id k24so3358538otn.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 02:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eOoyuE6GZ0/N5LfXMgRy4lFPmyiN4GqePwZ9hhxKx7c=;
        b=YC7v+rg1saI7e5IllQqsAPxsWgrNv2T/HquEKBQtpLdsRkixDv/kZVpskTBdkyXlOC
         RYo1G9JYsxa8EGUbp9eBd3+m+OOzVLIAzUETNgcMoiQuVjl9VeCtpLRxmGjLaw+LMd5m
         G/tfpCYiriKJIRJ+KFp01GDriRMlIqH5WjvJuMSmyX17sI5pNSh3ApIh3L/LfJXduayZ
         88WEK6B8NB3gWs7j8TpLoEEu3WCjURrwTyPHLLLhCbm4+etZXcRLYarNoEo503Oz5S9t
         rpkT6yHrLoiNkv2+7fz/oYpFeL6iZvKFYkPOvLNtcAN+8V3ot7h5qhjbud6a2yWvcN6w
         qQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eOoyuE6GZ0/N5LfXMgRy4lFPmyiN4GqePwZ9hhxKx7c=;
        b=Dv04TXHWL1FEv8Y1iggKF4kA47QBHibaglrlPdMgXrF9iFq5R+jnnj2Ae3/YEvrJ8O
         3rpSWYYOMHxGxZyM7w6mRqqO55B63xsK11nxMkXzbR3GPsmoqhu6XilmwjpSB+YZNHU+
         qZwVu+Xfp4S25fpCqcMWdZqOvMDRioqWR4is4zuhE2UPGvWSOxUMaz+VqUs/JwQWUoSd
         i9rqn/EZKpigz7lolx+u2iVcqi8nKlrumiEXXRS4rUkCAbmSqchJ73pC0tD7vQXEi+TC
         amd090fvKQ9ozI0lDWGP+7PVi4c6xo5/dcv6nUhOeRuzMw6pucYA8zB5fOxJr4N5DrrI
         G1+g==
X-Gm-Message-State: APjAAAW9HXTyL9j1pWhuRkfA6ZNAbIjK1V0c3ccPIGhuAfimFO3zSfsJ
        lH98G0J6XFm6mrCf8zTc6bEWow==
X-Google-Smtp-Source: APXvYqwIKQZ/SptkBhQGTE75KY3E0ymdrnY1VCnZIW2PHsWdDzVviZjkbrPDCMhHoJ9w1OIIuXZOPg==
X-Received: by 2002:a9d:481a:: with SMTP id c26mr989834otf.267.1559293796647;
        Fri, 31 May 2019 02:09:56 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li808-42.members.linode.com. [104.237.132.42])
        by smtp.gmail.com with ESMTPSA id o203sm1966255oia.15.2019.05.31.02.09.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 02:09:50 -0700 (PDT)
Date:   Fri, 31 May 2019 17:09:41 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCHv3 00/12] perf tools: Display eBPF code in intel_pt trace
Message-ID: <20190531090940.GA9580@leoy-ThinkPad-X240s>
References: <20190508132010.14512-1-jolsa@kernel.org>
 <20190530105439.GA5927@leoy-ThinkPad-X240s>
 <20190530120709.GA3669@krava>
 <20190530125709.GB5927@leoy-ThinkPad-X240s>
 <20190530133645.GC21962@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530133645.GC21962@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Thu, May 30, 2019 at 10:36:45AM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> One other way of testing this:
> 
> I used perf trace's use of BPF, using:
> 
> [root@quaco ~]# cat ~/.perfconfig
> [llvm]
> 	dump-obj = true
> 	clang-opt = -g
> [trace]
> 	add_events = /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c
> 	show_zeros = yes
> 	show_duration = no
> 	no_inherit = yes
> 	show_timestamp = no
> 	show_arg_names = no
> 	args_alignment = 40
> 	show_prefix = yes
> 
> For arm64 this needs fixing, tools/perf/examples/bpf/augmented_raw_syscalls.c
> (its in the kernel sources) is still hard coded for x86_64 syscall numbers :-\

I changed the system call numbers for arm64 respectively in
augmented_raw_syscalls.s; so this if fine.

> Use some other BPF workload, one that has its programs being hit so that
> we get samples in it, in my case running:
> 
>     # perf trace

After I run 'perf trace' command it reports the building failure when
generate eBPF object file, as shown in below log.  I saw the eBPF code
includes the header files unistd.h and pid_filter.h which cannot be
found when clang compiled it.

These two header files are stored in the folder
$linux/tools/perf/include/bpf so I tried to use below command to
specify header path, but still failed:

# clang-7 -target bpf -O2 -I./include/bpf -I./include \
  -I../../usr/include -I../../include \
  -I../../tools/testing/selftests/bpf/ \
  -I../../tools/lib/ \
  -c examples/bpf/augmented_raw_syscalls.c

So now I am stuck for eBPF program building.  Do I miss some
configurations for headers pathes for llvm/clang?

BTW, I notice another potential issue is even the eBPF bytecode
building failed, 'perf trace' command still can continue its work;
after read the code [1], the flow is:
  trace__config();
    `-> parse_events_option();

When building eBPF object failure, parse_events_option() returns 1; for
this case trace__config() needs to detect the erro and return -1 rather
than directly return 1 to caller function.


---8<---

# perf trace
/mnt/linux-kernel/linux-cs-dev/tools/perf/examples/bpf/augmented_raw_syscalls.c:17:10: fatal error: 'unistd.h' file not found
#include <unistd.h>
         ^~~~~~~~~~
1 error generated.
ERROR:  unable to compile /mnt/linux-kernel/linux-cs-dev/tools/perf/examples/bpf/augmented_raw_syscalls.c
Hint:   Check error message shown above.
Hint:   You can also pre-compile it into .o using:
                clang -target bpf -O2 -c /mnt/linux-kernel/linux-cs-dev/tools/perf/examples/bpf/augmented_raw_syscalls.c
        with proper -I and -D options.
event syntax error: '/mnt/linux-kernel/linux-cs-dev/tools/perf/examples/bpf/augmented_raw_syscalls.c'
                     \___ Failed to load /mnt/linux-kernel/linux-cs-dev/tools/perf/examples/bpf/augmented_raw_syscalls.c from source: Error when compiling BPF scriptlet

(add -v to see detail)
Run 'perf list' for a list of valid events

Thanks a lot for help!

Leo.
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/builtin-trace.c?h=v5.2-rc2#n3631
