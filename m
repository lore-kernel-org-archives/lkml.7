Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B382DC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3932064A
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfH1Mqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 08:46:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47009 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfH1Mqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 08:46:55 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i2xLe-0003Fv-Fd; Wed, 28 Aug 2019 14:46:50 +0200
Date:   Wed, 28 Aug 2019 14:46:50 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Neil Horman <nhorman@tuxdriver.com>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org, djuran@redhat.com,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH V2] x86: Add irq spillover warning
In-Reply-To: <20190822143421.9535-1-nhorman@tuxdriver.com>
Message-ID: <alpine.DEB.2.21.1908281337280.1869@nanos.tec.linutronix.de>
References: <20190822143421.9535-1-nhorman@tuxdriver.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil,

On Thu, 22 Aug 2019, Neil Horman wrote:

Just a few nits.

> On Intel hardware, cpus are limited in the number of irqs they can
> have affined to them (currently 240), based on section 10.5.2 of:
> https://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-software-developer-vol-3a-part-1-manual.pdf
>

Please do not add links to URLs which are not reliable and sections which
have a different number in the next version of the document. Just cite the
3 relevant lines or transcribe them.

Aside of that the above is not really accurate:

1) This is not restricted to Intel. All x86 CPUs of all vendors behave
   that way.

2) CPUs have a vector space of 256. CPUs reserve 32 vectors (0..31). That
   leaves 224. The kernel reserves another 22 vectors for various purposes.

   That leaves 202 vectors for assignment to devices and that's what this
   is about.

> assign_irq_vector_any_locked() will attempt to honor the affining
> request, but if the 240 vector limitation documented above is crossed, a

that means the vector space is exhausted.

> new mask will be selected that is potentially outside the requested cpu

It's not potentially outside. The point is that the requested affinity mask
has no vectors left, so it falls back to a wider cpumask and is guaranteed
to select a CPU which is not in the requested affinity mask.

> set silently.  This can lead to unexpected behavior for administrators.
> 
> Mitigate this problem by checking the affinity mask after its been
> assigned in activate_reserved so that adminstrators get a logged warning
> about the change.

Please do not describe implementation details which can be seen from the
patch itself.
 
> Tested successfully by the reporter

We have a 'Tested-by:' tag for this
 
> Change Notes:
> V1->V2)
> 	* Moved the check for this condition to activate_reserved from
> do_IRQ, taking it out of the hot path (request by tglx@lintronix.de)

Please put change notes (and thanks for providing them) below the '---'
discard line. They are not part of the final changelog in git. They are
informative for the reviewers, but if in the changelog it's manual work to
remove them while the discard section goes away automatically.

> +
> +	/*
> +	 * Check to ensure that the effective affinity mask is a subset
> +	 * the user supplied affinity mask, and warn the user if it is not
> +	 */
> +	if (!cpumask_subset(irq_data_get_effective_affinity_mask(irqd),
> +	     irq_data_get_affinity_mask(irqd)))
> +		pr_warn("irq %d has been assigned to a cpu outside of its user affinity mask\n",

s/%d/%u/  irqd->irq is unsigned int.

So you tell what, but no hint about the why. That should be:

   "irq %u: Affinity broken due to vector space exhaustion.\n"

That actually tells that it happened and gives the administrator
information why. So he knows that he tried to assign too many interrupts to
a set of CPUs.

> +			irqd->irq);

This is a multiline statement and wants brackets around it.

> +
>  	return ret;

I fixed that all up while applying, so no need to resend.

Thanks,

	tglx
