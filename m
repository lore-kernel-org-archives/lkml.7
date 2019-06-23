Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9223C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 03:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B268A208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 03:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfFXDBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 23:01:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34569 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbfFXDBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 23:01:47 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfB8b-0007OX-Ve; Mon, 24 Jun 2019 00:39:06 +0200
Date:   Mon, 24 Jun 2019 00:39:05 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v5 2/5] x86/umwait: Initialize umwait control values
In-Reply-To: <1560994438-235698-3-git-send-email-fenghua.yu@intel.com>
Message-ID: <alpine.DEB.2.21.1906232038421.32342@nanos.tec.linutronix.de>
References: <1560994438-235698-1-git-send-email-fenghua.yu@intel.com> <1560994438-235698-3-git-send-email-fenghua.yu@intel.com>
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

On Wed, 19 Jun 2019, Fenghua Yu wrote:
>  
> +#define MSR_IA32_UMWAIT_CONTROL			0xe1
> +#define MSR_IA32_UMWAIT_CONTROL_C02_DISABLED	BIT(0)
> +#define MSR_IA32_UMWAIT_CONTROL_MAX_TIME	0xfffffffc

Errm, no! That's not maxtime, that's the time field mask in the
MSR. Throughout the code you use that as a mask, which is not really
obvious.

> +	(((max_time) & MSR_IA32_UMWAIT_CONTROL_MAX_TIME) |		\

and later on:

	if (max_time & ~MSR_IA32_UMWAIT_CONTROL_MAX_TIME)

What? How is anyone supposed to understand that?

	if (max_time & ~MSR_IA32_UMWAIT_CONTROL_TIME_MASK)

makes it entirely clear that the value is not allowed to have any bits
outside of the mask set.

> +
> +#define UMWAIT_C02_ENABLED	(0 & MSR_IA32_UMWAIT_CONTROL_C02_DISABLED)

The AND is there for maximal confusion of the reader?

> +/*
> + * On resume, set up IA32_UMWAIT_CONTROL MSR on BP which is the only active
> + * CPU at this time. Setting up the MSR on APs when they are re-added later
> + * using CPU hotplug.
> + * The MSR on BP is supposed not to be changed during suspend and thus it's
> + * unnecessary to set it again during resume from suspend. But at this point
> + * we don't know resume is from suspend or hibernation. To simplify the
> + * situation, just set up the MSR on resume from suspend.

We also do not trust any firmware by default whatever it is supposed to do.

Thanks,

	tglx
