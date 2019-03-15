Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF230C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC4E21872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zMzMMCnc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbfCOIlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 04:41:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38314 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfCOIlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 04:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FINscIAgJF9qwsD0YBTp7g9zpsKfnzD3Jj21mHq3qok=; b=zMzMMCncXryV2IMrnPAnAqakF
        7ZPae5U0x8/fEC8vt9WNaCkwvuOyRx+RbHIJPGdY3uqz2pBVFAJwPH22qyLxPD8X0N/g5fjhNl/K3
        S3Mdhm2ks+m2/PvxmQ31gQAkFB0FSB/mFJ5iZ56rXqm+lUA53YDjWC8ItGB5z/mTztGkdjp6zk41c
        VmjQMlIoN3WVDaoBICe5aRGePOsmtwMAexlV1X5O/hPmfcsOlJ2klnYhIfbhzcp3gModpokYu66vk
        wP88I01xdeluW37LUKmgQPvRoORUk2hoQln+VBxfyyJy/ItrLkGmDdK1QnjXfZQ0SCGibK9g1PRjW
        YV0VX2HYA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4iPF-0004HM-43; Fri, 15 Mar 2019 08:41:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9481621419E59; Fri, 15 Mar 2019 09:41:31 +0100 (CET)
Date:   Fri, 15 Mar 2019 09:41:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     chenjie6@huawei.com
Cc:     linux-kernel@vger.kernel.org, dvhart@infradead.org,
        mingo@redhat.com, tglx@linutronix.de, zengweilin@huawei.com
Subject: Re: [PATCH] futex:fix robust futex alignment exception
Message-ID: <20190315084131.GS5996@hirez.programming.kicks-ass.net>
References: <1552621478-119787-1-git-send-email-chenjie6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552621478-119787-1-git-send-email-chenjie6@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 03:44:38AM +0000, chenjie6@huawei.com wrote:
> From: chen jie <chenjie6@huawei.com>

> [11542.215247] [<c017b1d4>] (cmpxchg_futex_value_locked) from [<c017da50>] (handle_futex_death+0x78/0xcc)
> [11542.215259] [<c017da50>] (handle_futex_death) from [<c017dba8>] (exit_robust_list+0x104/0x160)
> [11542.215273] [<c017dba8>] (exit_robust_list) from [<c011b40c>] (mm_release+0x1c/0x108)
> [11542.215287] [<c011b40c>] (mm_release) from [<c011f9a4>] (do_exit+0x218/0x9a4)
> [11542.215299] [<c011f9a4>] (do_exit) from [<c0120250>] (do_group_exit+0xac/0xf4)
> [11542.215311] [<c0120250>] (do_group_exit) from [<c01202a8>] (__wake_up_parent+0x0/0x18)

> Signed-off-by: chen jie <chenjie6@huawei.com>

Reviewed-by: Peter Zijlstra (Intel) <peterz@infradead.org>

However, should there not also be alignment tests on set_robust_list()?

Also; do_futex() should probably check uaddr and uaddr2.

That is; why aren't there any alignment tests anywhere? Or am I just
gone blind?

> ---
>  kernel/futex.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/futex.c b/kernel/futex.c
> index a0514e0..70231c4 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -3440,6 +3440,9 @@ static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr, int p
>  {
>  	u32 uval, uninitialized_var(nval), mval;
>  
> +	if (((unsigned long)uaddr & 0x3) > 0)
> +		return -1;
> +
>  retry:
>  	if (get_user(uval, uaddr))
>  		return -1;
> -- 
> 1.8.3.4
> 
