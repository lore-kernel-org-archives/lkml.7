Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC06C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49E92084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D+RIQfG4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbfDJLuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:50:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53430 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727515AbfDJLuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dv77kUs2l4ezlruwYlRtYss9SZER3mIBGYqVkphqyQM=; b=D+RIQfG48+vLGL32Z6bnxYacC
        MH9PRJiYnZwBM0GymUMYHHOzED7EfajqzWaso++xDx7gshM2Z7Va/5vpYCJQVFQOThnE7sQDewREd
        a9Tm+lSlrZC2njFiFWkI7R6r5MDKDlU4MNdHSgZAodGdgjVF1NIsb2Zo7aipYlg30nq5oehDtc4uv
        C0g9POeJNpFQULz0wFUQ2Du5D+HIF9P36X9Z2LRufAxm8XpL552WBtX+VL7bxrmzxLShz9/Z/uLeD
        ta1jOZ5AjWYwB6yeBNQQ5K4LbyHzBeA00MAHt8d810uZY7Fecos4Uq61eq6nevhJ4KncaiD2Zh7ds
        fK4CquqjQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEBjh-00084B-1y; Wed, 10 Apr 2019 11:49:49 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C543E2395002E; Wed, 10 Apr 2019 13:49:47 +0200 (CEST)
Date:   Wed, 10 Apr 2019 13:49:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [RFC patch 00/41] stacktrace: Avoid the pointless redirection
 through struct stack_trace
Message-ID: <20190410114947.GA11158@hirez.programming.kicks-ass.net>
References: <20190410102754.387743324@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410102754.387743324@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 12:27:54PM +0200, Thomas Gleixner wrote:
> Struct stack_trace is a sinkhole for input and output parameters which is
> largely pointless for most usage sites. In fact if embedded into other data
> structures it creates indirections and extra storage overhead for no benefit.
> 
> Looking at all usage sites makes it clear that they just require an
> interface which is based on a storage array. That array is either on stack,
> global or embedded into some other data structure.
> 
> Some of the stack depot usage sites are outright wrong, but fortunately the
> wrongness just causes more stack being used for nothing and does not have
> functional impact.
> 
> Another oddity is the inconsistent termination of the stack trace with
> ULONG_MAX. It's pointless as the number of entries is what determines the
> length of the stored trace. In fact quite some call sites remove the
> ULONG_MAX marker afterwards with or without nasty comments about it. Not
> all architectures do that and those which do, do it inconsistenly either
> conditional on nr_entries == 0 or unconditionally.
> 
> The following series cleans that up by:
> 
>     1) Removing the ULONG_MAX termination in the architecture code
> 
>     2) Removing the ULONG_MAX fixups at the call sites
> 
>     3) Providing plain storage array based interfaces for stacktrace and
>        stackdepot.
> 
>     4) Cleaning up the mess at the callsites including some related
>        cleanups.
> 
>     5) Removing the struct stack_trace based interfaces
> 
> This is not changing the struct stack_trace interfaces at the architecture
> level, but it removes the exposure to the generic code.
> 
> It's only lightly tested as I'm traveling and access to my test boxes is
> limited.

This is indeed a much needed cleanup; thanks for starting this.

I didn't spot anything wrong while reading through it, so:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
