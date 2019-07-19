Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2781C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 11:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57CD20873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 11:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KZYGzcJe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbfGSLsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 07:48:55 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34306 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfGSLsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 07:48:54 -0400
Received: by mail-qk1-f196.google.com with SMTP id t8so22997071qkt.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 04:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BEQquUvm7pZb1cGrDQA3i7EHBHTQR3PwBTHZJKzT7h0=;
        b=KZYGzcJevvRDH/6zp+YVDCefS3om5aI+gV/vnmPR0/mlwLZy6qFkMcogazQ3K3PVUz
         5o48RyAUvp13eSQwsllPS5+/tmM3HaSpVc2sqRjA0JrOWuX5f27wQmRadmm5WVIpoA5h
         3rZVxfwDs46gmhnjNUMmDt61unvbhmLt2xIVhq0HJ1tRFcG7ZChQSou1qeIgm08LatnA
         QKKfZOEAIkODuRh5CVxABuFmOsnX6q3enfSB/gY8yXZfhhIyTXd3nFjf6zEHBvX4T+sy
         ZAWjQZrxfsxHESEeRbtUkr1wYUQauy/MF9PtNAeinWcxoZSSMhrDTxEwaw2HMkW+aAXT
         sXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BEQquUvm7pZb1cGrDQA3i7EHBHTQR3PwBTHZJKzT7h0=;
        b=DcmBUNj0BQ5KH5aFHKRDfhlXULDqSw7iDRDrU13lGnKhz4XLLVuatYba/xLqOTEUiT
         PryELZMzTHbOUNE3oJ98deekLWvcU4WxDn/L7X5hipcd9AgHWiahzII4R3GCpd3kkTAf
         DhCYqvWDRCLJbrDRgCCbzLRl80eoPFeEkedO1+yY4rJhzAEkjIi0NYXkYTaUS6rKz9JH
         zgyuN7reEOnjsNn0XDess71p1qeajXnvzNxfKwhCVvJWedgZHOrxMh8utBWbocnXLqko
         59bx540XhQDMWdAXjAuDA/dRw3xiEOvU96s+8dCCjZewP5D47nmT9c/jLpYIUuHn8evf
         7csw==
X-Gm-Message-State: APjAAAWlwA8YbBUXk654EHi7RlC9MK3ujzzNwFE0rrVir56zlmqp4F8u
        Z6uRaezYNW3AWxpzZy0kiQbcYWQGwlXr9Q==
X-Google-Smtp-Source: APXvYqxLJkrUw01kbBde4x9oizq7gCJSe4ztR8DzrTiMMUKXnRI1HsQOrg244wufi2Z5TQ/KbsJuPA==
X-Received: by 2002:a37:3d7:: with SMTP id 206mr35110960qkd.252.1563536933893;
        Fri, 19 Jul 2019 04:48:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id h19sm10801517qto.3.2019.07.19.04.48.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Jul 2019 04:48:53 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hoRNd-0004I3-1p; Fri, 19 Jul 2019 08:48:53 -0300
Date:   Fri, 19 Jul 2019 08:48:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Christoph Hellwig <hch@infradead.org>, john.hubbard@gmail.com,
        SCheung@nvidia.com, akpm@linux-foundation.org,
        aneesh.kumar@linux.vnet.ibm.com, benh@kernel.crashing.org,
        bsingharora@gmail.com, dan.j.williams@intel.com,
        dnellans@nvidia.com, ebaskakov@nvidia.com, hannes@cmpxchg.org,
        jglisse@redhat.com, jhubbard@nvidia.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        liubo95@huawei.com, mhairgrove@nvidia.com, mhocko@kernel.org,
        paulmck@linux.vnet.ibm.com, ross.zwisler@linux.intel.com,
        sgutti@nvidia.com, torvalds@linux-foundation.org,
        vdavydov.dev@gmail.com
Subject: Re: [PATCH] mm/Kconfig: additional help text for HMM_MIRROR option
Message-ID: <20190719114853.GB15816@ziepe.ca>
References: <20190717074124.GA21617@amd>
 <20190719013253.17642-1-jhubbard@nvidia.com>
 <20190719055748.GA29082@infradead.org>
 <20190719105239.GA10627@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719105239.GA10627@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 12:52:39PM +0200, Pavel Machek wrote:
> On Thu 2019-07-18 22:57:48, Christoph Hellwig wrote:
> > On Thu, Jul 18, 2019 at 06:32:53PM -0700, john.hubbard@gmail.com wrote:
> > > +	  HMM_MIRROR provides a way to mirror ranges of the CPU page tables
> > > +	  of a process into a device page table. Here, mirror means "keep
> > > +	  synchronized". Prerequisites: the device must provide the ability
> > > +	  to write-protect its page tables (at PAGE_SIZE granularity), and
> > > +	  must be able to recover from the resulting potential page faults.
> > > +
> > > +	  Select HMM_MIRROR if you have hardware that meets the above
> > > +	  description. An early, partial list of such hardware is:
> > > +	  an NVIDIA GPU >= Pascal, Mellanox IB >= mlx5, or an AMD GPU.
> > 
> > Nevermind that the Nvidia support is stagaging and looks rather broken,
> > there is no Mellanox user of this either at this point.
> > 
> > But either way this has no business in a common kconfig help.  Just
> > drop the fine grained details and leave it to the overview.
> 
> I disagree here. This explains what kind of hardware this is for (very
> new). Partial list does not hurt, and I know that I probably don't
> need to enable this.
> 
> How else am I supposed to know if my computer needs page tables
> synchronized?

It is like MMU_NOTIFIERS, if something needs it, then it will select
it.

Maybe it should just be a hidden kconfig anyhow as there is no reason
to turn it on without also turning on a using driver.

Jason

