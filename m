Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B94C06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2C0206A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UnhOZorS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfGCBPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:15:25 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38023 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGCBPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:15:25 -0400
Received: by mail-qt1-f195.google.com with SMTP id n11so760796qtl.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 18:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=liD/9MOuZoViFzGGyLdGUss/Gqo1ol5fJSSMhDITAQY=;
        b=UnhOZorS3ucGouUUJ6xafrtEEsrX5ysAkBVI/dg0ZDjAor0OxuBA66FjAsrdJzKZqa
         G3rtRFX3LZwSYqMOBRJdLP9vOEpUJGse5xkqxCgJgkoHH6ZETtC2CglOl4Gz5eFwpqB9
         QzIxbsAgExukM9P5cCYF4G/pWMgFuyXXXJu+u3Y4bLJtZMGGp8agn2dYu+GgusYFkrY0
         DjmP1xdzXz714lNjvE40LvuRv89Cq5LlyEdBR8fPDZmzLsUDw9f5zp7ObEGjtZEXBozS
         GWnd9fyxQj73uY3RTiDeaKO0HgGB35X+h7NDpv4bt5E6fuwbyoqXx5aVYiSemB1oaeTV
         JcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=liD/9MOuZoViFzGGyLdGUss/Gqo1ol5fJSSMhDITAQY=;
        b=a/QsiEs2sZGLW0r/CkwrQtOnelj+RoCaMMlSVPJnMhE3WEF8W/CPknAlHHwUcmVWoP
         saimTOvtRhjJ2LPYPh0xHXDNETiYQbKzDroinec/b3hEMtmsJ0U+HwiWray9ilkY9kVk
         7S29st0SnIqsiLp7vX57GMCAT4R9VPlwoxycfyo0uIHw/EPQXVJg8l3Cxk7dI1F7DDml
         plJpVWMKWO9hQ43YWlXcblm7QxRXb0HMKpQRsWoNFJ2+IvcP19CKXHrsRJPFO3mof1rz
         GdZV3t4Pwya/+Xic2fZ40ya1RRRpbtX6LryhE/oT7Uvnkt24p88unme182PicLjSKY0G
         gCcw==
X-Gm-Message-State: APjAAAV7AYFD8CZYjboI/qRj3kcb+x/Mp/2ChK2dkcOqjScPU8as2Y41
        IqYfugB6ye2GJPrALAXFBC1SqA==
X-Google-Smtp-Source: APXvYqxT1ad2sCuVGtqHLhWSofYS4jtico3ZGFHLaY5pqoKGA8G7OYoBujn1EZbSkY3AoMmJOvEP3A==
X-Received: by 2002:a0c:d91b:: with SMTP id p27mr28714349qvj.236.1562116523841;
        Tue, 02 Jul 2019 18:15:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id a21sm255229qkg.47.2019.07.02.18.15.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2019 18:15:23 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hiTrm-0004FU-T2; Tue, 02 Jul 2019 22:15:22 -0300
Date:   Tue, 2 Jul 2019 22:15:22 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     ira.weiny@intel.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v4] mm/swap: Fix release_pages() when releasing devmap
 pages
Message-ID: <20190703011522.GA15993@ziepe.ca>
References: <20190605214922.17684-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190605214922.17684-1-ira.weiny@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 02:49:22PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> release_pages() is an optimized version of a loop around put_page().
> Unfortunately for devmap pages the logic is not entirely correct in
> release_pages().  This is because device pages can be more than type
> MEMORY_DEVICE_PUBLIC.  There are in fact 4 types, private, public, FS
> DAX, and PCI P2PDMA.  Some of these have specific needs to "put" the
> page while others do not.
> 
> This logic to handle any special needs is contained in
> put_devmap_managed_page().  Therefore all devmap pages should be
> processed by this function where we can contain the correct logic for a
> page put.
> 
> Handle all device type pages within release_pages() by calling
> put_devmap_managed_page() on all devmap pages.  If
> put_devmap_managed_page() returns true the page has been put and we
> continue with the next page.  A false return of
> put_devmap_managed_page() means the page did not require special
> processing and should fall to "normal" processing.
> 
> This was found via code inspection while determining if release_pages()
> and the new put_user_pages() could be interchangeable.[1]
> 
> [1] https://lore.kernel.org/lkml/20190523172852.GA27175@iweiny-DESK2.sc.intel.com/
> 
> Cc: Jérôme Glisse <jglisse@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from V3:
> 	Update comment to the one provided by John
> 
> Changes from V2:
> 	Update changelog for more clarity as requested by Michal
> 	Update comment WRT "failing" of put_devmap_managed_page()
> 
> Changes from V1:
> 	Add comment clarifying that put_devmap_managed_page() can still
> 	fail.
> 	Add Reviewed-by tags.
> 
>  mm/swap.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Andrew,

As per the discussion on the hmm thread I took this patch into the
hmm.git as the conflict that was created with CH's rework was tricky -
the resolution is simple, but keeping Ira's hunk instead of the delete
is, IMHO, subtle.

Regards, 
Jason
