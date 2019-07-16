Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C428C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 10:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E5320880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 10:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1ei1CGt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733212AbfGPK2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 06:28:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44826 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733151AbfGPK2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 06:28:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id i18so9217276pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 03:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y9oHIuUnvA5xAOt2sG5I7PMnR70HX2a42btCOmZ0knc=;
        b=M1ei1CGtQUJ5wTz3qfdFMu+ibfhjsSqHNuABQXK+2mW2UaYsiKQmVgHImwaupyK1SJ
         WUzRu+v5p7JsCmFBucUUvbohrtTGD97XSBRI1dYMytdItzK17BNlRGMrQA+h/ELLHQzR
         LcE41K2Ds0I3L3RXd98KR7nMiZM5xKj7ndtMxKrcP1qX3ePptWLdDV5OTMPXyB0+JtMw
         Cm18CJIz9Z36j842xjw/5DYVtYdMGcg49LjUOFevHhJuhtJBtgUmsfxOJ7eJ7+mCIqIH
         DsxwZZcDk5a35gmc2Q+XPfARfNueBwJWzGiKzPi7CoLDdEWoaNtwPS7kePJcxf00Wcuc
         8yZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y9oHIuUnvA5xAOt2sG5I7PMnR70HX2a42btCOmZ0knc=;
        b=NycRN7QzcXnsAhmtKs4OriuqvGWjlYrf8qKEJcu++2gQEtyqXWuv0HQDe32dIKukOQ
         /si2fTKEKuyLL0SMdy7HS/5GkuLd14jgH0B9xwp/xOARDVDATVIstTBsNJMY9/da9Kpo
         fqnEpskKNsRZloJ7ERHcGIzUs4wl63ri8HuUJcyqAww4GSUwUPH76KRKKu9UfvXtiNR7
         WAKe92uB+9GqwZaDZJl7mjFCYKos9ZyT+p/CM9zFXfyi6lY0si1G19Ll6A4GW5nBJivn
         FFhTOVLc77+peL+nDo9AkzfwrmOf4B+pxyVsLe1NGRkjmqsvIgL0NSpEifBrIKdr683A
         SyeQ==
X-Gm-Message-State: APjAAAV79KDNFdhPMfDOJON+GStk60xtVcNmdWfoA8RxjZoM0CLF8i8E
        6k9xZ73mvBhrXSmOnQmzMIHZSaLmWyo=
X-Google-Smtp-Source: APXvYqzOWjwHADtg0IeTrZRs0dD/whTFszTRqY/XHlwCOHIyoUAXjjxmcFPlmNZSWKUocUa8VGy4Bw==
X-Received: by 2002:a63:494d:: with SMTP id y13mr33092205pgk.109.1563272903599;
        Tue, 16 Jul 2019 03:28:23 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id p27sm33040074pfq.136.2019.07.16.03.28.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 03:28:23 -0700 (PDT)
Date:   Tue, 16 Jul 2019 15:58:14 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Matt Sickler <Matt.Sickler@daktronics.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: kpc2000: Convert put_page() to put_user_page*()
Message-ID: <20190716102814.GA8715@bharath12345-Inspiron-5559>
References: <20190715195248.GA22495@bharath12345-Inspiron-5559>
 <2604fcd1-4829-d77e-9f7c-d4b731782ff9@nvidia.com>
 <SN6PR02MB4016687B605E3D97D699956EEECF0@SN6PR02MB4016.namprd02.prod.outlook.com>
 <82441723-f30e-5811-ab1c-dd9a4993d7df@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82441723-f30e-5811-ab1c-dd9a4993d7df@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 03:01:43PM -0700, John Hubbard wrote:
