Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955A1C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497472068F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574496474;
	bh=THrCQeq7Et5YV0JzheQEwHsz+oijxu1/MfQ/sa+ULmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WX5y6e2h8kSM6ApmDDCC7i7TU6TdgoY2UZ3pWHSLdhWBubZl/gWFLObK2IgCD0P5U
	 K6hWyJpytUabl6w1WPTR3UvaNftPp4SDExYwQqhpcpX2x9FsrdThbGXrRSc4Lcm/dk
	 GjtdPNqsCnd2zLgpwM7m3oph7H1ooneTXyBs3IVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfKWIHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 03:07:50 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52351 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfKWIHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 03:07:50 -0500
Received: by mail-wm1-f65.google.com with SMTP id l1so9872536wme.2;
        Sat, 23 Nov 2019 00:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=07fe1I7p12wQmHqQMWinNW0R6IU6biu7P23IKa0HBq8=;
        b=t+pOynLrAqWSf7Tb8KuH1ALOqcQs9CosnxAt2jyXfGwGcLnUKZiPI2H5H27n9AuvPw
         6dufCEwww1y8MAh5z6awa11KsuODjXY4zQX4kf2L12m5AgrZWPl8EpVV1mBqvtdKrVga
         xeEnd1eudESHwmvWVTA61CulSBhMQ8u6Rho2wdcEM3ofxzdwhFYZgBjLS7b8xB9Jiwpt
         HU6T/Gze5qJy4aHqoXkbWulsWWWsugxN8bCBxQ4hgQDlY/tPYmBgnPRTDiwfEBf6HEoC
         Bm57Nsmr13/A2NVFvglA+l8y7blGzdMsAZscb4Aq+N741SJMsSM1MaFy9IJgutNwTkKP
         bnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=07fe1I7p12wQmHqQMWinNW0R6IU6biu7P23IKa0HBq8=;
        b=pMy8XLrCcafJGkFwDpsdAFRmYy/mEa2JYnHxJMLkRGlcvZIH4YIdNdcJEfrZSLElRX
         twKcJyYBYvK+jHROu/j7vo5Nviom41bn05TXwKQGU1Y3P4853FXR1kMM7oqt4NXar16/
         sQgKPy5NiE6b4BE7fE1aghfnGY+cNwLgeGlBKPSJfpagxohPzwaJnWz0PHNQAHNCcTBy
         Xm9FPIYokxcppuCZ0nqUkOZzzqWhlkuGPQtBwPn0BHKDvz/r2PlOMoQ0f8xcu9/Kaz30
         Rn8ld9+ZFB6x+sfRnJePlzoJnP9kfAfn9GGYlFVoXFRrW/hi/66Iw4DyeuPPwcuEXTED
         EiEw==
X-Gm-Message-State: APjAAAWL1J02ZApED5eMNKgiPk4KPRrwJO2+S9ZnZfOLy5zAPISBtmj/
        XKIuOejC3d8bQigZ1qtmcRQ=
X-Google-Smtp-Source: APXvYqyMypxEx2A8jhLWegD4wlPK9gTf7quuyEB2M1vSQNrFiCWqPSW2pK1yQOdheup2DUxIaMI/xQ==
X-Received: by 2002:a05:600c:290e:: with SMTP id i14mr2329018wmd.126.1574496467097;
        Sat, 23 Nov 2019 00:07:47 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id t14sm1181370wrw.87.2019.11.23.00.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 00:07:46 -0800 (PST)
Date:   Sat, 23 Nov 2019 09:07:44 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Colin King <colin.king@canonical.com>,
        Hewenliang <hewenliang4@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudipm Mukherjee <sudipm.mukherjee@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Message-ID: <20191123080744.GB110331@gmail.com>
