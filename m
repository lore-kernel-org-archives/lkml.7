Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DAAC3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 20:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C7F206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 20:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EVu2/qM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbfIDUiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 16:38:07 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34390 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfIDUiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 16:38:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so74809pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 13:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bk5pYovWj1N2NE+OOJaoyRA6cWmgvTKyUM/n3n02nPQ=;
        b=EVu2/qM4dkFpjXBhv301WHW37bP6fyBlIs/gRq15bdIjJoMt6wfKjpMdCcxDV8HOM2
         UguTb66swmlioFkQdeJH4/MnKxuoTGxU5p+4kVOniyj6OVDbHd1SkZoTYBQx3KHPe8XN
         3G9Yy4DaGHQe46NHOUlg+hTOdrZ3CaSyEC104=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bk5pYovWj1N2NE+OOJaoyRA6cWmgvTKyUM/n3n02nPQ=;
        b=i7GAJZzs2Wp7qgwVZ0SuKEGu4/uNQ+9xRdcpSDTEbtkm9D9U/q+r6qF3gWQrto/r+j
         97ZoIELvbo7dl5GFE5Hve8OhEtGyNkr5GWmSRnFLQ3DM752xTTQPXyUiYTDxherIh5hQ
         MQteYjbj5+xDCkIe6WMJtU6Vt04JatQ14E7NE5nUfDlSB0uNRkaweSaUv2N3em1kmoXH
         vhxf8IGkxMt6KXBeOPnJ74M2DPlF9I9YiOj53eSzGq0q1Isgps2rtPhNyRtxYIS39NTn
         Zj3GXHUmuaC+3cPOMkz64iXvZyfaL24yh+7PCjUBsP7Wr5ePYPxKtbeaL+Ai4tPvoSz6
         7/wQ==
X-Gm-Message-State: APjAAAXx72RACoGknqY3rewUZDU9cxcP61cDkFH6YbNaKxGKZhR89RIx
        hIryLieOKa4zt0iyQT/bJ5e7Ng==
X-Google-Smtp-Source: APXvYqxBAXwOFmTw+wOpWeWmjPDDuL6B0POG2q8/5EaDnRs7jT8FbA4qXcZTsJJx0WPcTea4f0YBpw==
X-Received: by 2002:a62:7a12:: with SMTP id v18mr4855828pfc.205.1567629485983;
        Wed, 04 Sep 2019 13:38:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x22sm5737362pfi.139.2019.09.04.13.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 13:38:05 -0700 (PDT)
Date:   Wed, 4 Sep 2019 13:38:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] efi/libstub/arm64: Report meaningful relocation errors
Message-ID: <201909041336.E6DE4B69@keescook>
References: <201908141353.043EF60B@keescook>
 <20190904103803.iv7agcw2suv6fcib@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904103803.iv7agcw2suv6fcib@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 11:38:03AM +0100, Will Deacon wrote:
> Hi Kees,
> 
> On Wed, Aug 14, 2019 at 01:55:50PM -0700, Kees Cook wrote:
> > When UEFI booting, if allocate_pages() fails (either via KASLR or
> > regular boot), efi_low_alloc() is used for fall back. If it, too, fails,
> > it reports "Failed to relocate kernel". Then handle_kernel_image()
> > reports the failure to its caller, which unhelpfully reports exactly
> > the same string again:
> > 
> > EFI stub: ERROR: Failed to relocate kernel
> > EFI stub: ERROR: Failed to relocate kernel
> > 
> > While debugging linker errors in the UEFI code that created insane memory
> > sizes that all the allocation attempts would fail at, this was a cause
> > for confusion. Knowing each allocation had failed would have helped me
> > isolate the issue sooner. To that end, this improves the error messages
> > to detail which specific allocations have failed.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/firmware/efi/libstub/arm64-stub.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
> > index 1550d244e996..24022f956e01 100644
> > --- a/drivers/firmware/efi/libstub/arm64-stub.c
> > +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> > @@ -111,6 +111,8 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
> >  		status = efi_random_alloc(sys_table_arg, *reserve_size,
> >  					  MIN_KIMG_ALIGN, reserve_addr,
> >  					  (u32)phys_seed);
> > +		if (status != EFI_SUCCESS)
> > +			pr_efi_err(sys_table_arg, "KASLR allocate_pages() failed\n");
> >  
> >  		*image_addr = *reserve_addr + offset;
> >  	} else {
> > @@ -135,6 +137,8 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
> >  					EFI_LOADER_DATA,
> >  					*reserve_size / EFI_PAGE_SIZE,
> >  					(efi_physical_addr_t *)reserve_addr);
> > +		if (status != EFI_SUCCESS)
> > +			pr_efi_err(sys_table_arg, "regular allocate_pages() failed\n");
> >  	}
> 
> Not sure I see the need to distinsuish the 'KASLR' case from the 'regular'
> case -- only one should run, right?  That also didn't seem to be part of
> the use-case in the commit, unless I'm missing something.

I just did that to help with differentiating the cases. Maybe something
was special about KASLR picking the wrong location that triggered the
failure, etc.

> Maybe combine the prints as per the diff below?

That could work. If you're against the KASLR vs regular thing, I can
respin the patch?

-Kees

> 
> Will
> 
> --->8
> 
> diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
> index 1550d244e996..820c58cc149e 100644
> --- a/drivers/firmware/efi/libstub/arm64-stub.c
> +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> @@ -143,13 +143,15 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
>  				       MIN_KIMG_ALIGN, reserve_addr);
>  
>  		if (status != EFI_SUCCESS) {
> -			pr_efi_err(sys_table_arg, "Failed to relocate kernel\n");
> +			pr_efi_err(sys_table_arg, "efi_low_alloc() failed\n");
>  			*reserve_size = 0;
>  			return status;
>  		}
>  		*image_addr = *reserve_addr + TEXT_OFFSET;
> +	} else {
> +		pr_efi_err(sys_table_arg, "allocate_pages() failed\n");
>  	}
> -	memcpy((void *)*image_addr, old_image_addr, kernel_size);
>  
> +	memcpy((void *)*image_addr, old_image_addr, kernel_size);
>  	return EFI_SUCCESS;
>  }

-- 
Kees Cook
