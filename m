Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE598C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A568F2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556862563;
	bh=QDJS5qpCTDsWKWG1sOQ6PgfvOqSQm9xT+DF5YiTot4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cxqhbB8A6+1EjFyGszKwtJ96HxJr7vlBVTo7JCJ6qXZSY4h4/8VRezYcpGr7/1iyG
	 cDH8E5CjP2CojTa8hYCS/dblHgi2RjnVDTVqCjaqyp0YJvTKrMFPqPgXzaG9/y/0C7
	 uxAIx4JPGo3C4i2rpcjzRMm5L4Qfup9wwsRqb3zk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfECFtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 01:49:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52242 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfECFtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 01:49:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id y26so415582wma.2;
        Thu, 02 May 2019 22:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jEtD/QROdRoZMdtJ2dsZznCcpXDWY3kEnm5xfwgMrZc=;
        b=IihES92oVS0ac8Ta5hthk1BtpHLBkFWxNWjlDX25ERQrRn2jA8pxYnQ595yMxYDprz
         CSiJny4oK8Xn2mgUzlPs65z+ZHUYAwhxWf8ByZx0z0ngIBWoiaBJ0NrTY1yX2Lzm24CK
         QJNnEhAan/uBuNjz7LLb6go5by+15+hMnAkzqnFzZ745bG226kYhNNQ+Z/w5OisWZPgI
         2dnVWsnOPAybZqUhgTrom+zCHs6LoP6ALjeE6QVMxOG02MtF3ryveHaFLa/JPa/3fEiF
         wkUGwlP/BnFnTqwvHVuKu50g2+k4iHb68iEtWDFNuppTIwL2ReLSahpKGf/58MhrUlYj
         HzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jEtD/QROdRoZMdtJ2dsZznCcpXDWY3kEnm5xfwgMrZc=;
        b=L46EsPHqqJbRwG25NGI9Z93903Gv82gGMoEdGo4RxVacLIPff+vRGSzbQ2Xg2L+IGm
         XttRwWCRsPYbCKmJmnsPvgtqpiQRIUHYKveIUAbriu6YYYRBf56DEBX50/9DGeRCmv3W
         8Oo+ofRo2PYZBAPmfP9P6ijCJ3R5Vkr4vTvzJta0PfyGlN2qPNpxI81JDQ1liDq0+1nH
         zez5zq42kbAFARWaUkr09LpF3ED+g1hM8Bx4bRztY1k33zq1Gzwf5xWFKogjrZ7UMUAd
         U9gye1zk/rfoUPyxq4xXWEBVbXbkUvl8GGmI1n7ydXmVgDObynjKTInACpnU9Moe+40G
         O+Jg==
X-Gm-Message-State: APjAAAXdL9ohIqjrjMuZOlLrkXwKWhUFd2RCK3KRbz5HQdyO3GzBGRVY
        3iDRatXE13i2XdXI+Sm/u1Q=
X-Google-Smtp-Source: APXvYqwWtuHFglRdBg2eEFr1WvieAf1gFhFs/viszhEkovNmdR8Fy2s+NGgw0TVDEETeWnAEUX6PkQ==
X-Received: by 2002:a1c:c7c8:: with SMTP id x191mr4809912wmf.146.1556862544642;
        Thu, 02 May 2019 22:49:04 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id o130sm1008249wmo.43.2019.05.02.22.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 22:49:03 -0700 (PDT)
