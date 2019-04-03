Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11646C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD772084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q1I3tQIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfDCNJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:09:46 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40474 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDCNJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=E9y2bwtmtm5RPATkV8LMjdYfqram9n2UMCK0AZeny7g=; b=Q1I3tQIXkVqa7pzP6vMxeJYUv
        Gk662DcScrjCK6wSQzG/quILczFu/FRbV3UcfmjUnPPYrXE9iR1p+bnYrOfPbeX/ylsEMJ96Ax2Cm
        DMR18RgK4QabVZDB6IFv4aioYyRno1AGq5+pCcjV/RtY33KX0mogrq5RNLaI1AEfBsU06mEdUznYx
        OwL5+WyARuKZK+ksWD5QZEd27oH1v1Fo2R+k0r46jx8oG3YYoYyh4LXER0Ej0qVd+glmFPDeSNePz
        hWsfvuLivBdcnsqHlMiU+sw9WrX9hMACh3/etF2fAhGAEV2DTmW3yoYtt5yiC/FYJxkMQ6ESnWJdT
        b2Nh7XCSA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBfe3-0002Ta-Q6; Wed, 03 Apr 2019 13:09:36 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 874BF2038C24B; Wed,  3 Apr 2019 15:09:34 +0200 (CEST)
Date:   Wed, 3 Apr 2019 15:09:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH-tip v3 06/11] locking/rwsem: Enhance
 DEBUG_RWSEMS_WARN_ON() macro
Message-ID: <20190403130934.GH4038@hirez.programming.kicks-ass.net>
References: <1551380981-3113-1-git-send-email-longman@redhat.com>
 <1551380981-3113-7-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551380981-3113-7-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 02:09:36PM -0500, Waiman Long wrote:
> diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
> index 1d8f722..c8fd3f1 100644
> --- a/kernel/locking/rwsem.h
> +++ b/kernel/locking/rwsem.h
> @@ -27,9 +27,13 @@
>  #define RWSEM_ANONYMOUSLY_OWNED	(1UL << 1)
>  
>  #ifdef CONFIG_DEBUG_RWSEMS
> -# define DEBUG_RWSEMS_WARN_ON(c)	DEBUG_LOCKS_WARN_ON(c)
> +# define DEBUG_RWSEMS_WARN_ON(c, sem)				\
> +	WARN_ONCE(c, "DEBUG_RWSEMS_WARN_ON(%s): count = 0x%lx, owner = 0x%lx, curr 0x%lx, list %sempty\n",\
> +		#c, atomic_long_read(&(sem)->count),		\
> +		(long)((sem)->owner), (long)current,		\
> +		list_empty(&(sem)->wait_list) ? "" : "not ")

This changes DEBUG_LOCKS_WARN_ON() to WARN_ONCE(), the difference being
that you now fail to kill lockdep on a rwsem error, which seems
unfortunate.

>  #else
> -# define DEBUG_RWSEMS_WARN_ON(c)
> +# define DEBUG_RWSEMS_WARN_ON(c, sem)
>  #endif
