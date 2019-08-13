Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF641C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92EBD2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpPm6+RL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfHMNX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 09:23:57 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38387 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbfHMNXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 09:23:55 -0400
Received: by mail-qk1-f196.google.com with SMTP id u190so15938668qkh.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 06:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S1SWiFkQPLZW+Dt7K4dnQXpIbGcb4i0q4bJIJoaJpxY=;
        b=MpPm6+RLCJbFjmE10Am8jgCNaSnrscvhztQXXz5j+aZJC/COk8xq8W66HUdj2Qu8eW
         tDXRhKM7WQ0e99UHaMpesPZx6+DT9LxvdYqk7HlupxLke/tUEvPRhMkryg8pnMpebzp1
         hgr3TC/ysMbJUW4nnVLCI85VReRIiAQ/ifs62r39s/hq56/IshI+aqslEyjWEM5XSAmk
         WR6SWNII1S17hkQkbMVs5nv8rIwajNHtqIXvT+5Ce2mI7jW7PkgluLJ2KBSETuYUNBrl
         eTF5IHfZYgbFmK8oz8YECOJAJq0GGc4xZmehhN3/2Cwk1ULNUeOqHsToyccLfWlpd0mX
         z9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S1SWiFkQPLZW+Dt7K4dnQXpIbGcb4i0q4bJIJoaJpxY=;
        b=biY1VQkvqqr/asb2lwD9pXyufH1xryfcddIzc9q5N0YjRMb7JLXev2vzLcAbuunVrn
         2Aj3jQl9F1DoZmjW0h1gKGRoCy9ZnGakezTzQkjOZFT6oCgp/AGzaNAkGVZMAvMNbwT9
         4QoJY/XruMCQt+uNOr8cuoMJJ6ES22y0Gkje4PeqFdk+wMiP1sfNwo4mhN63ER0qXsFf
         WEFp0LS0qSLs+Rtine1Gu/gJduAyJNCmFAC1x1kuUOuJeQ3+0lDAPALLru8vb+Kwtlrz
         4kzp4SmHP4pWxV9+i8Im1cmcNPBlZXsJVSC/O9ruQZLkQiuHspqQ/U15fvJENMLVNhxu
         H33g==
X-Gm-Message-State: APjAAAXbMtD2fr9xz6GSb7vR39dgFfW6VDqIywmNqaBXVWfIxPGXIeKR
        DJjnzoyFz2SSWXJfp+TtdEc=
X-Google-Smtp-Source: APXvYqwG35C3QvYXq2qJU2jJDOJEsiUz+nGFkN5TVg7xQugeIkL/vSbXK1BSRcXeyjUFR0EzGgGU8w==
X-Received: by 2002:ae9:ef44:: with SMTP id d65mr16303044qkg.402.1565702634406;
        Tue, 13 Aug 2019 06:23:54 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id y25sm10275496qkj.35.2019.08.13.06.23.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 06:23:51 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7E2A340340; Tue, 13 Aug 2019 10:23:49 -0300 (-03)
Date:   Tue, 13 Aug 2019 10:23:49 -0300
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Igor Lubashev <ilubashe@akamai.com>,
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
Subject: Re: [PATCH v3 4/4] perf: Use CAP_SYS_ADMIN instead of euid==0 with
 ftrace
Message-ID: <20190813132349.GB12299@kernel.org>
References: <cover.1565188228.git.ilubashe@akamai.com>
 <bd8763b72ed4d58d0b42d44fbc7eb474d32e53a3.1565188228.git.ilubashe@akamai.com>
 <20190812202251.GG9280@kernel.org>
 <20190812202706.GH9280@kernel.org>
 <20190812202947.GI9280@kernel.org>
 <CANLsYkwjdhzVMwrWboTTOw+P3NajtoswxfxhodK0DdeexFCR3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkwjdhzVMwrWboTTOw+P3NajtoswxfxhodK0DdeexFCR3w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 12, 2019 at 03:42:17PM -0600, Mathieu Poirier escreveu:
