Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E1DCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 10:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8E82086D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 10:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lawnmS4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbfKAKGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 06:06:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46472 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbfKAKGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 06:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jmed3/I8XI1nyJIh3Dfsq3N/qBZGlZAkvrKYEkgMiC0=; b=lawnmS4/4P7nUtVf89/ilyj0IB
        b9Z6ob1Ti2QlYsNCks1XCPssUqvcSQ8ouHl9hUas1hbbqdOn5YJhEFYFmGyz7gLsTSsYTE/1rWW9S
        Z0r7c29roE+eUQP2KyI4jtYPQiUnI+oN5jSs+r9SBf0IUV+Nq0rQno1dfKWHhy3y9XKHlu2ALtbKb
        iJxGa1vNpT9owA7utH7bnk9VreSMJQiVr3EzSumYg54/hxQlSKX1P+8rLsrkOSCmbl99eY7+qN0bP
        ep3gW3Zly8mo9PTj7d/aH+REXWukKXz7Ewsax9RCxZzmqT4SLVoNsUtSXX7F/rShGu565+h2IScWP
        3OA262mg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iQTor-0001IS-6r; Fri, 01 Nov 2019 10:06:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3E240301A79;
        Fri,  1 Nov 2019 11:05:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3DF4B26540348; Fri,  1 Nov 2019 11:06:11 +0100 (CET)
Date:   Fri, 1 Nov 2019 11:06:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH RFC 1/6] perf/x86: Add perf text poke event
Message-ID: <20191101100611.GV4131@hirez.programming.kicks-ass.net>
References: <20191025130000.13032-1-adrian.hunter@intel.com>
 <20191025130000.13032-2-adrian.hunter@intel.com>
 <20191030104747.GA21153@leoy-ThinkPad-X240s>
 <20191030124659.GQ4114@hirez.programming.kicks-ass.net>
 <20191030141950.GB21153@leoy-ThinkPad-X240s>
 <20191030162325.GT4114@hirez.programming.kicks-ass.net>
 <20191031073136.GC21153@leoy-ThinkPad-X240s>
 <CAJ9a7VgZH7g=rFDpKf=FzEcyBVLS_WjqbrqtRnjOi7WOY4st+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ9a7VgZH7g=rFDpKf=FzEcyBVLS_WjqbrqtRnjOi7WOY4st+w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 12:29:15PM +0000, Mike Leach wrote:
> On Thu, 31 Oct 2019 at 07:31, Leo Yan <leo.yan@linaro.org> wrote:

> > > Since all instructions (with the possible exception of RET) are
> > > unconditional branch instructions: NOP, JMP, CALL. It makes no read
> > > difference to the argument below.
> > >
> > > ( I'm thinking RET might be special in that it reads the return address
> > > from the stack and therefore must emit the whole IP into the stream, as
> > > we cannot know the stack state )
> >
> > To be honest, I don't have knowledge what's the exactly format for 'ret'
> > in CoreSight trace; so would like to leave this to Mike.
> >
> 
> For ETM trace we do not have to output the entire address into he stream if:
> - address compression allows us to emit only the changed ls bit from the
> last address.
> - the address is identical to one of the last three addresses emitted ( we
> just emit a ‘same address encoding’
> - we are using return stack compression and the address is top of the
> return stack (we emit nothing and the decoder gets the address from its own
> mode, of the return stack)

Cute. I don't actually know what PT does, but I figured there had to at
least be the option to provide more information.

