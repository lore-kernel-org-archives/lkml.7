Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F63C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A90F208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jfp/nLSG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfFYU1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 16:27:51 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37850 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbfFYU1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 16:27:51 -0400
Received: by mail-ed1-f68.google.com with SMTP id w13so29090078eds.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 13:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KHfPZQLU9yl1gHuggr9n1N7pshmjwg+NN34rxMj0w4s=;
        b=Jfp/nLSGWZHHP04a0GL9kuH5TUJdr3nC5h+Ljhc6th6zySciaDZAmam8IinFFf57Uo
         OQ8hu+DrOkncMiAdjkSKTLD4JxVCJNydcHOp7QANaz3Ph5i/frjYn/WKkFXL77HrHih+
         rONtmWQ0W3P5U95COaaLEc1a3bow5QuvP8Cbs9ZABG24tN0OID3r+Vl/SuHXbIY+pDR+
         93RbA4EgKNBapnZCkZVhGlBT6LpLIQLXVSdiYOV1i1lp5he0S0zBxBEAw8dq8TgW6jwz
         vFKTutiOQZaLc4bhnoDrZ+qya+mdtrMh0a6OK4beQbdXkg6UfBbln+AaFm9m3MK5188F
         aUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KHfPZQLU9yl1gHuggr9n1N7pshmjwg+NN34rxMj0w4s=;
        b=TG2e0RUAMs6HV8pHf4mV6Envas0Fbgfj5mSCw5NaxruiDybLMdR8L4KHr25Ub/kvSH
         z28oHO0Mz3M1uYlS5Yv70BO/w7t4OA0oQTDh+vIFAgc7KxbZAErttv/xLTAoHSYjhKeA
         BQ2a6ch+ZZq2cPInC2LqgdPCUs+RprEuKkarxZwADlH+b6HGZi4G4xcb71GaGxAhNaJk
         16EBOKq0IDgleySvMTdkYUb+Y8VIhK25KosLdRycJWz1RpHdcTobJsKcoycqfK3y01vt
         24ap3BxYBF+++wSVuVJ0iooT4sxah2vfLT/ZDUML7exAwRZWugO891EisXmSDKBQaI+q
         pPcg==
X-Gm-Message-State: APjAAAUkNUCXMTqAIBrnwXVdC6WtAHJbcVtmWUyk80RUpfFcjGfRoCMj
        1+A563RupmDIu4o5ENri7jQ=
X-Google-Smtp-Source: APXvYqzC/bII30ufh+3eslpwLKFtwLVQgpfBB2Zd+HFjIVa7o0viBLQJwIWC6Dhw7rqBRQ2y7dh3RQ==
X-Received: by 2002:a50:b635:: with SMTP id b50mr401477ede.293.1561494469286;
        Tue, 25 Jun 2019 13:27:49 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id p15sm2608880ejb.6.2019.06.25.13.27.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 13:27:48 -0700 (PDT)
Date:   Tue, 25 Jun 2019 13:27:46 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Joe Perches <joe@perches.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shawn Landden <shawn@git.icu>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
Message-ID: <20190625202746.GA83499@archlinux-epyc>
References: <20190624161913.GA32270@embeddedor>
 <20190624193123.GI3436@hirez.programming.kicks-ass.net>
 <b00fc090d83ac6bd41a5db866b02d425d9ab20e4.camel@perches.com>
 <20190624203737.GL3436@hirez.programming.kicks-ass.net>
 <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
 <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com>
 <20190625071846.GN3436@hirez.programming.kicks-ass.net>
 <201906251009.BCB7438@keescook>
 <20190625180525.GA119831@archlinux-epyc>
 <alpine.DEB.2.21.1906252127290.32342@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906252127290.32342@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, Jun 25, 2019 at 09:53:09PM +0200, Thomas Gleixner wrote:
