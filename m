Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B98C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 23:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9BE206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 23:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KiP2nj3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732329AbfJIXHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 19:07:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46077 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731763AbfJIXHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 19:07:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id r5so5209038wrm.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 16:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7cg9A8ssoGgVdg1c9PU73u6OSiYvfVubeuTNtfdhXWo=;
        b=KiP2nj3mgy6HfdCboBplmPorRXdDeBQ4symQnSCd7IPRRjLsELAFAzQfFOrXHK+ve2
         RDx3xNqg4MqBl6AaEkpi9z6sNNQhuuk2NVsUnALxhLlJSQkFt/OuDDRTiSVeNHF24hzZ
         hpK/qH05Hsk75lMz+fmz3LnHsBhxu7xb47O6pTM1QyMmr2YAltOR393PgyuE101kxukm
         SfwgoW1FSjs/Jsa/7JEB89MsVh97nfr1apaYlSofEe85mNBaNSnOgoQaBEnz3F5+R9qf
         091x1WvpzZGuHCzopGFMz6+oq7GwhsHRPQmDAt6Rlu1kiZZda0MhNvCDTJcdd6ndQbrv
         IW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7cg9A8ssoGgVdg1c9PU73u6OSiYvfVubeuTNtfdhXWo=;
        b=OMTyBdzPLRWo1+eMj1jmi6+t1C5rzRs0fRNMqbD+yGt6gLeGJ5slkl5H+CiLB9V3y9
         5sPptMRfB6YmlxvXNAS4sJMYqqEtfbW81aNTPCvepP1zW7F6+a3l0lS0N/KcL1h1TsHW
         wLGChCi8FqlowoBmO8L7qluYD30MRIft0Vt+//8E4WIQpTLzHv6NUzUxTMkOewupOYO4
         CHW7/YC0W0tCbICAb61U1YTq/vZ3d5qLjaP1xJXfqM5E40TM7DAKFF6hirsxKg/xKGgN
         I9gRwuua5bgmGool+iLeOaVk2fZhb5IR0rEN5GzREvHW14JkPvhjZQ8DBlPFIYZt2lC4
         Wf+A==
X-Gm-Message-State: APjAAAWGl1Z2H1cWq2Y4eMdSCPDjhRm5lQ6GzqLHEpYhQ0NW7jeZO5DH
        vdnJo1np/WvghY0Wh1NxwVGOaxsp6RYSbUdV6ejPcA==
X-Google-Smtp-Source: APXvYqznH1kfiAoPAvGfS8DYqSUIbLNo2k9YMrThJTuuJfG/Ju0ql0MBdsImu3ad5iGLcB8PpGXHlWPiTpAt2/apJnQ=
X-Received: by 2002:a5d:5228:: with SMTP id i8mr4788125wra.191.1570662469675;
 Wed, 09 Oct 2019 16:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190927214341.170683-1-irogers@google.com> <20191001003623.255186-1-irogers@google.com>
 <20191008123104.GA16241@krava>
In-Reply-To: <20191008123104.GA16241@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 9 Oct 2019 16:07:37 -0700
Message-ID: <CAP-5=fUSgjyLkZJaHTvdFbzZijy6Gzmx5UZHK_brxVEhFpMG8g@mail.gmail.com>
Subject: Re: [PATCH v3] perf tools: avoid sample_reg_masks being const + weak
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Mao Han <han_mao@c-sky.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 8, 2019 at 5:31 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Sep 30, 2019 at 05:36:23PM -0700, Ian Rogers wrote:
> > Being const + weak breaks with some compilers that constant-propagate
> > from the weak symbol. This behavior is outside of the specification, but
> > in LLVM is chosen to match GCC's behavior.
> >
> > LLVM's implementation was set in this patch:
> > https://github.com/llvm/llvm-project/commit/f49573d1eedcf1e44893d5a062ac1b72c8419646
> > A const + weak symbol is set to be weak_odr:
> > https://llvm.org/docs/LangRef.html
> > ODR is one definition rule, and given there is one constant definition
> > constant-propagation is possible. It is possible to get this code to
> > miscompile with LLVM when applying link time optimization. As compilers
> > become more aggressive, this is likely to break in more instances.
>
> is this just aprecaution or you actualy saw some breakage?

We saw a breakage with clang with thinlto enabled for linking. Our
compiler team had recently seen, and were surprised by, a similar
issue and were able to dig out the weak ODR issue.

Thanks,
Ian

