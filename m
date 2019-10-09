Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D00C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 22:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB08206A1
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 22:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BjDCFFNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732036AbfJIWh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 18:37:56 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43579 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731134AbfJIWh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 18:37:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id a2so2550614pfo.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 15:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7hfShCs30Z7AfEHrmZa+2z/hnrcGihWEf8CO0VbMhkw=;
        b=BjDCFFNtvw8rBnYDnAvfTdhQKyJ+HwpU5BjulLJI396Rn7iYAq4OsGOX65aKf5tc+Q
         a/CQlynNZYVLFz3lfFVSVkMwfz45LOBeAOPi9IoRx0uOvTbk8f+c3/Q/qFRT1Gdnmm0m
         gncWy7L/ueC0XCafTYNF1dyDgAVFqAaLVMNPeCJzeC+Cldz2VUus8lTL28+HcTWifvrI
         r4fQZwKyMCD3yaOl983g5rNvT/m3eyo/3wmJo+NzD6T2Dcppg+JACxLAGlBU2ZAI1CeU
         rp0NWB890qUNRXdK0nAHkyKWP5EqkL0VX76/OZr+gR6KUBsDVsdr6QGTDSmb5s4/RaXr
         ie3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7hfShCs30Z7AfEHrmZa+2z/hnrcGihWEf8CO0VbMhkw=;
        b=SHtKG/fxKMgR6AmSIed3jTSW/TEPy4+ZLX32FU/wcbTdGFpdSo1wfoLsk0VXs9sM1V
         aaADdwIMUaUyANfeY+9rDn39LZV4olAXnRhvnQvW1NKdV3X5Uteo8D3+nmeA77ko2jg8
         pHM4bQRrM0gvot6LWYEIEOaOPF176CeJeF65DBXnkk3MNMk706UtNY3meKhICISk4Fo7
         4bSP3NmpBrlz32vyW8YFEsE7DiU1ueV6XwmKGdFxTPtCpHiGcxyRBUWdZ+9dz40G9ioZ
         loOcwVhpxf2VlyAxL9vnuAdiQsVKDapZSMNGKkDsWRB3QemoFMIHvMnacASvFTb/FGDn
         a+HQ==
X-Gm-Message-State: APjAAAV817mhmo/2j7blkluWTEDb+873x8cASXg7W4DAyqDeBQO7wHs7
        uB5k3/mKElT1Ygjin/cmq1fZBu07YXS5CaXXQbqs2Ka37SI=
X-Google-Smtp-Source: APXvYqymqTAd6Vk364cIUXias7XWRVd/fxdlL1GbFhKlVGoUAhPHuPD/5xlYwc3vOSkb/8M9pr2ZBqYZAsi381/R2vs=
X-Received: by 2002:a17:90a:b285:: with SMTP id c5mr6833625pjr.123.1570660673665;
 Wed, 09 Oct 2019 15:37:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1570292505.git.joe@perches.com> <4a904777303fbaea75fe0875b7984c33824f4b68.1570292505.git.joe@perches.com>
In-Reply-To: <4a904777303fbaea75fe0875b7984c33824f4b68.1570292505.git.joe@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 9 Oct 2019 15:37:42 -0700
Message-ID: <CAKwvOdm+u9ijMdfPQVZYU3tQCuhMePsvmKXA_kyyAaQUu2y5gA@mail.gmail.com>
Subject: Re: [PATCH 4/4] scripts/cvt_style.pl: Tool to reformat sources in
 various ways
To:     Joe Perches <joe@perches.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pavel Machek <pavel@ucw.cz>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 5, 2019 at 9:47 AM Joe Perches <joe@perches.com> wrote:
>
> Trivial tool to reformat source code in various ways.
>
> This is an old tool that was recently updated to convert /* fallthrough */
> style comments to the new pseudo-keyword fallthrough;
>
> Typical command line use is:
>     $ perl scripts/cvt_style --convert=fallthrough <file list>

It would be cool to include the treewide onliner from your cover sheet
in this commit message, as I find myself flipping between that and
this, otherwise the recommended onliner will be lost to LKML (instead
of being lost to git log). Or in the usage comment at the top of the
script.

>
> Available conversions:
>         all
>         printk_to_pr_level
>         printk_KERN_DEBUG_to_pr_debug
>         dev_printk_to_dev_level
>         dev_printk_KERN_DEBUG_to_dev_dbg
>         sdev_printk_to_sdev_level
>         sdev_printk_KERN_DEBUG_to_sdev_dbg
>         coalesce_formats
>         cuddle_open_brace
>         cuddle_else

I think some of these could use examples of what they do. I can't read
perl (as we've previously established :P) and I'm not sure what it
means to cuddle open braces or elses, though they do sound nice.

>         deparenthesize_returns
>         space_after_KERN_level
>         space_after_if_while_for_switch
>         space_after_for_semicolons
>         space_after_comma
>         space_before_pointer
>         space_around_trigraph
>         leading_spaces_to_tabs
>         coalesce_semicolons
>         remove_trailing_whitespace
>         remove_whitespace_before_quoted_newline
>         remove_whitespace_before_trailing_semicolon
>         remove_whitespace_before_bracket
>         remove_parenthesis_whitespace
>         remove_single_statement_braces
>         remove_whitespace_after_cast
>         hoist_assigns_from_if
>         convert_c99_comments
>         remove_private_data_casts
>         remove_static_initializations_to_0
>         remove_true_false_comparisons
>         remove_NULL_comparisons
>         remove_trailing_if_semicolons

To Miguel's comment about clang-format, it looks like you can do:

Use -style="{key: value, ...}" to set specific
                              parameters, e.g.:
                                -style="{BasedOnStyle: llvm, IndentWidth: 8}"

via: https://clang.llvm.org/docs/ClangFormat.html
which might make some nice one liners for some of these.


>         network_comments
>         remove_switchforwhileif_semicolons
>         detab_else_return
>         remove_while_while
>         fallthrough
> Additional conversions which may not work well:
>         (enable individually or with --convert=all --broken)
>         move_labels_to_column_1
>         space_around_logical_tests
>         space_around_assign
>         space_around_arithmetic
>         CamelCase_to_camel_case

s/camel_case/snake_case/

I'll give the script a run later this week and report back if I can
find any errors in the resulting build, as in the previous patch
series. Thanks for the work on this.
-- 
Thanks,
~Nick Desaulniers