> On Tue, 25 Jun 2019, Nathan Chancellor wrote:
> > On Tue, Jun 25, 2019 at 10:12:42AM -0700, Kees Cook wrote:
> > > On Tue, Jun 25, 2019 at 09:18:46AM +0200, Peter Zijlstra wrote:
> > > > Can it build a kernel without patches yet? That is, why should I care
> > > > what LLVM does?
> > > 
> > > Yes. LLVM trunk builds and boots x86 now. As for distro availability,
> > > AIUI, the asm-goto feature missed the 9.0 LLVM branch point, so it'll
> > > appear in the following release.
> > > 
> > > -- 
> > > Kees Cook
> > 
> > I don't think that's right. LLVM 9 hasn't been branched yet so it should
> > make it in.
> > 
> > http://lists.llvm.org/pipermail/llvm-dev/2019-June/133155.html
> > 
> > If anyone wants to play around with it before then, we wrote a
> > self-contained script that will build an LLVM toolchain suitable for
> > kernel development:
> > 
> > https://github.com/ClangBuiltLinux/tc-build
> 
> Useful!
> 
> But can the script please check for a minimal clang version required to
> build that thing.
> 
> The default clang-3.8 which is installed on Debian stretch explodes. The
> 6.0 variant from backports works as advertised.
> 

Hmmm interesting, I test a lot of different distros using Docker
containers to make sure the script works universally and that includes
Debian stretch, which is the stress tester because all of the packages
are older. I install the following packages then run the following
command and it works fine for me (just tested):

$ apt update && apt install -y --no-install-recommends ca-certificates \
ccache clang cmake curl file gcc g++ git make ninja-build python3 \
texinfo zlib1g-dev
$ ./build-llvm.py

If you could give me a build log, I'd be happy to look into it and see
what I can do.

> Kernel builds with the new shiny compiler. Jump labels seem to be enabled.
> 
> It complains about a few type conversions:
> 
>  arch/x86/kvm/mmu.c:4596:39: warning: implicit conversion from 'int' to 'u8' (aka 'unsigned char') changes value from -205 to 51 [-Wconstant-conversion]
>                 u8 wf = (pfec & PFERR_WRITE_MASK) ? ~w : 0;
>                    ~~                               ^~
> 

Yes, there was a patch sent to try and fix this but it was rejected by
the maintainers:

https://github.com/ClangBuiltLinux/linux/issues/95

https://lore.kernel.org/lkml/20180619192504.180479-1-mka@chromium.org/

> but it also makes objtool unhappy:
> 
>  arch/x86/events/intel/core.o: warning: objtool: intel_pmu_nhm_workaround()+0xb3: unreachable instruction
>  kernel/fork.o: warning: objtool: free_thread_stack()+0x126: unreachable instruction
>  mm/workingset.o: warning: objtool: count_shadow_nodes()+0x11f: unreachable instruction
>  arch/x86/kernel/cpu/mtrr/generic.o: warning: objtool: get_fixed_ranges()+0x9b: unreachable instruction
>  arch/x86/kernel/platform-quirks.o: warning: objtool: x86_early_init_platform_quirks()+0x84: unreachable instruction
>  drivers/iommu/irq_remapping.o: warning: objtool: irq_remap_enable_fault_handling()+0x1d: unreachable instruction
> 

Unfortunately, we have quite a few of those outstanding, it's probably
time to start really taking a look at them:

https://github.com/ClangBuiltLinux/linux/labels/objtool

> Kernel boots. As I'm currently benchmarking VDSO performance, this was
> obviosly my first test. Compared to the same kernel built with gcc6.3 the
> performance of the VDSO drops slightly.
> 
> It's below 1%. Though I need to run the same tests on 4 other uarchs to get
> the full picture. This stuff is randomly changing behaviour accross uarchs
> depending on how the c source is arranged. So nothing to worry about (yet).
> 

Thanks for trying it out and letting us know. Please keep us in the loop
if you happen to find anything amiss.

Cheers,
Nathan

> Thanks,
> 
> 	tglx
> 
