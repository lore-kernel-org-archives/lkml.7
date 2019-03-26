Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBE8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD0620700
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732716AbfCZVAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 17:00:30 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49360 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbfCZVA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 17:00:29 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8tBI-0006Ay-RT; Tue, 26 Mar 2019 22:00:25 +0100
Date:   Tue, 26 Mar 2019 22:00:24 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH v2 02/14] x86/hpet: Expose more functions to read
 and write registers
In-Reply-To: <1551283518-18922-3-git-send-email-ricardo.neri-calderon@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1903262156070.1789@nanos.tec.linutronix.de>
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com> <1551283518-18922-3-git-send-email-ricardo.neri-calderon@linux.intel.com>
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

On Wed, 27 Feb 2019, Ricardo Neri wrote:
>  struct irq_data;
> @@ -109,6 +114,11 @@ extern void hpet_unregister_irq_handler(rtc_irq_handler handler);
>  static inline int hpet_enable(void) { return 0; }
>  static inline int is_hpet_enabled(void) { return 0; }
>  #define hpet_readl(a) 0
> +#define hpet_writel(d, a)

What for?

> +#ifdef CONFIG_X86_64
> +#define hpet_readq(a) 0
> +#define hpet_writeq(d, a)
> +#endif

Ditto.

There are no users outside of HPET and your new HPET watchdog code for
those. And both are not compiled when CONFIG_HPET=n.

The only reason to have the hpet_readl() define, which btw. should be an
inline, is to avoid massive ifdeffery in the TSC calibration code.

Thanks,

	tglx
