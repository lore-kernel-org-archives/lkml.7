Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACD7C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68EDD20851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RBA5L+Tn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfCGUkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 15:40:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37916 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfCGUkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 15:40:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RLGSlF/tlCrksvMvOF1ni/HlSijSJRoMSXyBiUGR9Nk=; b=RBA5L+Tngrpqg8OqCfrLOLsUD
        jcHOUvHusPk+A4ytgp1P7dSEkBnXfu7HoEF48yVvTbejYEFqxi21o0b/uNjULF2atX5bahDJ82AvR
        7J37MqYRgxe4eUzTjnvteDcFD0wltnenzKm77YwCTw1AhAdMbX3LJCrLE//kvU86E3jv7clmOn0MA
        HH1h3r5ezzvqUxpoub/SNfo//bQJJkzKRa6X8olB2REgk69zQuB+u7qyAzb8hDUfxzcWKVEy24R7S
        YKzNIQBy9GMf5hNtbmsA/EqgXOCcIiwVZkyffAA9hlcK+l78WJulxNi+dWAY8SPPGkoo6tw+sEVO7
        Oofr3bmbA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1zoU-0002N2-Md; Thu, 07 Mar 2019 20:40:22 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2AC442029B186; Thu,  7 Mar 2019 21:40:21 +0100 (CET)
Date:   Thu, 7 Mar 2019 21:40:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 18/20] objtool: Add UACCESS validation
Message-ID: <20190307204021.GE32534@hirez.programming.kicks-ass.net>
References: <20190307114511.870090179@infradead.org>
 <20190307115200.697533978@infradead.org>
 <CAHk-=wgKDSSoV5WvO018hoPPSHO=TQ3wwnfOtCpaENceBe0Z6Q@mail.gmail.com>
 <20190307174135.GJ32477@hirez.programming.kicks-ass.net>
 <CAHk-=wgGZWXQj-J2xo0DY7150VrXOSqoD5Dj1_LGYaotqA6Z-Q@mail.gmail.com>
 <20190307184813.GL32477@hirez.programming.kicks-ass.net>
 <20190307202319.GD32534@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307202319.GD32534@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 09:23:19PM +0100, Peter Zijlstra wrote:
> On Thu, Mar 07, 2019 at 07:48:13PM +0100, Peter Zijlstra wrote:
> > Another thing I need to look at is why objtool only found memset_orig
> > (from __memset) but not memset_erms, which if I read the code right, is
> > a possible alternative there.
> 
> Turns out we only look for sibling calls in the original instruction
> stream, not in any alternatives; which in general seems like a fair
> enough assumption.

And while I'm looking at memset_64.S, why are memset_erms and
memset_orig global functions? At the very least they should be local,
and ideally not even functions.
