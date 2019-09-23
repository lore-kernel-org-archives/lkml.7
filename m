Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEED6C432C1
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 23:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB78207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 23:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CQdiUyiB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404290AbfIWXRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 19:17:05 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41747 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729286AbfIWXRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 19:17:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id q7so10171868pfh.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 16:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2SRJ6ZgJ4lHeC36veFG7EzrSxsnqF3NYqx2kwYQzmuU=;
        b=CQdiUyiBoP15YAlxbJ4P3mHyrUm2QzMpRFR3RW6BgqtoYUzezzNJIcVmfgRH38ifN4
         JAg68+CJiIUF0RGkTn2pj9exmwStyWMdRzQcJxmfA6/vlMuB32+FaTlyZDp63AA3rfkZ
         4WmPEW86L7oK8QQdlce6eVcs208x4daz5GU+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2SRJ6ZgJ4lHeC36veFG7EzrSxsnqF3NYqx2kwYQzmuU=;
        b=F1BuTRB9NPY6WpOIejBMCtHronehlbqB9H41bhtJ+RQzVb3u3ZuWs9qYq/hZyVVWIo
         EMX6qzq4HM59EXPnaPsfiXwmUar1vzcPmSFjd2YKjKunRfA9ZbbZXlAq30l1YRl0E/YP
         z0/em8fc8Tq+c4oN5wj1MFoNgs6G2010NyqmNAFrU1ALEeZTBSXZyWd5S54/+Ta5mbtF
         7AzI5DC/UbI0E6DBb3qSojAacEtC8AIo/qXT+Bozh226cp4HYNcw42D2efd5jdkJXaUJ
         5vKd8DzAs7pwjLf2Iih5WTdgmx8X6F+tyscSfY28t8d4PmrwaQTsaXfrO+R4kx/aL+Ki
         kHaw==
X-Gm-Message-State: APjAAAWgwsUM+nhoN+lz0fGYKtZhEpRKTNZKNySQDbCS10F3KoXoTgd2
        GOcO4rrBHwK0jU1kTiUXz2WCjjwJcE0=
X-Google-Smtp-Source: APXvYqw4TnJUOdYj60y0YT8Xmw+OhlToL6KC9KFfcU7ysVmx2bdDZJgCg+f1g5q/yaw70RDO3XpJRg==
X-Received: by 2002:a17:90a:2a4a:: with SMTP id d10mr2081796pjg.72.1569280624724;
        Mon, 23 Sep 2019 16:17:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l72sm21584704pjb.7.2019.09.23.16.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 16:17:03 -0700 (PDT)
Date:   Mon, 23 Sep 2019 16:17:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] efi/libstub/arm64: Report meaningful relocation errors
Message-ID: <201909231614.34B54F4076@keescook>
References: <201908141353.043EF60B@keescook>
 <20190904103803.iv7agcw2suv6fcib@willie-the-truck>
 <201909041336.E6DE4B69@keescook>
 <20190906104419.cyewsrnwcks7cbny@willie-the-truck>
 <CAKv+Gu9yHxUV2GAuPG=HWGRt81LhSVisABDpUZxyDkLJffxy6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9yHxUV2GAuPG=HWGRt81LhSVisABDpUZxyDkLJffxy6A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 10:34:47AM -0700, Ard Biesheuvel wrote:
> On Fri, 6 Sep 2019 at 03:44, Will Deacon <will@kernel.org> wrote:
> >
> > On Wed, Sep 04, 2019 at 01:38:04PM -0700, Kees Cook wrote:
> > > On Wed, Sep 04, 2019 at 11:38:03AM +0100, Will Deacon wrote:
> > > > On Wed, Aug 14, 2019 at 01:55:50PM -0700, Kees Cook wrote:
> > > > > diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
> > > > > index 1550d244e996..24022f956e01 100644
> > > > > --- a/drivers/firmware/efi/libstub/arm64-stub.c
> > > > > +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> > > > > @@ -111,6 +111,8 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
> > > > >           status = efi_random_alloc(sys_table_arg, *reserve_size,
> > > > >                                     MIN_KIMG_ALIGN, reserve_addr,
> > > > >                                     (u32)phys_seed);
> > > > > +         if (status != EFI_SUCCESS)
> > > > > +                 pr_efi_err(sys_table_arg, "KASLR allocate_pages() failed\n");
> > > > >
> > > > >           *image_addr = *reserve_addr + offset;
> > > > >   } else {
> > > > > @@ -135,6 +137,8 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
> > > > >                                   EFI_LOADER_DATA,
> > > > >                                   *reserve_size / EFI_PAGE_SIZE,
> > > > >                                   (efi_physical_addr_t *)reserve_addr);
> > > > > +         if (status != EFI_SUCCESS)
> > > > > +                 pr_efi_err(sys_table_arg, "regular allocate_pages() failed\n");
> > > > >   }
> > > >
> > > > Not sure I see the need to distinsuish the 'KASLR' case from the 'regular'
> > > > case -- only one should run, right?  That also didn't seem to be part of
> > > > the use-case in the commit, unless I'm missing something.
> > >
> > > I just did that to help with differentiating the cases. Maybe something
> > > was special about KASLR picking the wrong location that triggered the
> > > failure, etc.
> > >
> > > > Maybe combine the prints as per the diff below?
> > >
> > > That could work. If you're against the KASLR vs regular thing, I can
> > > respin the patch?
> >
> > Happy to Ack it with that change, although I suppose it's ultimately up
> > to Ard :)
> >
> 
> No objections from me, but I prefer Will's version.

I took a look at this again... to report the failures as Will suggests,
it would look like this:

--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -138,12 +138,14 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
 	}
 
 	if (status != EFI_SUCCESS) {
+		pr_efi_err(sys_table_arg, "allocate_pages() failed\n");
+
 		*reserve_size = kernel_memsize + TEXT_OFFSET;
 		status = efi_low_alloc(sys_table_arg, *reserve_size,
 				       MIN_KIMG_ALIGN, reserve_addr);
 
 		if (status != EFI_SUCCESS) {
-			pr_efi_err(sys_table_arg, "Failed to relocate kernel\n");
+			pr_efi_err(sys_table_arg, "efi_low_alloc() failed\n");
 			*reserve_size = 0;
 			return status;
 		}

My reasoning for putting the failure earlier is to differentiate which
path was taken where the allocate_pages() failed: either regular or
KASLR. If that's really not considered important here, I can send the
above patch... Thoughts?

-- 
Kees Cook
