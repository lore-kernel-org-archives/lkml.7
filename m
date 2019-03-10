Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CABC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 05:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15162086A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 05:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghaokLF8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbfCJFHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 00:07:45 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46371 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfCJFHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 00:07:45 -0500
Received: by mail-pf1-f194.google.com with SMTP id g6so1186799pfh.13;
        Sat, 09 Mar 2019 21:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RQs+sCkg1041UmwvA5LQtuLiVsbtinmDeYg6aLDahps=;
        b=ghaokLF8w+wpZ5b2SUWOkxwQVnL/bhcuM3cHU9tPJgFDD5QGxD7gzOwQ/LXXfUf1kT
         37AuJkSysjoPcuqVaxd3Wmr3+taPl12O3dWIxCI7oEKwEWl3NwtKROWGgzIPhWn/Q5Bj
         vaVWokQEEvHFQEe21O6AuTH7rBG4JSnPh2kagGNKnqpwiuG+zeO9dlHNmgJMi4QCsQce
         YW+eeF0Wb4ToxmRL77PJ2IdrOvtGF9hfg1utud+ZQAw4SNA/qfXyVev5PJKa98v2o9wa
         cdh+wYzCFOOdJeL0+YYSLDNotHqn+5lzjvBvomR1QfEwiDnAavcrzZn8OrRHAkoRCKcK
         I+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RQs+sCkg1041UmwvA5LQtuLiVsbtinmDeYg6aLDahps=;
        b=XJ6m2e0hzAG5Hlj/VnkFTDqEFak0JKH9Nse1GOPhIkq+QKfbBy0xE11nyowTRoWfdB
         VNL1FLE1GAsil+5Dk2JEJxeorfcn9I0xO860i84uPArsteVNhqmOH05Q0UHCZz3nXEPV
         Sd6zSimUtSweF2Tb/VbX9DyUgdBrFCQZq2mEz5k1wWn7QUeGE2/hh6KyQusxLtNqRECs
         jgpOZBI+0j7C9xkL1egeYoUoWkWbTJsVKprbROVfLbPzD3dyVx46C4BuSo2SMXOF35n8
         8bLMKxzxugsPCnHh0+qUCpw/SRANxeeR4WHaekUdnJTsGcaIUHC2J1A+YtIuBLuAtmpE
         Bz4w==
X-Gm-Message-State: APjAAAWdW/8ED8LUo/cRO95Dc6GqGx+366cmkPWSCiWft5fAxMlaEAiv
        0RZ+Uh63s8IQtUOngT33bAA=
X-Google-Smtp-Source: APXvYqxQqv/kVIWAWauEPjas9MTPmLRTVFm0E7tEUa1mfYofhuPFtkncI3/hHBz+tXVcR7/icGaxXQ==
X-Received: by 2002:a62:788a:: with SMTP id t132mr27051293pfc.101.1552194464204;
        Sat, 09 Mar 2019 21:07:44 -0800 (PST)
Received: from localhost (www.xihetech.top. [159.203.232.101])
        by smtp.gmail.com with ESMTPSA id h64sm3254547pfj.40.2019.03.09.21.07.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Mar 2019 21:07:43 -0800 (PST)
From:   Sean Fu <fxinrong@gmail.com>
X-Google-Original-From: Sean Fu <Sean@linux-xjtn>
Date:   Sun, 10 Mar 2019 13:07:32 +0800
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Sean Fu <fxinrong@gmail.com>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: Use kmem_zalloc for bp->b_pages.
Message-ID: <20190310050608.dtidrfuqepze6uoh@linux-xjtn>
References: <20190309153636.14154-1-fxinrong@gmail.com>
 <20190309173230.GA4359@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190309173230.GA4359@magnolia>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 09, 2019 at 09:32:30AM -0800, Darrick J. Wong wrote:
> On Sat, Mar 09, 2019 at 11:36:36PM +0800, Sean Fu wrote:
> > Change the allocation of bp->b_pages to use kmem_zalloc instead of
> > kmem_alloc.
> > Remove unnecessary memset for bp->b_pages.
> >
> > This reduces text size by 42 bytes.
> > Before:
> >    text	   data	    bss	    dec	    hex	filename
> >   23335	    588	      8	  23931	   5d7b	./fs/xfs/xfs_buf.o
> > After:
> >    text	   data	    bss	    dec	    hex	filename
> >   23293	    588	      8	  23889	   5d51	./fs/xfs/xfs_buf.o
> >
> > Signed-off-by: Sean Fu <fxinrong@gmail.com>
> > ---
> >  fs/xfs/xfs_buf.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> > index 4f5f2ff3f70f..be4f740b97c1 100644
> > --- a/fs/xfs/xfs_buf.c
> > +++ b/fs/xfs/xfs_buf.c
> > @@ -289,12 +289,11 @@ _xfs_buf_get_pages(
> >  		if (page_count <= XB_PAGES) {
> >  			bp->b_pages = bp->b_page_array;
> >  		} else {
> > -			bp->b_pages = kmem_alloc(sizeof(struct page *) *
> > +			bp->b_pages = kmem_zalloc(sizeof(struct page *) *
> >  						 page_count, KM_NOFS);
> >  			if (bp->b_pages == NULL)
> >  				return -ENOMEM;
> >  		}
> > -		memset(bp->b_pages, 0, sizeof(struct page *) * page_count);
>
> Does this leave b_pages uninitialized in the page_count <= XB_PAGES
> case?
bp is allocated by kmem_zone_zalloc, But i will take a deep look at xfs_buf_associate_memory.
>
> --D
>
> >  	}
> >  	return 0;
> >  }
> > --
> > 2.16.4
> >
