Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191F0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D501E2086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rl2q3rns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfDAKsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:48:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38022 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDAKsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=H5dr0GGoJJsBhUrOqq0GjKEE5KuhA7ttsgAnFiV86UQ=; b=rl2q3rnsJk6vG6Kv6E1uB+MYb
        8uc7b8CDr66KVAwnNks3oOuabeInbrn6anFwV5cbA4ojubXneqWU7q+34a/tx4vH0tQXRSlBeEpgi
        QdGnOxp212Jz0tc5Bkk24Y9sFajFMSP0uScEG/Ti0tbGH7t7mcIfT0i3osPTuCkkDAg7q+DX0mLE6
        e7Wn0AQ5FFt1bYOWP71DA4jnTqm6FNDh/VQb76fx1p7z+0k0KvAf8sdlNnEoMZ/bfQ0PoQHeFP9uS
        c5XrUwSj/24odbB7WmvkdDIDVUJoElODeI8oiGOFywUee94uj1g8vpBikYog46tBEnosWTc4ljc+M
        /GiUXN63Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hAuTv-0008Kh-JO; Mon, 01 Apr 2019 10:47:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D2EC3203CBE11; Mon,  1 Apr 2019 12:47:56 +0200 (CEST)
Date:   Mon, 1 Apr 2019 12:47:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH] i2c: remove use of in_atomic()
Message-ID: <20190401104756.GK11158@hirez.programming.kicks-ass.net>
References: <20190327211256.17232-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327211256.17232-1-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 10:12:56PM +0100, Wolfram Sang wrote:
> Commit cea443a81c9c ("i2c: Support i2c_transfer in atomic contexts")
> added in_atomic() to the I2C core. However, the use of in_atomic()
> outside of core kernel code is discouraged and was already[1] when this
> code was added in early 2008. The above commit was a preparation for
> b7a3670131c7 ("i2c-pxa: Add polling transfer"). Its commit message says
> explicitly it was added "for cases where I2C transactions have to occur
> at times interrups are disabled". So, the intention was 'disabled
> interrupts'. This matches the use cases for atomic I2C transfers I have
> seen so far: very late communication (mostly to a PMIC) to powerdown or
> reboot the system. For those cases, interrupts are disabled then. It
> doesn't seem that in_atomic() adds value.
> 
> Note that only ~10 out of ~120 bus master drivers support atomic
> transfers, mostly by polling always when no irq is supplied. A generic
> I2C client driver cannot assume support for atomic transfers. This is
> currently a platform-dependent corner case.
> 
> The I2C core will soon gain an extra callback into bus drivers
> especially for atomic transfers to make them more generic. The code
> deciding which transfer to use (atomic/non-atomic) should mimic the
> behaviour which locking to use (trylock/lock). Because I don't want to
> add more in_atomic() to the I2C core, this patch simply removes it.
> 
> [1] https://lwn.net/Articles/274695/
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> So, I had to dive into this in_atomic() topic and this is what I
> concluded. I don't see any reasonable constellation where this could
> cause a regression, but I am all open for missing something and being
> pointed to it. This is why the patch is RFC. I'd really welcome
> comments. Thanks!
> 
> 
>  drivers/i2c/i2c-core-base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 38af18645133..943bebeec3ed 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -1946,7 +1946,7 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>  	 *    one (discarding status on the second message) or errno
>  	 *    (discarding status on the first one).
>  	 */
> -	if (in_atomic() || irqs_disabled()) {
> +	if (irqs_disabled()) {
>  		ret = i2c_trylock_bus(adap, I2C_LOCK_SEGMENT);
>  		if (!ret)
>  			/* I2C activity is ongoing. */

So I know absolutely nothing about i2c, except that it is supposedly
fsck all slow.

In that context, busy-spinning for i2c completions seems like a terrible
idea, _esp_ in atomic contexts.

I did a quick grep for trylock_bus() and found i2c_mux_trylock_bus()
which uses rt_mutex_trylock and therefore the calling context must
already exclude IRQs and NMIs and the like.

That leaves task context with preemption/IRQs disabled. Of that, you
retain the IRQs disabled test, which is by far the worst possible
condition to spin-wait in.

Why must we allow i2c usage with IRQs disabled? Just say NO?
