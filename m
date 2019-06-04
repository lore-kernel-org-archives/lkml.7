Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7CBC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A57924A57
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ItdVXloc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfFDK7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 06:59:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35720 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfFDK7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 06:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qzOjyBSpF7RZNnNR9zgoOURs0pNhwQE02Z05N1I+GE8=; b=ItdVXloco/vqVF2c61wLS40uf
        YoCfqtnz9ks9UgkIDCA/7rJWTNljX+lKTlG79Vt24gCXuMqa7Ve8u+Ps2ySshFf3SOREsO2x6YtBC
        pgVWQrfBW97hGusznuTbHpaRCTz3PyR9WjXVpXTrg8Hk4udfzuLjA/12ek+Xgxh1/Lkn3ebqnwAa0
        B4o+m0hYBCZYyNg9K6RZHVIlIziU/PcZK6CFxD7m/C8eNz26PHdCBRxzKFZ5XWqRgunU4fkJvoc+g
        NFME0Z8h1NGQL7vSstDdmCz0H3RGYL0tLRi4Xo1EFRsDDVJu+Jb+pHid1xOF16qjwClhB6N0teF1n
        BqeXmf1rg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hY79X-0003uC-M5; Tue, 04 Jun 2019 10:58:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D14F920761B69; Tue,  4 Jun 2019 12:58:48 +0200 (CEST)
Date:   Tue, 4 Jun 2019 12:58:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v8 15/19] locking/rwsem: Adaptive disabling of reader
 optimistic spinning
Message-ID: <20190604105848.GL3402@hirez.programming.kicks-ass.net>
References: <20190520205918.22251-1-longman@redhat.com>
 <20190520205918.22251-16-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520205918.22251-16-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 04:59:14PM -0400, Waiman Long wrote:
> +static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
> +					      long last_rowner)
> +{
> +	long owner = atomic_long_read(&sem->owner);
> +
> +	if (!(owner & RWSEM_READER_OWNED))
> +		return false;
> +
> +	owner	    &= ~RWSEM_OWNER_FLAGS_MASK;
> +	last_rowner &= ~RWSEM_OWNER_FLAGS_MASK;
> +	if ((owner != last_rowner) && rwsem_try_read_lock_unqueued(sem)) {

just because I'm struggling with sleep deprivation and the big picture
isn't making sense,.. you can write that like:

	((owner ^ last_rowner) & ~RWSEM_OWNER_FLAGS_MASK)

> +		lockevent_inc(rwsem_opt_rlock2);
> +		lockevent_add(rwsem_opt_fail, -1);
> +		return true;
> +	}
> +	return false;
> +}
