Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A61C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 13:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0505207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 13:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e150KcCv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfCJNNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 09:13:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53288 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfCJNNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 09:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LEIef661FM8j5UkrBAqQSbJez2EkNY7teSflteSNOe8=; b=e150KcCvL1kPviLTyIjJkaAjd
        27neT/ID10yeixqRKg9Ydq7cOiofdCM+5kqvlUSGAWr72ORDF3hoAe0NR/5YmnQsLMJ4scSIdkxI/
        xzf2us0+vzgvsGEEOZBK6yLsvp6+7m2ICCUIrYJreLeuRp1aVAnCo/DpZBjdQGbjSNVZUklQNAa2F
        URVxwcpcee576r+wH1u45cxsHm0Z1/tVBLXhCqMfTQJI3B8vsOWMhCob7RhiS50RuDrkrYo8SDoSq
        zjkoaYWMoF+Uo78eqeJFVi9Mw3omRN04R6neJWRPg30wAWwMhPYvqi9yvf96gzZZuNZXXY0T7d6mf
        /Q+RnC1hQ==;
Received: from [188.207.104.17] (helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h2yGk-0006r0-4o; Sun, 10 Mar 2019 13:13:34 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 08B05981BBE; Sun, 10 Mar 2019 14:13:32 +0100 (CET)
Date:   Sun, 10 Mar 2019 14:13:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, luto@kernel.org,
        bp@alien8.de, dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: Re: [PATCH 20/20] objtool: Add Direction Flag validation
Message-ID: <20190310131331.GK2482@worktop.programming.kicks-ass.net>
References: <20190307114511.870090179@infradead.org>
 <20190307115200.878625203@infradead.org>
 <20190308211603.fpjbd5avcuoox6xf@treble>
 <20190308213343.GE2482@worktop.programming.kicks-ass.net>
 <20190308215602.txm4bv2eg2tyubuj@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308215602.txm4bv2eg2tyubuj@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 03:56:02PM -0600, Josh Poimboeuf wrote:
> On Fri, Mar 08, 2019 at 10:33:43PM +0100, Peter Zijlstra wrote:
> > On Fri, Mar 08, 2019 at 03:16:03PM -0600, Josh Poimboeuf wrote:

> > > Can you elaborate on why (in the patch description)?  Did this actually
> > > find any occurrences?
> > 
> > Nope, didn't find anything. Also, all DF users are in asm so I didn't
> > really expect any. Having it escape would probably result in fairly
> > instant wreckage though.
> > 
> > DF=1 results in things like rep mov going _backwards_.
> 
> Ok, I wonder if we really need to add this then.

Well, Linus asked for it, and it was a fairly trivial add-on :-)
