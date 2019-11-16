Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5153C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 01:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D0920733
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 01:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SLjyuWZn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfKPBUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 20:20:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45456 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfKPBUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 20:20:46 -0500
Received: by mail-wr1-f65.google.com with SMTP id z10so12835692wrs.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 17:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eH3rV54eSSKEAob9LDRsJb0Vwhybzb7lax4DLdENnBM=;
        b=SLjyuWZnZj2O+hY/SATkN32JsmzFet1TbGYjq7YUjI66FdCELUcO+dJqSFKE7R5/pF
         KFmDZLM5WcaE7BGyv47S8PjOHvXyYr73ZinKwooarmpowwaPuQq3yREegkUOyFM2MdSS
         doSGkZe7X78P8v1cuFhInrdjLDFir4XHBbBOtdu+GDY/NnY9Fqcb/MJoJRicx43sutvX
         IjPP7fabGYIiA26B6FnWbtdPt2W8B6a5APtOxw1l3gL2VAp9sOzwK735cDt1vwPdsuGm
         TnQmV/BGAmXOha4/C/+oFjFAOyMfGWd116rjxW1/ivIxB16i2kbaM0QZXN7k+7BUYP2P
         1yzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eH3rV54eSSKEAob9LDRsJb0Vwhybzb7lax4DLdENnBM=;
        b=lPf635naBqBbFN9Cn3kXtwkheUgn2PJTNH2ek4hZlQAsltkNSvi0Pl4OQXGFinCEgU
         7wVHyvBA5SS3oUczqZdEWCRWSWRUU5jD0Xb8C6uySa7IZVvTertW4X2LFoE/RpKE2ZNx
         Sacu+Pmxr4PtPM20Ovp+2EqrBuGTrjB0IguI7gXtReu4D353I++H9A2yPRxBtGyBCkU+
         Om/HBgUHsIzeaPL9H0DusapJ61PyujOGT6dWrMNTATdsxEKbT5FzNMPjTV8qIwwBLpcn
         Iznv5rRAYbSv2pDTcx7ih9Kot7CLEbMQmvolkBq1CcEXC0S0hXAvSy2cFNZM9ItLFxfk
         j0Tw==
X-Gm-Message-State: APjAAAWGDQ6cZGCGHmhd3mR9dUJ3oUSekQ+M8bmDfaTlyqRQzBR13l++
        vUFg5nBKUjHB59kLPpX+pU+z3dKaMIFXc730RPgyTg==
X-Google-Smtp-Source: APXvYqz1+QEDZY3LSTxdZr+kAmqJNtyoSXLxv0EUjt6FH6mAgIyuj/Dnt6NO3zBE6UW68rhg0ZRF/A65RS6uPimAJS0=
X-Received: by 2002:adf:f1c7:: with SMTP id z7mr19994449wro.355.1573867243556;
 Fri, 15 Nov 2019 17:20:43 -0800 (PST)
MIME-Version: 1.0
References: <20191114003042.85252-1-irogers@google.com> <20191114003042.85252-8-irogers@google.com>
 <20191114100312.GR4131@hirez.programming.kicks-ass.net>
In-Reply-To: <20191114100312.GR4131@hirez.programming.kicks-ass.net>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 15 Nov 2019 17:20:32 -0800
Message-ID: <CAP-5=fWy0r277xsrvZii5uSiC27GkrBVQdkf+EBOtPSSNaBC2A@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] perf: simplify and rename visit_groups_merge
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Qian Cai <cai@lca.pw>, Joe Lawrence <joe.lawrence@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Gary Hook <Gary.Hook@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 2:03 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Nov 13, 2019 at 04:30:39PM -0800, Ian Rogers wrote:
> > To enable a future caching optimization, pass in whether
> > visit_groups_merge is operating on pinned or flexible groups. The
> > is_pinned argument makes the func argument redundant, rename the
> > function to ctx_groups_sched_in as it just schedules pinned or flexible
> > groups in. Compute the cpu and groups arguments locally to reduce the
> > argument list size. Remove sched_in_data as it repeats arguments already
> > passed in. Remove the unused data argument to pinned_sched_in.
>
> Where did my first two patches go? Why aren't
> {pinned,flexible}_sched_in() merged?

I've merged these 2 patches except for the helper function which is
now trivial with the pinned boolean.

Thanks,
Ian
