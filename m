Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DC7C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2927C217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390653AbfEXKxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 06:53:45 -0400
Received: from foss.arm.com ([217.140.101.70]:40106 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390459AbfEXKxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 06:53:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 427CE374;
        Fri, 24 May 2019 03:53:44 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC7B83F703;
        Fri, 24 May 2019 03:53:42 -0700 (PDT)
Date:   Fri, 24 May 2019 11:53:40 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jorgen Hansen <jhansen@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH 2/2] compiler: Prevent evaluation of WRITE_ONCE()
Message-ID: <20190524105339.GC12796@lakrids.cambridge.arm.com>
References: <1558694136-19226-1-git-send-email-andrea.parri@amarulasolutions.com>
 <1558694136-19226-3-git-send-email-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558694136-19226-3-git-send-email-andrea.parri@amarulasolutions.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This would be better titled as:

  compiler: don't return a value from WRITE_ONCE()

... since we do want the WRITE_ONCE() itself to be evaluated.

On Fri, May 24, 2019 at 12:35:36PM +0200, Andrea Parri wrote:
> Now that there's no single use of the value of WRITE_ONCE(), change
> the implementation to eliminate it.

I hope that's the case, but it's possible that some macros might be
relying on this, so it's probably worth waiting to see if the kbuild
test robot screams.

Otherwise, I agree that WRITE_ONCE() returning a value is surprising,
and unnecessary. IIRC you said that trying to suport that in other
implementations was painful, so aligning on a non-returning version
sounds reasonable to me.

> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jorgen Hansen <jhansen@vmware.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
> ---
>  include/linux/compiler.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 8aaf7cd026b06..4024c809a6c63 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -277,12 +277,11 @@ unsigned long read_word_at_a_time(const void *addr)
>  }
>  
>  #define WRITE_ONCE(x, val) \
> -({							\
> +do {							\
>  	union { typeof(x) __val; char __c[1]; } __u =	\
>  		{ .__val = (__force typeof(x)) (val) }; \
>  	__write_once_size(&(x), __u.__c, sizeof(x));	\
> -	__u.__val;					\
> -})
> +} while (0)

With the title fixed, and assuming that the kbuild test robot doesn't
find uses we've missed:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.


>  
>  #endif /* __KERNEL__ */
>  
> -- 
> 2.7.4
> 
