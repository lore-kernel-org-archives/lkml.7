Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADF4C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 16:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 118DD20679
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 16:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wi9/mC5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfHMQfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 12:35:39 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40457 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfHMQfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 12:35:38 -0400
Received: by mail-ot1-f67.google.com with SMTP id c34so34894440otb.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 09:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fzB2ggJlh0N+RbsH1azT+YPoxdzqG3zdG3CDP2iDq1A=;
        b=Wi9/mC5yulWJWA8OL9yRNSdmg86TTwQRjHIxZgGJXQXTXWY1RgB04RHBGtJxkRO4bf
         urA+4xmvrgqERtVC6H7eu+h5dVTMCARHxeQqDkRF1tLCPjkKRIsCuHG0lKKCNrHaUnkW
         /UQ4QUxNS6u7FJbT2Zi43xADWGN8MoHdbgIzlKE+23bXsr6b2pBuMC3t3QMg60kPmYuz
         XFT1Ty4iiip+itZNva+5vrjez+FVS2GTlhSu8/7siDOzLuE55bkcKGD/Rt+GrBqi7LKu
         pTAhxdDZ+Zi06m8SACepkm/xn8AgSnB7uOx3/C+KNAEJ9bbikNEfuY9hP8TPCF3e6qic
         l25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fzB2ggJlh0N+RbsH1azT+YPoxdzqG3zdG3CDP2iDq1A=;
        b=Em19WXQkXX1FbyZDzv7yWR6MMVCDXmr/MgrBj7OrAFtecr3FnxUVKzFqlY5wIbGkfj
         mCaeNfIaSsMIDLHR0mB8yYO3JlZuK6Oobuo0vtMvtBWn+yfs1RhP8OB7cEN2ylSacRxX
         wcM5PtAtwY0k5nT4LQeEvdxTFcILMUdG4w0iWingVWhOKXluoNrBq0u/AQHhEeUOuCaL
         ezqdnSTUlF4dejtNX0+c4m3IbwKuDGp0NRVgxDC5kMlZzja1ns5wJSoJAEdpkOTHRPRq
         vsh8B7zddfGJwzLAMzbv9XtqEgerOQFFIkGw80HZnCMfv/u1WSsQ9J3b28o+NNmi2kyA
         8eSQ==
X-Gm-Message-State: APjAAAV1rqbMd+OvYJtBz+ZM6BmT61ZQMSqKvnvcKXSGr4wWqBko51kO
        I3DlKW8YfERsleoKSFIi19dVU/MjThBN3/ayFZkmYQ==
X-Google-Smtp-Source: APXvYqyxL+jripQJqwIkVPl+ZCHAArNKcyrcvRHPfSZDGGG/wGq0OQGkJKpNIB8aKn/fDZQh37VaPdgNU4AcXI3pybc=
X-Received: by 2002:a6b:720e:: with SMTP id n14mr42955425ioc.139.1565714137167;
 Tue, 13 Aug 2019 09:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1565188228.git.ilubashe@akamai.com> <bd8763b72ed4d58d0b42d44fbc7eb474d32e53a3.1565188228.git.ilubashe@akamai.com>
 <20190812202251.GG9280@kernel.org> <20190812202706.GH9280@kernel.org>
 <20190812202947.GI9280@kernel.org> <CANLsYkwjdhzVMwrWboTTOw+P3NajtoswxfxhodK0DdeexFCR3w@mail.gmail.com>
 <20190813132349.GB12299@kernel.org>
