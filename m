Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D43C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2535720700
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732811AbfCZVDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 17:03:12 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49374 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbfCZVDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 17:03:10 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8tDq-0006HU-RS; Tue, 26 Mar 2019 22:03:03 +0100
Date:   Tue, 26 Mar 2019 22:03:02 +0100 (CET)
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
        Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH v2 03/14] x86/hpet: Calculate ticks-per-second in a
 separate function
In-Reply-To: <1551283518-18922-4-git-send-email-ricardo.neri-calderon@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1903262201140.1789@nanos.tec.linutronix.de>
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com> <1551283518-18922-4-git-send-email-ricardo.neri-calderon@linux.intel.com>
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
>  int hpet_alloc(struct hpet_data *hdp)
>  {
>  	u64 cap, mcfg;
> @@ -845,7 +868,6 @@ int hpet_alloc(struct hpet_data *hdp)
>  	size_t siz;
>  	struct hpet __iomem *hpet;
>  	static struct hpets *last;
> -	unsigned long period;
>  	unsigned long long temp;
>  	u32 remainder;
>  
> @@ -881,6 +903,8 @@ int hpet_alloc(struct hpet_data *hdp)
>  
>  	cap = readq(&hpet->hpet_cap);
>  
> +	temp = hpet_get_ticks_per_sec(cap);

Just putting stuff to random places does not make the code any better.

>  	ntimer = ((cap & HPET_NUM_TIM_CAP_MASK) >> HPET_NUM_TIM_CAP_SHIFT) + 1;
>  
>  	if (hpetp->hp_ntimer != ntimer) {
> @@ -897,11 +921,6 @@ int hpet_alloc(struct hpet_data *hdp)
>  
>  	last = hpetp;
>  
> -	period = (cap & HPET_COUNTER_CLK_PERIOD_MASK) >>
> -		HPET_COUNTER_CLK_PERIOD_SHIFT; /* fs, 10^-15 */
> -	temp = 1000000000000000uLL; /* 10^15 femtoseconds per second */
> -	temp += period >> 1; /* round */
> -	do_div(temp, period);
>  	hpetp->hp_tick_freq = temp; /* ticks per second */

What's wrong with the obvious:

       hpetp->hp_tick_freq = hpet_get_ticks_per_sec(cap);

Hmm?

Thanks,

	tglx
