Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8013C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894DE20863
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GEGGm38d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbfFYHTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:19:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44412 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfFYHTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pts7pdji0i2LdYa39C8jjPmRsnBKfIOoOl3vWwmkw/g=; b=GEGGm38dDwDxeXl5r5xBXQXQS
        p8j3Q8zlg3NOdJTiAih3f/iLrInmHeW6ewV7CKxkb5zwOLAVaceEFWzv9KL1C2QRJAxMZxFlPSzuZ
        2pCONouGo5+WsTAnEe1vPoAXxfEDiA7aPefe39qlrfOWbgW9w9OlUUjc7o4X1VLuYI1g0FQnvFjjz
        EqfE5WM9S2RUwyqACrWIiHH3IdOolsvO85XxRx34u8JKVnMEbhMKhPp9t2OxVceXExe1FVocJD0/p
        1jQzDOgHMxus78L1GvhTHaNxgdPETGwbgI2vDly9JrEGVQ8apOC47Mc7ljJJYNBVxKlHPvEX6fwUd
        kksX4GAgg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hffj7-0000KS-DB; Tue, 25 Jun 2019 07:18:49 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9E705209FFF54; Tue, 25 Jun 2019 09:18:46 +0200 (CEST)
Date:   Tue, 25 Jun 2019 09:18:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Joe Perches <joe@perches.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shawn Landden <shawn@git.icu>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
Message-ID: <20190625071846.GN3436@hirez.programming.kicks-ass.net>
References: <20190624161913.GA32270@embeddedor>
 <20190624193123.GI3436@hirez.programming.kicks-ass.net>
 <b00fc090d83ac6bd41a5db866b02d425d9ab20e4.camel@perches.com>
 <20190624203737.GL3436@hirez.programming.kicks-ass.net>
 <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
 <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 12:28:23AM +0200, Miguel Ojeda wrote:
> On Mon, Jun 24, 2019 at 10:53 PM Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
> >
> > Once the C++17 `__attribute__((fallthrough))` is more widely handled by C compilers,
> > static analyzers, and IDEs, we can switch to using that instead. Also, we are a few
> > warnings away (less than five) from being able to enable -Wimplicit-fallthrough. After
> > this option has been finally enabled (in v5.3) we can easily go and replace the comments
> > to whatever we agree upon.
> 
> Indeed -- the decision last year was to wait for a while since not
> everyone had support for it. My branch is waiting here:
> 
>     https://github.com/ojeda/linux/tree/compiler-attributes-fallthrough
> 
> The good news is that there is some progress. For instance, LLVM is
> working on supporting the GNU spelling:
> 
>     https://reviews.llvm.org/D63260
>     https://bugs.llvm.org/show_bug.cgi?id=37135
>     https://github.com/ClangBuiltLinux/linux/issues/235

Can it build a kernel without patches yet? That is, why should I care
what LLVM does?

> Also note that C2x may get [[fallthrough]]. See N2267 and N2335. At
> that point, surely tools/IDEs/analyzers will support it :-) The
> question is whether we want to wait that long to replace the comments.

#define __fallthrough [[fallthrough]]

right?
