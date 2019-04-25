Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8F9C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3D7208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2gypBO3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbfDYIdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:33:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48294 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfDYIdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:33:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sA64SEnRlKcPxfGZbt5NjWRkUkhVgmJCuZ+TFzTB++k=; b=2gypBO3nHvA0R+JYarJCymfk0
        PZjTr/t+QOUrMNmsZT4xwbfMLNhlMjMbn6wSca+OUO3TAM/1Wd46V0xKQYIUFWrP2Ud4V7YteDXHO
        5Y6C3fJ95Dw4qx/p7dQUKfJlNYlRsx1wWY+okqDrfqrX5I02mqh1UZQoX6YQ0cuecFTV7cXmDVi3M
        AyilxPCRvBsYzMQbdo1Gu7xeN8iO/Y5yWUYX9wTN6xqebZHKAjHMSYYPv9HnQXKAGehDv3tyq4Yus
        N54OzSu0A/zKZHChhn7s8JVQyVULU+mH5QY6RA/7Mk2X4N2KAi3Hqp0RQVcoO1gm0JulywhOpQxcl
        cMGizLfpg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJZon-0001Fs-Me; Thu, 25 Apr 2019 08:33:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3B75B203E8871; Thu, 25 Apr 2019 10:33:20 +0200 (CEST)
Date:   Thu, 25 Apr 2019 10:33:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Raphael Gault <Raphael.Gault@arm.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Julien Thierry <Julien.Thierry@arm.com>
Subject: Re: [RFC 3/6] objtool: arm64: Adapt the stack frame checks and the
 section analysis for the arm architecture
Message-ID: <20190425083320.GK4038@hirez.programming.kicks-ass.net>
References: <20190409135243.12424-1-raphael.gault@arm.com>
 <20190409135243.12424-4-raphael.gault@arm.com>
 <20190423203627.mwnaknit7cvr3l5l@treble>
 <cd86ce1a-7c6a-9ebf-4c84-6cb6ffd88017@arm.com>
 <20190424165640.5yeg2yicl7ej7g3i@treble>
 <c90f402e-6494-73bc-1df8-516c3113019a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c90f402e-6494-73bc-1df8-516c3113019a@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 08:12:24AM +0000, Raphael Gault wrote:
> The motivation behind this is that the `br <Xn>` instruction is a
> dynamic jump (jump to the address contained in the provided register).
> This instruction is used for sibling calls but can also be used for
> switch table. I use this to differentiate these two cases from one another:
> 
> Generally the `adr/adrp` instruction is used prior to `br` in order to
> load the address into the register. What I do here is go back throught
> the instructions and try to identify if the address loaded.

Yikes, be very careful with simply going back on the instruction stream.

The problem case would be something like:

	adr	...
	b	1f

	...

	b	...
1:	br	...

In that case, simply going backwards from 1 will not yield the desired
result.

At some point I did a pass storing all the fwd jumps in their
destination and used that to 'rewind' the instruction stream, but that
wasn't very pretty either.

The best way might be to, while doing validate_branch() keep a state
table of all most recent ADR(P) instructions and when encountering BR
check that state to see what it really is.

We currently don't do dynamic insn->type, but it shouldn't be too hard
(famous last words of course).
