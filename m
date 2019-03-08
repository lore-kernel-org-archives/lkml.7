Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16707C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD1920811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g2jTxncH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfCHIhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 03:37:55 -0500
Received: from merlin.infradead.org ([205.233.59.134]:59280 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfCHIhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 03:37:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=H3Wsp8MwyJspistThPh4TVCNJNcfrAaSLLUfmcf3CIU=; b=g2jTxncHJIdO9eLhM250IzHof
        yUTLd5DTZk6C1GvB7Tzk/Q48cM9vsUtCUQdDFfZdjHb5zZHeEh0ywcBvjlJUbwxC6mwi5C+T69kZT
        ONRU31inkkFZEoGg3Lar3u7dB4wQFptLF/zV88op+v+h8UeVrRaPDKKQifwDiXMh1eGbyijONamOu
        Pi3GTHKVYR2w0enfzVkP04HM1zKcgM3zT4+yTuTcu1RvPHpS1KCzcczbT2diBc+qqqoggr75QFS9D
        R4wGnM5Hr17EJ002LQ/h40oSkmpajxHOuldgkFNAvILRQ+PKke4/kvShjynNeJQRVXbKuHe3zzKlS
        aV1EiLQCg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h2B0o-0004PJ-Oe; Fri, 08 Mar 2019 08:37:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 49C2F20262FAE; Fri,  8 Mar 2019 09:37:48 +0100 (CET)
Date:   Fri, 8 Mar 2019 09:37:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARCv2: spinlock: remove the extra smp_mb before lock,
 after unlock
Message-ID: <20190308083748.GP32477@hirez.programming.kicks-ass.net>
References: <1552008946-8008-1-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552008946-8008-1-git-send-email-vgupta@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 05:35:46PM -0800, Vineet Gupta wrote:
> @@ -68,8 +72,6 @@ static inline void arch_spin_unlock(arch_spinlock_t *lock)
>  	smp_mb();
>  
>  	lock->slock = __ARCH_SPIN_LOCK_UNLOCKED__;
> -
> -	smp_mb();
>  }
>  
>  /*

> @@ -226,8 +218,6 @@ static inline void arch_write_unlock(arch_rwlock_t *rw)
>  	smp_mb();
>  
>  	rw->counter = __ARCH_RW_LOCK_UNLOCKED__;
> -
> -	smp_mb();
>  }
>  
>  #else	/* !CONFIG_ARC_HAS_LLSC */

I'm thinking those assignments should be WRITE_ONCE() at the very least.