In-Reply-To: <20190813132349.GB12299@kernel.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 13 Aug 2019 10:35:26 -0600
Message-ID: <CANLsYkynrTs4TouDs2=beEigOh6Ptatga_-WjE-FdC1ecKWyWg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] perf: Use CAP_SYS_ADMIN instead of euid==0 with ftrace
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Igor Lubashev <ilubashe@akamai.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Tue, 13 Aug 2019 at 07:23, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Mon, Aug 12, 2019 at 03:42:17PM -0600, Mathieu Poirier escreveu:
> > On Mon, 12 Aug 2019 at 14:29, Arnaldo Carvalho de Melo
> > <arnaldo.melo@gmail.com> wrote:
> > >
> > > Em Mon, Aug 12, 2019 at 05:27:06PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > Em Mon, Aug 12, 2019 at 05:22:51PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > > Em Wed, Aug 07, 2019 at 10:44:17AM -0400, Igor Lubashev escreveu:
> > > > > > @@ -281,7 +283,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
> > > > > >           .events = POLLIN,
> > > > > >   };
> > > > > >
> > > > > > - if (geteuid() != 0) {
> > > > > > + if (!perf_cap__capable(CAP_SYS_ADMIN)) {
> > > > > >           pr_err("ftrace only works for root!\n");
> > > > >
> > > > > I guess we should update the error message too?
> > > > >
> > > >
> > > > I.e. I applied this as a follow up patch:
> > > >
> > > > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > > > index 01a5bb58eb04..ba8b65c2f9dc 100644
> > > > --- a/tools/perf/builtin-ftrace.c
> > > > +++ b/tools/perf/builtin-ftrace.c
> > > > @@ -284,7 +284,12 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
> > > >       };
> > > >
> > > >       if (!perf_cap__capable(CAP_SYS_ADMIN)) {
> > > > -             pr_err("ftrace only works for root!\n");
> > > > +             pr_err("ftrace only works for %s!\n",
> > > > +#ifdef HAVE_LIBCAP_SUPPORT
> > > > +             "users with the SYS_ADMIN capability"
> > > > +#else
> > > > +             "root"
> > > > +#endif
> > >
> > >                 );
> > >
> > > :-)
> > >
> > > >               return -1;
> > > >       }
> > > >
> > >
> > > I've pushed the whole set to my tmp.perf/cap branch, please chec
> >
> > Please hold on before moving further - I'm getting a segmentation
> > fault on ARM64 that I'm still trying to figure out.
>
> This is just sitting in my tmp branch, and in my local perf/core branch,
> so that I can test it with the containers, etc.
>
> Is this related to the following fix?

That is the first thing I thought about but no, it has nothing to do
with it.  Patch 3/4 is where the problem shows up.  The code in the
patch is fine, it is the repercussion it has on other part that needs
to be investigated.

Right now I see that kmap->ref_reloc_sym is NULL here [1] when tracing
with anything else than the 'u' option.  I am currently investigating
the problem.

Igor, please see if you can reproduce on QEMU or an ARM64 based platform.

[1] https://elixir.bootlin.com/linux/v5.3-rc4/source/tools/perf/util/event.c#L945

>
> commit 3e70008a6021fffd2cd1614734603ea970773060
> Author: Leo Yan <leo.yan@linaro.org>
> Date:   Fri Aug 9 18:47:52 2019 +0800
>
>     perf trace: Fix segmentation fault when access syscall info on arm64
>
>     'perf trace' reports the segmentation fault as below on Arm64:
>
>       # perf trace -e string -e augmented_raw_syscalls.c
>       LLVM: dumping tools/perf/examples/bpf/augmented_raw_syscalls.o
>       perf: Segmentation fault
>       Obtained 12 stack frames.
>       perf(sighandler_dump_stack+0x47) [0xaaaaac96ac87]
>       linux-vdso.so.1(+0x5b7) [0xffffadbeb5b7]
>       /lib/aarch64-linux-gnu/libc.so.6(strlen+0x10) [0xfffface7d5d0]
>       /lib/aarch64-linux-gnu/libc.so.6(_IO_vfprintf+0x1ac7) [0xfffface49f97]
>       /lib/aarch64-linux-gnu/libc.so.6(__vsnprintf_chk+0xc7) [0xffffacedfbe7]
>       perf(scnprintf+0x97) [0xaaaaac9ca3ff]
>       perf(+0x997bb) [0xaaaaac8e37bb]
>       perf(cmd_trace+0x28e7) [0xaaaaac8ec09f]
>       perf(+0xd4a13) [0xaaaaac91ea13]
>       perf(main+0x62f) [0xaaaaac8a147f]
>       /lib/aarch64-linux-gnu/libc.so.6(__libc_start_main+0xe3) [0xfffface22d23]
>       perf(+0x57723) [0xaaaaac8a1723]
>       Segmentation fault
>
>     This issue is introduced by commit 30a910d7d3e0 ("perf trace:
>     Preallocate the syscall table"), it allocates trace->syscalls.table[]
>     array and the element count is 'trace->sctbl->syscalls.nr_entries'; but
>     on Arm64, the system call number is not continuously used; e.g. the
>     syscall maximum id is 436 but the real entries is only 281.
>
>
