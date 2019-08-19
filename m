Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4535C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8EA22CE8
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5vnuhw5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfHSTG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:06:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43784 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbfHSTG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 15:06:58 -0400
Received: by mail-pf1-f193.google.com with SMTP id v12so1709115pfn.10;
        Mon, 19 Aug 2019 12:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XKxoNzwl2f7tdJUzSZBy+zHR43qV/Sy81NVyGH0mZAY=;
        b=H5vnuhw53+NFqjevMuItdNGkvMQO3oybGlnseLaTzRUYFaQqAmlEiFwe3cgkLC155a
         ffXc8jnVqNbeU7F0wO+ZFXomSROUm9d2loD/1r7jpAcGJ7uCJxSj01gt9hsheZreh/Dt
         F7fRPSfIJwfXpH+llgxQpv/PVq/xko9VYTeXdw8Js2Ll5eA1OqoCnXxwwpgNkv+ZSCdL
         dv7tYLjQ/DZXlWPEsE8lnaC3OyaGGwkoxyhyYWehk98rgkUJJwv7gE8gBT6stez3kqrz
         1LKBaF+MZk4hoMH+BctaBbtPU1pPwOe0og8f29wb68PGbdNgorYdgEumGMPrFGr2hY10
         yXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XKxoNzwl2f7tdJUzSZBy+zHR43qV/Sy81NVyGH0mZAY=;
        b=AAB5agow6vvwi9KHwcrbCBPiMa3a6iKAgCbWWLI/u0t4s6JbQdZcnuzZsEySfU8DRz
         qqTflzygJEEaCLvsfogJrIPaX/7IplUToK7HezNcsENWfodOSWS6ge0BEBTztrinEjF2
         5mZ62HXzqAFPQPBeRa3sU9Fm1QMxqBlvNQH5i0FEBqMVlnOBEPFZ4aVGhR3ORHJrVaKD
         oS4cANFgumUPRaF6ktQapOgCI6CbErUo5LIAk6+wV9GCX/u/jajcjWRJ1nYufGdhSPXV
         wVA6hNLeeApcqOnWYjhYTgek9SuyYH2HarIT3WXxg6lqQ9pGgZWo5RzjxvHftodC7JqQ
         Nj+A==
X-Gm-Message-State: APjAAAU9GQpa2f0y876U5DZdNGPYAmPUz/vZywkbYrfhmyuBZm6mhmhY
        v4rbFGZEltCNzR2QAdNr2pM=
X-Google-Smtp-Source: APXvYqznze8pzlJmKpgW/Tcy7NikGDCleK4bKxe5cEVOB63r5vKAXucpjQhiJk1v0YBDhTmB1jbcBQ==
X-Received: by 2002:a63:4612:: with SMTP id t18mr21505996pga.85.1566241617995;
        Mon, 19 Aug 2019 12:06:57 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id k3sm28690589pfg.23.2019.08.19.12.06.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 12:06:57 -0700 (PDT)
Date:   Tue, 20 Aug 2019 00:36:47 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Dimitri Sivanich <sivanich@hpe.com>
Cc:     jhubbard@nvidia.com, jglisse@redhat.com, ira.weiny@intel.com,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        william.kucharski@oracle.com, hch@lst.de,
        inux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees][PATCH v6 1/2] sgi-gru: Convert put_page()
 to put_user_page*()
Message-ID: <20190819190647.GA6261@bharath12345-Inspiron-5559>
References: <1566157135-9423-1-git-send-email-linux.bhar@gmail.com>
 <1566157135-9423-2-git-send-email-linux.bhar@gmail.com>
 <20190819125611.GA5808@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190819125611.GA5808@hpe.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 07:56:11AM -0500, Dimitri Sivanich wrote:
> Reviewed-by: Dimitri Sivanich <sivanich@hpe.com>
Thanks!

John, would you like to take this patch into your miscellaneous
conversions patch set?

Thank you
Bharath
> On Mon, Aug 19, 2019 at 01:08:54AM +0530, Bharath Vedartham wrote:
> > For pages that were retained via get_user_pages*(), release those pages
> > via the new put_user_page*() routines, instead of via put_page() or
> > release_pages().
> > 
> > This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
> > ("mm: introduce put_user_page*(), placeholder versions").
> > 
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: Jérôme Glisse <jglisse@redhat.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Dimitri Sivanich <sivanich@sgi.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: William Kucharski <william.kucharski@oracle.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > Cc: linux-kernel-mentees@lists.linuxfoundation.org
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> > Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> > Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> > ---
> >  drivers/misc/sgi-gru/grufault.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
> > index 4b713a8..61b3447 100644
> > --- a/drivers/misc/sgi-gru/grufault.c
> > +++ b/drivers/misc/sgi-gru/grufault.c
> > @@ -188,7 +188,7 @@ static int non_atomic_pte_lookup(struct vm_area_struct *vma,
> >  	if (get_user_pages(vaddr, 1, write ? FOLL_WRITE : 0, &page, NULL) <= 0)
> >  		return -EFAULT;
> >  	*paddr = page_to_phys(page);
> > -	put_page(page);
> > +	put_user_page(page);
> >  	return 0;
> >  }
> >  
> > -- 
> > 2.7.4
> > 
