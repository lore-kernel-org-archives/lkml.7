Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF058C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6AF20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfHSKlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 06:41:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46798 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfHSKlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 06:41:36 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzf6Q-0001NF-7j; Mon, 19 Aug 2019 12:41:30 +0200
Date:   Mon, 19 Aug 2019 12:41:29 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Heiner Kallweit <hkallweit1@gmail.com>
cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] x86/irq: factor out IS_ERR_OR_NULL check from
 platfom-specific handle_irq
In-Reply-To: <e9b4d21d-d9eb-51c5-871e-87e3b69d01ec@gmail.com>
Message-ID: <alpine.DEB.2.21.1908191236540.1923@nanos.tec.linutronix.de>
References: <c9b51ac3-b1d6-89a6-e323-4600af22d9de@gmail.com> <e9b4d21d-d9eb-51c5-871e-87e3b69d01ec@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Aug 2019, Heiner Kallweit wrote:
> -
> -	if (!handle_irq(desc, regs)) {
> +	if (IS_ERR_OR_NULL(desc)) {

This really want's an unlikely or preferrably be written as:

	if (likely(!IS_ERR_OR_NULL(desc))) {
		handle_irq(desc);
	} else {

>  		ack_APIC_irq();
>  
>  		if (desc != VECTOR_RETRIGGERED && desc != VECTOR_SHUTDOWN) {
> @@ -254,6 +253,8 @@ __visible unsigned int __irq_entry do_IRQ(struct pt_regs *regs)
>  		} else {
>  			__this_cpu_write(vector_irq[vector], VECTOR_UNUSED);
>  		}
> +	} else {
> +		handle_irq(desc, regs);
>  	}
>  
> diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
> index 6bf6517a0..cd4595b71 100644
> --- a/arch/x86/kernel/irq_64.c
> +++ b/arch/x86/kernel/irq_64.c
> @@ -26,13 +26,9 @@
>  DEFINE_PER_CPU_PAGE_ALIGNED(struct irq_stack, irq_stack_backing_store) __visible;
>  DECLARE_INIT_PER_CPU(irq_stack_backing_store);
>  
> -bool handle_irq(struct irq_desc *desc, struct pt_regs *regs)
> +void handle_irq(struct irq_desc *desc, struct pt_regs *regs)
>  {
> -	if (IS_ERR_OR_NULL(desc))
> -		return false;
> -
>  	generic_handle_irq_desc(desc);

With that the function call does not make any sense for 64bit. So the
wrapper should be an inline and only for 32bit a function call.

Thanks,

	tglx
