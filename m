Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A844CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E84D206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571647772;
	bh=NpXG/RiXMN6GZ7FeOc3UodXKrK/4C1mQCqvDI2cyuRw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jSF3mQI3Q2OAAZa584dW30iRs0q2V7y//dZZgp2kLnlSBEfOg+UNTnUiPlXQll6DK
	 og6OjMQpv947RCapJRw+Q6AEwFHO/NitwnK1mhl1xUf7eBBA4R7V0lguY/tAPWKCay
	 xoXrTJIVhAxT838my2qs6hZSZTMRGK3polT8Uz3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfJUItb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 04:49:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfJUItb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 04:49:31 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F211B2067B;
        Mon, 21 Oct 2019 08:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571647770;
        bh=NpXG/RiXMN6GZ7FeOc3UodXKrK/4C1mQCqvDI2cyuRw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2YwstC6/R6V+ozb8ttKQ5pdLT6a8CCR5fBFZtFjcfitB5J54BBKA5xlw3SrR1Xb8t
         f9+8MUX5OTUh0gh6ZhOVim64ZQhn69t8klw0/XFT1PdMXhHHjwaQWMM7eGQfHlk/By
         0vudsqwDHQDFj0oh8OSXkDgiK+TqJ+w9Y8sXGHcU=
Date:   Mon, 21 Oct 2019 17:49:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     will@kernel.org, catalin.marinas@arm.com, mhiramat@kernel.org,
        james.morse@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: kprobes: Drop open-coded exception fixup
Message-Id: <20191021174926.10992282af1c36d721a6747d@kernel.org>
In-Reply-To: <e70f7b9de7e601b9e4a6fedad8eaf64d304b1637.1571326276.git.robin.murphy@arm.com>
References: <e70f7b9de7e601b9e4a6fedad8eaf64d304b1637.1571326276.git.robin.murphy@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Thu, 17 Oct 2019 16:31:42 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> The short-circuit call to fixup_exception() from kprobe_fault_handler()
> poses a problem now that the former wants to consume the fault address
> too, since the common kprobes API offers us no way to pass it through.
> Fortunately, however, it works out to be unnecessary:

Thank you for pointing it out!

> 
> - uaccess instructions themselves are not probeable, so at most we
>   should only ever expect to take a fixable fault from the pre or post
>   handlers.

Right. If it is not fixable, we should handle it as a kernel bug.
(to avoid it we can use probe_kernel_read() in kprobe handler)

> - the pre and post handler run with preemption disabled, thus for any
>   fault they may cause, an unhandled return from kprobe_page_fault()
>   will proceed directly to __do_kernel_fault() thanks to the
>   faulthandler_disabled() check.

OK, this is reasonable.

> - __do_kernel_fault() will immediately call fixup_exception() unless
>   we're in an EL1 instruction abort, and if we've somehow taken one of
>   those on what we think is the middle of a uaccess routine, then the
>   world is already very on fire.

OK, this looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> Thus we can reasonably drop the call from kprobe_fault_handler() and
> leave uaccess fixups to the regular flow.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  arch/arm64/kernel/probes/kprobes.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index c4452827419b..422fbd5c6c55 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -334,13 +334,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
>  		 */
>  		if (cur->fault_handler && cur->fault_handler(cur, regs, fsr))
>  			return 1;
> -
> -		/*
> -		 * In case the user-specified fault handler returned
> -		 * zero, try to fix up.
> -		 */
> -		if (fixup_exception(regs))
> -			return 1;
>  	}
>  	return 0;
>  }
> -- 
> 2.21.0.dirty
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
