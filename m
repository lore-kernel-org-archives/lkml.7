Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD8EC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 00:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6952171F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 00:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564447673;
	bh=AztOHi4Kp+HKxMoVaBKhtRLUlBqU/CllXSellCd7MoY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=R/fQA6p7Rx25BVpUpzFNaRYfErMTrewVxZ9HXvoW5vYycacwURmZGFZyTNG7u3cm5
	 O7CByrP886WJofLAifacp7v7/ca7HnupApMqeEL2wTBi8aNpTud+fi35ycbYforq7c
	 sME3zxri0R4xU/Pu9X9pnx3o4yv8C3cQ+zQaEg9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbfG3Arw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 20:47:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728845AbfG3Arv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 20:47:51 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97400216C8;
        Tue, 30 Jul 2019 00:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564447670;
        bh=AztOHi4Kp+HKxMoVaBKhtRLUlBqU/CllXSellCd7MoY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t8krZ5D50gtZUNJm0blX6uYgPRyMRX5pe0L+zQx3XSVkoQ4OFw6i9CwfgO1fmjUaE
         9It8DPSpJmO6Un568jGQKcRNfLMfef1UR7kC1ARLu5cFcjwMpRK5PH2qtN1xAkspE+
         dFB+GGxJ5b2YMKldheNW4k3xAQ5dut06GHbFnQpo=
Date:   Tue, 30 Jul 2019 09:47:45 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Numfor Mbiziwo-Tiapo <nums@google.com>, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, songliubraving@fb.com,
        mbd@fb.com, linux-kernel@vger.kernel.org, irogers@google.com,
        eranian@google.com
Subject: Re: [PATCH 3/3] Fix insn.c misaligned address error
Message-Id: <20190730094745.f5d6e7fa062e09d70b643801@kernel.org>
In-Reply-To: <2bc0fcc6-0477-ba1d-7418-5497efa7d571@intel.com>
References: <20190724184512.162887-1-nums@google.com>
        <20190724184512.162887-4-nums@google.com>
        <20190726193806.GB24867@kernel.org>
        <20190727184638.3263eb76c3cbde95f9896210@kernel.org>
        <2bc0fcc6-0477-ba1d-7418-5497efa7d571@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2019 11:22:34 +0300
Adrian Hunter <adrian.hunter@intel.com> wrote:

> On 27/07/19 12:46 PM, Masami Hiramatsu wrote:
> > On Fri, 26 Jul 2019 16:38:06 -0300
> > Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 
> >> Em Wed, Jul 24, 2019 at 11:45:12AM -0700, Numfor Mbiziwo-Tiapo escreveu:
> >>> The ubsan (undefined behavior sanitizer) version of perf throws an
> >>> error on the 'x86 instruction decoder - new instructions' function
> >>> of perf test.
> >>>
> >>> To reproduce this run:
> >>> make -C tools/perf USE_CLANG=1 EXTRA_CFLAGS="-fsanitize=undefined"
> >>>
> >>> then run: tools/perf/perf test 62 -v
> >>>
> >>> The error occurs in the __get_next macro (line 34) where an int is
> >>> read from a potentially unaligned address. Using memcpy instead of
> >>> assignment from an unaligned pointer.
> >>
> >> Since this came from the kernel, don't we have to fix it there as well?
> >> Masami, Adrian?
> > 
> > I guess we don't need it, since x86 can access "unaligned address" and
> > x86 insn decoder in kernel runs only on x86. I'm not sure about perf's
> > that part. Maybe if we run it on other arch as cross-arch application,
> > it may cause unaligned pointer issue.
> 
> Yes, theoretically Intel PT decoding can be done on any arch.
> 
> But the memcpy is probably sub-optimal for x86, so the patch as it stands
> does not seem suitable.  I notice the kernel has get_unaligned() and
> put_unaligned().
> 
> Obviously it would be better for a patch to be accepted to
> arch/x86/lib/insn.c also.

Hmm, then I rather like memcpy() for arch/x86/lib/insn.c, because it runs only
on x86.

Thank you,

> 
> > 
> > Thank you,
> > 
> >>
> >> [acme@quaco perf]$ find . -name insn.c
> >> ./arch/x86/lib/insn.c
> >> ./arch/arm/kernel/insn.c
> >> ./arch/arm64/kernel/insn.c
> >> ./tools/objtool/arch/x86/lib/insn.c
> >> ./tools/perf/util/intel-pt-decoder/insn.c
> >> [acme@quaco perf]$ diff -u ./tools/perf/util/intel-pt-decoder/insn.c ./arch/x86/lib/insn.c
> >> --- ./tools/perf/util/intel-pt-decoder/insn.c	2019-07-06 16:59:05.734265998 -0300
> >> +++ ./arch/x86/lib/insn.c	2019-07-06 16:59:01.369202998 -0300
> >> @@ -10,8 +10,8 @@
> >>  #else
> >>  #include <string.h>
> >>  #endif
> >> -#include "inat.h"
> >> -#include "insn.h"
> >> +#include <asm/inat.h>
> >> +#include <asm/insn.h>
> >>
> >>  /* Verify next sizeof(t) bytes can be on the same instruction */
> >>  #define validate_next(t, insn, n)	\
> >> [acme@quaco perf]$
> >>
> >>
> >> - Arnaldo
> >>  
> >>> Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
> >>> ---
> >>>  tools/perf/util/intel-pt-decoder/insn.c | 3 ++-
> >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/tools/perf/util/intel-pt-decoder/insn.c b/tools/perf/util/intel-pt-decoder/insn.c
> >>> index ca983e2bea8b..de1944c60aa9 100644
> >>> --- a/tools/perf/util/intel-pt-decoder/insn.c
> >>> +++ b/tools/perf/util/intel-pt-decoder/insn.c
> >>> @@ -31,7 +31,8 @@
> >>>  	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
> >>>  
> >>>  #define __get_next(t, insn)	\
> >>> -	({ t r = *(t*)insn->next_byte; insn->next_byte += sizeof(t); r; })
> >>> +	({ t r; memcpy(&r, insn->next_byte, sizeof(t)); \
> >>> +		insn->next_byte += sizeof(t); r; })
> >>>  
> >>>  #define __peek_nbyte_next(t, insn, n)	\
> >>>  	({ t r = *(t*)((insn)->next_byte + n); r; })
> >>> -- 
> >>> 2.22.0.657.g960e92d24f-goog
> >>
> >> -- 
> >>
> >> - Arnaldo
> > 
> > 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
