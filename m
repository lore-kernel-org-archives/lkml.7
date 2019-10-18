Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04409CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A5E222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BT4N0WgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505646AbfJRR70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 13:59:26 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43576 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505577AbfJRR70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 13:59:26 -0400
Received: by mail-qk1-f196.google.com with SMTP id a194so2010079qkg.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 10:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7ecMN7RCihceURPicB6OoYAunxLf2+vRZsYu+FJ9JKU=;
        b=BT4N0WgMKUaa+kVJfM1Hl4S1b2FLBqiG3CTVqBj4ElZE0g7USU+833RtYU+/oFfXvd
         cOe19aQs9uLjSjMeGXvaCQx4d65bhIuUyGGKAXRKJenrvK8VQKdrNT9PN7Q/kr62z3Ph
         ieVcYIqR7h7qLOV1TTWVJS82MZAK3fZXJyuYgUa1ImWVO7tBYEI98EfqhaPeL9ENVcuy
         frNRFUTPcTNaIELmILb1Lly8HX0Rdsxhha/8LZqZ+UCpHOEvq5lhqv9WjlAb4IxfLCf6
         AvxM/CB4jms/X55CYrtdImirBfMQ411UfFkWyKJkQdxGpaIQtd5kCVpb3FfBNdTIVzTq
         NkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7ecMN7RCihceURPicB6OoYAunxLf2+vRZsYu+FJ9JKU=;
        b=r0c0UOAdy14W6pri51y1ILAe9vIzjZ9S8/uL3FTKA8L+/q7NDBT5+IV+BSLArAAReh
         f/wn5d8sXqrbmz0UcKTUCtDmJoFMJ2TA6kxRrV4QOOsnGIQqbOUB0TE92mJ/s5W0crh9
         al6vZTy/gAa31nxb21hvzYnWhj38HJqOzm+lvVV8eKodG+GmUmNfxFw3wYT9Nmf3RPUh
         GcpNfPr6ICGa4p6B0BQLuAw2svw8WDQGD1YLvzkKe9ZHQeEg0xMHLa8pHCXV9HkR/Vpl
         FXb5yNvov438m3QNXn8nfODwqzInmn/WKBw+irqCmd1wgMp5OOCYBTa0L8/hv7+qifWf
         ZgZg==
X-Gm-Message-State: APjAAAX3ikeRbyziEOKV6rW89ds0aKX9MrflDSDcy+DOpzWk+QT02Yo+
        TRqnDZSctrOUUfBYxGK7f4A=
X-Google-Smtp-Source: APXvYqypUFaO8lwxL0khauMIjyib6Q6hRS0z1+9pSsQGEF2YYnL0Pielqe3U8a4gBZGlWz1Hg1MmFQ==
X-Received: by 2002:a37:a283:: with SMTP id l125mr8203680qke.298.1571421564645;
        Fri, 18 Oct 2019 10:59:24 -0700 (PDT)
Received: from quaco.ghostprotocols.net (179-240-170-47.3g.claro.net.br. [179.240.170.47])
        by smtp.gmail.com with ESMTPSA id g10sm3328303qkm.38.2019.10.18.10.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 10:59:24 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9A07C4DD66; Fri, 18 Oct 2019 14:59:19 -0300 (-03)
Date:   Fri, 18 Oct 2019 14:59:19 -0300
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] perf tests: Disable bp_signal testing for arm64
Message-ID: <20191018175919.GC1797@kernel.org>
References: <20191018085531.6348-1-leo.yan@linaro.org>
 <20191018085531.6348-3-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018085531.6348-3-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 18, 2019 at 04:55:31PM +0800, Leo Yan escreveu:
> As there have several discussions for enabling Perf breakpoint signal
> testing on arm64 platform; arm64 needs to rely on single-step to execute
> the breakpointed instruction and then reinstall the breakpoint exception
> handler.  But if hook the breakpoint with a signal, the signal handler
> will do the stepping rather than the breakpointed instruction, this
> causes infinite loops as below:
> 
>          Kernel space              |            Userspace
> -----------------------------------|--------------------------------
>                                    |  __test_function() -> hit
> 				   |                       breakpoint
>   breakpoint_handler()             |
>     `-> user_enable_single_step()  |
>   do_signal()                      |
>                                    |  sig_handler() -> Step one
> 				   |                instruction and
> 				   |                trap to kernel
>   single_step_handler()            |
>     `-> reinstall_suspended_bps()  |
>                                    |  __test_function() -> hit
> 				   |     breakpoint again and
> 				   |     repeat up flow infinitely
> 
> As Will Deacon mentioned [1]: "that we require the overflow handler to
> do the stepping on arm/arm64, which is relied upon by GDB/ptrace. The
> hw_breakpoint code is a complete disaster so my preference would be to
> rip out the perf part and just implement something directly in ptrace,
> but it's a pretty horrible job".  Though Will commented this on arm
> architecture, but the comment also can apply on arm64 architecture.
> 
> For complete information, I searched online and found a few years back,
> Wang Nan sent one patch 'arm64: Store breakpoint single step state into
> pstate' [2]; the patch tried to resolve this issue by avoiding single
> stepping in signal handler and defer to enable the signal stepping when
> return to __test_function().  The fixing was not merged due to the
> concern for missing to handle different usage cases.
> 
> Based on the info, the most feasible way is to skip Perf breakpoint
> signal testing for arm64 and this could avoid the duplicate
> investigation efforts when people see the failure.  This patch skips
> this case on arm64 platform, which is same with arm architecture.

Ok, applying,

- Arnaldo
 
> [1] https://lkml.org/lkml/2018/11/15/205
> [2] https://lkml.org/lkml/2015/12/23/477
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/tests/bp_signal.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
> index c1c2c13de254..166f411568a5 100644
> --- a/tools/perf/tests/bp_signal.c
> +++ b/tools/perf/tests/bp_signal.c
> @@ -49,14 +49,6 @@ asm (
>  	"__test_function:\n"
>  	"incq (%rdi)\n"
>  	"ret\n");
> -#elif defined (__aarch64__)
> -extern void __test_function(volatile long *ptr);
> -asm (
> -	".globl __test_function\n"
> -	"__test_function:\n"
> -	"str x30, [x0]\n"
> -	"ret\n");
> -
>  #else
>  static void __test_function(volatile long *ptr)
>  {
> @@ -302,10 +294,15 @@ bool test__bp_signal_is_supported(void)
>  	 * stepping into the SIGIO handler and getting stuck on the
>  	 * breakpointed instruction.
>  	 *
> +	 * Since arm64 has the same issue with arm for the single-step
> +	 * handling, this case also gets suck on the breakpointed
> +	 * instruction.
> +	 *
>  	 * Just disable the test for these architectures until these
>  	 * issues are resolved.
>  	 */
> -#if defined(__powerpc__) || defined(__s390x__) || defined(__arm__)
> +#if defined(__powerpc__) || defined(__s390x__) || defined(__arm__) || \
> +    defined(__aarch64__)
>  	return false;
>  #else
>  	return true;
> -- 
> 2.17.1

-- 

- Arnaldo
