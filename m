Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D871C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A0120881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RslugHZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388986AbfEWTre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:47:34 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38920 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388912AbfEWTrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:47:31 -0400
Received: by mail-qt1-f195.google.com with SMTP id y42so8220604qtk.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 12:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k6jEOw1s8FeruI8avosu7qbsQ0qwz52OhsgSY45eojI=;
        b=RslugHZP7bdpXCoWjNFMFQd+0DDkcFEtYA5UVOgDxkZL8DRCyAf3elcV7gyLZv/N3r
         Au3nZzEUorYMt3KTRDl7iv9fLmChs7tw2dtFGtlmc/DBiS0nlVYvpkwT6Dfudk9xbuyz
         29strAD1fMKYdTpCqzwPqg55vYFzEm91Y+tKBVbSs0faM+hj/8TQ66RkpRoR1Y2OLu78
         iwOrAgEuvBQAVVKO1yr4ctVHMPrpTFGPva06945X7+4ck5IWhcPXK6FPL/djJP49AdSu
         /sKVmxWjm/MJ5+sSVv3VJd6I8c9VlS2/Xre1Ku7275dhaawiX2LkVSmNlfEM/zlDsEso
         kIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k6jEOw1s8FeruI8avosu7qbsQ0qwz52OhsgSY45eojI=;
        b=QYkL1CM0F2JqhYLoPpN0I6sAiYkAAC4SudQfnDeEdpCK2PAbtsGHdS6tGFsXV7OQdk
         AMJRd/8a+YNU0khWqpRxTznx15f/+mw2CvfG+Cc+kOSRKRGI93jd9X1d7ltiB1IjxP55
         8w6gFte1bO2s8DBdBIbQHI2/zen/SWz9dPhgI0uysBCYWnWYQ8dmtqsw8Ny9Yi3sRPlh
         sCPCFw1/8qdPAwti2I1LXrocb0KI4C1/t+ayiY8scxGU4ZA/jO9+fcuRv9Lns0InFyqn
         9whb3sLHyH56yOqmGyL1eC+3HhPVdkXbduSdQhKNhjhOaGE2KQICQKkjjU9dqYh4wed7
         Fqtw==
X-Gm-Message-State: APjAAAW6oAoGkKL0Cz4XPHjJUcWHlD7/avYXxB3rVFDK8QDP500WPEoS
        YKm5qgNYl88s3IrsYfn0eWm+UjW4GOw=
X-Google-Smtp-Source: APXvYqzCzj5/rvv5QLN90xyskSXQNfrkyAflWRkMk+WUpYMqTxgGusHxjvpYNMQcvWYnz5eNYA9f8Q==
X-Received: by 2002:ac8:3658:: with SMTP id n24mr83121461qtb.354.1558640850167;
        Thu, 23 May 2019 12:47:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id n190sm159698qkb.83.2019.05.23.12.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 12:47:29 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTtgX-000173-14; Thu, 23 May 2019 16:47:29 -0300
Date:   Thu, 23 May 2019 16:47:29 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: Re: [PATCH v4 0/1] Use HMM for ODP v4
Message-ID: <20190523194729.GJ12159@ziepe.ca>
References: <20190522235737.GD15389@ziepe.ca>
 <20190523150432.GA5104@redhat.com>
 <20190523154149.GB12159@ziepe.ca>
 <20190523155207.GC5104@redhat.com>
 <20190523163429.GC12159@ziepe.ca>
 <20190523173302.GD5104@redhat.com>
 <20190523175546.GE12159@ziepe.ca>
 <20190523182458.GA3571@redhat.com>
 <20190523191038.GG12159@ziepe.ca>
 <20190523193959.GA5658@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523193959.GA5658@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 03:39:59PM -0400, Jerome Glisse wrote:
> On Thu, May 23, 2019 at 04:10:38PM -0300, Jason Gunthorpe wrote:
> > 
> > On Thu, May 23, 2019 at 02:24:58PM -0400, Jerome Glisse wrote:
> > > I can not take mmap_sem in range_register, the READ_ONCE is fine and
> > > they are no race as we do take a reference on the hmm struct thus
> > 
> > Of course there are use after free races with a READ_ONCE scheme, I
> > shouldn't have to explain this.
> 
> Well i can not think of anything again here the mm->hmm can not
> change while driver is calling hmm_range_register() 

Oh of course! It is so confusing because the new code makes it look like
it could be changing...

> so if you want i can remove the READ_ONCE() this does not change
> anything.

Please just write it as:
  
  /* The caller must hold a valid struct hmm_mirror to call this api,
   * and a valid hmm_mirror guarantees mm->hmm is valid.
   */
  range->hmm = mm->hmm;
  kref_get(&range->hmm->kref);

All the READ_ONCE/kref_get_not_zero/!hmm just obfuscates the reality
that hmm is non-NULL and constant here or the caller is using the API
wrong.

kref_get will reliably oops or WARN_ON if it is misused which is a
fine amount of debugging.

Jason
