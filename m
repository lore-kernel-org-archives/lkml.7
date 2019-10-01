Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB93C388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 00:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E842E20842
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 00:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ul6xbIN3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732609AbfJAAgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 20:36:31 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33605 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732303AbfJAAga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 20:36:30 -0400
Received: by mail-wm1-f66.google.com with SMTP id r17so1220278wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 17:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mOeRdJMXm8eeaJf+3lO1hp40vfxqYjaWky+3mVw3yAs=;
        b=ul6xbIN3Mkx8LqRAhOnil0zuqWak21eKWoYRmpqGrBkfprGvpqLuUTZemRS2aHPWAU
         kSPN76YW5yGg7cTECKSc+puLXCGLMnm/5kb2+1o1DQA13Sd3X4FvQRst2ZLUr4jQkmux
         HyMsSU2XoEg1XgoOZebXT+Q0E0NAe1C44WSH8wG4aDn+rwFtTKdQlkm143eJw6XzI+Yy
         54LtQlvBiUcGjZqodgSBbtAFy1AeFlZRu65ObtbjEAC+eiDpJqBRubpyCbkByKEFSLMl
         DOgZK4ZqycArIxWyE/9zUz0GQxcgMryMCRJTTiVRSENKBc1Ra92IWMEHbZsoQEPBD+gq
         7Epw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mOeRdJMXm8eeaJf+3lO1hp40vfxqYjaWky+3mVw3yAs=;
        b=Aec50qdCaImIJlgTzegLHVzKyqZJIYi399LIIx9Mp4ZzgsNsbrdeU+p3ezJc0XnNF5
         UlVEtNgSslU45kg6flqduOUoVhrGStkT08SmSdRxUeS2SFLHv1V6gar90JCET9g9wj0D
         tGMfcYkUXW9HS91ujkEXHQ9XLLOYg+ZFt3PyWo4Ut/Q71KGaoa7zq8Fb3RVrFjMTpytx
         3pJYVvchVwNF3Cm6URgbyIsDGSLa5/QJvPp6HMgckn59s6PakNFd1U4y8EaoPd2m7chY
         0wf71Hgvyy6nGx5gDOFaqX40sdpdUEcHl3+Ef8Nr5aIBdRGaiJgxY7e1/Yjr4w76F9KY
         W9rw==
X-Gm-Message-State: APjAAAWPHHZHgNTF1CxDkrx+0CzPOgOoUh5BkD8DvXt3tJwOcKwbrjRY
        sqBQGg2K8Jdj0r5BmSxpYwzlxzw9Lre4VwAEB7663Q==
X-Google-Smtp-Source: APXvYqzK6VvUPeQaaEECJ2WcGoC4RlwQG4WX9wcX1gD7g6YMiIpksh7mDSx5C69H4oc4fP605Osd4MXLZRoxHdtzxeE=
X-Received: by 2002:a1c:4b10:: with SMTP id y16mr1271997wma.54.1569890188494;
 Mon, 30 Sep 2019 17:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190927211005.147176-1-irogers@google.com> <20190927214341.170683-1-irogers@google.com>
 <20190929210514.GC602@krava> <20190930122335.GF9622@kernel.org> <20190930124209.GF602@krava>
In-Reply-To: <20190930124209.GF602@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 30 Sep 2019 17:36:16 -0700
Message-ID: <CAP-5=fUDUBQRqhMij6DwETF3vLWCkhpeoG82aLOWqwHftYtQ6Q@mail.gmail.com>
Subject: Re: [PATCH v2] perf tools: avoid sample_reg_masks being const + weak
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for that. I've addressed in v3 but only tested for riscv.
There is potential for additional tidy up related to this change, let
me know what would be appropriate.

Thanks,
Ian

On Mon, Sep 30, 2019 at 5:42 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Sep 30, 2019 at 09:23:35AM -0300, Arnaldo Carvalho de Melo wrote:
>
> SNIP
>
> >   CC       /tmp/build/perf/util/lzma.o
> >   CC       /tmp/build/perf/util/demangle-java.o
> >   CC       /tmp/build/perf/util/demangle-rust.o
> >   CC       /tmp/build/perf/util/jitdump.o
> >   CC       /tmp/build/perf/util/genelf.o
> >   CC       /tmp/build/perf/util/genelf_debug.o
> >   CC       /tmp/build/perf/util/perf-hooks.o
> >   CC       /tmp/build/perf/util/bpf-event.o
> >   FLEX     /tmp/build/perf/util/parse-events-flex.c
> >   LD       /tmp/build/perf/util/intel-pt-decoder/perf-in.o
> >   FLEX     /tmp/build/perf/util/pmu-flex.c
> >   CC       /tmp/build/perf/util/pmu-bison.o
> >   CC       /tmp/build/perf/util/expr-bison.o
> >   CC       /tmp/build/perf/util/parse-events.o
> >   CC       /tmp/build/perf/util/parse-events-flex.o
> >   CC       /tmp/build/perf/util/pmu.o
> >   CC       /tmp/build/perf/util/pmu-flex.o
> >   LD       /tmp/build/perf/util/perf-in.o
> >   LD       /tmp/build/perf/perf-in.o
> >   LINK     /tmp/build/perf/perf
> > /usr/lib/gcc-cross/aarch64-linux-gnu/8/../../../../aarch64-linux-gnu/bin/ld: /tmp/build/perf/perf-in.o: in function `__parse_regs':
> > /git/linux/tools/perf/util/parse-regs-options.c:39: undefined reference to `sample_reg_masks'
> > /usr/lib/gcc-cross/aarch64-linux-gnu/8/../../../../aarch64-linux-gnu/bin/ld: /git/linux/tools/perf/util/parse-regs-options.c:47: undefined reference to `sample_reg_masks'
> > /usr/lib/gcc-cross/aarch64-linux-gnu/8/../../../../aarch64-linux-gnu/bin/ld: /git/linux/tools/perf/util/parse-regs-options.c:60: undefined reference to `sample_reg_masks'
> > /usr/lib/gcc-cross/aarch64-linux-gnu/8/../../../../aarch64-linux-gnu/bin/ld: /git/linux/tools/perf/util/parse-regs-options.c:50: undefined reference to `sample_reg_masks'
>
> argh.. I tried on power.. should have tried on arm ;-)
>
> I expected that all the archs that set NO_PERF_REGS := 0 would have
> sample_reg_masks defined..  all those archs did fallback to the:
>
>   const struct sample_reg __weak sample_reg_masks[] = {
>        SMPL_REG_END
>   };
>
> those archs are not able to use --user-regs/--intr-regs options,
> but for dwarf unwind we set those registers manualy, so that works
>
> so I guess we need to define empty sample_reg_masks for those archs
>
> jirka
