Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45647C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA4E208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567766666;
	bh=oPAhurO0ALmu/C/6NOdjj83pRyv0Wb9DoTwwsAJYlVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Lwd8E4OJXW00FpFQe6M+MH+gOVcMDUuFxvGaPJCMcJwZm4b/4ugRMWd8wBh0GH8aO
	 CKMO1C1son09M50TfhCnKmcM3lVRS55KMB4oft08e2+I1caEA9U6WId6A+QnCObZaJ
	 FYamRTcJNnadxubVlyxoLmITtHVPzR6/rYjSyNp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387861AbfIFKoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 06:44:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733174AbfIFKoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 06:44:25 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D2D22084F;
        Fri,  6 Sep 2019 10:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567766664;
        bh=oPAhurO0ALmu/C/6NOdjj83pRyv0Wb9DoTwwsAJYlVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rIMVemDEyXaAuskc8ewY7x+fhcG45AS08U0OBPKvgArIe26Qut3LEXAIrd2WipGP2
         iZmoKBHhiTVPo7UWvCBOQUxxcvuzAFW06wgbT/7cvSClsFBvW9wpaW+LnNrRxAjs0W
         W85saJY+M/jWusrJJDIP/Ha+SA+YByuw9zDQBAf0=
Date:   Fri, 6 Sep 2019 11:44:20 +0100
From:   Will Deacon <will@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] efi/libstub/arm64: Report meaningful relocation errors
Message-ID: <20190906104419.cyewsrnwcks7cbny@willie-the-truck>
References: <201908141353.043EF60B@keescook>
 <20190904103803.iv7agcw2suv6fcib@willie-the-truck>
 <201909041336.E6DE4B69@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201909041336.E6DE4B69@keescook>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 01:38:04PM -0700, Kees Cook wrote:
> On Wed, Sep 04, 2019 at 11:38:03AM +0100, Will Deacon wrote:
> > On Wed, Aug 14, 2019 at 01:55:50PM -0700, Kees Cook wrote:
> > > diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
> > > index 1550d244e996..24022f956e01 100644
> > > --- a/drivers/firmware/efi/libstub/arm64-stub.c
> > > +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> > > @@ -111,6 +111,8 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
> > >  		status = efi_random_alloc(sys_table_arg, *reserve_size,
> > >  					  MIN_KIMG_ALIGN, reserve_addr,
> > >  					  (u32)phys_seed);
> > > +		if (status != EFI_SUCCESS)
> > > +			pr_efi_err(sys_table_arg, "KASLR allocate_pages() failed\n");
> > >  
> > >  		*image_addr = *reserve_addr + offset;
> > >  	} else {
> > > @@ -135,6 +137,8 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
> > >  					EFI_LOADER_DATA,
> > >  					*reserve_size / EFI_PAGE_SIZE,
> > >  					(efi_physical_addr_t *)reserve_addr);
> > > +		if (status != EFI_SUCCESS)
> > > +			pr_efi_err(sys_table_arg, "regular allocate_pages() failed\n");
> > >  	}
> > 
> > Not sure I see the need to distinsuish the 'KASLR' case from the 'regular'
> > case -- only one should run, right?  That also didn't seem to be part of
> > the use-case in the commit, unless I'm missing something.
> 
> I just did that to help with differentiating the cases. Maybe something
> was special about KASLR picking the wrong location that triggered the
> failure, etc.
> 
> > Maybe combine the prints as per the diff below?
> 
> That could work. If you're against the KASLR vs regular thing, I can
> respin the patch?

Happy to Ack it with that change, although I suppose it's ultimately up
to Ard :)

Will
