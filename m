Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB936C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896242070D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbfHFMez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 08:34:55 -0400
Received: from foss.arm.com ([217.140.110.172]:60920 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbfHFMez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 08:34:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2361A28;
        Tue,  6 Aug 2019 05:34:54 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC1073F694;
        Tue,  6 Aug 2019 05:34:52 -0700 (PDT)
Date:   Tue, 6 Aug 2019 13:34:50 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        James Morse <james.morse@arm.com>
Subject: Re: [PATCH] arm64: mm: print hexadecimal EC value in
 mem_abort_decode()
Message-ID: <20190806123450.GE475@lakrids.cambridge.arm.com>
References: <20190806112948.4357-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806112948.4357-1-miles.chen@mediatek.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 07:29:48PM +0800, Miles Chen wrote:
> This change prints the hexadecimal EC value in mem_abort_decode(),
> which makes it easier to lookup the corresponding EC in
> the ARM Architecture Reference Manual.
> 
> The commit 1f9b8936f36f ("arm64: Decode information from ESR upon mem
> faults") prints useful information when memory abort occurs. It would
> be easier to lookup "0x25" instead of "DABT" in the document. Then we
> can check the corresponding ISS.
> 
> For example:
> Current	info	  	Document
> 		  	EC	Exception class
> "CP15 MCR/MRC"		0x3	"MCR or MRC access to CP15a..."
> "ASIMD"			0x7	"Access to SIMD or floating-point..."
> "DABT (current EL)" 	0x25	"Data Abort taken without..."
> ...
> 
> Before:
> Unable to handle kernel paging request at virtual address 000000000000c000
> Mem abort info:
>   ESR = 0x96000046
>   Exception class = DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
> Data abort info:
>   ISV = 0, ISS = 0x00000046
>   CM = 0, WnR = 1
> 
> After:
> Unable to handle kernel paging request at virtual address 000000000000c000
> Mem abort info:
>   ESR = 0x96000046
>   EC = 0x25, Exception class = DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
> Data abort info:
>   ISV = 0, ISS = 0x00000046
>   CM = 0, WnR = 1
> 
> Cc: Mark Rutland <Mark.rutland@arm.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> ---
>  arch/arm64/mm/fault.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index cfd65b63f36f..afb6041e25e6 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -86,8 +86,8 @@ static void mem_abort_decode(unsigned int esr)
>  	pr_alert("Mem abort info:\n");
>  
>  	pr_alert("  ESR = 0x%08x\n", esr);
> -	pr_alert("  Exception class = %s, IL = %u bits\n",
> -		 esr_get_class_string(esr),
> +	pr_alert("  EC = 0x%lx, Exception class = %s, IL = %u bits\n",
> +		 ESR_ELx_EC(esr), esr_get_class_string(esr),

Could we make this:

	pr_alert("  EC = 0x%02lx: %s, IL = %u bits\n",
		 ESR_ELx_EC(esr), esr_get_class_string(esr));

We don't need to spell out "Exception Class" if we say "EC", and we
should print the EC hex value with a consistent width as we do for the
ISS.

With that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