References: <20191122145711.3171-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191122145711.3171-1-acme@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo/Thomas,
> 
> 	Please consider pulling,
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 8f6ee51d772d0dab407d868449d2c5d9c8d2b6fc:
> 
>   Merge tag 'perf-core-for-mingo-5.5-20191119' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2019-11-19 12:59:03 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.5-20191122
> 
> for you to fetch changes up to 4584f084aa9d8033d5911935837dbee7b082d0e9:
> 
>   perf parse: Fix potential memory leak when handling tracepoint errors (2019-11-22 10:48:14 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf report:
> 
>   Jin Yao:
> 
>   - Allow entering the annotation view (symbol source/assembly +
>     overhead/cycles/etc column) from the 'perf report --total-cycles'
>     interface.
> 
>     E.g.:
> 
>       # perf record --all-cpus --branch-any --all-kernel
>       ^C[ perf record: Woken up 5 times to write data ]
>       #
>       # perf evlist -v
>       cycles: size: 120, { sample_period, sample_freq }: 4000,
>       sample_type: IP|TID|TIME|CPU|PERIOD|BRANCH_STACK,
>       read_format: ID, disabled: 1, inherit: 1, exclude_user: 1, mmap: 1, comm: 1, freq: 1, task: 1,
>       precise_ip: 3, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1,
>       bpf_event: 1, branch_sample_type: ANY
>       #
>       # perf report --total-cycles
>       #
>       # Samples: 78762 of event 'cycles'
>       Sampled  Sampled Avg      Avg
>       Cycles%  Cycles  Cycles%  Cycles                           [Program Block Range]     Shared Object
>         1.72%    95.8K   0.00%     254                        [msr.h:105 -> msr.h:166]  [kernel.vmlinux]
>         1.56%   107.6K   0.00%     618                [compiler.h:199 -> common.c:301]  [kernel.vmlinux]
>         0.83%    46.3K   0.00%     409              [entry_64.S:153 -> entry_64.S:175]  [kernel.vmlinux]
>         0.83%    46.1K   0.00%      83                  [jump_label.h:41 -> tsc.c:230]  [kernel.vmlinux]
>         0.64%    36.9K   0.01%    1.4K            [hda_intel.c:904 -> hda_intel.c:916]   [snd_hda_intel]
>         0.57%    30.2K   0.00%     282                      [file.c:710 -> file.c:730]  [kernel.vmlinux]
>         0.48%    25.8K   0.00%      82              [spinlock.c:158 -> spinlock.c:160]  [kernel.vmlinux]
>         0.45%    23.7K   0.00%     369  [tick-broadcast.c:585 -> tick-broadcast.c:586]  [kernel.vmlinux]
>         0.44%    24.4K   0.00%      73                       [msr.h:236 -> tsc.c:1088]  [kernel.vmlinux]
>         0.43%    22.7K   0.00%     144                [cpuidle.c:229 -> cpuidle.c:232]  [kernel.vmlinux]
> 
>     Then press 'A' or Enter on one of those lines, just like with 'perf top', say
>     the top one: [msr.h:105 -> msr.h:166], then this shows up:
> 
>       Samples: 78K of event 'cycles', 4000 Hz, Event count (approx.): 78762
>       native_write_msr  /lib/modules/5.4.0-rc8/build/vmlinux [Percent: local period]
>       Percent│ IPC Cycle (Average IPC: 0.02, IPC Coverage: 50.0%)
>              │
>              │             Disassembly of section .text:
>              │
>              │             ffffffff8106c480 <native_write_msr>:
>              │             __wrmsr():
>              │             return EAX_EDX_VAL(val, low, high);
>              │             }
>              │
>              │             static inline void notrace __wrmsr(unsigned int msr, u32 low, u32 high)
>              │             {
>              │             asm volatile("1: wrmsr\n"
>        49.16 │0.02           mov   %edi,%ecx
>              │0.02           mov   %esi,%eax
>              │0.02           wrmsr
>              │             arch_static_branch():
>              │             #include <linux/stringify.h>
>              │             #include <linux/types.h>
>              │
>              │             static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
>              │             {
>              │             asm_volatile_goto("1:"
>         0.79 │0.02           nop
>              │             native_write_msr():
>              │             {
>              │             __wrmsr(msr, low, high);
>              │
>              │             if (msr_tracepoint_active(__tracepoint_write_msr))
>              │             do_trace_write_msr(msr, ((u64)high << 32 | low), 0);
>              │             }
>        50.05 │0.02  254    ← retq
>              │             do_trace_write_msr(msr, ((u64)high << 32 | low), 0);
>              │               shl   $0x20,%rdx
>              │               mov   %esi,%esi
>              │               or    %rdx,%rsi
>              │               xor   %edx,%edx
>              │             → jmpq  do_trace_write_msr
> 
>     We need to improve this to show the source code line numbers in the
>     annotation view, so one can go from that program block to the annotation view
>     and see those source code line numbers straight away.
> 
> auxtrace/Intel PT:
> 
>   Adrian Hunter:
> 
>   - Add support for AUX area sampling, requires new functionality that
>     will land in 5.5, its already in tip.
> 
>     This includes kernel capability querying so that it fails gracefully
>     with older kernels, duimping aux area samples in 'perf report -D' and
>     'perf script'.
> 
> perf.data:
> 
>   Alexey Budankov:
> 
>   - Fix decompression of PERF_RECORD_COMPRESSED records.
> 
> core:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Use the 'dcacheline' cmp routine to find the right DSOs taking into
>     account the 'maj', 'min', 'ino' and 'ino_generation', that got moved
>     from 'struct map' to 'struct dso', where it belongs.
> 
>     This further reduces the size of 'struct map', there is still more
>     work to do to maybe get it to max one cacheline.
> 
> libtraceevent:
> 
>   Hewenliang:
> 
>   - Fix memory leakage in copy_filter_type().
> 
>   Sudip Mukherjee:
> 
>   - Fix header installation.
> 
> perf parse:
> 
>   Ian Rogers :
> 
>   - Fix potential memory leak when handling tracepoint errors, found using
>     LLVM's libFuzzer.
> 
> perf probe:
> 
>   Colin Ian King:
> 
>   - Fix spelling mistake "addrees" -> "address".
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------

>  46 files changed, 1190 insertions(+), 200 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
