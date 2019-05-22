Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F52FC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E96221880
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbfEVV5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 17:57:45 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58304 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729996AbfEVV5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 17:57:43 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:b93f:9fae:b276:a89a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 611FD26397A;
        Wed, 22 May 2019 22:57:41 +0100 (BST)
Date:   Wed, 22 May 2019 23:57:38 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] mtd: onenand_base: Avoid fall-through warnings
Message-ID: <20190522235738.68059906@collabora.com>
In-Reply-To: <201905221403.642AF6092@keescook>
References: <20190522180446.GA30082@embeddedor>
        <201905221403.642AF6092@keescook>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019 14:30:11 -0700
Kees Cook <keescook@chromium.org> wrote:

> Sorry for being late to speaking up on this. I missed something in the
> code the first time I read the thread, that now stood out to me. Notes
> below...
> 
> On Wed, May 22, 2019 at 01:04:46PM -0500, Gustavo A. R. Silva wrote:
> > diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/onenand/onenand_base.c
> > index f41d76248550..6cf4df9f8c01 100644
> > --- a/drivers/mtd/nand/onenand/onenand_base.c
> > +++ b/drivers/mtd/nand/onenand/onenand_base.c
> > @@ -3280,12 +3280,14 @@ static void onenand_check_features(struct mtd_info *mtd)  
> 
> Reverse-order review, second hunk first:
> 
> >  	case ONENAND_DEVICE_DENSITY_2Gb:
> >  		/* 2Gb DDP does not have 2 plane */
> >  		if (!ONENAND_IS_DDP(this))
> >  			this->options |= ONENAND_HAS_2PLANE;
> >  		this->options |= ONENAND_HAS_UNLOCK_ALL;
> > +		/* Fall through - ? */
> >  
> >  	case ONENAND_DEVICE_DENSITY_1Gb:
> >  		/* A-Die has all block unlock */  
> 
> So, I think the ONENAND_DEVICE_DENSITY_2Gb should be a "break". Though,
> actually, it doesn't matter:
> 
>         case ONENAND_DEVICE_DENSITY_2Gb:
>                 /* 2Gb DDP does not have 2 plane */
>                 if (!ONENAND_IS_DDP(this))
>                         this->options |= ONENAND_HAS_2PLANE;
>                 this->options |= ONENAND_HAS_UNLOCK_ALL;
> 
>         case ONENAND_DEVICE_DENSITY_1Gb:
>                 /* A-Die has all block unlock */
>                 if (process)
>                         this->options |= ONENAND_HAS_UNLOCK_ALL;
>                 break;
> 
> Falling through from ONENAND_DEVICE_DENSITY_2Gb to
> ONENAND_DEVICE_DENSITY_1Gb will actually have no side-effects:
> ONENAND_HAS_UNLOCK_ALL was unconditionally set in ..._2Gb, so there is
> no reason to fall through to ..._1Gb. (But falling through is harmless.)
> 
> Now the first hunk:
> 
> >  			if ((this->version_id & 0xf) == 0xe)
> >  				this->options |= ONENAND_HAS_NOP_1;
> >  		}
> > +		/* Fall through - ? */
> >    
> 
>         case ONENAND_DEVICE_DENSITY_4Gb:
>                 if (ONENAND_IS_DDP(this))
>                         this->options |= ONENAND_HAS_2PLANE;
>                 else if (numbufs == 1) {
>                         this->options |= ONENAND_HAS_4KB_PAGE;
>                         this->options |= ONENAND_HAS_CACHE_PROGRAM;
>                         /*
>                          * There are two different 4KiB pagesize chips
>                          * and no way to detect it by H/W config values.
>                          *
>                          * To detect the correct NOP for each chips,
>                          * It should check the version ID as workaround.
>                          *
>                          * Now it has as following
>                          * KFM4G16Q4M has NOP 4 with version ID 0x0131
>                          * KFM4G16Q5M has NOP 1 with versoin ID 0x013e
>                          */
>                         if ((this->version_id & 0xf) == 0xe)
>                                 this->options |= ONENAND_HAS_NOP_1;
>                 }
> 
> Falling through from ONENAND_DEVICE_DENSITY_4Gb to
> ONENAND_DEVICE_DENSITY_2Gb looks like it would mean that
> ONENAND_HAS_2PLANE would be unconditionally set for ...4Gb, which seems
> very strange to expect:
> 
>                 if (ONENAND_IS_DDP(this))
>                         this->options |= ONENAND_HAS_2PLANE;
> ...
>                 if (!ONENAND_IS_DDP(this))
>                         this->options |= ONENAND_HAS_2PLANE;

Oops, didn't notice the ! on the second test.

> 
> However! This happens later:
> 
>         if (ONENAND_IS_4KB_PAGE(this))
>                 this->options &= ~ONENAND_HAS_2PLANE;
> 
> i.e. falling through to ...2Gb (which sets ONENAND_HAS_2PLANE) has no
> effect because when ONENAND_HAS_2PLANE isn't set (numbufs == 1), it gets
> _cleared_ by the above code due to ONENAND_HAS_4KB_PAGE getting set:

Are you sure !DDP implies num_bufs == 1?


> 
> #define ONENAND_IS_4KB_PAGE(this) \
>         (this->options & ONENAND_HAS_4KB_PAGE)
> 
> 
> Unfortunately, though, it's less clear about ONENAND_HAS_UNLOCK_ALL,
> which is getting set unconditionally for ...4Gb currently (due to the
> fallthrough to ...2Gb). However, this happens later:
> 
>         if (FLEXONENAND(this)) {
>                 this->options &= ~ONENAND_HAS_CONT_LOCK;
>                 this->options |= ONENAND_HAS_UNLOCK_ALL;
>         }
> ...
> #define FLEXONENAND(this) \
>         (this->device_id & DEVICE_IS_FLEXONENAND)
> 
> So it's possible this fall through has no effect (are all 4Gb density
> devices also FLEXONENAND devices?)
> 

All this look suspicious, and even if the fall through logic
has no side effects in practice (which I'm still not sure is the case),
I think it'd be better to explicitly set the flags that have
to be set in each case statement and add breaks.
