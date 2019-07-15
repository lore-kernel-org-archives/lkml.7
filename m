Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B13C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4663A2086C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vRaErLWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732639AbfGOUw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:52:27 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35295 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729640AbfGOUw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 16:52:26 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so8908301plp.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 13:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kR4xbKeLkqzM5m4IkfGOvFM7+dvSxhNFEJ7oNVJrvqQ=;
        b=vRaErLWauN0PK2S1rhodMt5sJ3WgJaXgnY2tZZxt8XarHR9jtlCcHgwbau1887Ce6V
         wPwnxhzyeoa24uBZQy/lPcYwOxNYpnCjVZOAYrzllp8Jyldk5UMiNAkuK/5gILgpL7zT
         I/+OhYEkG4eAPKGLBzTMxMuui60/CxzsYA7S+G0SNSSHgkuqThYPYFSErYnVpHXbHOzs
         96nqyqsVFaFugyW+U8nFSigdHjuizyEtOxUb+POScUYS3z3JezDsjI6snDDWhsHxK8Bx
         GtaT0Zy5clHx4yrkJBeaMpdOrIW6qz1NzJ+5xML90nBEkDt+FTMB1wts3Bf9xRU/tdHX
         b0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kR4xbKeLkqzM5m4IkfGOvFM7+dvSxhNFEJ7oNVJrvqQ=;
        b=OUKrrB3K7Txlu/CFEOvrqhX67maugFtA8JC5qrueKje05nWZ/XT6Xt5JGq0mKcs6Ms
         /iUIjVtX2d7doB3+CwfwZuc0WlU3h4ZZJ8XDw+RtATXHqBpgnuManMV0+5R13m0F6T9o
         5k2mp6tpMw7xUgvMR7kMezNy8sdxqPiW55VMBpBGXsjXB/kTf3JjdssIZqup7jNlXfVp
         innrLh+9fT/Xn51OIf4td/8rB6IQVZXTMHVFQ7bTSCqssFl8F5EzGLIsSu23Rnl7NQB9
         B802dyQ9n4631rZnwKNnsRYXWEbTI6JZIEBeojvDIPsEE72l4Bx3evQtbvzh8qxSSVO1
         ZtAw==
X-Gm-Message-State: APjAAAW2ubjaKHrIfdoFMcfXB7XCAKHdQvHxuZxo6q5c7v+jhFm6sw1o
        t2FNAJWWqm/PLtLEgh1tLYc=
X-Google-Smtp-Source: APXvYqxEa3WgGh3U0Jn4/Smo82YSRjT7yS9UoqfVPVb6FVIPqlesr9mgxDqSMQvxauH1zQPJ8wmqLA==
X-Received: by 2002:a17:902:4c88:: with SMTP id b8mr31598648ple.29.1563223945760;
        Mon, 15 Jul 2019 13:52:25 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.33])
        by smtp.gmail.com with ESMTPSA id 185sm22172155pfa.170.2019.07.15.13.52.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 13:52:25 -0700 (PDT)
Date:   Tue, 16 Jul 2019 02:22:16 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     ira.weiny@intel.com, gregkh@linuxfoundation.org,
        Matt.Sickler@daktronics.com, jglisse@redhat.com,
        devel@driverdev.osuosl.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: kpc2000: Convert put_page() to put_user_page*()
Message-ID: <20190715205216.GD21161@bharath12345-Inspiron-5559>
References: <20190715195248.GA22495@bharath12345-Inspiron-5559>
 <2604fcd1-4829-d77e-9f7c-d4b731782ff9@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2604fcd1-4829-d77e-9f7c-d4b731782ff9@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 01:14:13PM -0700, John Hubbard wrote:
> On 7/15/19 12:52 PM, Bharath Vedartham wrote:
> > There have been issues with get_user_pages and filesystem writeback.
> > The issues are better described in [1].
> > 
> > The solution being proposed wants to keep track of gup_pinned pages which will allow to take furthur steps to coordinate between subsystems using gup.
> > 
> > put_user_page() simply calls put_page inside for now. But the implementation will change once all call sites of put_page() are converted.
> > 
> > I currently do not have the driver to test. Could I have some suggestions to test this code? The solution is currently implemented in [2] and
> > it would be great if we could apply the patch on top of [2] and run some tests to check if any regressions occur.
> 
> Hi Bharath,
> 
> Process point: the above paragraph, and other meta-questions (about the patch, rather than part of the patch) should be placed either after the "---", or in a cover letter (git-send-email --cover-letter). That way, the patch itself is in a commit-able state.
> 
> One more below:
Will fix that in the next version. 
> > 
> > [1] https://lwn.net/Articles/753027/
> > [2] https://github.com/johnhubbard/linux/tree/gup_dma_core
> > 
> > Cc: Matt Sickler <Matt.Sickler@daktronics.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jérôme Glisse <jglisse@redhat.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: linux-mm@kvack.org
> > Cc: devel@driverdev.osuosl.org
> > 
> > Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> > ---
> >  drivers/staging/kpc2000/kpc_dma/fileops.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
> > index 6166587..82c70e6 100644
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
> > @@ -229,9 +227,7 @@ void  transfer_complete_cb(struct aio_cb_data *acd, size_t xfr_count, u32 flags)
> >  	
> >  	dma_unmap_sg(&acd->ldev->pldev->dev, acd->sgt.sgl, acd->sgt.nents, acd->ldev->dir);
> >  	
> > -	for (i = 0 ; i < acd->page_count ; i++){
> > -		put_page(acd->user_pages[i]);
> > -	}
> > +	put_user_pages(acd->user_pages, acd->page_count);
> >  	
> >  	sg_free_table(&acd->sgt);
> >  	
> > 
> 
> Because this is a common pattern, and because the code here doesn't likely need to set page dirty before the dma_unmap_sg call, I think the following would be better (it's untested), instead of the above diff hunk:
>
> diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
> index 48ca88bc6b0b..d486f9866449 100644
> --- a/drivers/staging/kpc2000/kpc_dma/fileops.c
> +++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
> @@ -211,16 +211,13 @@ void  transfer_complete_cb(struct aio_cb_data *acd, size_t xfr_count, u32 flags)
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
>  
>         for (i = 0 ; i < acd->page_count ; i++) {
> -               put_page(acd->user_pages[i]);
> +               if (!PageReserved(acd->user_pages[i])) {
> +                       put_user_pages_dirty(&acd->user_pages[i], 1);
> +               else
> +                       put_user_page(acd->user_pages[i]);
>         }
>  
>         sg_free_table(&acd->sgt);
I had my doubts on this. This definitley needs to be looked at by the
driver author. 
> Assuming that you make those two changes, you can add:
> 
>     Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Great!
> 
> thanks,
> -- 
> John Hubbard
> NVIDIA