> > Move the definition of sample_reg_masks to the conditional part of
> > perf_regs.h and guard usage with HAVE_PERF_REGS_SUPPORT. This avoids the
> > weak symbol.
> >
> > Fix an issue when HAVE_PERF_REGS_SUPPORT isn't defined from patch v1.
> > In v3, add perf_regs.c for architectures that HAVE_PERF_REGS_SUPPORT but
> > don't declare sample_regs_masks.
>
> looks good to me (again ;-)), let's see if it passes Arnaldo's farm
>
> thanks,
> jirka
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/arch/arm/util/Build         | 2 ++
> >  tools/perf/arch/arm/util/perf_regs.c   | 6 ++++++
> >  tools/perf/arch/arm64/util/Build       | 1 +
> >  tools/perf/arch/arm64/util/perf_regs.c | 6 ++++++
> >  tools/perf/arch/csky/util/Build        | 2 ++
> >  tools/perf/arch/csky/util/perf_regs.c  | 6 ++++++
> >  tools/perf/arch/riscv/util/Build       | 2 ++
> >  tools/perf/arch/riscv/util/perf_regs.c | 6 ++++++
> >  tools/perf/arch/s390/util/Build        | 1 +
> >  tools/perf/arch/s390/util/perf_regs.c  | 6 ++++++
> >  tools/perf/util/parse-regs-options.c   | 8 ++++++--
> >  tools/perf/util/perf_regs.c            | 4 ----
> >  tools/perf/util/perf_regs.h            | 4 ++--
> >  13 files changed, 46 insertions(+), 8 deletions(-)
> >  create mode 100644 tools/perf/arch/arm/util/perf_regs.c
> >  create mode 100644 tools/perf/arch/arm64/util/perf_regs.c
> >  create mode 100644 tools/perf/arch/csky/util/perf_regs.c
> >  create mode 100644 tools/perf/arch/riscv/util/perf_regs.c
> >  create mode 100644 tools/perf/arch/s390/util/perf_regs.c
> >
> > diff --git a/tools/perf/arch/arm/util/Build b/tools/perf/arch/arm/util/Build
> > index 296f0eac5e18..37fc63708966 100644
> > --- a/tools/perf/arch/arm/util/Build
> > +++ b/tools/perf/arch/arm/util/Build
> > @@ -1,3 +1,5 @@
> > +perf-y += perf_regs.o
> > +
> >  perf-$(CONFIG_DWARF) += dwarf-regs.o
> >
> >  perf-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind.o
> > diff --git a/tools/perf/arch/arm/util/perf_regs.c b/tools/perf/arch/arm/util/perf_regs.c
> > new file mode 100644
> > index 000000000000..2864e2e3776d
> > --- /dev/null
> > +++ b/tools/perf/arch/arm/util/perf_regs.c
> > @@ -0,0 +1,6 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include "../../util/perf_regs.h"
> > +
> > +const struct sample_reg sample_reg_masks[] = {
> > +     SMPL_REG_END
> > +};
> > diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
> > index 3cde540d2fcf..0a7782c61209 100644
> > --- a/tools/perf/arch/arm64/util/Build
> > +++ b/tools/perf/arch/arm64/util/Build
> > @@ -1,4 +1,5 @@
> >  perf-y += header.o
> > +perf-y += perf_regs.o
> >  perf-y += sym-handling.o
> >  perf-$(CONFIG_DWARF)     += dwarf-regs.o
> >  perf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
> > diff --git a/tools/perf/arch/arm64/util/perf_regs.c b/tools/perf/arch/arm64/util/perf_regs.c
> > new file mode 100644
> > index 000000000000..2864e2e3776d
> > --- /dev/null
> > +++ b/tools/perf/arch/arm64/util/perf_regs.c
> > @@ -0,0 +1,6 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include "../../util/perf_regs.h"
> > +
> > +const struct sample_reg sample_reg_masks[] = {
> > +     SMPL_REG_END
> > +};
> > diff --git a/tools/perf/arch/csky/util/Build b/tools/perf/arch/csky/util/Build
> > index 1160bb2332ba..7d3050134ae0 100644
> > --- a/tools/perf/arch/csky/util/Build
> > +++ b/tools/perf/arch/csky/util/Build
> > @@ -1,2 +1,4 @@
> > +perf-y += perf_regs.o
> > +
> >  perf-$(CONFIG_DWARF) += dwarf-regs.o
> >  perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
> > diff --git a/tools/perf/arch/csky/util/perf_regs.c b/tools/perf/arch/csky/util/perf_regs.c
> > new file mode 100644
> > index 000000000000..2864e2e3776d
> > --- /dev/null
> > +++ b/tools/perf/arch/csky/util/perf_regs.c
> > @@ -0,0 +1,6 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include "../../util/perf_regs.h"
> > +
> > +const struct sample_reg sample_reg_masks[] = {
> > +     SMPL_REG_END
> > +};
> > diff --git a/tools/perf/arch/riscv/util/Build b/tools/perf/arch/riscv/util/Build
> > index 1160bb2332ba..7d3050134ae0 100644
> > --- a/tools/perf/arch/riscv/util/Build
> > +++ b/tools/perf/arch/riscv/util/Build
> > @@ -1,2 +1,4 @@
> > +perf-y += perf_regs.o
> > +
> >  perf-$(CONFIG_DWARF) += dwarf-regs.o
> >  perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
> > diff --git a/tools/perf/arch/riscv/util/perf_regs.c b/tools/perf/arch/riscv/util/perf_regs.c
> > new file mode 100644
> > index 000000000000..2864e2e3776d
> > --- /dev/null
> > +++ b/tools/perf/arch/riscv/util/perf_regs.c
> > @@ -0,0 +1,6 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include "../../util/perf_regs.h"
> > +
> > +const struct sample_reg sample_reg_masks[] = {
> > +     SMPL_REG_END
> > +};
> > diff --git a/tools/perf/arch/s390/util/Build b/tools/perf/arch/s390/util/Build
> > index 22797f043b84..3d9d0f4f72ca 100644
> > --- a/tools/perf/arch/s390/util/Build
> > +++ b/tools/perf/arch/s390/util/Build
> > @@ -1,5 +1,6 @@
> >  perf-y += header.o
> >  perf-y += kvm-stat.o
> > +perf-y += perf_regs.o
> >
> >  perf-$(CONFIG_DWARF) += dwarf-regs.o
> >  perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
> > diff --git a/tools/perf/arch/s390/util/perf_regs.c b/tools/perf/arch/s390/util/perf_regs.c
> > new file mode 100644
> > index 000000000000..2864e2e3776d
> > --- /dev/null
> > +++ b/tools/perf/arch/s390/util/perf_regs.c
> > @@ -0,0 +1,6 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include "../../util/perf_regs.h"
> > +
> > +const struct sample_reg sample_reg_masks[] = {
> > +     SMPL_REG_END
> > +};
> > diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
> > index ef46c2848808..e687497b3aac 100644
> > --- a/tools/perf/util/parse-regs-options.c
> > +++ b/tools/perf/util/parse-regs-options.c
> > @@ -13,7 +13,7 @@ static int
> >  __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
> >  {
> >       uint64_t *mode = (uint64_t *)opt->value;
> > -     const struct sample_reg *r;
> > +     const struct sample_reg *r = NULL;
> >       char *s, *os = NULL, *p;
> >       int ret = -1;
> >       uint64_t mask;
> > @@ -46,19 +46,23 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
> >
> >                       if (!strcmp(s, "?")) {
> >                               fprintf(stderr, "available registers: ");
> > +#ifdef HAVE_PERF_REGS_SUPPORT
> >                               for (r = sample_reg_masks; r->name; r++) {
> >                                       if (r->mask & mask)
> >                                               fprintf(stderr, "%s ", r->name);
> >                               }
> > +#endif
> >                               fputc('\n', stderr);
> >                               /* just printing available regs */
> >                               return -1;
> >                       }
> > +#ifdef HAVE_PERF_REGS_SUPPORT
> >                       for (r = sample_reg_masks; r->name; r++) {
> >                               if ((r->mask & mask) && !strcasecmp(s, r->name))
> >                                       break;
> >                       }
> > -                     if (!r->name) {
> > +#endif
> > +                     if (!r || !r->name) {
> >                               ui__warning("Unknown register \"%s\", check man page or run \"perf record %s?\"\n",
> >                                           s, intr ? "-I" : "--user-regs=");
> >                               goto error;
> > diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
> > index 2774cec1f15f..5ee47ae1509c 100644
> > --- a/tools/perf/util/perf_regs.c
> > +++ b/tools/perf/util/perf_regs.c
> > @@ -3,10 +3,6 @@
> >  #include "perf_regs.h"
> >  #include "event.h"
> >
> > -const struct sample_reg __weak sample_reg_masks[] = {
> > -     SMPL_REG_END
> > -};
> > -
> >  int __weak arch_sdt_arg_parse_op(char *old_op __maybe_unused,
> >                                char **new_op __maybe_unused)
> >  {
> > diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
> > index 47fe34e5f7d5..e014c2c038f4 100644
> > --- a/tools/perf/util/perf_regs.h
> > +++ b/tools/perf/util/perf_regs.h
> > @@ -15,8 +15,6 @@ struct sample_reg {
> >  #define SMPL_REG2(n, b) { .name = #n, .mask = 3ULL << (b) }
> >  #define SMPL_REG_END { .name = NULL }
> >
> > -extern const struct sample_reg sample_reg_masks[];
> > -
> >  enum {
> >       SDT_ARG_VALID = 0,
> >       SDT_ARG_SKIP,
> > @@ -27,6 +25,8 @@ uint64_t arch__intr_reg_mask(void);
> >  uint64_t arch__user_reg_mask(void);
> >
> >  #ifdef HAVE_PERF_REGS_SUPPORT
> > +extern const struct sample_reg sample_reg_masks[];
> > +
> >  #include <perf_regs.h>
> >
> >  #define DWARF_MINIMAL_REGS ((1ULL << PERF_REG_IP) | (1ULL << PERF_REG_SP))
> > --
> > 2.23.0.444.g18eeb5a265-goog
> >
