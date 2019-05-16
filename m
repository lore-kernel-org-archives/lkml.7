Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0BEC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B8F20657
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="M3ypSYF3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfEPPVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 11:21:50 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40368 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfEPPVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 11:21:50 -0400
Received: by mail-qk1-f193.google.com with SMTP id q197so2492936qke.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 08:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0r/Lt4feYExSfZt48U8FYJfInCwa1MwFDcbDzAnYQfE=;
        b=M3ypSYF3CCar3IPLbQ6KnJArsxjTjcyGcOG7w/noCYWw8cmfMLxp+gdmEvwPfEf6mH
         ecYm6NZlDIiRpiZ2YqUy5C/upaQZDKtkpIrPCdg3ZrEgN0+44wGBlbw3Rm18+RkOoah6
         cKMc8Raydjq3r21b8PMp8zHjMQ/dg8S28v4PjYxxGMTLAonO0BNMk/uJ/8uwVRu9CfZq
         66XQor3l9J9AVIr3WGKKwB4jPyq/BcK5hYntd0J61PJPNAE8ddtI8tElQgY7aWOBQgjL
         2STANaYGJNGu9zzjWB1b0kwpgWcfxTwh2QH/w0gntuJgZtAi9qSbc3cO2j3zyyuVRlDL
         /mJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0r/Lt4feYExSfZt48U8FYJfInCwa1MwFDcbDzAnYQfE=;
        b=lypzNzIo+nHJ+Gb+4+SWKe5epyGK3TyQ0XNC1bPn5osizdTP67OGAouRdoKoW1h+HA
         KdZ/NEH6sKaDZ5P+P17xNNwvlkwtVetL/HLsaETlPGt+K+I39DuoRpds1tfOZ3BhTZcn
         0ehpNHlVFgiiWwmrEz619HYMEHzBQD2YmJ5b1tMRiXZk6R8WwZeF5IEp+4hSV44SaHGE
         JtyJhLmDy+Ksrd0jQcqKkNQKwr+swZl+B+nvtYjFv43FeogSaObBI148BjXnASCjQhBV
         iOurNeS2BOLIO+xgEzCrTlVusAjfAZ+5XGA8WdnioADb7AIC8kYTlWIf4KkC0Xt/SGlP
         Luqg==
X-Gm-Message-State: APjAAAXeRw7tQ+VWdwxS3rJ5BiKBwju5rW2iLqauxIiZraq9+XvTZAtA
        Y1bqB+MowP1vFaCAHgeXnQyootl0ktY=
X-Google-Smtp-Source: APXvYqxsFjQx1/aKKG35SpuyAjlaj3JoYgzBXlwiuqvmf5amtxuaGC64qzkPjDeJDKT/mWCEOI9z2A==
X-Received: by 2002:a37:a707:: with SMTP id q7mr6293200qke.74.1558020109094;
        Thu, 16 May 2019 08:21:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id f7sm2444633qth.41.2019.05.16.08.21.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 08:21:48 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hRICa-0001mZ-1Z; Thu, 16 May 2019 12:21:48 -0300
Date:   Thu, 16 May 2019 12:21:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Simon Horman <horms@verge.net.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH v2] RDMA: Directly cast the sockaddr union to sockaddr
Message-ID: <20190516152148.GD22587@ziepe.ca>
References: <20190514005521.GA18085@ziepe.ca>
 <20190516124428.hytvkwfltfi24lrv@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516124428.hytvkwfltfi24lrv@verge.net.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 02:44:28PM +0200, Simon Horman wrote:
> On Mon, May 13, 2019 at 09:55:21PM -0300, Jason Gunthorpe wrote:
> > gcc 9 now does allocation size tracking and thinks that passing the member
> > of a union and then accessing beyond that member's bounds is an overflow.
> > 
> > Instead of using the union member, use the entire union with a cast to
> > get to the sockaddr. gcc will now know that the memory extends the full
> > size of the union.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> >  drivers/infiniband/core/addr.c           | 16 ++++++++--------
> >  drivers/infiniband/hw/ocrdma/ocrdma_ah.c |  5 ++---
> >  drivers/infiniband/hw/ocrdma/ocrdma_hw.c |  5 ++---
> >  3 files changed, 12 insertions(+), 14 deletions(-)
> > 
> > I missed the ocrdma files in the v1
> > 
> > We can revisit what to do with that repetitive union after the merge
> > window, but this simple patch will eliminate the warnings for now.
> > 
> > Linus, I'll send this as a PR tomorrow - there is also a bug fix for
> > the rdma-netlink changes posted that should go too.
> 
> <2c>
> I would be very happy to see this revisited in such a way
> that some use is made of the C type system (instead of casts).
> </2c>

Well, I was thinking of swapping the union to sockaddr_storage ..

Do you propose to add a union to the kernel's sockaddr storage?

Jason
