Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D558EC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9199208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564577861;
	bh=okXF5i5vaeExDoO318U4IQz1NUTULDtYpMjX5VybXa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jwlqFFDMmFAY+94TXRylcSXBhNAwMihYOGR7bUIpj4HGfoR+FmM9/PgQan8Y2U2SZ
	 2aPgOiJRtdFzjufPkX2yetYmQbGtjAUWQkLnI1R6Ayo+p+Px6k6s8Uzk1gp11k1poP
	 jRyy+bu8JwHdCPkNzu9odvlY83NrGByuajoPOvHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbfGaM5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:57:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:41834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726786AbfGaM5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:57:40 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34DE2206B8;
        Wed, 31 Jul 2019 12:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564577859;
        bh=okXF5i5vaeExDoO318U4IQz1NUTULDtYpMjX5VybXa8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0gNz/z2N2FVKJSq5nKsfxQ6jkM5bXwbk5ejbg/oueGFf+66HxtP1VObGp+PPHvXcT
         FCqoVb+UTvs3fMs+tQ9QtSOVfexkt+fZ9rSzwg53vqD9CtvotI1ILU8g0mcNCNOeBK
         w8h++X9My6pAOdZdbUIMywBPN0q2a84InCI2zQ6U=
Date:   Wed, 31 Jul 2019 13:57:33 +0100
From:   Will Deacon <will@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: debug: Make 'btc' and similar work in kdb
Message-ID: <20190731125733.op3y5j5psuj6pet3@willie-the-truck>
References: <20190730221800.28326-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730221800.28326-1-dianders@chromium.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On Tue, Jul 30, 2019 at 03:18:00PM -0700, Douglas Anderson wrote:
> diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
> index 43119922341f..b666210fbc75 100644
> --- a/arch/arm64/kernel/kgdb.c
> +++ b/arch/arm64/kernel/kgdb.c
> @@ -148,6 +148,45 @@ sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *task)
>  	gdb_regs[32] = cpu_context->pc;
>  }
>  
> +void kgdb_call_nmi_hook(void *ignored)
> +{
> +	struct pt_regs *regs;
> +
> +	/*
> +	 * NOTE: get_irq_regs() is supposed to get the registers from
> +	 * before the IPI interrupt happened and so is supposed to
> +	 * show where the processor was.  In some situations it's
> +	 * possible we might be called without an IPI, so it might be
> +	 * safer to figure out how to make kgdb_breakpoint() work
> +	 * properly here.
> +	 */
> +	regs = get_irq_regs();
> +
> +	/*
> +	 * Some commands (like 'btc') assume that they can find info about
> +	 * a task in the 'cpu_context'.  Unfortunately that's only valid
> +	 * for sleeping tasks.  ...but let's make it work anyway by just
> +	 * writing the registers to the right place.  This is safe because
> +	 * nobody else is using the 'cpu_context' for a running task.
> +	 */
> +	current->thread.cpu_context.x19 = regs->regs[19];
> +	current->thread.cpu_context.x20 = regs->regs[20];
> +	current->thread.cpu_context.x21 = regs->regs[21];
> +	current->thread.cpu_context.x22 = regs->regs[22];
> +	current->thread.cpu_context.x23 = regs->regs[23];
> +	current->thread.cpu_context.x24 = regs->regs[24];
> +	current->thread.cpu_context.x25 = regs->regs[25];
> +	current->thread.cpu_context.x26 = regs->regs[26];
> +	current->thread.cpu_context.x27 = regs->regs[27];
> +	current->thread.cpu_context.x28 = regs->regs[28];
> +	current->thread.cpu_context.fp = regs->regs[29];
> +
> +	current->thread.cpu_context.sp = regs->sp;
> +	current->thread.cpu_context.pc = regs->pc;
> +
> +	kgdb_nmicallback(raw_smp_processor_id(), regs);
> +}

This is really gross... :/

Can you IPI the other CPUs instead and have them backtrace locally, like we
do for things like magic sysrq (sysrq_handle_showallcpus())?

Will
