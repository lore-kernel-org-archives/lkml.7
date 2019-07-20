Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAE7C76186
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 17:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2480F2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 17:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isL+NyTl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfGTRXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 13:23:20 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38169 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728743AbfGTRXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 13:23:19 -0400
Received: by mail-pl1-f196.google.com with SMTP id az7so17117038plb.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2019 10:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=txlmNAr+NwP/f9mdJ1YbslIVZwuCfLJ/aWnHfkbj/ng=;
        b=isL+NyTlYKatZjFTLLfqQMg0bH6Qo/HekdDHYYQyy0/3Z0BEB0Lni/tM/zgCffMTlo
         pp/fcwL0AJmBktORv2+a/dWw5bi/ZETD8tcYWw67bseE2wutp+fHY4+hti+Bgw7FifTh
         rar99b/E/YQMC2gbksQ7RFRuIx155d42kI6PFFlV+5TbuSeMN2VeW9IDbCazpJGXdzjT
         YivtETGegS1Z8Qn5VSd3eoXoy4mVaDA7KLtQGo13DVqD2QgZKlSeFvfeH2DSOdHPVNF+
         sYwhOLHeauEvyz1vdFoxINz7om4yaMsaR+zpyaMjSw3X60I5xZjOG6eKMxltWJ1PaGWe
         yOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=txlmNAr+NwP/f9mdJ1YbslIVZwuCfLJ/aWnHfkbj/ng=;
        b=DExPpuEb3D2SwPekGhUpWYIC8sW+M3NBnTnODDVBjisScXMxM0G7o4uQslZBaUEzis
         QAWYJ7vww2mP0yqfjOSW18Xii/xqNMFJhwfrZDv0Fj9bA8ntsE/R2e5j6z5G240K0gIw
         u1QSRtxsiTD8d4cQcPRd0C0bhzw6yOpuGoTMTchBFDay2X1H7p+wonEZwxiEnJERZl7+
         UesYYNmANrA89yYE9DjPU+IbHmp0Nj4stOnzjkV4k/lHtqVsaQ48Yvfu+LQej72nzbnK
         nAhP9hNzvXMQJAoKtvelT/0NDmK+BaHoirKHtDCYQLW5pk7rCnQoIdbefxvLNHZeulCl
         iPxg==
X-Gm-Message-State: APjAAAXI2/tjX5NOZIBmC4u7hWuGX9l5tlWWm4YK3gE/IiW4ev5VCXHY
        Hq5rzzaArV1A8iZVqO1vBGg=
X-Google-Smtp-Source: APXvYqwCl+0p4loNmBy9AS8aE4DKp7ExSSZ0OLYl/twU5R0/mvD/0nbRoJXX34M2Lb+/fuCT11r6Qg==
X-Received: by 2002:a17:902:e306:: with SMTP id cg6mr64062158plb.263.1563643398778;
        Sat, 20 Jul 2019 10:23:18 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id q63sm46216384pfb.81.2019.07.20.10.23.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jul 2019 10:23:18 -0700 (PDT)
Date:   Sat, 20 Jul 2019 22:53:11 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     ira.weiny@intel.com, jglisse@redhat.com,
        gregkh@linuxfoundation.org, Matt.Sickler@daktronics.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH v3] staging: kpc2000: Convert put_page to put_user_page*()
Message-ID: <20190720172310.GA3728@bharath12345-Inspiron-5559>
References: <20190719200235.GA16122@bharath12345-Inspiron-5559>
 <8bce5bb2-d9a5-13f1-7d96-27c41057c519@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8bce5bb2-d9a5-13f1-7d96-27c41057c519@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 02:28:39PM -0700, John Hubbard wrote:
