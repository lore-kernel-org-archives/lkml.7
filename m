Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74717C74A2B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 16:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9AA2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 16:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562777460;
	bh=K6RLxomY6/gcylM+PgA2F22Cd9n5TkDVQKNBjdOm/cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W3pNqcqJKrqccQCFD58uDPPwkjBkMKZGf54m86k5NDeGdKncR/JNlvKL9w3DkHNL6
	 LafKjBRHWhPDG3uaIPXmqPuIF9ZiDZWxS74EPDxGjrMrMsYIBxINLwxiiZ8hCWBXXN
	 NDs8NR/U7T6Fd4gYKkTpHWSXvgNcIMwPtTwUikkQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbfGJQu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 12:50:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbfGJQu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 12:50:58 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 556A020665;
        Wed, 10 Jul 2019 16:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562777458;
        bh=K6RLxomY6/gcylM+PgA2F22Cd9n5TkDVQKNBjdOm/cs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ti2Bfojla1sTv2FTzxEHe6Vi2FoSNE5wORzZIPoTWSLPbyzdLRQZhb7BfhLk4WEiR
         U48OE5ZzNxM5Jk4OW6BPw7r6Qd2OVTsmlWtc2T1re9KhjyGgOkC9RgPjCMKoJlKN1c
         0Rpyx46CqmkjE+v0tXI6UFO9ysMG8nspo11Kqb5g=
Date:   Wed, 10 Jul 2019 17:50:54 +0100
From:   Will Deacon <will@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, tglx@linutronix.de
Subject: Re: [PATCH] locking/mutex: Test for initialized mutex
Message-ID: <20190710165053.cjt7qs7kx5fwu3d4@willie-the-truck>
References: <20190703092125.lsdf4gpsh2plhavb@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703092125.lsdf4gpsh2plhavb@linutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 11:21:26AM +0200, Sebastian Andrzej Siewior wrote:
> An uninitialized/ zeroed mutex will go unnoticed because there is no
> check for it. There is a magic check in the unlock's slowpath path which
> might go unnoticed if the unlock happens in the fastpath.
> 
> Add a ->magic check early in the mutex_lock() and mutex_trylock() path.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> Nothing screamed during uninitialized usage of init_mm's context->lock
>   https://git.kernel.org/tip/32232b350d7cd93cdc65fe5a453e6a40b539e9f9
> 
>  kernel/locking/mutex.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index 0c601ae072b3f..fb1f6f1e1cc61 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -908,6 +908,10 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
>  
>  	might_sleep();
>  
> +#ifdef CONFIG_DEBUG_MUTEXES
> +	DEBUG_LOCKS_WARN_ON(lock->magic != lock);
> +#endif

Why do we need to check this so early, or could we move it into
debug_mutex_lock_common() instead?

Will
