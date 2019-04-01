Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB69C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E174020880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="laHYie1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbfDASDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:03:31 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59198 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730002AbfDASD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:03:27 -0400
Received: from zn.tnic (p200300EC2F148A00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 92B991EC0669;
        Mon,  1 Apr 2019 20:03:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554141805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=S5WyqxgBrRQQRZEH27Xmbh+w+LW4QU1L3IU4n9f/qXo=;
        b=laHYie1SobobPInYVeUFQTOjSjHxMkSero/qU4oQfyNEm+sjz59kXD3hWXnmRWUhsWm6sQ
        tB485mO0ifDKQPsXOZHt+Bf4PN6ORX/rSV6IX6CPFHKyjM+iY7yVnRYzjl+BcDeSDQzE6i
        89JdMt+bs+rwMsAdSnaa9O73oAk/77k=
Date:   Mon, 1 Apr 2019 20:03:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mitsuo Hayasaka <mitsuo.hayasaka.hu@hitachi.com>
Subject: Re: [patch 01/14] x86/irq/64: Limit IST stack overflow check to #DB
 stack
Message-ID: <20190401175549.GL28264@zn.tnic>
References: <20190331214020.836098943@linutronix.de>
 <20190331215134.837052834@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190331215134.837052834@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 11:40:21PM +0200, Thomas Gleixner wrote:
> 37fe6a42b343 ("x86: Check stack overflow in detail") added a broad check
> for the full exception stack area, i.e. it considers the full exception
> stack are as valid.
> 
> That's wrong in two aspects:
> 
>  1) It does not check the individual areas one by one
> 
>  2) #DF, NMI and #MCE are not enabling interrupts which means that a
>     regular device interrupt cannot happen in their context. In fact if a
>     device interrupt hits one of those IST stacks that's a bug because some
>     code path enabled interrupts while handling the exception.
> 
> Limit the check to the #DB stack and consider all other IST stacks as
> 'overflow' or invalid.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mitsuo Hayasaka <mitsuo.hayasaka.hu@hitachi.com>
> ---
>  arch/x86/kernel/irq_64.c |   19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> --- a/arch/x86/kernel/irq_64.c
> +++ b/arch/x86/kernel/irq_64.c
> @@ -26,9 +26,18 @@ int sysctl_panic_on_stackoverflow;
>  /*
>   * Probabilistic stack overflow check:
>   *
> - * Only check the stack in process context, because everything else
> - * runs on the big interrupt stacks. Checking reliably is too expensive,
> - * so we just check from interrupts.
> + * Regular device interrupts can enter on the following stacks:
> + *
> + * - User stack
> + *
> + * - Kernel task stack
> + *
> + * - Interrupt stack if a device driver reenables interrupt

						     "interrupts"

> + *   which should only happen in really old drivers.
> + *
> + * - Debug IST stack
> + *
> + * All other contexts are invalid.

<---

I could use the above blurb here too, explaining why we're checking the
#DB stack only.

Otherwise:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
