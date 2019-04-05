Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AFCC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE91206C0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731457AbfDERGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:06:08 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:51929 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730492AbfDERGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:06:07 -0400
Received: by mail-it1-f193.google.com with SMTP id s3so10613267itk.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 10:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DwdiTOlzswrVZJohQK/ubxpquxDuyzS+tvd080uqhns=;
        b=SOzFJFJr7gvtUig8dd/3rfpK68DKnyekfztWcX47tDrXcLax7uUB39o/MSSPJmvnLm
         TOlKSRt7Tjy3RhNEVhiN313lQIc6wTntw0IO3JHKNqZwa4hCCGaA41pxl0skmIP2mZsV
         FQRY9vwzyF3v0T01V3p8tZqUgSGb5sKsYG8IG3GEWTmsVxyNtVHv4oU8xxeXos9s6E4z
         N9MqUL9187+2U76ENN8p/MtUpJCu9rSBN0c4WCvZUQDl6i24SV9vH+RM9Xy6/N5mVHhV
         tMsesHxblVCl+Nl3GNxhsbI9pubPmBOcLEVbVK8XUBh/nNNqA1dylwhsNCr1T3tfGUVl
         Cqzw==
X-Gm-Message-State: APjAAAUolI3Yep+B1FQoITMEuzElNBOBcKpL4Xx1BZtAuC1pb3K5vXcO
        mlLrR/i208gxLcRLmNKdmGuL/GsjRGVmdUXruFs2tA==
X-Google-Smtp-Source: APXvYqwR3zHPXzI9SsaYq6dMYAbJsfjU4G202/g7BTPLyTlyvXM6chuCuZBNbzDaREhj7oj1k90RAzBKXUuGgkynZeg=
X-Received: by 2002:a24:605:: with SMTP id 5mr10081339itv.144.1554483966904;
 Fri, 05 Apr 2019 10:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190404172545.20928-1-kasong@redhat.com> <20190405140929.pycfea7drnpb2sug@treble>
 <CACPcB9f7v4SU37YWKmUr=+iFWqL8hRapp1GPX+H8ixvGwzHsHA@mail.gmail.com> <20190405165715.fpgh4ggkmnqdtfwm@treble>
In-Reply-To: <20190405165715.fpgh4ggkmnqdtfwm@treble>
From:   Kairui Song <kasong@redhat.com>
Date:   Sat, 6 Apr 2019 01:05:55 +0800
Message-ID: <CACPcB9fPk2G=_k=K-1xOpPKU_R9F32LDo_bQ+vkLYJ8tajedMA@mail.gmail.com>
Subject: Re: [RFC PATCH] perf/x86: make perf callchain work without CONFIG_FRAME_POINTER
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 6, 2019 at 12:57 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Fri, Apr 05, 2019 at 11:13:02PM +0800, Kairui Song wrote:
> > Hi Josh, thanks for the review, I tried again, using latest upstream
> > kernel commit ea2cec24c8d429ee6f99040e4eb6c7ad627fe777:
> > # uname -a
> > Linux localhost.localdomain 5.1.0-rc3+ #29 SMP Fri Apr 5 22:53:05 CST
> > 2019 x86_64 x86_64 x86_64 GNU/Linux
> >
> > Having following config:
> > > CONFIG_UNWINDER_ORC=y
> > > # CONFIG_UNWINDER_FRAME_POINTER is not set
> > and CONFIG_FRAME_POINTER is off too.
> >
> > Then record something with perf (also latest upstream version):
> > ./perf record -g -e kmem:* -c 1
> >
> > Interrupt it, then view the output:
> > perf script | less
> >
> > Then I notice the stacktrace in kernle is incomplete like following.
> > Did I miss anything?
> > --------------
> > lvmetad   617 [000]    55.600786:                     kmem:kfree:
> > call_site=ffffffffb219e269 ptr=(nil)
> >         ffffffffb22b2d1c kfree+0x11c (/lib/modules/5.1.0-rc3+/build/vmlinux)
> >             7fba7e58fd0f __select+0x5f (/usr/lib64/libc-2.28.so)
> >
> > kworker/u2:5-rp   171 [000]    55.628529:
> > kmem:kmem_cache_alloc: call_site=ffffffffb20e963d
> > ptr=0xffffa07f39c581e0 bytes_req=80 bytes_alloc=80
> > gfp_flags=GFP_ATOMIC
> >         ffffffffb22b0dec kmem_cache_alloc+0x13c
> > (/lib/modules/5.1.0-rc3+/build/vmlinux)
> > -------------
> >
> > And for the patch, I debugged the problem, and found how it happend:
> > The reason is that we use following code for fetching the registers on
> > a trace point:
> > ...snip...
> > #define perf_arch_fetch_caller_regs(regs, __ip) { \
> > (regs)->ip = (__ip); \
> > (regs)->bp = caller_frame_pointer(); \
> > (regs)->cs = __KERNEL_CS;
> > ...snip...
>
> Thanks, I was able to recreate.  It only happens when unwinding from a
> tracepoint.  I haven't investigated yet, but
> perf_arch_fetch_caller_regs() looks highly suspect, since it's doing
> (regs)->bp = caller_frame_pointer(), even for ORC.
>
> My only explanation for how your patch works is that RBP just happens to
> point to somewhere higher on the stack, causing the unwinder to start at
> a semi-random location.  I suspect the real "fix" is that you're no
> longer passing the regs to unwind_start().
>

Yes that's right. Simply not passing regs to unwind_start will let the
unwind start from the perf sample handling functions, and introduce a
lot of "noise", so I let it skipped the frames until it reached the
frame of the trace point. The regs->bp should still points to the
stack base of the function which get called in the tracepoint that
trigger perf sample, so let unwinder skip all the frames above it made
it work.

-- 
Best Regards,
Kairui Song
