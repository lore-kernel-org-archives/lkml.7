Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19E2C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBAD7217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="j+xBzV11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfDKFd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 01:33:59 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:58679 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfDKFd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 01:33:58 -0400
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x3B5XlaW030498
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 14:33:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x3B5XlaW030498
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554960828;
        bh=HvmtDKfbJ6Ps0FaeCVAcEqPD8iGT/6So3ajmfgsNAbc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j+xBzV11f3MnyIASQGr3mids1soSwTGitcO4xnUYV9U5M52wDx6txarcbbLTSgx+Y
         9dQKe1ml9FuijsxL8yvbVc16HkWh4xgWqeDtOMB6FyeOMBRZtc+aXd5EsA8VAvYrng
         1F7pCxLMYqnOfqrStYuRZ2XCMcJfhpWZd42KSfWXZ8zWfmHUDzRjoR+40f3n3qO3vX
         wR5511EN8cyTfm3q0qjEP4QCyb+gMZXXxNVkudSrzW8K/ccxj9WFGoP5dCtzcunwwi
         qs5nlnjr6LZH0a/tBxPP+suZAxEA+UwfhB/9Ah8xUQQofiB/gZhsgGbHWKbWbGcHSX
         TM9MFOCxit5Gg==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id f15so2766084vsk.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 22:33:48 -0700 (PDT)
X-Gm-Message-State: APjAAAWR1TGRG5q5RJ2Jd+N5f/WOjfdRa/2NrUKCPnEByTdX1bCcJlL5
        8rfNW2QHi/4wtHRNZX1335D+Dw3NrEGqwNgPUlc=
X-Google-Smtp-Source: APXvYqw8dtBZYtbkHRQ5tpD8pXUzfrRmMujgYr9ThBeSXAF17LPVVMcd5I81Cajqj28mn6PmD+pzMdpw+liQUNBcvdE=
X-Received: by 2002:a67:818e:: with SMTP id c136mr26680017vsd.65.1554960827450;
 Wed, 10 Apr 2019 22:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190411005634.8495-1-okaya@kernel.org> <CAGXu5jLU8Nh0+9rMSeOxwv4hUoPFWSiGf_L_SKpSHO_=VZxisg@mail.gmail.com>
In-Reply-To: <CAGXu5jLU8Nh0+9rMSeOxwv4hUoPFWSiGf_L_SKpSHO_=VZxisg@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 11 Apr 2019 14:33:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQqcKjs6Cnp5fK8OYhj2G_xbXpZc3WtTany3D+=RUpaew@mail.gmail.com>
Message-ID: <CAK7LNAQqcKjs6Cnp5fK8OYhj2G_xbXpZc3WtTany3D+=RUpaew@mail.gmail.com>
Subject: Re: [PATCH v3] init: Do not select DEBUG_KERNEL by default
To:     Kees Cook <keescook@chromium.org>
Cc:     Sinan Kaya <okaya@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Changbin Du <changbin.du@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 11:47 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Apr 10, 2019 at 5:56 PM Sinan Kaya <okaya@kernel.org> wrote:
> >
> > We can't seem to have a kernel with CONFIG_EXPERT set but
> > CONFIG_DEBUG_KERNEL unset these days.
> >
> > While some of the features under the CONFIG_EXPERT require
> > CONFIG_DEBUG_KERNEL, it doesn't apply for all features.
> >
> > It looks like CONFIG_KALLSYMS_ALL is the only feature that
> > requires CONFIG_DEBUG_KERNEL.
> >
> > Select CONFIG_EXPERT when CONFIG_DEBUG_KERNEL is chosen but
> > you can still choose CONFIG_EXPERT without CONFIG_DEBUG_KERNEL.
> >
> > Signed-off-by: Sinan Kaya <okaya@kernel.org>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
>
> Masahiro, should this go via your tree, or somewhere else?


I think somewhere else.


-- 
Best Regards
Masahiro Yamada
