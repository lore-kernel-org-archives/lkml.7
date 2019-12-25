Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1E3C2D0DA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 11:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660252075B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 11:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ndjckrlc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfLYLjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 06:39:39 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45278 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfLYLjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 06:39:39 -0500
Received: from zn.tnic (p200300EC2F0ED600EC808D3B89E41380.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:d600:ec80:8d3b:89e4:1380])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 016031EC05B5;
        Wed, 25 Dec 2019 12:39:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1577273977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BOpJVFIA2qniQ9Bo8EMJuWfsf1ZZVYCz4G3dfSzw3m0=;
        b=NdjckrlcApT428Zvf8AGb3ViwmHwYVjwno9sG1RMzK9cTPBtk1nfnd0aIjOZPJWX6YPkO5
        yzG+XqcGo9gmLZRO9uRJQFeruZEtMqtvJXsVPu46N4jIroclRDp/wA0TQpn88g/9N9qweH
        JEfSITV+cujgruLras39iUYWcwfw14M=
Date:   Wed, 25 Dec 2019 12:39:32 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>
Subject: Re: [tip: core/urgent] rseq: Reject unknown flags on rseq unregister
Message-ID: <20191225113932.GD18098@zn.tnic>
References: <20191211161713.4490-2-mathieu.desnoyers@efficios.com>
 <157727033331.30329.17206832903007175600.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <157727033331.30329.17206832903007175600.tip-bot2@tip-bot2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 25, 2019 at 10:38:53AM -0000, tip-bot2 for Mathieu Desnoyers wrote:
> The following commit has been merged into the core/urgent branch of tip:
> 
> Commit-ID:     66528a4575eee9f5a5270219894ab6178f146e84
> Gitweb:        https://git.kernel.org/tip/66528a4575eee9f5a5270219894ab6178f146e84
> Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> AuthorDate:    Wed, 11 Dec 2019 11:17:11 -05:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Wed, 25 Dec 2019 10:41:20 +01:00
> 
> rseq: Reject unknown flags on rseq unregister
> 
> It is preferrable to reject unknown flags within rseq unregistration
> rather than to ignore them. It is an oversight caused by the fact that
> the check for unknown flags is after the rseq unregister flag check.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lkml.kernel.org/r/20191211161713.4490-2-mathieu.desnoyers@efficios.com
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  kernel/rseq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/rseq.c b/kernel/rseq.c
> index 27c48eb..a4f86a9 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -310,6 +310,8 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
>  	int ret;
>  
>  	if (flags & RSEQ_FLAG_UNREGISTER) {
> +		if (flags & ~RSEQ_FLAG_UNREGISTER)
> +			return -EINVAL;
>  		/* Unregister rseq for current thread. */
>  		if (current->rseq != rseq || !current->rseq)
>  			return -EINVAL;

Cc: stable perhaps?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
