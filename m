Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AA1C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1743820883
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfE1SBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 14:01:53 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51527 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfE1SBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 14:01:52 -0400
Received: from 50-233-100-202-static.hfc.comcastbusiness.net ([50.233.100.202] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hVgQ0-0004i9-OO; Tue, 28 May 2019 20:01:49 +0200
Date:   Tue, 28 May 2019 11:01:38 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jason Vas Dias <jason.vas.dias@gmail.com>
Subject: Re: [PATCH] x86/vdso: implement clock_gettime(CLOCK_MONOTONIC_RAW,
 ...)
In-Reply-To: <20190528080034.31259-1-alexander.sverdlin@nokia.com>
Message-ID: <alpine.DEB.2.21.1905281055240.1859@nanos.tec.linutronix.de>
References: <20190528080034.31259-1-alexander.sverdlin@nokia.com>
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

Alexander,

On Tue, 28 May 2019, Sverdlin, Alexander (Nokia - DE/Ulm) wrote:
> Add CLOCK_MONOTONIC_RAW to the existing clock_gettime() vDSO
> implementation. This is based on the ideas of Jason Vas Dias and comments
> of Thomas Gleixner.

Well to some extent, but

> The results from the above test program:
> 
> Clock			Before		After		Diff
> -----			------		-----		----
> CLOCK_MONOTONIC		355531720	338039373	-5%
> CLOCK_MONOTONIC_RAW	44831738	336064912	+650%
> CLOCK_REALTIME		347665133	338102907	-3%

the preformance regressions for CLOCK_MONOTONIC and CLOCK_REALTIME are just
not acceptable.

> diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
> index 98c7d12..7c9db26 100644
> --- a/arch/x86/entry/vdso/vclock_gettime.c
> +++ b/arch/x86/entry/vdso/vclock_gettime.c
> @@ -144,6 +144,13 @@ notrace static int do_hres(clockid_t clk, struct timespec *ts)
>  	struct vgtod_ts *base = &gtod->basetime[clk];
>  	u64 cycles, last, sec, ns;
>  	unsigned int seq;
> +	u32 mult = gtod->mult;
> +	u32 shift = gtod->shift;
> +
> +	if (clk == CLOCK_MONOTONIC_RAW) {
> +		mult = gtod->raw_mult;
> +		shift = gtod->raw_shift;
> +	}

They stem from this extra conditional.

>  
>  	do {
>  		seq = gtod_read_begin(gtod);
> @@ -153,8 +160,8 @@ notrace static int do_hres(clockid_t clk, struct timespec *ts)
>  		if (unlikely((s64)cycles < 0))
>  			return vdso_fallback_gettime(clk, ts);
>  		if (cycles > last)
> -			ns += (cycles - last) * gtod->mult;
> -		ns >>= gtod->shift;
> +			ns += (cycles - last) * mult;

And this is completely broken because you read the mult/shift values
outside of the sequence count protected region, so a concurrent update of
the timekeeping values will lead to inconsistent state.

Thanks,

	tglx