> On 7/15/19 2:47 PM, Matt Sickler wrote:
> > It looks like Outlook is going to absolutely trash this email.  Hopefully it comes through okay.
> > 
> ...
> >>
> >> Because this is a common pattern, and because the code here doesn't likely
> >> need to set page dirty before the dma_unmap_sg call, I think the following
> >> would be better (it's untested), instead of the above diff hunk:
> >>
> >> diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c
> >> b/drivers/staging/kpc2000/kpc_dma/fileops.c
> >> index 48ca88bc6b0b..d486f9866449 100644
> >> --- a/drivers/staging/kpc2000/kpc_dma/fileops.c
> >> +++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
> >> @@ -211,16 +211,13 @@ void  transfer_complete_cb(struct aio_cb_data
> >> *acd, size_t xfr_count, u32 flags)
> >>        BUG_ON(acd->ldev == NULL);
> >>        BUG_ON(acd->ldev->pldev == NULL);
> >>
> >> -       for (i = 0 ; i < acd->page_count ; i++) {
> >> -               if (!PageReserved(acd->user_pages[i])) {
> >> -                       set_page_dirty(acd->user_pages[i]);
> >> -               }
> >> -       }
> >> -
> >>        dma_unmap_sg(&acd->ldev->pldev->dev, acd->sgt.sgl, acd->sgt.nents, acd->ldev->dir);
> >>
> >>        for (i = 0 ; i < acd->page_count ; i++) {
> >> -               put_page(acd->user_pages[i]);
> >> +               if (!PageReserved(acd->user_pages[i])) {
> >> +                       put_user_pages_dirty(&acd->user_pages[i], 1);
> >> +               else
> >> +                       put_user_page(acd->user_pages[i]);
> >>        }
> >>
> >>        sg_free_table(&acd->sgt);
> > 
> > I don't think I ever really knew the right way to do this. 
> > 
> > The changes Bharath suggested look okay to me.  I'm not sure about the check for PageReserved(), though.  At first glance it appears to be equivalent to what was there before, but maybe I should learn what that Reserved page flag really means.
> > From [1], the only comment that seems applicable is
> > * - MMIO/DMA pages. Some architectures don't allow to ioremap pages that are
> >  *   not marked PG_reserved (as they might be in use by somebody else who does
> >  *   not respect the caching strategy).
> > 
> > These pages should be coming from anonymous (RAM, not file backed) memory in userspace.  Sometimes it comes from hugepage backed memory, though I don't think that makes a difference.  I should note that transfer_complete_cb handles both RAM to device and device to RAM DMAs, if that matters.
Yes. file_operations->read passes a userspace buffer which AFAIK is
anonymous memory.
> > [1] https://elixir.bootlin.com/linux/v5.2/source/include/linux/page-flags.h#L17
> > 
> 
> I agree: the PageReserved check looks unnecessary here, from my outside-the-kpc_2000-team
> perspective, anyway. Assuming that your analysis above is correct, you could collapse that
> whole think into just:
Since the file_operations->read passes a userspace buffer, I doubt that
the pages of the userspace buffer will be reserved.
> @@ -211,17 +209,8 @@ void  transfer_complete_cb(struct aio_cb_data *acd, size_t xfr_count, u32 flags)
>         BUG_ON(acd->ldev == NULL);
>         BUG_ON(acd->ldev->pldev == NULL);
>  
> -       for (i = 0 ; i < acd->page_count ; i++) {
> -               if (!PageReserved(acd->user_pages[i])) {
> -                       set_page_dirty(acd->user_pages[i]);
> -               }
> -       }
> -
>         dma_unmap_sg(&acd->ldev->pldev->dev, acd->sgt.sgl, acd->sgt.nents, acd->ldev->dir);
> -
> -       for (i = 0 ; i < acd->page_count ; i++) {
> -               put_page(acd->user_pages[i]);
> -       }
> +       put_user_pages_dirty(&acd->user_pages[i], acd->page_count);
>  
>         sg_free_table(&acd->sgt);
>  
> (Also, Matt, I failed to Cc: you on a semi-related cleanup that I just sent out for this
> driver, as long as I have your attention:
> 
>    https://lore.kernel.org/r/20190715212123.432-1-jhubbard@nvidia.com
> )
Matt will you be willing to pick this up for testing or do you want a
different patch?
> thanks,
> -- 
> John Hubbard
> NVIDIA
Thank you
Bharath
