Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E286CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 07:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA5BB20830
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 07:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pdoqibss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfJUHyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 03:54:11 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39019 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfJUHyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 03:54:11 -0400
Received: by mail-qt1-f196.google.com with SMTP id t8so2070385qtc.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 00:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/SqswiV+O4l/WvPEZbqOyv+SpkidW7GtfPPAGcnNlro=;
        b=PdoqibssSlcMEEQ53CZ63eSRrYmPPLnkZDMZgGBmCq5XvIiOyzCrFVp2mH91akpnfZ
         gEImjUchoVdcoLkPHA5pGkYsyP3OOLmQUHsAA+FajIY1SdJBPd2Y6ilhoZ2IF6BSHN/k
         RQ2ZVCJthANygHVlre85PgooluSH3fXTKIiJn0dxBu/yVeBbBWb/i6FdcsEdlg0eaOo8
         XiE7xmf80lZepuPdFZOQVScbputOjAOZc1nFz6Z6vV+m6wE4oCuUtti/9S0w6lfxcAS2
         wDOAT2u37OGmy0LdRckKPAeGFfyKnfdWOFWssWed2ECiV3hWlnbJ0upJGvBDrqwk9G/a
         jMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/SqswiV+O4l/WvPEZbqOyv+SpkidW7GtfPPAGcnNlro=;
        b=XtXRyj8D8t14P5Js/6uIQksuHoY0pYmPw9Grb0Vzx5kYqHW03BMcrij7tLo1s03oSJ
         wlp9F5ebR4djMNsblq5eCsWEZ6LSja3DGdwuqwAcJgGdqJUhQhwhgNf+b7eHb38e9U+N
         oj2HvLhTEzi5gFu+tol7SnT4Jp2VRcyC/EcBd8/7i075AaENo08OE2Xcn/OiofsPNtz/
         1k2Mv5YJtwf0FdQ3O5Gt1rCChqbS3KAS/DQSch3O0Zs5kLafhKnLvKIA+QnaCRdg8vsz
         ipw6Cq5800V35329Ez8li5UDwjVMA+GK37y2wG9hIosspqHDF3mxnsLoIUGu+Nyt4ArJ
         /vUQ==
X-Gm-Message-State: APjAAAWEHXGH1fX+0OKRz1to5uI1/qK7Qw4MabgFTwqHQwxktDI8DT63
        hLCGvxrmoc+25wexG58xGnXz/A==
X-Google-Smtp-Source: APXvYqxXFnUuUGy2rdlJn3kk74MWvYkCwvjrVlZKb6XlgQHfBpNTrQ1QorGkABOnqq8px3qVJc7Exg==
X-Received: by 2002:ac8:6890:: with SMTP id m16mr23414431qtq.227.1571644449713;
        Mon, 21 Oct 2019 00:54:09 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li937-157.members.linode.com. [45.56.119.157])
        by smtp.gmail.com with ESMTPSA id 64sm7257589qkk.63.2019.10.21.00.54.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 00:54:08 -0700 (PDT)
Date:   Mon, 21 Oct 2019 15:53:59 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
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
Message-ID: <20191021075359.GA26243@leoy-ThinkPad-X240s>
References: <20191018085531.6348-1-leo.yan@linaro.org>
 <20191018085531.6348-3-leo.yan@linaro.org>
 <20191018175919.GC1797@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018175919.GC1797@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 02:59:19PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Oct 18, 2019 at 04:55:31PM +0800, Leo Yan escreveu:
> > As there have several discussions for enabling Perf breakpoint signal
> > testing on arm64 platform; arm64 needs to rely on single-step to execute
> > the breakpointed instruction and then reinstall the breakpoint exception
> > handler.  But if hook the breakpoint with a signal, the signal handler
> > will do the stepping rather than the breakpointed instruction, this
> > causes infinite loops as below:
> > 
> >          Kernel space              |            Userspace
> > -----------------------------------|--------------------------------
> >                                    |  __test_function() -> hit
> > 				   |                       breakpoint
> >   breakpoint_handler()             |
> >     `-> user_enable_single_step()  |
> >   do_signal()                      |
> >                                    |  sig_handler() -> Step one
> > 				   |                instruction and
> > 				   |                trap to kernel
> >   single_step_handler()            |
> >     `-> reinstall_suspended_bps()  |
> >                                    |  __test_function() -> hit
> > 				   |     breakpoint again and
> > 				   |     repeat up flow infinitely
> > 
> > As Will Deacon mentioned [1]: "that we require the overflow handler to
> > do the stepping on arm/arm64, which is relied upon by GDB/ptrace. The
> > hw_breakpoint code is a complete disaster so my preference would be to
> > rip out the perf part and just implement something directly in ptrace,
> > but it's a pretty horrible job".  Though Will commented this on arm
> > architecture, but the comment also can apply on arm64 architecture.
> > 
> > For complete information, I searched online and found a few years back,
> > Wang Nan sent one patch 'arm64: Store breakpoint single step state into
> > pstate' [2]; the patch tried to resolve this issue by avoiding single
> > stepping in signal handler and defer to enable the signal stepping when
> > return to __test_function().  The fixing was not merged due to the
> > concern for missing to handle different usage cases.
> > 
> > Based on the info, the most feasible way is to skip Perf breakpoint
> > signal testing for arm64 and this could avoid the duplicate
> > investigation efforts when people see the failure.  This patch skips
> > this case on arm64 platform, which is same with arm architecture.
> 
> Ok, applying,

Thanks a lot, Arnaldo.

@Will, @Mark Rultland, very appreciate if you have time to review this
patch and welcome any comments or suggestions!  It's good you could
confirm this patch so have more confidence for it.

Thanks,
Leo Yan

> - Arnaldo
>  
> > [1] https://lkml.org/lkml/2018/11/15/205
> > [2] https://lkml.org/lkml/2015/12/23/477
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/tests/bp_signal.c | 15 ++++++---------
> >  1 file changed, 6 insertions(+), 9 deletions(-)
> > 
> > diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
> > index c1c2c13de254..166f411568a5 100644
> > --- a/tools/perf/tests/bp_signal.c
> > +++ b/tools/perf/tests/bp_signal.c
> > @@ -49,14 +49,6 @@ asm (
> >  	"__test_function:\n"
> >  	"incq (%rdi)\n"
> >  	"ret\n");
> > -#elif defined (__aarch64__)
> > -extern void __test_function(volatile long *ptr);
> > -asm (
> > -	".globl __test_function\n"
> > -	"__test_function:\n"
> > -	"str x30, [x0]\n"
> > -	"ret\n");
> > -
> >  #else
> >  static void __test_function(volatile long *ptr)
> >  {
> > @@ -302,10 +294,15 @@ bool test__bp_signal_is_supported(void)
> >  	 * stepping into the SIGIO handler and getting stuck on the
> >  	 * breakpointed instruction.
> >  	 *
> > +	 * Since arm64 has the same issue with arm for the single-step
> > +	 * handling, this case also gets suck on the breakpointed
> > +	 * instruction.
> > +	 *
> >  	 * Just disable the test for these architectures until these
> >  	 * issues are resolved.
> >  	 */
> > -#if defined(__powerpc__) || defined(__s390x__) || defined(__arm__)
> > +#if defined(__powerpc__) || defined(__s390x__) || defined(__arm__) || \
> > +    defined(__aarch64__)
> >  	return false;
> >  #else
> >  	return true;
> > -- 
> > 2.17.1
> 
> -- 
> 
> - Arnaldo
