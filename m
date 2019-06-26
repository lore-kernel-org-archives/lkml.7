Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24269C48BD9
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 18:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF82216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 18:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qubuTSQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfFZSwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 14:52:06 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35836 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZSwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 14:52:06 -0400
Received: by mail-qk1-f196.google.com with SMTP id l128so2588619qke.2;
        Wed, 26 Jun 2019 11:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=p9K06d59FRaDpkkj9NANAS0nFJd5BrgX3LJ88SYT5To=;
        b=qubuTSQUj0H5UZbc8cam7i7K/f45lbPGfx1tw9/4adAvIVmqVLzweI+dvVDS4XqDee
         GUH2rCOug+WfvVi+E6brjQoJT6RIgkgsj96SCXn+VyHaequjpwn4768WyconR5o4T2dA
         +ufsM0EP8czWx74GWBUA1/b32vUHoYsnSnOW47tYqw7Hfr2hvwJhL6zJCXZQMS9FqN4X
         Taknn06tnGaDlaaqkE6vdy0pIRZjoyfZkCuZ37R3XPAXHNENfQqiaPzves9K7hDs+NaS
         F2l49fCm6zoHyrFpKopmEjCG6Em7uUc/km6rxcoq9Kl+To9Y/8dqQgAwY7IJzjyWOJHK
         pX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=p9K06d59FRaDpkkj9NANAS0nFJd5BrgX3LJ88SYT5To=;
        b=H0TY9sdlk6UxO/YNka/zmhW4CuWbWsWA+1DhNiDWDQUZUmzHfF/MFa14u86YUaFc+E
         WlgwryDiVbP0GO90RfZJhcyzyR15ot9A++mJ49/gmMisl/XhXY54jfwSQny+IhP4k+Dg
         mHDuYgm1XEMVxKgNqy/cVDw6goG1FiuIka+AdnputviYI7c7HIbBsszu8j+yajqlzlfQ
         tx0/6TQoF+VH62wtEb0CjfJ2ECi2GYa2k8qNET+N7qh7+ZIAA4mQgPGsVLpptnp8HRCw
         EAO3t9FJYyvyrIo87jLlv3R+cicUi+HfvYDKn4uX6VXTA1vqUaqKOYnamJRzOCpjqHka
         Hu2g==
X-Gm-Message-State: APjAAAXT3sj0WWCeJGVi0Qqc/49fr+iDgElv3VVTMQzRZdiq8JQ5Uibg
        HEQmgCy3BLGJPmY2m3NpGqBo8Ab1
X-Google-Smtp-Source: APXvYqwLZV2I2VF4ZEjpG8jQe0eFLXGegk6TX3SbYo+Q2+djeurKFQOvbk5ljXi80HCGCG1xosuAuw==
X-Received: by 2002:a37:a5cd:: with SMTP id o196mr5241469qke.442.1561575123549;
        Wed, 26 Jun 2019 11:52:03 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.215.254])
        by smtp.gmail.com with ESMTPSA id e125sm9775194qkd.120.2019.06.26.11.52.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 11:52:02 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6692E41153; Wed, 26 Jun 2019 15:51:56 -0300 (-03)
Date:   Wed, 26 Jun 2019 15:51:56 -0300
To:     Guo Ren <guoren@kernel.org>
Cc:     Mao Han <han_mao@c-sky.com>, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 1/1] perf annotate csky: Add perf annotate support
Message-ID: <20190626185156.GC3902@kernel.org>
References: <cover.1561531557.git.han_mao@c-sky.com>
 <d874d7782d9acdad5d98f2f5c4a6fb26fbe41c5d.1561531557.git.han_mao@c-sky.com>
 <CAJF2gTRyma8sDMJaWCde1eOe6KSwn4_e=tJOT4d3kgmvzOxz8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTRyma8sDMJaWCde1eOe6KSwn4_e=tJOT4d3kgmvzOxz8g@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 26, 2019 at 02:56:55PM +0800, Guo Ren escreveu:
> Thx Mao,
> 
> Approved!

I guess I can take this as a:

Acked-by: Guo Ren <guoren@kernel.org>

Or would this better be:

Reviewed-by: Guo Ren <guoren@kernel.org>

?

- Arnaldo
 