Date:   Fri, 3 May 2019 07:49:00 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Bo YU <tsu.yubo@gmail.com>, Leo Yan <leo.yan@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Thomas Backlund <tmb@mageia.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [GIT PULL 00/11] perf/urgent fixes
Message-ID: <20190503054900.GA95556@gmail.com>
References: <20190503002533.29359-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503002533.29359-1-acme@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Hi Ingo,
> 
> 	This took a bit more time than I expected as I'm traveling,
> LSF/MM + BPF, and also some of the fixes I worked on and off while on my
> way here needed tweaks,
> 
> Thanks,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 1804569d87de903b4d746ba71512c3ed0a890d65:
> 
>   MAINTAINERS: Include vendor specific files under arch/*/events/* (2019-05-02 18:28:12 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.1-20190502
> 
> for you to fetch changes up to 7e221b811f1472d0c58c7d4e0fe84fcacd22580a:
> 
>   perf tools: Remove needless asm/unistd.h include fixing build in some places (2019-05-02 16:00:20 -0400)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> tools UAPI:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Sync x86's vmx.h with the kernel.
> 
>   - Copy missing unistd.h headers for arc, hexagon and riscv, fixing
>     a reported build regression on the ARC 32-bit architecture.
> 
> perf bench numa:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Add define for RUSAGE_THREAD if not present, fixing the build on the
>     ARC architecture when only zlib and libnuma are present.
> 
> perf BPF:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - The disassembler-four-args feature test needs -ldl on distros such as
>     Mageia 7.
> 
>   Bo YU:
> 
>   - Fix unlocking on success in perf_env__find_btf(), detected with
>     the coverity tool.
> 
> libtraceevent:
> 
>   Leo Yan:
> 
>   - Change misleading hard coded 'trace-cmd' string in error messages.
> 
> ARM hardware tracing:
> 
>   Leo Yan:
> 
>   - Always allocate memory for cs_etm_queue::prev_packet, fixing a segfault
>     when processing CoreSight perf data.
> 
> perf annotate:
> 
>   Thadeu Lima de Souza Cascardo:
> 
>   - Fix build on 32 bit for BPF.
> 
> perf report:
> 
>   Thomas Richter:
> 
>   - Report OOM in status line in the GTK UI.
> 
> core libs:
> 
>   - Remove needless asm/unistd.h that, used with sys/syscall.h ended
>     up redefining the syscalls defines in environments such as the
>     ARC arch when using uClibc.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (5):
>       tools uapi x86: Sync vmx.h with the kernel
>       perf bench numa: Add define for RUSAGE_THREAD if not present
>       tools build: Add -ldl to the disassembler-four-args feature test
>       tools arch uapi: Copy missing unistd.h headers for arc, hexagon and riscv
>       perf tools: Remove needless asm/unistd.h include fixing build in some places
> 
> Bo YU (1):
>       perf bpf: Return value with unlocking in perf_env__find_btf()
> 
> Leo Yan (3):
>       tools lib traceevent: Change tag string for error
>       perf cs-etm: Don't check cs_etm_queue::prev_packet validity
>       perf cs-etm: Always allocate memory for cs_etm_queue::prev_packet
> 
> Thadeu Lima de Souza Cascardo (1):
>       perf annotate: Fix build on 32 bit for BPF annotation
> 
> Thomas Richter (1):
>       perf report: Report OOM in status line in the GTK UI
> 
>  tools/arch/arc/include/uapi/asm/unistd.h     | 51 ++++++++++++++++++++++++++++
>  tools/arch/hexagon/include/uapi/asm/unistd.h | 40 ++++++++++++++++++++++
>  tools/arch/riscv/include/uapi/asm/unistd.h   | 42 +++++++++++++++++++++++
>  tools/arch/x86/include/uapi/asm/vmx.h        |  1 +
>  tools/lib/traceevent/parse-utils.c           |  2 +-
>  tools/perf/Makefile.config                   |  2 +-
>  tools/perf/bench/numa.c                      |  4 +++
>  tools/perf/util/annotate.c                   |  8 ++---
>  tools/perf/util/cloexec.c                    |  1 -
>  tools/perf/util/cs-etm.c                     | 14 +++-----
>  tools/perf/util/env.c                        |  2 +-
>  tools/perf/util/session.c                    |  8 +++--
>  12 files changed, 154 insertions(+), 21 deletions(-)
>  create mode 100644 tools/arch/arc/include/uapi/asm/unistd.h
>  create mode 100644 tools/arch/hexagon/include/uapi/asm/unistd.h
>  create mode 100644 tools/arch/riscv/include/uapi/asm/unistd.h

Pulled, thanks a lot Arnaldo!

	Ingo
