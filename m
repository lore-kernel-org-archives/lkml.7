Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CB6C31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 16:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B59020870
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 16:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfFPQFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 12:05:36 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41899 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfFPQFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 12:05:36 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hcXem-000248-Aj; Sun, 16 Jun 2019 18:05:24 +0200
Date:   Sun, 16 Jun 2019 18:05:23 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v7 18/18] x86/fsgsbase/64: Add documentation for
 FSGSBASE
In-Reply-To: <62430B9C-95B6-4EB3-94FA-C16A02B9BD7C@intel.com>
Message-ID: <alpine.DEB.2.21.1906161804570.1760@nanos.tec.linutronix.de>
References: <1557309753-24073-1-git-send-email-chang.seok.bae@intel.com> <1557309753-24073-19-git-send-email-chang.seok.bae@intel.com> <alpine.DEB.2.21.1906132246310.1791@nanos.tec.linutronix.de> <EEACF240-4772-417A-B516-95D9003D0D11@intel.com>
 <89BE934A-A392-4CED-83E5-CA4FADDAE6DF@intel.com> <alpine.DEB.2.21.1906161038160.1760@nanos.tec.linutronix.de> <alpine.DEB.2.21.1906161433390.1760@nanos.tec.linutronix.de> <62430B9C-95B6-4EB3-94FA-C16A02B9BD7C@intel.com>
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

On Sun, 16 Jun 2019, Bae, Chang Seok wrote:

> 
> > On Jun 16, 2019, at 05:34, Thomas Gleixner <tglx@linutronix.de> wrote:
> > 
> > On Sun, 16 Jun 2019, Thomas Gleixner wrote:
> >> 
> >> Please dont. Send me a delta patch against the documentation. I have queued
> >> all the other patches already internally. I did not push it out because I
> >> wanted to have proper docs.
> > 
> > Fixed it up already. About to push it out.
> > 
> 
> Thanks. This is the diff though.
> 
> diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
> index 22992c8377952..f667087792747 100644
> --- a/arch/x86/include/asm/preempt.h
> +++ b/arch/x86/include/asm/preempt.h
> @@ -118,7 +118,7 @@ static __always_inline bool should_resched(int preempt_offset)
>  
>  	/* preempt count == 0 ? */
>  	tmp &= ~PREEMPT_NEED_RESCHED;
> -	if (tmp)
> +	if (tmp != preempt_offset)
>  		return false;
>  	if (current_thread_info()->preempt_lazy_count)
>  		return false;
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index c15583162a559..25bcf2f2714ba 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -92,6 +92,34 @@ static inline void softirq_clr_runner(unsigned int sirq)
>  	sr->runner[sirq] = NULL;
>  }
>  
> +static bool softirq_check_runner_tsk(struct task_struct *tsk,
> +				     unsigned int *pending)

WHAT? How is this related ?

