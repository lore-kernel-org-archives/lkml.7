Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93E6C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DEE2206BA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfDEVzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 17:55:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41374 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfDEVzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 17:55:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DE69619CBD5;
        Fri,  5 Apr 2019 21:55:22 +0000 (UTC)
Received: from treble (ovpn-124-124.rdu2.redhat.com [10.10.124.124])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 314405C70C;
        Fri,  5 Apr 2019 21:55:22 +0000 (UTC)
Date:   Fri, 5 Apr 2019 16:55:20 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [patch V2 20/29] x86/dumpstack/64: Speedup in_exception_stack()
Message-ID: <20190405215520.wsevtopb63oetkfd@treble>
References: <20190405150658.237064784@linutronix.de>
 <20190405150930.219316964@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190405150930.219316964@linutronix.de>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 05 Apr 2019 21:55:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 05:07:18PM +0200, Thomas Gleixner wrote:
> The current implementation of in_exception_stack() iterates over the
> exception stacks array. Most of the time this is an useless exercise, but
> even for the actual use cases (perf and ftrace) it takes at least 2
> iterations to get to the NMI stack.
> 
> As the exception stacks and the guard pages are page aligned the loop can
> be avoided completely.
> 
> Add a initial check whether the stack pointer is inside the full exception
> stack area and leave early if not.
> 
> Create a lookup table which describes the stack area. The table index is
> the page offset from the beginning of the exception stacks. So for any
> given stack pointer the page offset is computed and a lookup in the
> description table is performed. If it is inside a guard page, return. If
> not, use the descriptor to fill in the info structure.
> 
> The table is filled at compile time and for the !KASAN case the interesting
> page descriptors exactly fit into a single cache line. Just the last guard
> page descriptor is in the next cacheline, but that should not be accessed
> in the regular case.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: Simplify the macro maze

This is indeed a little better.  It's friday, have an ack.

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

I don't like the clever ISTACK_* macro naming however...

-- 
Josh
