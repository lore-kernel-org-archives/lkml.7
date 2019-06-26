Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0BAC4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 08:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675092133F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 08:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E1zOSkc5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfFZIGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 04:06:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39804 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFZIGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 04:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2iTCh3reZAKC9g3ThceRYOjvo3XKUmMa8eZRZ5HXM04=; b=E1zOSkc5DpzkVGlg1+h0BYiT7
        MNUlnpycbkPotCUTu5dSGzW4FgEUo8aPSqy6NjX9R28UbuUkRW++EVwrMUppWTRUo6bx032JuCIvl
        6GG2Or/2bthcoBUUQWL6hv0WoBVBOjbcE4cS9IOFde2PX2dmMQ9ylZWIODLlhfjH0/OUAb1DVcweV
        Piqix0RSHvf63fI1RNxYLqN1YRTzhnVyfhC8C8H845eOwowGW/lZeMaseS9I8h29Tf6j/kdFxKM1W
        2Hz/QVfPQhmNddVgEg8hwI8rI37Rvzlre5/b80Y+lJXLKv4KmYKIM/C6cJ8vC1H0m3gI/J2D1/rKF
        8usiMwt6Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hg2wR-0001T7-Ck; Wed, 26 Jun 2019 08:06:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DF3B8200B848F; Wed, 26 Jun 2019 10:06:05 +0200 (CEST)
Date:   Wed, 26 Jun 2019 10:06:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
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
        Shawn Landden <shawn@git.icu>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
Message-ID: <20190626080605.GH3419@hirez.programming.kicks-ass.net>
References: <20190624161913.GA32270@embeddedor>
 <20190624193123.GI3436@hirez.programming.kicks-ass.net>
 <b00fc090d83ac6bd41a5db866b02d425d9ab20e4.camel@perches.com>
 <20190624203737.GL3436@hirez.programming.kicks-ass.net>
 <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
 <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com>
 <20190625071846.GN3436@hirez.programming.kicks-ass.net>
 <201906251009.BCB7438@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201906251009.BCB7438@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 10:12:42AM -0700, Kees Cook wrote:
> On Tue, Jun 25, 2019 at 09:18:46AM +0200, Peter Zijlstra wrote:
> > Can it build a kernel without patches yet? That is, why should I care
> > what LLVM does?
> 
> Yes. LLVM trunk builds and boots x86 now. As for distro availability,

If it's not release and not in distros, then no. So then get that same
trunk to support the __fallthrough crap so it all lands in the same
release and we done ;-)
