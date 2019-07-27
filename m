Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52209C7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 09:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494522085A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 09:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564220806;
	bh=BGA5k1Ua4iwHHhg8twY7qUz0ZWvcvVd41aByooCam/0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Ij3FMZygGXSwX67K7TbZ+uI62kbJ7CDPVVwCSUccKm9+3S+qyBUXlBuOXq5delDVW
	 bv34OKenGyo7Zmc/Yx7aZ/scZNrJ32w9OFaI/XDyHIX7xnWa08JLImYlXW1+dv7RKO
	 CZJty8+QxE5crEgmQpG3FWA/SZspZBBQ0Uf6rJJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387585AbfG0Jqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 05:46:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727885AbfG0Jqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 05:46:44 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEFA920651;
        Sat, 27 Jul 2019 09:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564220803;
        bh=BGA5k1Ua4iwHHhg8twY7qUz0ZWvcvVd41aByooCam/0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uH9AV7Df2pI/ygeVXHowKTMVg2DpJEMnlWIEUEfGs+21KOYNM66akXmo5GMb8iXND
         yq1UOTs+aKBGP44cHeayzCHHeYmOCcSRuGkXi9/VlpTVvVFTC/UgQxbz78ynXDU3Mx
         Sp4q6jngGNUyHg3/sKc3btiQjZLgTRK+uWWv/HV8=
Date:   Sat, 27 Jul 2019 18:46:38 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Numfor Mbiziwo-Tiapo <nums@google.com>, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, songliubraving@fb.com,
        mbd@fb.com, linux-kernel@vger.kernel.org, irogers@google.com,
        eranian@google.com
Subject: Re: [PATCH 3/3] Fix insn.c misaligned address error
Message-Id: <20190727184638.3263eb76c3cbde95f9896210@kernel.org>
In-Reply-To: <20190726193806.GB24867@kernel.org>
References: <20190724184512.162887-1-nums@google.com>
        <20190724184512.162887-4-nums@google.com>
        <20190726193806.GB24867@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2019 16:38:06 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Wed, Jul 24, 2019 at 11:45:12AM -0700, Numfor Mbiziwo-Tiapo escreveu:
> > The ubsan (undefined behavior sanitizer) version of perf throws an
> > error on the 'x86 instruction decoder - new instructions' function
> > of perf test.
> > 
> > To reproduce this run:
> > make -C tools/perf USE_CLANG=1 EXTRA_CFLAGS="-fsanitize=undefined"
> > 
> > then run: tools/perf/perf test 62 -v
> > 
> > The error occurs in the __get_next macro (line 34) where an int is
> > read from a potentially unaligned address. Using memcpy instead of
> > assignment from an unaligned pointer.
> 
> Since this came from the kernel, don't we have to fix it there as well?
> Masami, Adrian?

I guess we don't need it, since x86 can access "unaligned address" and
x86 insn decoder in kernel runs only on x86. I'm not sure about perf's
that part. Maybe if we run it on other arch as cross-arch application,
it may cause unaligned pointer issue.

Thank you,

> 
> [acme@quaco perf]$ find . -name insn.c
> ./arch/x86/lib/insn.c
> ./arch/arm/kernel/insn.c
> ./arch/arm64/kernel/insn.c
> ./tools/objtool/arch/x86/lib/insn.c
> ./tools/perf/util/intel-pt-decoder/insn.c
> [acme@quaco perf]$ diff -u ./tools/perf/util/intel-pt-decoder/insn.c ./arch/x86/lib/insn.c
> --- ./tools/perf/util/intel-pt-decoder/insn.c	2019-07-06 16:59:05.734265998 -0300
> +++ ./arch/x86/lib/insn.c	2019-07-06 16:59:01.369202998 -0300
> @@ -10,8 +10,8 @@
>  #else
>  #include <string.h>
>  #endif
> -#include "inat.h"
> -#include "insn.h"
> +#include <asm/inat.h>
> +#include <asm/insn.h>
> 
>  /* Verify next sizeof(t) bytes can be on the same instruction */
>  #define validate_next(t, insn, n)	\
> [acme@quaco perf]$
> 
> 
> - Arnaldo
>  
> > Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
> > ---
> >  tools/perf/util/intel-pt-decoder/insn.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/intel-pt-decoder/insn.c b/tools/perf/util/intel-pt-decoder/insn.c
> > index ca983e2bea8b..de1944c60aa9 100644
> > --- a/tools/perf/util/intel-pt-decoder/insn.c
> > +++ b/tools/perf/util/intel-pt-decoder/insn.c
> > @@ -31,7 +31,8 @@
> >  	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
> >  
> >  #define __get_next(t, insn)	\
> > -	({ t r = *(t*)insn->next_byte; insn->next_byte += sizeof(t); r; })
> > +	({ t r; memcpy(&r, insn->next_byte, sizeof(t)); \
> > +		insn->next_byte += sizeof(t); r; })
> >  
> >  #define __peek_nbyte_next(t, insn, n)	\
> >  	({ t r = *(t*)((insn)->next_byte + n); r; })
> > -- 
> > 2.22.0.657.g960e92d24f-goog
> 
> -- 
> 
> - Arnaldo


-- 
Masami Hiramatsu <mhiramat@kernel.org>
