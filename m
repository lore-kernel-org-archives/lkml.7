Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2744C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B43A20657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dp9heUFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbfG2UMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:12:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39673 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbfG2TcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:32:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id x4so9936463wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 12:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8upL6qrx/Dku4beiU/9+Km060tmr3ZR5MWxxCZyyP9I=;
        b=dp9heUFNPuLguWBoxY40ChTIuX06DyHskIzK1fea05PYc9rCdVlA7cXoQInGXSCuyY
         SQBajmQNbzz2Q3cus9Su4cRvYtNAtnmVMMC9JOUl881feAEly1c0h5F+KV/MiWuhgKiT
         iEGjpK9Wu18czQP2hOeridWPzsVal98/F5E/KrdbgQqOCIkpc/1KOSedYTtCLveJbonY
         feSXQDlkR4l7PqrA+6FP9f5T7mLxxVs5A1kS8g7cucINjC/qWVK1+VTZTeUv90fINtAD
         UrW60gMJQME+HFlbBSVBH3hV8R8/bbhe8sLcKvmWJuj0sly7KGJNWCF/lBp+7ffoHpj6
         3MnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8upL6qrx/Dku4beiU/9+Km060tmr3ZR5MWxxCZyyP9I=;
        b=Ad0byrwjNZOTOz3fj06gGx2w3CElMP2zbntnSW9H9n6fP4DGTnqYeUak9J6hNrcZzS
         gh7gO2zmaPpRUAHC9gNvItML3LhjkLiCJ+dknSPKEAVoc+eoT5lR7RlpUZNNWUTE+Rw1
         g4Pd7DyPYGgXy5BG+pDBm01g8hed8KMx9bYnQRLUWzhRJHJEwoIbd8MNmxeOhxRVvlFS
         Aei6CwL5r9TloMaufLBZRIs+4HNBc95MfIY6CSdDtQikJ7nN0mVpOILufEMns1sZ0v2i
         hjBzOqB3tEV6togNhpSGtt94p9iwIdvu1MApi7qsFOFuki0xYtzjGHhGid/Gn3CoGYvP
         ZCwQ==
X-Gm-Message-State: APjAAAV2aXFMBcdfSeXy9Z7OcLLFTW5uSbM61a2mdLplZOVOc+J573nk
        NLyviBfJpHO3hEL1AF/xfZ5ezRXnvJOyTMnuB9L11A==
X-Google-Smtp-Source: APXvYqzoKDoCDsPlUX4JnlYHES2KAh4hWjesv1N7r4wpe3qemewDk+Hr7mPpA/TjcA35PXCTpvganho7U9axtOaRrwU=
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr117650363wrr.252.1564428741297;
 Mon, 29 Jul 2019 12:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190724184512.162887-1-nums@google.com> <20190724184512.162887-4-nums@google.com>
 <20190726193806.GB24867@kernel.org> <20190727184638.3263eb76c3cbde95f9896210@kernel.org>
 <2bc0fcc6-0477-ba1d-7418-5497efa7d571@intel.com>
In-Reply-To: <2bc0fcc6-0477-ba1d-7418-5497efa7d571@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 29 Jul 2019 12:32:09 -0700
Message-ID: <CAP-5=fU2XBoOa2=00VCuWYqsLUzMSMzUXY63ZJt9rz-NJ+vYwA@mail.gmail.com>
Subject: Re: [PATCH 3/3] Fix insn.c misaligned address error
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Numfor Mbiziwo-Tiapo <nums@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>, mbd@fb.com,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 1:24 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
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

http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf
"A pointer to an object or incomplete type may be converted to a
pointer to a different object or incomplete type. If the resulting
pointer is not correctly aligned for the pointed-to type, the behavior
is undefined."
I agree the code will generally run on x86.

> Yes, theoretically Intel PT decoding can be done on any arch.
>
> But the memcpy is probably sub-optimal for x86, so the patch as it stands
> does not seem suitable.  I notice the kernel has get_unaligned() and
> put_unaligned().

Why is a fixed sized memcpy suboptimal? The compiler can should turn
into a load.

Thanks,
Ian

> Obviously it would be better for a patch to be accepted to
> arch/x86/lib/insn.c also.
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
> >> --- ./tools/perf/util/intel-pt-decoder/insn.c        2019-07-06 16:59:05.734265998 -0300
> >> +++ ./arch/x86/lib/insn.c    2019-07-06 16:59:01.369202998 -0300
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
> >>  #define validate_next(t, insn, n)   \
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
> >>>     ((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
> >>>
> >>>  #define __get_next(t, insn)        \
> >>> -   ({ t r = *(t*)insn->next_byte; insn->next_byte += sizeof(t); r; })
> >>> +   ({ t r; memcpy(&r, insn->next_byte, sizeof(t)); \
> >>> +           insn->next_byte += sizeof(t); r; })
> >>>
> >>>  #define __peek_nbyte_next(t, insn, n)      \
> >>>     ({ t r = *(t*)((insn)->next_byte + n); r; })
> >>> --
> >>> 2.22.0.657.g960e92d24f-goog
> >>
> >> --
> >>
> >> - Arnaldo
> >
> >
>
