Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DAAC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D849206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FLvLVIFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfCHTxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 14:53:08 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36764 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfCHTxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 14:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HmHDBcWa41rLW3eKSxE7V5EQqNizppq/JTPzVj4Lfeo=; b=FLvLVIFj49657IYlGILZDJCbM
        qp+VimSYf9hwKDcjF4rPrWnR1dowUy2n8jZqo3ZCXHXTMK1bV0VJqpVbYAah5GRr0lznYRduhHmY4
        VwRdJHP+4P9HKkwFwQLDv+fpTGd6SEhNOeYoXMWIlU3v3TuH2uORkcYxHI1Mp6xD/N7QSMAh7HWKO
        serp/S8Sc39Axi9wnhvYYRdvNol4/q3dKBTWbp9k/onX3vAShtLNhbpUEDGVHzOLRPX2CI628/DAL
        pePJMtErt2XYRyTDCutF0BsLldfgYXdP6Z6i7EMDtt4yF5A84PQFxIiLwL9naFKEVuSWMeNU1iT5p
        yWSJkS2Bw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h2LY7-0001Vb-U4; Fri, 08 Mar 2019 19:52:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 902F020281DC5; Fri,  8 Mar 2019 20:52:54 +0100 (CET)
Date:   Fri, 8 Mar 2019 20:52:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, luto@kernel.org,
        bp@alien8.de, dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: Re: [PATCH 13/20] objtool: Hande function aliases
Message-ID: <20190308195254.GG32494@hirez.programming.kicks-ass.net>
References: <20190307114511.870090179@infradead.org>
 <20190307115200.238778618@infradead.org>
 <20190308192358.65kzunthwzvsdifg@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308192358.65kzunthwzvsdifg@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 01:23:58PM -0600, Josh Poimboeuf wrote:
> 
> On Thu, Mar 07, 2019 at 12:45:24PM +0100, Peter Zijlstra wrote:
> > Function aliases result in different symbols for the same set of
> > instructions; track a canonical symbol so there is a unique point of
> > access.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> s/Hande/Handle/ in $SUBJECT

Whoops :-)

> Also you can clarify why we need to track aliases?

Function attributes (as per that previous patch) and: git grep "alias"
mm/kasan.
