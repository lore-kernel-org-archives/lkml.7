Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9857C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 17:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B824206A1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 17:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TBp20337"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395227AbfIFRfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 13:35:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54818 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391211AbfIFRfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 13:35:06 -0400
Received: by mail-wm1-f65.google.com with SMTP id k2so7324003wmj.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 10:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1BZzqsouBDxGzdYj+D/chN8ZV4lw7sjJgvyq9zFqAMA=;
        b=TBp20337h/J8ZuV78tdqfcyrziDClsy5rOzZSe9WojLKrwzbZWJWp7quDGCTKIG9gv
         FCSVRn1GCZC9dI7IlGOVi7QossfV7cvvqBi2X+5aG26vU7zGOI4pcOOQCg8MP0+N5ffc
         jTOgxl/14YXeny9GB3a8yAcsnyw/TB2ferDL405YZcrQQk+HE0I6CPYBogop2UY7V9Gw
         qPKf6jUEKJyw1k+jjc0VfTRFVsgzTas9W2ZZb/c3+5VElU+H7ioRho9nuxevwhPe+MyH
         VhGhHRhV26dxgLXEqyGuSGpOrQou6a3JT0l+J+KpbbYmMR6bvhFcrdzQFhcsN0BgD3Ir
         xNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1BZzqsouBDxGzdYj+D/chN8ZV4lw7sjJgvyq9zFqAMA=;
        b=UtlF1fMxuqLQnw4GxkqALYAD/bqf9CqNTUOxQ8v09Bs/p7ApKedo+Ex5K4p9Fira6H
         jIibPcf1SdbDE3r+i8H/PMjPb74xzuzxe2u/90MWJK1F8yOgsaf4AXObm8k+ea9Ndumr
         hCAmDgnNWSOIE4SYHpJL8fb/DzwnUabG1EqQpxJS00bByMQnK1kW/IjUsfCkMOAEujHY
         w3K8+YrHLNV64dUCrACKkHsrXPBmveF6P+kzVQaqOqEkyoORGai+AeCi03a16CeMfhLu
         G5mJgfrkXjDYJsW65X0J5WLpg7h99O880bvgsmrXSO2oZqhnUBo8uSKrjQUTS3heHCtD
         j/Hw==
X-Gm-Message-State: APjAAAUmeZGESG0CQglyaJvpJqO9I0IHbg4PIEXSbjHU533oYCmNEgX5
        Kv5eg2z0O1MYq/UvjN5X1SQ8IDUmRKQhFJbY7lBtSBZa+c/D9Q==
X-Google-Smtp-Source: APXvYqyVeDDb4IFcM7XSyWi6ty1FBe11PYleWfqCMyzYV90xT4MLuL+6saovFf5Bsbheej6g4TFpkW/T7d+ekFxfr9Y=
X-Received: by 2002:a1c:2546:: with SMTP id l67mr8614620wml.10.1567791303869;
 Fri, 06 Sep 2019 10:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <201908141353.043EF60B@keescook> <20190904103803.iv7agcw2suv6fcib@willie-the-truck>
 <201909041336.E6DE4B69@keescook> <20190906104419.cyewsrnwcks7cbny@willie-the-truck>
In-Reply-To: <20190906104419.cyewsrnwcks7cbny@willie-the-truck>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 6 Sep 2019 10:34:47 -0700
Message-ID: <CAKv+Gu9yHxUV2GAuPG=HWGRt81LhSVisABDpUZxyDkLJffxy6A@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub/arm64: Report meaningful relocation errors
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Sep 2019 at 03:44, Will Deacon <will@kernel.org> wrote:
>
> On Wed, Sep 04, 2019 at 01:38:04PM -0700, Kees Cook wrote:
> > On Wed, Sep 04, 2019 at 11:38:03AM +0100, Will Deacon wrote:
> > > On Wed, Aug 14, 2019 at 01:55:50PM -0700, Kees Cook wrote:
> > > > diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
> > > > index 1550d244e996..24022f956e01 100644
> > > > --- a/drivers/firmware/efi/libstub/arm64-stub.c
> > > > +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> > > > @@ -111,6 +111,8 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
> > > >           status = efi_random_alloc(sys_table_arg, *reserve_size,
> > > >                                     MIN_KIMG_ALIGN, reserve_addr,
> > > >                                     (u32)phys_seed);
> > > > +         if (status != EFI_SUCCESS)
> > > > +                 pr_efi_err(sys_table_arg, "KASLR allocate_pages() failed\n");
> > > >
> > > >           *image_addr = *reserve_addr + offset;
> > > >   } else {
> > > > @@ -135,6 +137,8 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
> > > >                                   EFI_LOADER_DATA,
> > > >                                   *reserve_size / EFI_PAGE_SIZE,
> > > >                                   (efi_physical_addr_t *)reserve_addr);
> > > > +         if (status != EFI_SUCCESS)
> > > > +                 pr_efi_err(sys_table_arg, "regular allocate_pages() failed\n");
> > > >   }
> > >
> > > Not sure I see the need to distinsuish the 'KASLR' case from the 'regular'
> > > case -- only one should run, right?  That also didn't seem to be part of
> > > the use-case in the commit, unless I'm missing something.
> >
> > I just did that to help with differentiating the cases. Maybe something
> > was special about KASLR picking the wrong location that triggered the
> > failure, etc.
> >
> > > Maybe combine the prints as per the diff below?
> >
> > That could work. If you're against the KASLR vs regular thing, I can
> > respin the patch?
>
> Happy to Ack it with that change, although I suppose it's ultimately up
> to Ard :)
>

No objections from me, but I prefer Will's version.
