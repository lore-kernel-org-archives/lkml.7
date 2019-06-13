Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8A1C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E2120B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387511AbfFMPHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:07:02 -0400
Received: from foss.arm.com ([217.140.110.172]:40610 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732395AbfFMOCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:02:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88E342B;
        Thu, 13 Jun 2019 07:02:08 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAC333F718;
        Thu, 13 Jun 2019 07:02:06 -0700 (PDT)
Date:   Thu, 13 Jun 2019 15:02:04 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     stern@rowland.harvard.edu, akiyks@gmail.com,
        andrea.parri@amarulasolutions.com, boqun.feng@gmail.com,
        dlustig@nvidia.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, npiggin@gmail.com, paulmck@linux.ibm.com,
        paul.burton@mips.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH v2 4/4] x86/atomic: Fix smp_mb__{before,after}_atomic()
Message-ID: <20190613140204.GD18966@fuggles.cambridge.arm.com>
References: <20190613134317.734881240@infradead.org>
 <20190613134933.141230706@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613134933.141230706@infradead.org>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 03:43:21PM +0200, Peter Zijlstra wrote:
> Recent probing at the Linux Kernel Memory Model uncovered a
> 'surprise'. Strongly ordered architectures where the atomic RmW
> primitive implies full memory ordering and
> smp_mb__{before,after}_atomic() are a simple barrier() (such as x86)
> fail for:
> 
> 	*x = 1;
> 	atomic_inc(u);
> 	smp_mb__after_atomic();
> 	r0 = *y;
> 
> Because, while the atomic_inc() implies memory order, it
> (surprisingly) does not provide a compiler barrier. This then allows
> the compiler to re-order like so:
> 
> 	atomic_inc(u);
> 	*x = 1;
> 	smp_mb__after_atomic();
> 	r0 = *y;
> 
> Which the CPU is then allowed to re-order (under TSO rules) like:
> 
> 	atomic_inc(u);
> 	r0 = *y;
> 	*x = 1;
> 
> And this very much was not intended. Therefore strengthen the atomic
> RmW ops to include a compiler barrier.
> 
> NOTE: atomic_{or,and,xor} and the bitops already had the compiler
> barrier.
> 
> Reported-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  Documentation/atomic_t.txt         |    3 +++
>  arch/x86/include/asm/atomic.h      |    8 ++++----
>  arch/x86/include/asm/atomic64_64.h |    8 ++++----
>  arch/x86/include/asm/barrier.h     |    4 ++--
>  4 files changed, 13 insertions(+), 10 deletions(-)
> 
> --- a/Documentation/atomic_t.txt
> +++ b/Documentation/atomic_t.txt
> @@ -194,6 +194,9 @@ These helper barriers exist because arch
>  ordering on their SMP atomic primitives. For example our TSO architectures
>  provide full ordered atomics and these barriers are no-ops.
>  
> +NOTE: when the atomic RmW ops are fully ordered, they should also imply a
> +compiler barrier.

Acked-by: Will Deacon <will.deacon@arm.com>

Cheers,

Will
