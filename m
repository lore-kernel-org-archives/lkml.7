Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05794C468BC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40D32146E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oZC9a6nv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732020AbfFGSuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 14:50:22 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34545 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730281AbfFGSuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:50:21 -0400
Received: by mail-qt1-f194.google.com with SMTP id m29so3509501qtu.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 11:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=981lOBbF7NntqOPGnU+wDEqlWf7ONqp9B0Ou4FbjqoU=;
        b=oZC9a6nvcosvTmp2Xz2vW0f9gvXIuh4kitLGI6CjsLXK1+Gnu0mccx6TNO5esZKRWN
         jpusXhxZ6diyXP/2IvDfe4Sozh6aFMls99kKfV0Oh9uEVYvzKsy1COSoqZhzVVpYwP9K
         DlLyyRWwMTfr89qP7WlB75o9IQD+x/cE6xx3qucV0uEUL41Hb7JpWs/wMh4hLxr3HoJx
         fc49CEJVp4R714dI4okPWcziniOd2LBG5fbQY9h/Cjd9k+Pglq+pi5j+zKX1QlmTE64r
         wbxNASKedhU1orq0qO6Me5wbL2KGqE9NauEFAABsOyUfWfONSs2MlnU6mWezKlVjNiry
         8Hvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=981lOBbF7NntqOPGnU+wDEqlWf7ONqp9B0Ou4FbjqoU=;
        b=t0t49XuACcXQ6m0zooFcO0MaCTJRfVNbi0wP3UZUkMvyDjvYbSrw+AIE+b3NhCFp7I
         8j0T5Cy5ntciipp6TiIQEoJ4Sip70TqCWvuPcWumSlCXJ/iVPL3iv7X7aawDRTrDOF4k
         lnmHXtlPfuTyCV8/i4ybXewavnO5Mc70ObbgwqtMMIUGxa19HZRnLLyjHCXn7vm9vdST
         DXeyjDK8G3TWWmANcxXluFc4rPWeriR2SbckE/fy4qtSwsbmu6E/4wbvHo7366xoXtZ6
         hh7WA9qVUX4MUxVCFrYnDqv9MYY9E1bVlOKdwz/zmGSYsjSTvaraLRhfRJGaifxNJWjv
         5yVw==
X-Gm-Message-State: APjAAAX3fsxic+6mb4E9D4LP3rZUWJ1EX1gPEsCTMWjn5jcdkXG7wSt8
        WQWmuVCdxdYLr0Z7dFbMceQzoA==
X-Google-Smtp-Source: APXvYqxHzZOVD73PAZq/gC6oUmCxE3JRfnnnGXli2ogTGkWJxAu+ueWdhS//gQBOh+cGCpWnmaBbVg==
X-Received: by 2002:ac8:444c:: with SMTP id m12mr48345365qtn.306.1559933420780;
        Fri, 07 Jun 2019 11:50:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id q2sm1527313qkf.44.2019.06.07.11.50.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 11:50:20 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hZJwR-0007vm-HB; Fri, 07 Jun 2019 15:50:19 -0300
Date:   Fri, 7 Jun 2019 15:50:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Jeff Layton <jlayton@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
Message-ID: <20190607185019.GP14802@ziepe.ca>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
 <20190606220329.GA11698@iweiny-DESK2.sc.intel.com>
 <20190607110426.GB12765@quack2.suse.cz>
 <20190607182534.GC14559@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607182534.GC14559@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 11:25:35AM -0700, Ira Weiny wrote:

> And I think this is related to what Christoph Hellwig is doing with bio_vec and
> dma.  Really we want drivers out of the page processing business.

At least for RDMA, and a few other places I've noticed, I'd really
like to get totally out of the handling struct pages game.

We are DMA based and really only want DMA addresses for the target
device. I know other places need CPU pages or more complicated
things.. But I also know there are other drivers like RDMA..

So I think it would be very helpful to have a driver API something
like:

int get_user_mem_for_dma(struct device *dma_device,
                void __user *mem, size_t length,
                struct gup_handle *res,
                struct 'bio dma list' *dma_list,
                const struct dma_params *params);
void put_user_mem_for_dma(struct gup_handle *res, 
                 struct 'bio dma list' *dma_list);

And we could hope to put in there all the specialty logic we want to
have for this flow:
 - The weird HMM stuff in hmm_range_dma_map()
 - Interaction with DAX
 - Interaction with DMA BUF
 - Holding file leases
 - PCI peer 2 peer features
 - Optimizations for huge pages
 - Handling page dirtying from DMA
 - etc

I think Matthew was suggesting something like this at LS/MM, so +1
from here..

When Christoph sends his BIO dma work I was thinking of investigating
this avenue, as we already have something quite similiar in RDMA that
could perhaps be hoisted out for re-use into mm/

Jason
