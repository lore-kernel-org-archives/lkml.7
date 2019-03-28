Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B847C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E7F217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nMs6X8cY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YKMad1I3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfC1MOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:14:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58024 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbfC1MOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:14:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0A75A6081E; Thu, 28 Mar 2019 12:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553775240;
        bh=TOzKyM0rdas4EXtK9JCqhnBYcHDjRI6FE9oHvMnQPlI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nMs6X8cYuRkYR+i9YmpEXlVH19Ix4MNCLnG0LClkX4Hq2wPnrZ50B561x69E4CYnU
         pO9m17OAkef7W14BO2/6U0i2e62gwbC6akBKBef9nRAN68JWGOzYVKcuwVoG0pbCpt
         Iiz/XFLSAVJ/Ab2eaz0sD4FpTq5gTh8+cfC3zxyc=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 23C5060364;
        Thu, 28 Mar 2019 12:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553775239;
        bh=TOzKyM0rdas4EXtK9JCqhnBYcHDjRI6FE9oHvMnQPlI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YKMad1I3QG99+DwuBfTZM+n/DnbvJJyh65d3KNn6uF2serLDozXbig5iG1pRxwV0v
         cCZScRvhW686LU7qw7/3QEnlJEFz/Z8y2rEYt6jIhOGrvDA4MzFAvAF8kiNe+7wd94
         cb2ULjyhBF7izFPBQ8hOf4H/29e2G/UAjy+OYLj0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 23C5060364
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] x86: remove unused argument from set_real_mode_mem()
To:     Matteo Croce <mcroce@redhat.com>, x86@kernel.org,
        linux-efi@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <20190328114233.27835-1-mcroce@redhat.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <2541ee29-b54d-3415-6d25-dda285b13098@codeaurora.org>
Date:   Thu, 28 Mar 2019 17:43:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190328114233.27835-1-mcroce@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/28/2019 5:12 PM, Matteo Croce wrote:
> Following commit b929a500d684 ("x86/realmode: Don't leak the trampoline
> kernel address"), set_real_mode_mem() is a trivial function with a
> unused argument.
> Remove the unused argument and move it into an header file, so it can be
> inlined.
>
> Signed-off-by: Matteo Croce <mcroce@redhat.com>
Seems you are doing two things in the same patch argument removal, and 
function movement.
Although, i am ok with it unless somebody question it.


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh

> ---
>   arch/x86/include/asm/realmode.h | 6 +++++-
>   arch/x86/platform/efi/quirks.c  | 2 +-
>   arch/x86/realmode/init.c        | 9 +--------
>   3 files changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
> index 63b3393bd98e..c53682303c9c 100644
> --- a/arch/x86/include/asm/realmode.h
> +++ b/arch/x86/include/asm/realmode.h
> @@ -77,7 +77,11 @@ static inline size_t real_mode_size_needed(void)
>   	return ALIGN(real_mode_blob_end - real_mode_blob, PAGE_SIZE);
>   }
>   
> -void set_real_mode_mem(phys_addr_t mem, size_t size);
> +static inline void set_real_mode_mem(phys_addr_t mem)
> +{
> +	real_mode_header = (struct real_mode_header *) __va(mem);
> +}
> +
>   void reserve_real_mode(void);
>   
>   #endif /* __ASSEMBLY__ */
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index 458a0e2bcc57..a25a9fd987a9 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -449,7 +449,7 @@ void __init efi_free_boot_services(void)
>   		 */
>   		rm_size = real_mode_size_needed();
>   		if (rm_size && (start + rm_size) < (1<<20) && size >= rm_size) {
> -			set_real_mode_mem(start, rm_size);
> +			set_real_mode_mem(start);
>   			start += rm_size;
>   			size -= rm_size;
>   		}
> diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
> index 47d097946872..7dce39c8c034 100644
> --- a/arch/x86/realmode/init.c
> +++ b/arch/x86/realmode/init.c
> @@ -15,13 +15,6 @@ u32 *trampoline_cr4_features;
>   /* Hold the pgd entry used on booting additional CPUs */
>   pgd_t trampoline_pgd_entry;
>   
> -void __init set_real_mode_mem(phys_addr_t mem, size_t size)
> -{
> -	void *base = __va(mem);
> -
> -	real_mode_header = (struct real_mode_header *) base;
> -}
> -
>   void __init reserve_real_mode(void)
>   {
>   	phys_addr_t mem;
> @@ -40,7 +33,7 @@ void __init reserve_real_mode(void)
>   	}
>   
>   	memblock_reserve(mem, size);
> -	set_real_mode_mem(mem, size);
> +	set_real_mode_mem(mem);
>   }
>   
>   static void __init setup_real_mode(void)
