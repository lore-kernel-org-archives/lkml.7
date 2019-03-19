Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC8FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D43620989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ya6l0hgu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfCSKL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:11:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38638 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfCSKLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 06:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Zp5T4D2YXKefBpPzhTowsVZAxi5fFXjhAzZ4KtfEyDk=; b=Ya6l0hgun1s6Zpn9dww71boij
        RbjqlWDVEKTj3gVcyyT68IrkTjAP1yv2tadkhx3hOk5WhHwTSI2lYEZr+qawVPKdagIIYJpL0CRh0
        fIPiQoWjyVs6IuQ8NiS+8/buEILTZJODWF8QMyRujEy5+ix/nTxqqChukYuB28MVTOb2zL1fpmo+Q
        W1lT3tepxs8yc2vXIMwtyyYwKlDi1ShTqaj2lbgYJU4TQO6efA7/bRDwn49n3uHE1pRjRCyZG1Tvo
        Z77Judsbuw+u4wg8t4ctVSjhLW1CZSjjB5czIMmTXCtH+yAf2OQ4VjCgTW713afclv2MH1KfvJPiE
        aAJRsDDMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6BiQ-0007tn-Oe; Tue, 19 Mar 2019 10:11:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E388C2020F503; Tue, 19 Mar 2019 11:11:23 +0100 (CET)
Date:   Tue, 19 Mar 2019 11:11:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, luto@kernel.org,
        bp@alien8.de, dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: Re: [PATCH 02/25] tracing: Improve "if" macro code generation
Message-ID: <20190319101123.GX6058@hirez.programming.kicks-ass.net>
References: <20190318153840.906404905@infradead.org>
 <20190318155140.058627431@infradead.org>
 <20190318233720.76j6ywkdulmnhu2o@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318233720.76j6ywkdulmnhu2o@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 06:37:20PM -0500, Josh Poimboeuf wrote:
> On Mon, Mar 18, 2019 at 04:38:42PM +0100, Peter Zijlstra wrote:
> > With CONFIG_PROFILE_ALL_BRANCHES, the "if" macro converts the
> > conditional to an array index.  This can cause GCC to create horrible
> > code.  When there are nested ifs, the generated code uses register
> > values to encode branching decisions.
> > 
> > Make it easier for GCC to optimize by keeping the conditional as a
> > conditional rather than converting it to an integer.  This shrinks the
> > generated code quite a bit, and also makes the code sane enough for
> > objtool to understand.
> > 
> > Cc: rostedt@goodmis.org
> > Cc: valentin.schneider@arm.com
> > Cc: luto@amacapital.net
> > Cc: brgerst@gmail.com
> > Cc: catalin.marinas@arm.com
> > Cc: mingo@kernel.org
> > Cc: dvlasenk@redhat.com
> > Cc: will.deacon@arm.com
> > Cc: julien.thierry@arm.com
> > Cc: torvalds@linux-foundation.org
> > Cc: dvyukov@google.com
> > Cc: bp@alien8.de
> > Cc: tglx@linutronix.de
> > Cc: james.morse@arm.com
> > Cc: luto@kernel.org
> > Cc: hpa@zytor.com
> > Reported-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Link: https://lkml.kernel.org/r/20190307174802.46fmpysxyo35hh43@treble
> 
> Missing "From" me.

Right, sorry, quilt eats that and I sometimes forget to fix up :/
