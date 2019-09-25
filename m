Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6CDC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6789421D79
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a4Odjpqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732674AbfIYPiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 11:38:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34245 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfIYPiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 11:38:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id a11so7536432wrx.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 08:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cx/GNZpNHYFwIzpok9xHy8DS/NWBlVTJrgPnmAduazI=;
        b=a4OdjpqnUrTK9YT8UuDyOGUcXUkwmuGF6IHh7EkZ3lXavXtW+EzlXYBVRB286Vu84F
         gFOF0gwx7eARJtK03E+khCuzVZWCzAGrLhu1PDCduazoxEvea+ktREvrx5MIXdBMZKO+
         ulxTy8XB2Mc7B0dFFUlhwjsPIRClD6g/lRzw5sK4TSw/GSOGlbt9iIrMdxalBwZsI7Ie
         GaqoCUyJ8bFk1j5u4/HxxGukXUmq7EfDe/EBZ1SuTJpkUjR3gVovYhjpTj7gyCg6to1u
         Y0vMEpxnZDc6e5X3B1V34CQuEOEL3B9fgkJDcSFOXYjjesI8PzMmqWypMIK2+6tUtApZ
         HOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cx/GNZpNHYFwIzpok9xHy8DS/NWBlVTJrgPnmAduazI=;
        b=RbmzbE0vo0RNNOPrxE44sMImc5glkRIjpOt02NwoyONKBhr0284Am5VRasaXtIVyah
         qzfqIu+oHiVxLlBfBQszaWWCNICH0h0riXVV9vMDXBHIzwzmTcXsNWnZQIuHQTvZ1Uyb
         EX64yq0gXOqodY+lud1KcMunbbEU/lTmhNno7Oadg0vkCLahM2kItrmMBgY8y0Nt7/XH
         h38NSrYyxQet9UFsqBR86stbWvDuXReJyluAJ0UGZMMCPyyoAau7ogYCf4cmUYkXXxYN
         kFBCLHp1c9/rhSylkpwAx8rGKaZH1KXgoqDuANR7sJDH2kRljjqqhys0bp3GwbSqfDB+
         d1ag==
X-Gm-Message-State: APjAAAWEi78MYe4Xv4PZhwQ2tT+cqF0EAMhnkK8qd1nZjzAEufxnBK2/
        cCYIrqjTzVj2Imte11vb9l0mKpkN4S4f/BjNSYNRFIWMcQ8=
X-Google-Smtp-Source: APXvYqxTEINYkf4GdvAEm2yCr3TpuMgb5ftmOJJbDktR7h0txYnodr3vAVACKcrPiBCHzq1YVlyAvE1YNiwqBaMMUEE=
X-Received: by 2002:adf:f406:: with SMTP id g6mr9566277wro.325.1569425932603;
 Wed, 25 Sep 2019 08:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <201908141353.043EF60B@keescook> <20190904103803.iv7agcw2suv6fcib@willie-the-truck>
 <201909041336.E6DE4B69@keescook> <20190906104419.cyewsrnwcks7cbny@willie-the-truck>
 <CAKv+Gu9yHxUV2GAuPG=HWGRt81LhSVisABDpUZxyDkLJffxy6A@mail.gmail.com> <201909231614.34B54F4076@keescook>
In-Reply-To: <201909231614.34B54F4076@keescook>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 25 Sep 2019 17:38:41 +0200
Message-ID: <CAKv+Gu-TS+vRxVAcV_sVH5bXKU5Gnb8xb1HE-NuJLepZ4Tu1XQ@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub/arm64: Report meaningful relocation errors
To:     Kees Cook <keescook@chromium.org>
Cc:     Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Sep 2019 at 01:17, Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Sep 06, 2019 at 10:34:47AM -0700, Ard Biesheuvel wrote:
> > On Fri, 6 Sep 2019 at 03:44, Will Deacon <will@kernel.org> wrote:
> > >
> > > On Wed, Sep 04, 2019 at 01:38:04PM -0700, Kees Cook wrote:
> > > > On Wed, Sep 04, 2019 at 11:38:03AM +0100, Will Deacon wrote:
> > > > > On Wed, Aug 14, 2019 at 01:55:50PM -0700, Kees Cook wrote:
> > > > > > diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
> > > > > > index 1550d244e996..24022f956e01 100644
> > > > > > --- a/drivers/firmware/efi/libstub/arm64-stub.c
> > > > > > +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> > > > > > @@ -111,6 +111,8 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
> > > > > >           status = efi_random_alloc(sys_table_arg, *reserve_size,
> > > > > >                                     MIN_KIMG_ALIGN, reserve_addr,
> > > > > >                                     (u32)phys_seed);
> > > > > > +         if (status != EFI_SUCCESS)
> > > > > > +                 pr_efi_err(sys_table_arg, "KASLR allocate_pages() failed\n");
> > > > > >
> > > > > >           *image_addr = *reserve_addr + offset;
> > > > > >   } else {
> > > > > > @@ -135,6 +137,8 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
> > > > > >                                   EFI_LOADER_DATA,
> > > > > >                                   *reserve_size / EFI_PAGE_SIZE,
> > > > > >                                   (efi_physical_addr_t *)reserve_addr);
> > > > > > +         if (status != EFI_SUCCESS)
> > > > > > +                 pr_efi_err(sys_table_arg, "regular allocate_pages() failed\n");
> > > > > >   }
> > > > >
> > > > > Not sure I see the need to distinsuish the 'KASLR' case from the 'regular'
> > > > > case -- only one should run, right?  That also didn't seem to be part of
> > > > > the use-case in the commit, unless I'm missing something.
> > > >
> > > > I just did that to help with differentiating the cases. Maybe something
> > > > was special about KASLR picking the wrong location that triggered the
> > > > failure, etc.
> > > >
> > > > > Maybe combine the prints as per the diff below?
> > > >
> > > > That could work. If you're against the KASLR vs regular thing, I can
> > > > respin the patch?
> > >
> > > Happy to Ack it with that change, although I suppose it's ultimately up
> > > to Ard :)
> > >
> >
> > No objections from me, but I prefer Will's version.
>
> I took a look at this again... to report the failures as Will suggests,
> it would look like this:
>
> --- a/drivers/firmware/efi/libstub/arm64-stub.c
> +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> @@ -138,12 +138,14 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
>         }
>
>         if (status != EFI_SUCCESS) {
> +               pr_efi_err(sys_table_arg, "allocate_pages() failed\n");
> +
>                 *reserve_size = kernel_memsize + TEXT_OFFSET;
>                 status = efi_low_alloc(sys_table_arg, *reserve_size,
>                                        MIN_KIMG_ALIGN, reserve_addr);
>
>                 if (status != EFI_SUCCESS) {
> -                       pr_efi_err(sys_table_arg, "Failed to relocate kernel\n");
> +                       pr_efi_err(sys_table_arg, "efi_low_alloc() failed\n");
>                         *reserve_size = 0;
>                         return status;
>                 }
>
> My reasoning for putting the failure earlier is to differentiate which
> path was taken where the allocate_pages() failed: either regular or
> KASLR. If that's really not considered important here, I can send the
> above patch... Thoughts?
>

The first pr_efi_err() in the patch above complains about a condition
that is not actually an error.

If you are interested in recording the path taken through this
function, I have no objections to putting a normal pr_efi() print
inside the KASLR block that shows that the physical placement of the
kernel is being randomized. Then, we can keep only the second
pr_efi_err() above to report the failure.