> Best Regards
>  Guo Ren
> 
> On Wed, Jun 26, 2019 at 2:53 PM Mao Han <han_mao@c-sky.com> wrote:
> >
> > This patch add basic arch initialization and instruction associate support
> > for csky.
> >
> > perf annotate --stdio2
> > Samples: 161  of event 'cpu-clock:pppH', 4000 Hz, Event count (approx.):
> > 40250000, [percent: local period]
> > test_4() /usr/lib/perf-test/callchain_test
> > Percent
> >
> >             Disassembly of section .text:
> >
> >             00008420 <test_4>:
> >             test_4():
> >               subi  sp, sp, 4
> >               st.w  r8, (sp, 0x0)
> >               mov   r8, sp
> >               subi  sp, sp, 8
> >               subi  r3, r8, 4
> >               movi  r2, 0
> >               st.w  r2, (r3, 0x0)
> >             ↓ br    2e
> > 100.00  14:   subi  r3, r8, 4
> >               ld.w  r2, (r3, 0x0)
> >               subi  r3, r8, 8
> >               st.w  r2, (r3, 0x0)
> >               subi  r3, r8, 4
> >               ld.w  r3, (r3, 0x0)
> >               addi  r2, r3, 1
> >               subi  r3, r8, 4
> >               st.w  r2, (r3, 0x0)
> >         2e:   subi  r3, r8, 4
> >               ld.w  r2, (r3, 0x0)
> >               lrw   r3, 0x98967f    // 8598 <main+0x28>
> >               cmplt r3, r2
> >             ↑ bf    14
> >               mov   r0, r0
> >               mov   r0, r0
> >               mov   sp, r8
> >               ld.w  r8, (sp, 0x0)
> >               addi  sp, sp, 4
> >             ← rts
> >
> > Signed-off-by: Mao Han <han_mao@c-sky.com>
> > Cc: Guo Ren <guoren@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/arch/csky/annotate/instructions.c | 48 ++++++++++++++++++++++++++++
> >  tools/perf/util/annotate.c                   |  5 +++
> >  2 files changed, 53 insertions(+)
> >  create mode 100644 tools/perf/arch/csky/annotate/instructions.c
> >
> > diff --git a/tools/perf/arch/csky/annotate/instructions.c b/tools/perf/arch/csky/annotate/instructions.c
> > new file mode 100644
> > index 0000000..5337bfb
> > --- /dev/null
> > +++ b/tools/perf/arch/csky/annotate/instructions.c
> > @@ -0,0 +1,48 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.
> > +
> > +#include <linux/compiler.h>
> > +
> > +static struct ins_ops *csky__associate_ins_ops(struct arch *arch,
> > +                                              const char *name)
> > +{
> > +       struct ins_ops *ops = NULL;
> > +
> > +       /* catch all kind of jumps */
> > +       if (!strcmp(name, "bt") ||
> > +           !strcmp(name, "bf") ||
> > +           !strcmp(name, "bez") ||
> > +           !strcmp(name, "bnez") ||
> > +           !strcmp(name, "bnezad") ||
> > +           !strcmp(name, "bhsz") ||
> > +           !strcmp(name, "bhz") ||
> > +           !strcmp(name, "blsz") ||
> > +           !strcmp(name, "blz") ||
> > +           !strcmp(name, "br") ||
> > +           !strcmp(name, "jmpi") ||
> > +           !strcmp(name, "jmp"))
> > +               ops = &jump_ops;
> > +
> > +       /* catch function call */
> > +       if (!strcmp(name, "bsr") ||
> > +           !strcmp(name, "jsri") ||
> > +           !strcmp(name, "jsr"))
> > +               ops = &call_ops;
> > +
> > +       /* catch function return */
> > +       if (!strcmp(name, "rts"))
> > +               ops = &ret_ops;
> > +
> > +       if (ops)
> > +               arch__associate_ins_ops(arch, name, ops);
> > +       return ops;
> > +}
> > +
> > +static int csky__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
> > +{
> > +       arch->initialized = true;
> > +       arch->objdump.comment_char = '/';
> > +       arch->associate_instruction_ops = csky__associate_ins_ops;
> > +
> > +       return 0;
> > +}
> > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > index 79db038..eb2456e 100644
> > --- a/tools/perf/util/annotate.c
> > +++ b/tools/perf/util/annotate.c
> > @@ -144,6 +144,7 @@ static int arch__associate_ins_ops(struct arch* arch, const char *name, struct i
> >  #include "arch/arc/annotate/instructions.c"
> >  #include "arch/arm/annotate/instructions.c"
> >  #include "arch/arm64/annotate/instructions.c"
> > +#include "arch/csky/annotate/instructions.c"
> >  #include "arch/x86/annotate/instructions.c"
> >  #include "arch/powerpc/annotate/instructions.c"
> >  #include "arch/s390/annotate/instructions.c"
> > @@ -163,6 +164,10 @@ static struct arch architectures[] = {
> >                 .init = arm64__annotate_init,
> >         },
> >         {
> > +               .name = "csky",
> > +               .init = csky__annotate_init,
> > +       },
> > +       {
> >                 .name = "x86",
> >                 .init = x86__annotate_init,
> >                 .instructions = x86__instructions,
> > --
> > 2.7.4
> >
> 
> 
> -- 
> Best Regards
>  Guo Ren
> 
> ML: https://lore.kernel.org/linux-csky/

-- 

- Arnaldo
