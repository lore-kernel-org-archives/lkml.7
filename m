Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202D0C10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E052A207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbfCYXkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 19:40:40 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47100 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfCYXkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 19:40:40 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8ZCk-0001Ad-Jc; Tue, 26 Mar 2019 00:40:34 +0100
Date:   Tue, 26 Mar 2019 00:40:34 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Matthew Garrett <matthewgarrett@google.com>
cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org
Subject: Re: [PATCH 12/27] x86/msr: Restrict MSR access when the kernel is
 locked down
In-Reply-To: <20190325220954.29054-13-matthewgarrett@google.com>
Message-ID: <alpine.DEB.2.21.1903260003040.1789@nanos.tec.linutronix.de>
References: <20190325220954.29054-1-matthewgarrett@google.com> <20190325220954.29054-13-matthewgarrett@google.com>
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

Matthew,

On Mon, 25 Mar 2019, Matthew Garrett wrote:

> From: Matthew Garrett <mjg59@srcf.ucam.org>
> 
> Writing to MSRs should not be allowed if the kernel is locked down, since
> it could lead to execution of arbitrary code in kernel mode.  Based on a
> patch by Kees Cook.
> 
> MSR accesses are logged for the purposes of building up a whitelist as per
> Alan Cox's suggestion.
> 
> Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Acked-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

I'm pretty sure, that I reviewed a different version of this, but due to
the lack of:

 1) A version indicator in the subject line, i.e. [PATCH v7 12/27]

 2) A simple change indicator after the --- separator, e.g.

    v6 -> v7: Add MRS logging to dmesg .....

It's tedious to figure out what actually changed here. I just know for sure
that the printk wasn't there before.

It's not a huge effort adding such information, but it's very helpful for
those who are supposed to look at your patches. Those people are drowned in
patches so making it as easy as it goes would be very appreciated.

> +++ b/arch/x86/kernel/msr.c
> @@ -84,6 +84,11 @@ static ssize_t msr_write(struct file *file, const char __user *buf,
>  	int err = 0;
>  	ssize_t bytes = 0;
>  
> +	if (kernel_is_locked_down("Direct MSR access")) {
> +		pr_info("Direct access to MSR %x\n", reg);

I'm really not fond of this at all. /dev/msr should simply die.

Maintaining a whitelist for this is a horrible idea as you will get a
gazillion of excuses why access to a particular MSR is sane. And I'm
neither interested in these discussions nor interested in adding the
whitelist to this trainwreck,

The right thing to do is to provide sane interfaces and that's where we are
moving to. So simply blocking the access with locked down mode might be
very helpful to accelerate that.

Thanks,

	tglx


