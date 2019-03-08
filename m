Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821B7C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43FB520652
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aT1zb9Gp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfCHVd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:33:57 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47648 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfCHVd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 16:33:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=f1uvKVxVhzDTR2+cHskxGsv/MTOUPRhC3M5x+AFK9hw=; b=aT1zb9GpuKazXic5RbeIbUInr
        Nm3KIW/aDZtYhhPcoHpW9/gc/UHckd9FVmPE4rqDRoHYmjQ6T8tHIJtsyXRyvYZJ7gJ96SaaIWJeZ
        WUZpDccJDJcZF8mqQEVTKQCI4s0ES8i0XP8aPdEYQ/CR2+YEfOPhPCucljqJKlYIR3h2V0RrkRVlC
        23MA5j0/Dejqi4CK4qLREXFVbpzW8IabBCLzCub1qLoVDRxRFSLFFS3I9Ygj6nMqChARiDr5U1NJz
        7H6ygUAObzSbl6UfVNGMFP/ARrsfuSZNODyuajdBpFrt4pYugvhjeuJ3dUGpkn5nZSkqZNcbkKrxn
        NwMvxlNXA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h2N7h-00025K-7L; Fri, 08 Mar 2019 21:33:45 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 16F25981BBE; Fri,  8 Mar 2019 22:33:43 +0100 (CET)
Date:   Fri, 8 Mar 2019 22:33:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, luto@kernel.org,
        bp@alien8.de, dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: Re: [PATCH 20/20] objtool: Add Direction Flag validation
Message-ID: <20190308213343.GE2482@worktop.programming.kicks-ass.net>
References: <20190307114511.870090179@infradead.org>
 <20190307115200.878625203@infradead.org>
 <20190308211603.fpjbd5avcuoox6xf@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308211603.fpjbd5avcuoox6xf@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 03:16:03PM -0600, Josh Poimboeuf wrote:
> On Thu, Mar 07, 2019 at 12:45:31PM +0100, Peter Zijlstra wrote:
> > Having DF escape is BAD(tm).
> > 
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Can you elaborate on why (in the patch description)?  Did this actually
> find any occurrences?

Nope, didn't find anything. Also, all DF users are in asm so I didn't
really expect any. Having it escape would probably result in fairly
instant wreckage though.

DF=1 results in things like rep mov going _backwards_.

