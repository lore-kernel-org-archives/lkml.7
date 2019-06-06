Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84790C28EB4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B3420866
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YyM3d9F8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbfFFOxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 10:53:05 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45566 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbfFFOxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 10:53:05 -0400
Received: by mail-qt1-f195.google.com with SMTP id j19so2918235qtr.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 07:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rwk3g2mjO7u8AyfAS8Q2YGcDDqcuXwzQCBazZp8dMOI=;
        b=YyM3d9F8NpTGqs+6Oz/bFIAwDIb6AMR9dQjZvcG7jugaKFVOss+SFYSKHn5pCRSCYr
         atqIMgKwQaeWpTsRFv4ZG8QNCX4WZuJuViyRchCJBxcIp5ccRTDkx5hpCWxB+no+ettb
         KgTLHgA7tq73Brk3UOcybhh2F+vU4epOsvBPlwyl5be3TDs1XrHC8J1Ot6ESqzM7ONv+
         /ZxelDbLEzGRibnzXWb4cDMn6rSHPXhvSIif/dA92YR0yWnsJ0ZANAG3qcMzVniUszzE
         rBTQlSurX9TXV5LG5nwdaZUud6L9MPFKhCLVTA4AbEMLQYYGEAuJ9eqFxJDXQDgwHxED
         7T/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rwk3g2mjO7u8AyfAS8Q2YGcDDqcuXwzQCBazZp8dMOI=;
        b=ZCtq32Tf8tlCL0NFDU/1VjXLasldy+uan/rsr55JNzew8RV/vm92xjC2CsGxk+RTsf
         2RRrEF80NllePAoMDzEIOJH3sGirdIqLu2HmEUhiLdOCBS4NGESOLETIDhYtsL7gP+je
         HWUVdbGjsKnXE6WGHoELu5nvi9idNHjfQgKbE44mlsGug/E9S9/r35SnwoAYS/toGO8V
         1gK8vufL86T9PR4/DLi7I7cAogwGFHMLIGgf0CRGOuX0YwB7Um3JcNNwdyxI33qmgBXk
         PneVzWzw2oAg0tl0d63VH9jThOZdk+NAKUTTzWDyYwG4zn6EFiIhMBUHsXMdLEboJlsb
         onUQ==
X-Gm-Message-State: APjAAAWkvWgWGyJbp9xY9XCQkElZ7J4h1QKSPxK/vnRwqMo/fBqmsSsf
        ckzf2pIakfMSaYZaS+QDFH+VjA==
X-Google-Smtp-Source: APXvYqzogf8+qz/m25zpvUSWX8ZermCY/xWYAkBSXOmj0SwgnGPv1iHRExXEqe+teTmO50fXGzbJuQ==
X-Received: by 2002:ad4:53c2:: with SMTP id k2mr37787769qvv.15.1559832784348;
        Thu, 06 Jun 2019 07:53:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id t30sm795128qkm.39.2019.06.06.07.53.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 07:53:04 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hYtlH-0001FD-GL; Thu, 06 Jun 2019 11:53:03 -0300
Date:   Thu, 6 Jun 2019 11:53:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     rcampbell@nvidia.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/5] mm/hmm: HMM documentation updates and code fixes
Message-ID: <20190606145303.GA4698@ziepe.ca>
References: <20190506232942.12623-1-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506232942.12623-1-rcampbell@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 04:29:37PM -0700, rcampbell@nvidia.com wrote:
> From: Ralph Campbell <rcampbell@nvidia.com>
> 
> I hit a use after free bug in hmm_free() with KASAN and then couldn't
> stop myself from cleaning up a bunch of documentation and coding style
> changes. So the first two patches are clean ups, the last three are
> the fixes.
> 
> Ralph Campbell (5):
>   mm/hmm: Update HMM documentation
>   mm/hmm: Clean up some coding style and comments

I applied these two to hmm.git

>   mm/hmm: hmm_vma_fault() doesn't always call hmm_range_unregister()

This one needs revision

>   mm/hmm: Use mm_get_hmm() in hmm_range_register()
>   mm/hmm: Fix mm stale reference use in hmm_free()

I belive we all agreed that the approach in the RFC series I sent is
preferred, so these are superseded by that series.

Thanks,
Jason
