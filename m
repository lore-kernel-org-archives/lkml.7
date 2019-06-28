Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D67C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B94208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DCJbIut9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfF1Nb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 09:31:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52946 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfF1Nb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 09:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WWW87peQLpsz5hF+D7roPrdiHtXEaavrtIXlcnYMy1Q=; b=DCJbIut9E6YcoLpwlDbqM6bjg
        jSwlILW4EWr68yzvQf+B4qtTC60F/kkGKy2SDO0NEEISF/yza/RdM2RMq+WlWNvtH81TFWgqnJlQg
        rgXHKEXu/iTMzCqtpSYjDeMvBoYmGxyZ9JnVsljXbv0NA3dxPFFVq/1YNoOrHX0ZB2zYNGGkJmPUj
        Ccf4ofQoCJ5XaOh6pD41cQJEQipyZi1N1cg8KTCEtLl3sDyfCm7wpl/i36Mu+lQnge70hj/MFL3+k
        j363U9hbm0bmnZz2z/1JjYqOBtnCOrqcPwcibcrdj2zQiRYA5WcAYUSmC5B45nQcb4ZCbIn75PI/2
        qahVgr6lw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgqy3-0005JE-Co; Fri, 28 Jun 2019 13:31:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 48F2E20AB898E; Fri, 28 Jun 2019 15:31:05 +0200 (CEST)
Date:   Fri, 28 Jun 2019 15:31:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Joe Perches <joe@perches.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
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
        Shawn Landden <shawn@git.icu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Chandler Carruth <chandlerc@google.com>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
Message-ID: <20190628133105.GD3463@hirez.programming.kicks-ass.net>
References: <b00fc090d83ac6bd41a5db866b02d425d9ab20e4.camel@perches.com>
 <20190624203737.GL3436@hirez.programming.kicks-ass.net>
 <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
 <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com>
 <20190625071846.GN3436@hirez.programming.kicks-ass.net>
 <CANiq72=zzZ+Cx8uM+5UW7HeB9XtbXRhXmC2y2tz5EzPX77gHMw@mail.gmail.com>
 <CAKwvOdn5j8Hkc_jrLMbhg-4jbNya+agtMJi=c9o01RPCno1Q+w@mail.gmail.com>
 <20190626084927.GI3419@hirez.programming.kicks-ass.net>
 <CAKwvOdkp7qnwLGY2=TOx=FQa1k2hEkdi1PO+9GfZkTQEUh49Rg@mail.gmail.com>
 <20190627071250.GZ3402@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627071250.GZ3402@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 09:12:50AM +0200, Peter Zijlstra wrote:

> Josh came up with the following:
> 
> +		/* If the jump target is close, do a 2-byte nop: */
> +		".skip -(%l[l_yes] - 1b <= 126), 0x66\n"
> +		".skip -(%l[l_yes] - 1b <= 126), 0x90\n"
> +		/* Otherwise do a 5-byte nop: */
> +		".skip -(%l[l_yes] - 1b > 126), 0x0f\n"
> +		".skip -(%l[l_yes] - 1b > 126), 0x1f\n"
> +		".skip -(%l[l_yes] - 1b > 126), 0x44\n"
> +		".skip -(%l[l_yes] - 1b > 126), 0x00\n"
> +		".skip -(%l[l_yes] - 1b > 126), 0x00\n"
> 
> Which is a wonderfully gruesome hack :-) So I'll be playing with that
> for a bit.

For those with interest; full patches at:

  https://lkml.kernel.org/r/20190628102113.360432762@infradead.org
