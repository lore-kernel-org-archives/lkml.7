Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE7DC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 10:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A742339D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 10:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567593490;
	bh=a7KcCjxvZ7QnCGdxs/fbPhmEa4sN3JIvH3PaQemDeBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LmdSN8rH+YorzZpUZJLA8S6TkBUizisSZIE8KlafoHKOCB7wfTaFe0oz3bZoBjwtX
	 Bi9dWq7mpsKkRJm+62noxe4zJaWiDmsb+8rTOhA79WdAqt1Z6QTv5IYa/YAoqTGX3B
	 4eQyJkLGu8sOmo0bGlC1hG20CQpZDIrSFtdu6apM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbfIDKiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 06:38:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfIDKiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 06:38:08 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3B5922CF5;
        Wed,  4 Sep 2019 10:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567593487;
        bh=a7KcCjxvZ7QnCGdxs/fbPhmEa4sN3JIvH3PaQemDeBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ILxU3QE84ARauFFBedsGBmjVGkCC3WbRNVBOwju+fL2uI5eW8rCFKvmHEFiXdhWzA
         nkpMPzRYVlMsu5NYGN/LgRzq6rPO2zNCzRllDIS7Co2IFmxjMQFEtZkqeTM51Fw8bK
         6D45/fO/KRyf/38IwuiH7BzsvYk7Ws+1lLP2c0i4=
Date:   Wed, 4 Sep 2019 11:38:03 +0100
From:   Will Deacon <will@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] efi/libstub/arm64: Report meaningful relocation errors
Message-ID: <20190904103803.iv7agcw2suv6fcib@willie-the-truck>
References: <201908141353.043EF60B@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201908141353.043EF60B@keescook>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Wed, Aug 14, 2019 at 01:55:50PM -0700, Kees Cook wrote:
> When UEFI booting, if allocate_pages() fails (either via KASLR or
> regular boot), efi_low_alloc() is used for fall back. If it, too, fails,
> it reports "Failed to relocate kernel". Then handle_kernel_image()
> reports the failure to its caller, which unhelpfully reports exactly
> the same string again:
> 
> EFI stub: ERROR: Failed to relocate kernel
> EFI stub: ERROR: Failed to relocate kernel
> 
> While debugging linker errors in the UEFI code that created insane memory
> sizes that all the allocation attempts would fail at, this was a cause
> for confusion. Knowing each allocation had failed would have helped me
> isolate the issue sooner. To that end, this improves the error messages
> to detail which specific allocations have failed.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/firmware/efi/libstub/arm64-stub.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
> index 1550d244e996..24022f956e01 100644
> --- a/drivers/firmware/efi/libstub/arm64-stub.c
> +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> @@ -111,6 +111,8 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
>  		status = efi_random_alloc(sys_table_arg, *reserve_size,
>  					  MIN_KIMG_ALIGN, reserve_addr,
>  					  (u32)phys_seed);
> +		if (status != EFI_SUCCESS)
> +			pr_efi_err(sys_table_arg, "KASLR allocate_pages() failed\n");
>  
>  		*image_addr = *reserve_addr + offset;
>  	} else {
> @@ -135,6 +137,8 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
>  					EFI_LOADER_DATA,
>  					*reserve_size / EFI_PAGE_SIZE,
>  					(efi_physical_addr_t *)reserve_addr);
> +		if (status != EFI_SUCCESS)
> +			pr_efi_err(sys_table_arg, "regular allocate_pages() failed\n");
>  	}

Not sure I see the need to distinsuish the 'KASLR' case from the 'regular'
case -- only one should run, right?  That also didn't seem to be part of
the use-case in the commit, unless I'm missing something.

Maybe combine the prints as per the diff below?

Will

--->8

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 1550d244e996..820c58cc149e 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -143,13 +143,15 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
 				       MIN_KIMG_ALIGN, reserve_addr);
 
 		if (status != EFI_SUCCESS) {
-			pr_efi_err(sys_table_arg, "Failed to relocate kernel\n");
+			pr_efi_err(sys_table_arg, "efi_low_alloc() failed\n");
 			*reserve_size = 0;
 			return status;
 		}
 		*image_addr = *reserve_addr + TEXT_OFFSET;
+	} else {
+		pr_efi_err(sys_table_arg, "allocate_pages() failed\n");
 	}
-	memcpy((void *)*image_addr, old_image_addr, kernel_size);
 
+	memcpy((void *)*image_addr, old_image_addr, kernel_size);
 	return EFI_SUCCESS;
 }
