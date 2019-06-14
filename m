Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6765DC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BB22177E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfFNSRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 14:17:40 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39150 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFNSRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:17:38 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hbqlM-0006Wc-Mn; Fri, 14 Jun 2019 20:17:20 +0200
Date:   Fri, 14 Jun 2019 20:17:14 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH v4 04/21] x86/hpet: Add hpet_set_comparator() for
 periodic and one-shot modes
In-Reply-To: <1558660583-28561-5-git-send-email-ricardo.neri-calderon@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1906142010230.1760@nanos.tec.linutronix.de>
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com> <1558660583-28561-5-git-send-email-ricardo.neri-calderon@linux.intel.com>
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

On Thu, 23 May 2019, Ricardo Neri wrote:
> +/**
> + * hpet_set_comparator() - Helper function for setting comparator register
> + * @num:	The timer ID
> + * @cmp:	The value to be written to the comparator/accumulator
> + * @period:	The value to be written to the period (0 = oneshot mode)
> + *
> + * Helper function for updating comparator, accumulator and period values.
> + *
> + * In periodic mode, HPET needs HPET_TN_SETVAL to be set before writing
> + * to the Tn_CMP to update the accumulator. Then, HPET needs a second
> + * write (with HPET_TN_SETVAL cleared) to Tn_CMP to set the period.
> + * The HPET_TN_SETVAL bit is automatically cleared after the first write.
> + *
> + * For one-shot mode, HPET_TN_SETVAL does not need to be set.
> + *
> + * See the following documents:
> + *   - Intel IA-PC HPET (High Precision Event Timers) Specification
> + *   - AMD-8111 HyperTransport I/O Hub Data Sheet, Publication # 24674
> + */
> +void hpet_set_comparator(int num, unsigned int cmp, unsigned int period)
> +{
> +	if (period) {
> +		unsigned int v = hpet_readl(HPET_Tn_CFG(num));
> +
> +		hpet_writel(v | HPET_TN_SETVAL, HPET_Tn_CFG(num));
> +	}
> +
> +	hpet_writel(cmp, HPET_Tn_CMP(num));
> +
> +	if (!period)
> +		return;

TBH, I hate this conditional handling. What's wrong with two functions?

> +
> +	/*
> +	 * This delay is seldom used: never in one-shot mode and in periodic
> +	 * only when reprogramming the timer.
> +	 */
> +	udelay(1);
> +	hpet_writel(period, HPET_Tn_CMP(num));
> +}
> +EXPORT_SYMBOL_GPL(hpet_set_comparator);

Why is this exported? Which module user needs this?

Thanks,

	tglx
