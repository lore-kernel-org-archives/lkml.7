Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48746C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 20:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1301E20872
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 20:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YJJoQmks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbfI0UZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 16:25:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46737 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfI0UZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 16:25:04 -0400
Received: by mail-pf1-f196.google.com with SMTP id q5so2166185pfg.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 13:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P7s7y5MsBXTHC1vdLioQVRyjRMpyNf8MnGkSVFAC734=;
        b=YJJoQmksBuEHSBpTTvwBx1b1GH0h0CMSQvQtggC+RcX6dS8q8zI+hryFjw79cuv4T5
         fiDJGtUJS9ArNS8RcuRMAEc7hWJeyUfSecHutl7Q2hn6c1H3xyRMaza/MO7cH3m2pfMf
         R38vyjWplTHBZSJsWyJA5dLy9hUPR67rR+eD1CRyH8aDSUUiYw1fUaJPlN2RNk5ES5gA
         xgLRjP+b23Sao70l5RkrKgpoJc3uX0bYoD/bE+dL05OY4Sy9FDEcY+gR4r+MxejYjgC7
         q9wKlAMsbtEE89eTXSDFIjtgf+E+hgWLIiKyTLRpj7607RDJWQ44sGbHkQ3QonH4xeLV
         6+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P7s7y5MsBXTHC1vdLioQVRyjRMpyNf8MnGkSVFAC734=;
        b=hBojs0XFLRj9rjhl6cZYwPAtpXNDXverf9VZwwaPGjxgdH3hqa+5zXXYxuIFi/oEKK
         2AWSnjqtc8UQbuOKeSw3INo+j6qDMeE3MYo4EwC7u/OL3tRyj6FRbe7glBeZilK1LmjS
         WhQJyD0Zsj7vy6USGI9rCLf495rP8KZ7MdFKeHIJNjxUdjWwHj68FrdTnPwfxyOAojNA
         etvJ8SzIPzwJHG9pwg9NN1AG1StDmquSAY9GvwejkU/Jsx65YUoOhWunGhNFQzAUvCmd
         kmYR5h0xUJnw3TUl0y2iMW6G8YAMhggbkpoKVXxfKpisOU1vwkk1hof20CNaan4RoWVY
         FZOg==
X-Gm-Message-State: APjAAAX9riE9cu5BuvMSLG5pzOmEvnOb/V4uI359+b8Mzizu6l43MKZV
        AceZcwSPOQmW0NpQJtiCkSQWPGWLmvzJ57xwIab3tQ==
X-Google-Smtp-Source: APXvYqzMUnAsIsa7nXqhxzBmb9GTNmgw/tH9hfMTaKRwVaF8crXXuj+i10xF1biCfF4+8MgByFOhhPFB07fXi5be8Fo=
X-Received: by 2002:a65:48cf:: with SMTP id o15mr7733135pgs.263.1569615901799;
 Fri, 27 Sep 2019 13:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1563150885.git.jpoimboe@redhat.com> <20190715193834.5tvzukcwq735ufgb@treble>
 <CAKwvOdnXt=_NVjK7+RjuxeyESytO6ra769i4qjSwt1Gd1G22dA@mail.gmail.com>
 <20190716231718.flutou25wemgsfju@treble> <CAKwvOdn8_NENF8_cxizrD-PYN_t11px+51WKtkAUa2Q-vH68yw@mail.gmail.com>
In-Reply-To: <CAKwvOdn8_NENF8_cxizrD-PYN_t11px+51WKtkAUa2Q-vH68yw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 27 Sep 2019 13:24:50 -0700
Message-ID: <CAKwvOdmXbkprvi5FO2aic__JQh7z4NmU6MV_iqcnfu5G7T=9Xg@mail.gmail.com>
Subject: Re: [PATCH 00/22] x86, objtool: several fixes/improvements
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 3:26 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Jul 16, 2019 at 4:17 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > > > > 2) There's also an issue in clang where a large switch table had a bunch
> > > > >    of unused (bad) entries.  It's not a code correctness issue, but
> > > > >    hopefully it can get fixed in clang anyway.  See patch 20/22 for more
> > > > >    details.
> > >
> > > Thanks for the report, let's follow up on steps for me to reproduce.
> >
> > Just to clarify, there are two clang issues.  Both of them were reported
> > originally by Arnd, IIRC.
> >
> > 1) The one described above and in patch 20, where the switch table is
> >    mostly unused entries.  Not a real bug, but it's a bit sloppy and
> >    wasteful, and objtool doesn't know how to interpret it.
>
> Thanks for the concise reports.  Will follow up on these in:
> https://github.com/ClangBuiltLinux/linux/issues/611

Following up on this one; in one of the test cases we determined that
the default destination of an exhaustive switch wasn't getting cleaned
up properly, and is being fixed in:
https://reviews.llvm.org/D68131
https://bugs.llvm.org/show_bug.cgi?id=43129
I'm not sure that was the precise issue you described, or if there's
more than one bug here, but hopefully it will help.

>
> >
> > 2) The bug with the noreturn call site having a different stack size
> >    depending on which code path was taken.
>
> and:
> https://github.com/ClangBuiltLinux/linux/issues/612
-- 
Thanks,
~Nick Desaulniers
