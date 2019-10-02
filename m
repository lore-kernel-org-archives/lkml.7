Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDD1C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B48721920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfJBMYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 08:24:09 -0400
Received: from foss.arm.com ([217.140.110.172]:42732 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfJBMYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 08:24:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C16D28;
        Wed,  2 Oct 2019 05:24:08 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F5713F71A;
        Wed,  2 Oct 2019 05:24:06 -0700 (PDT)
Date:   Wed, 2 Oct 2019 13:23:57 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/x86/intel/uncore: fix integer overflow on shift of
 a u32 integer
Message-ID: <20191002122357.GA29018@lakrids.cambridge.arm.com>
References: <20191002115545.15570-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002115545.15570-1-colin.king@canonical.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 12:55:45PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Shifting the u32 integer result of (pci_dword & SNR_IMC_MMIO_BASE_MASK)
> will end up with an overflow when pci_dword greater than 0x1ff. Fix this
> by casting pci_dword to a resource_size_t before masking and shifting it.
> 
> Addresses-Coverity: ("Unintentional integer overflow")

I don't see that tag in Documentation/process/submitting-patches.rst ;)

IIUC this is unintented truncation of the upper bits due to missing type
promotion before the shift, rather than overflow (i.e. the value
wrapping across addition/subtraction), so I think the wording is
slightly misleading.

Does coverity call that integer overflow?

It might be better to say:

| [PATCH] perf/x86/intel/uncore: don't truncate upper bits of address
|
| Shifting the u32 integer result of (pci_dword & SNR_IMC_MMIO_BASE_MASK)
| by 23 will throw away the upper 23 bits of the potentially 64-bit
| address. Fix this by casting pci_dword to a resource_size_t before
| masking and shifting it.
|
| Found by coverity ("Unintentional integer overflow").

Otherwise, the patch looks fine to me:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> Fixes: ee49532b38dd ("perf/x86/intel/uncore: Add IMC uncore support for Snow Ridge")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  arch/x86/events/intel/uncore_snbep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index b10a5ec79e48..ed69df1340d9 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -4415,7 +4415,7 @@ static void snr_uncore_mmio_init_box(struct intel_uncore_box *box)
>  		return;
>  
>  	pci_read_config_dword(pdev, SNR_IMC_MMIO_BASE_OFFSET, &pci_dword);
> -	addr = (pci_dword & SNR_IMC_MMIO_BASE_MASK) << 23;
> +	addr = ((resource_size_t)pci_dword & SNR_IMC_MMIO_BASE_MASK) << 23;
>  
>  	pci_read_config_dword(pdev, SNR_IMC_MMIO_MEM0_OFFSET, &pci_dword);
>  	addr |= (pci_dword & SNR_IMC_MMIO_MEM0_MASK) << 12;
> -- 
> 2.20.1
> 