> On 7/19/19 1:02 PM, Bharath Vedartham wrote:
> > There have been issues with coordination of various subsystems using
> > get_user_pages. These issues are better described in [1].
> > 
> > An implementation of tracking get_user_pages is currently underway
> > The implementation requires the use put_user_page*() variants to release
> > a reference rather than put_page(). The commit that introduced
> > put_user_pages, Commit fc1d8e7cca2daa18d2fe56b94874848adf89d7f5 ("mm: introduce
> > put_user_page*(), placeholder version").
> > 
> > The implementation currently simply calls put_page() within
> > put_user_page(). But in the future, it is to change to add a mechanism
> > to keep track of get_user_pages. Once a tracking mechanism is
> > implemented, we can make attempts to work on improving on coordination
> > between various subsystems using get_user_pages.
> > 
> > [1] https://lwn.net/Articles/753027/
> 
> Optional: I've been fussing about how to keep the change log reasonable,
> and finally came up with the following recommended template for these 
> conversion patches. This would replace the text you have above, because the 
> put_user_page placeholder commit has all the documentation (and then some) 
> that we need:
> 
> 
> For pages that were retained via get_user_pages*(), release those pages
> via the new put_user_page*() routines, instead of via put_page().
> 
> This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
> ("mm: introduce put_user_page*(), placeholder versions").
Great then, I ll send another patch with the updated changelog.
> 
> For the change itself, you will need to rebase it onto the latest 
> linux.git, as it doesn't quite apply there. 
> 
> Testing is good if we can get it, but as far as I can tell this is
> correct, so you can also add:
> 
>     Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Thanks! 
> thanks,
> -- 
> John Hubbard
> NVIDIA
>
> > 
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: Jérôme Glisse <jglisse@redhat.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Matt Sickler <Matt.Sickler@daktronics.com>
> > Cc: devel@driverdev.osuosl.org 
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> > ---
> > Changes since v1
> > 	- Improved changelog by John's suggestion.
> > 	- Moved logic to dirty pages below sg_dma_unmap
> > 	and removed PageReserved check.
> > Changes since v2
> > 	- Added back PageResevered check as suggested by John Hubbard.
> > 	
> > The PageReserved check needs a closer look and is not worth messing
> > around with for now.
> > 
> > Matt, Could you give any suggestions for testing this patch?
> >     
> > If in-case, you are willing to pick this up to test. Could you
> > apply this patch to this tree
> > https://github.com/johnhubbard/linux/tree/gup_dma_core
> > and test it with your devices?
> > 
> > ---
> >  drivers/staging/kpc2000/kpc_dma/fileops.c | 17 ++++++-----------
> >  1 file changed, 6 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
> > index 6166587..75ad263 100644
> > --- a/drivers/staging/kpc2000/kpc_dma/fileops.c
> > +++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
> > @@ -198,9 +198,7 @@ int  kpc_dma_transfer(struct dev_private_data *priv, struct kiocb *kcb, unsigned
> >  	sg_free_table(&acd->sgt);
> >   err_dma_map_sg:
> >   err_alloc_sg_table:
> > -	for (i = 0 ; i < acd->page_count ; i++){
> > -		put_page(acd->user_pages[i]);
> > -	}
> > +	put_user_pages(acd->user_pages, acd->page_count);
> >   err_get_user_pages:
> >  	kfree(acd->user_pages);
> >   err_alloc_userpages:
> > @@ -221,16 +219,13 @@ void  transfer_complete_cb(struct aio_cb_data *acd, size_t xfr_count, u32 flags)
> >  	
> >  	dev_dbg(&acd->ldev->pldev->dev, "transfer_complete_cb(acd = [%p])\n", acd);
> >  	
> > -	for (i = 0 ; i < acd->page_count ; i++){
> > -		if (!PageReserved(acd->user_pages[i])){
> > -			set_page_dirty(acd->user_pages[i]);
> > -		}
> > -	}
> > -	
> >  	dma_unmap_sg(&acd->ldev->pldev->dev, acd->sgt.sgl, acd->sgt.nents, acd->ldev->dir);
> >  	
> > -	for (i = 0 ; i < acd->page_count ; i++){
> > -		put_page(acd->user_pages[i]);
> > +	for (i = 0; i < acd->page_count; i++) {
> > +		if (!PageReserved(acd->user_pages[i]))
> > +			put_user_pages_dirty(&acd->user_pages[i], 1);
> > +		else
> > +			put_user_page(acd->user_pages[i]);
> >  	}
> >  	
> >  	sg_free_table(&acd->sgt);
> > 