> On Mon, 12 Aug 2019 at 14:29, Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Mon, Aug 12, 2019 at 05:27:06PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Mon, Aug 12, 2019 at 05:22:51PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > Em Wed, Aug 07, 2019 at 10:44:17AM -0400, Igor Lubashev escreveu:
> > > > > @@ -281,7 +283,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
> > > > >           .events = POLLIN,
> > > > >   };
> > > > >
> > > > > - if (geteuid() != 0) {
> > > > > + if (!perf_cap__capable(CAP_SYS_ADMIN)) {
> > > > >           pr_err("ftrace only works for root!\n");
> > > >
> > > > I guess we should update the error message too?
> > > >
> > >
> > > I.e. I applied this as a follow up patch:
> > >
> > > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > > index 01a5bb58eb04..ba8b65c2f9dc 100644
> > > --- a/tools/perf/builtin-ftrace.c
> > > +++ b/tools/perf/builtin-ftrace.c
> > > @@ -284,7 +284,12 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
> > >       };
> > >
> > >       if (!perf_cap__capable(CAP_SYS_ADMIN)) {
> > > -             pr_err("ftrace only works for root!\n");
> > > +             pr_err("ftrace only works for %s!\n",
> > > +#ifdef HAVE_LIBCAP_SUPPORT
> > > +             "users with the SYS_ADMIN capability"
> > > +#else
> > > +             "root"
> > > +#endif
> >
> >                 );
> >
> > :-)
> >
> > >               return -1;
> > >       }
> > >
> >
> > I've pushed the whole set to my tmp.perf/cap branch, please chec
> 
> Please hold on before moving further - I'm getting a segmentation
> fault on ARM64 that I'm still trying to figure out.

This is just sitting in my tmp branch, and in my local perf/core branch,
so that I can test it with the containers, etc.

Is this related to the following fix?

commit 3e70008a6021fffd2cd1614734603ea970773060
Author: Leo Yan <leo.yan@linaro.org>
Date:   Fri Aug 9 18:47:52 2019 +0800

    perf trace: Fix segmentation fault when access syscall info on arm64

    'perf trace' reports the segmentation fault as below on Arm64:

      # perf trace -e string -e augmented_raw_syscalls.c
      LLVM: dumping tools/perf/examples/bpf/augmented_raw_syscalls.o
      perf: Segmentation fault
      Obtained 12 stack frames.
      perf(sighandler_dump_stack+0x47) [0xaaaaac96ac87]
      linux-vdso.so.1(+0x5b7) [0xffffadbeb5b7]
      /lib/aarch64-linux-gnu/libc.so.6(strlen+0x10) [0xfffface7d5d0]
      /lib/aarch64-linux-gnu/libc.so.6(_IO_vfprintf+0x1ac7) [0xfffface49f97]
      /lib/aarch64-linux-gnu/libc.so.6(__vsnprintf_chk+0xc7) [0xffffacedfbe7]
      perf(scnprintf+0x97) [0xaaaaac9ca3ff]
      perf(+0x997bb) [0xaaaaac8e37bb]
      perf(cmd_trace+0x28e7) [0xaaaaac8ec09f]
      perf(+0xd4a13) [0xaaaaac91ea13]
      perf(main+0x62f) [0xaaaaac8a147f]
      /lib/aarch64-linux-gnu/libc.so.6(__libc_start_main+0xe3) [0xfffface22d23]
      perf(+0x57723) [0xaaaaac8a1723]
      Segmentation fault

    This issue is introduced by commit 30a910d7d3e0 ("perf trace:
    Preallocate the syscall table"), it allocates trace->syscalls.table[]
    array and the element count is 'trace->sctbl->syscalls.nr_entries'; but
    on Arm64, the system call number is not continuously used; e.g. the
    syscall maximum id is 436 but the real entries is only 281.


