Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B954FC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBC22238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiPttf3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404016AbfGYLSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 07:18:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35019 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390493AbfGYLSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 07:18:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id s1so16578989pgr.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 04:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1FbnKtI3LwQwgUsr/g3MUa9Py+KRgg38b6IrILFDUhU=;
        b=RiPttf3VULytvTV1gQCGGIofaH3cmMvvcLlShfvYsVeKFzWjG/kfl/UguNaNy7/Dfo
         FVmH2PIQAE2iC69ldXu5sNi9yS2z2PuKCOKbuswCunkNuJwrNoEzBk2cOmbgVNaQZsql
         vWiZsd67ciYl95JIzgVUAExNBHZtC8mivPnxWK78M7nMNjVgpYOHWMOxtXNNo0v9cqC2
         r/T/+iTbpnJX5k7uurmQUrJ54neQWBfYxzH6kvGeSJ+H2ILyhbfMSTjrInxG6dRzsZPQ
         t9CzL6qva/lkcI8XGhVlO+HAbtcciB4SanHFtxVMYgiTsIzVps4/IUCTGBW581LK8m7v
         GkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1FbnKtI3LwQwgUsr/g3MUa9Py+KRgg38b6IrILFDUhU=;
        b=iMGZBn2JHnv2wC6U9ZqHFt2je5tZYGomkvjXQYqPHMR834kadU2j+CAXEx95h1EIOq
         YZlAsyYfN/OddyhgWccDaavcfA+xfox8gkS8FEF6QcXTjRstQa9pbKIn/ygcq8mQCx0d
         J46j2mvbZkbLUBb9dZ71DLrfcW4k1aHG8KrlmcNTCblrC69jA6szCZ3dNXPnkarvhNZn
         zgjXttSCj9ipYvwn258NhPvkblC9yPsXsW8Ltpc95fHdbeQ/eYO1U4AnC9yHPvKQvAuP
         aX0iBv34ovOiCfzp1g13+/3e8r7T2XwzpqCMfk6hZJZTlTG6dr/o06grd4V1aknHc5oK
         Vgxg==
X-Gm-Message-State: APjAAAUDejFJfMY4e6yDvUFaYRL1j6+g2sfxIuq3sR5bkHtEKfDGPK01
        3xbXEPsffQxNWDtfvnlsmyY=
X-Google-Smtp-Source: APXvYqwWrdl5FJRCm09CQlypUGpElLXPTtXQhNRGvN4DIQ3ybEer3KGwJh1GSg+qHIHbIRJ+x3Bfug==
X-Received: by 2002:a63:121b:: with SMTP id h27mr70608971pgl.335.1564053523202;
        Thu, 25 Jul 2019 04:18:43 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id s15sm48874992pfd.183.2019.07.25.04.18.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 04:18:42 -0700 (PDT)
Date:   Thu, 25 Jul 2019 16:48:35 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     ira.weiny@intel.com, jglisse@redhat.com,
        Matt.Sickler@daktronics.com, jhubbard@nvidia.com,
        devel@driverdev.osuosl.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: kpc2000: Convert put_page to put_user_page*()
Message-ID: <20190725111834.GA12517@bharath12345-Inspiron-5559>
References: <20190720173214.GA4250@bharath12345-Inspiron-5559>
 <20190725074634.GB15090@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190725074634.GB15090@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 09:46:34AM +0200, Greg KH wrote:
> On Sat, Jul 20, 2019 at 11:02:14PM +0530, Bharath Vedartham wrote:
> > For pages that were retained via get_user_pages*(), release those pages
> > via the new put_user_page*() routines, instead of via put_page().
> > 
> > This is part a tree-wide conversion, as described in commit fc1d8e7cca2d ("mm: introduce put_user_page*(), placeholder versions").
> 
> Please line-wrap this line.
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
> > Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> > Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> > ---
> > Changes since v1
> >        - Improved changelog by John's suggestion.
> >        - Moved logic to dirty pages below sg_dma_unmap
> >        and removed PageReserved check.
> > Changes since v2
> >        - Added back PageResevered check as suggested by John Hubbard.
> > Changes since v3
> >        - Changed the commit log as suggested by John.
> >        - Added John's Reviewed-By tag
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
> > -- 
> > 2.7.4
> 
> This patch can not be applied at all :(
> 
> Can you redo it against the latest staging-next branch and resend?
> 
> thanks,
Yup. Will do that!
> greg k-h
