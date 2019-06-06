Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D39AC28EB3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 18:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368152089E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 18:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DfY0Q040"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfFFSyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 14:54:37 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39525 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfFFSyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 14:54:37 -0400
Received: by mail-qt1-f193.google.com with SMTP id i34so3937142qta.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 11:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vyj+6CVYT6/SclKU5U5COjT2Okh3PlJFjv+2ILDUOlk=;
        b=DfY0Q040f6zs3YRa631XXmcuTGF55hxDFVU9TX5ARAqwLQq/3wgV4InukzkKOQsiJD
         e00JNuL2N1GKGqgUZsRFhjvJmYhg067swzJXzPnrrulT9O7ZC+VY/yEUDG4Gcz1CDSse
         XibMzl1dCihxY+cXKOJlBlUYBUZqfc6aEEWkTBGMAkbRi0Bx79aqUZd2ynN8QALKcChv
         5tiGwYdoc7zbsXyaHBojClL6aMNCEiZ+iWBcKw8Mjnqh/Dw7dGNUCamZzXT+aNfNcuTS
         enS+EFqGMlluJLQff6oyqnCrYG8AFObLci2Mt4hw4aRhmwOW0CRlKAkVRKjhpOGlbBHd
         KALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vyj+6CVYT6/SclKU5U5COjT2Okh3PlJFjv+2ILDUOlk=;
        b=XsrT2jzn3CLf1ZuTqsClPCcKBgE7qT1M1F8vEYz/yRYhS5AeG8OeK2hLjc9Qrw3qQ0
         2vd9OE6YOVEsEZO/s4glS9qiNneaewm9IeID8htxVTuH+T1z1HsAe6hmmYyoY7hQu1gT
         smW2Y1Neh+zYMDPdUXNYi3kaAzbegomg2d/Fi52K7p4M6BN3ZdH19gzZ5ucKOo/FrJga
         +40ZQUgnRgqCg9ugA36LYvJA9cUCefVCvwjaAJ+Ht/nthElwfX76W3vkdpL5D4g2RcIF
         5wRWQVdERNvIRK5VcaMxggTJdq/ynid20Vh70zmP6Xh7JUuFnN0GeQTLVj+mp9DCkuUL
         I0Ag==
X-Gm-Message-State: APjAAAWcDr5UjRPOxoMdlbo/SEAw8KLO/uXwpTIQj3SNNb6iX4xx8851
        dNns6UM5n7FNauIdAqLJHKX16w==
X-Google-Smtp-Source: APXvYqx+vVETo47tgK43mzzCTdpyn7vjag/ZaU5oAM9JQ6aHmzaMykBxyQ4w64rpkOSnLhOHAqMRRQ==
X-Received: by 2002:a0c:d4eb:: with SMTP id y40mr21179717qvh.30.1559847275858;
        Thu, 06 Jun 2019 11:54:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id t80sm1241863qka.87.2019.06.06.11.54.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 11:54:35 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hYxX1-0008Mq-1o; Thu, 06 Jun 2019 15:54:35 -0300
Date:   Thu, 6 Jun 2019 15:54:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     rcampbell@nvidia.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/5] mm/hmm: Clean up some coding style and comments
Message-ID: <20190606185435.GC17373@ziepe.ca>
References: <20190506232942.12623-1-rcampbell@nvidia.com>
 <20190506232942.12623-3-rcampbell@nvidia.com>
 <20190606141644.GA2876@ziepe.ca>
 <20190606142743.GA8053@redhat.com>
 <20190606154129.GB17373@ziepe.ca>
 <20190606155213.GB8053@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190606155213.GB8053@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 11:52:13AM -0400, Jerome Glisse wrote:
> On Thu, Jun 06, 2019 at 12:41:29PM -0300, Jason Gunthorpe wrote:
> > On Thu, Jun 06, 2019 at 10:27:43AM -0400, Jerome Glisse wrote:
> > > On Thu, Jun 06, 2019 at 11:16:44AM -0300, Jason Gunthorpe wrote:
> > > > On Mon, May 06, 2019 at 04:29:39PM -0700, rcampbell@nvidia.com wrote:
> > > > > From: Ralph Campbell <rcampbell@nvidia.com>
> > > > > 
> > > > > There are no functional changes, just some coding style clean ups and
> > > > > minor comment changes.
> > > > > 
> > > > > Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> > > > > Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
> > > > > Cc: John Hubbard <jhubbard@nvidia.com>
> > > > > Cc: Ira Weiny <ira.weiny@intel.com>
> > > > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > > > Cc: Balbir Singh <bsingharora@gmail.com>
> > > > > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > > > > Cc: Matthew Wilcox <willy@infradead.org>
> > > > > Cc: Souptick Joarder <jrdr.linux@gmail.com>
> > > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > >  include/linux/hmm.h | 71 +++++++++++++++++++++++----------------------
> > > > >  mm/hmm.c            | 51 ++++++++++++++++----------------
> > > > >  2 files changed, 62 insertions(+), 60 deletions(-)
> > > > 
> > > > Applied to hmm.git, thanks
> > > 
> > > Can you hold off, i was already collecting patches and we will
> > > be stepping on each other toe ... for instance i had
> > 
> > I'd really rather not, I have a lot of work to do for this cycle and
> > this part needs to start to move forward now. I can't do everything
> > last minute, sorry.
> > 
> > The patches I picked up all look very safe to move ahead.
> 
> I want to post all the patch you need to apply soon, it is really
> painful because they are lot of different branches

I've already handled everything in your hmm-5.3, so I don't think
there is anything for you to do in that regard. Please double check
though!

If you have new patches please post them against something sensible
(and put them in a git branch) and I can usually sort out 'git am'
conflicts pretty quickly.

> If you hold of i will be posting all the patches in one big set so
> that you can apply all of them in one go and it will be a _lot_
> easier for me that way.

You don't need to repost my patches, I can do that myself, but thanks
for all the help getting them ready! Please respond to my v2 with more
review's/ack's/changes/etc so the series can move toward being
applied.

> On process thing it would be easier if we ask Dave/Daniel to merge
> hmm within drm this cycle. 

Yes, I expect we will do this - probably also to the AMD tree judging
on things in -next. This is the entire point of running a shared tree.

> Merging with Linus will break drm drivers and it seems easier to me
> to fix all this within the drm tree.

This is the normal process with a shared tree, we merge the tree
*everywhere it is required* so all trees can run concurrently.

I will *also* send it to Linus early so that Linus reviews the hmm
patches in the HMM pull request, not in the DRM or RDMA pull
request. This is best-practice when working across trees like this.

Please just keep me up to date when things conflicting arise and we
will work out the best solution.

Reminder, I still need patches from you for:
 - Fix all the kconfig stuff for randconfig failures/etc
 - Enable ARM64
 - Remove deprecated APIs from hmm.h

Please send them ASAP so it can be tested.

There shouldn't be any patches held back for 5.4 - send them all now.

Thanks,
Jason
