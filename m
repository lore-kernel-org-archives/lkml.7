Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48C4C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 06:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C6520B7C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 06:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfHJGhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 02:37:33 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:40063 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfHJGhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 02:37:33 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 465C8S5vmhz1rJCf;
        Sat, 10 Aug 2019 08:37:28 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 465C8R6rLvz1qqkr;
        Sat, 10 Aug 2019 08:37:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id rgO-e_q9Of7V; Sat, 10 Aug 2019 08:37:26 +0200 (CEST)
X-Auth-Info: MGf3vtvDZUlt9nH4JPNPyfNH0Crfs9J8zNlWOKuASYmkGDQGdc/2upzcT0jPFvb5
Received: from linux.local (ppp-46-244-179-104.dynamic.mnet-online.de [46.244.179.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat, 10 Aug 2019 08:37:26 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
        id 88AD01E5386; Sat, 10 Aug 2019 08:37:21 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Anup Patel <anup.patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org,
        Allison Randal <allison@lohutok.net>
Subject: Re: [PATCH] RISC-V: Issue a local tlb flush if possible.
References: <20190810014309.20838-1-atish.patra@wdc.com>
X-Yow:  Do I hear th' SPINNING of various WHIRRING, ROUND, and WARM
 WHIRLOMATICS?!
Date:   Sat, 10 Aug 2019 08:37:21 +0200
In-Reply-To: <20190810014309.20838-1-atish.patra@wdc.com> (Atish Patra's
        message of "Fri, 9 Aug 2019 18:43:09 -0700")
Message-ID: <m2r25t8r1a.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 09 2019, Atish Patra <atish.patra@wdc.com> wrote:

> @@ -46,14 +47,38 @@ static inline void remote_sfence_vma(struct cpumask *cmask, unsigned long start,
>  				     unsigned long size)
>  {
>  	struct cpumask hmask;
> +	struct cpumask tmask;
> +	int cpuid = smp_processor_id();
>  
>  	cpumask_clear(&hmask);
> -	riscv_cpuid_to_hartid_mask(cmask, &hmask);
> -	sbi_remote_sfence_vma(hmask.bits, start, size);
> +	cpumask_clear(&tmask);
> +
> +	if (cmask)
> +		cpumask_copy(&tmask, cmask);
> +	else
> +		cpumask_copy(&tmask, cpu_online_mask);
> +
> +	if (cpumask_test_cpu(cpuid, &tmask)) {
> +		/* Save trap cost by issuing a local tlb flush here */
> +		if ((start == 0 && size == -1) || (size > PAGE_SIZE))
> +			local_flush_tlb_all();
> +		else if (size == PAGE_SIZE)
> +			local_flush_tlb_page(start);
> +		cpumask_clear_cpu(cpuid, &tmask);
> +	} else if (cpumask_empty(&tmask)) {
> +		/* cpumask is empty. So just do a local flush */
> +		local_flush_tlb_all();
> +		return;
> +	}
> +
> +	if (!cpumask_empty(&tmask)) {
> +		riscv_cpuid_to_hartid_mask(&tmask, &hmask);
> +		sbi_remote_sfence_vma(hmask.bits, start, size);
> +	}
>  }

I think it's becoming too big to be inline.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
