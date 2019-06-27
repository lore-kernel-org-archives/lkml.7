Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB484C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 16:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83FCD2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 16:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oaokw1Uc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfF0QfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 12:35:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46606 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfF0QfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 12:35:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id 81so1484612pfy.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 09:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZS7BdZWWEVunG3KiycDjtP4eG/sAThYBJpiImcoQqZ0=;
        b=oaokw1UcFtYPz8TD2pHWC6HI4frjVJ+O5tteS3wu6S4/GzjN4GvNNRS+aKkZjmj7OI
         eEAuxc5ILO8p31iSYnoXxTnamWmV6gRNiF+WbQvr4rwQqcTHhthPs/jCPgfC4N29DAxS
         SsQcL+Vf65kCJ1KHXT/8LTEgEpFYOuR9LdJBo8CAPx6ARSU3pOSA7fRF/5BAenTuqNCs
         pU0mWPPel5CxEFVsW53CEEK+pRqcM2XLYyT9DEOtu5FHYYY9v4l0HR8NJbdp1XUhSCD3
         WgDOed5jc3x9JUv8vnt79gq4aBEWoSZFjuDPL6G9oVFKdm5Uwq5audmeAnA3TSd6/34+
         qFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZS7BdZWWEVunG3KiycDjtP4eG/sAThYBJpiImcoQqZ0=;
        b=VTCyX5b75iMW9ZBhuy2TWINmG8TwMtMziFcRZLz3NAiw/jXpAn6AFcTEBYKTH9MZGj
         VfK3ym9z9jhMYWEoRYG05itanSX2Jxe1tCqskXSQILcIxIozRstNHCVbDHOXHEIr/ehF
         DRfhYB5Fn8/MXRRjrb4DjqaqNs5vopkFTrPb36In62MARnEUCrdJ0hPXVXCttpVKB3Tz
         UwlirQavZPT8SQeIsUg/R1T/hjtd3KlJhBL/6ndqVHKZtVAiIqfWcV6z3l2YD/r6TKk1
         gWRY9GUEsKXRuLMIS5QLYoMjASWPxxqsUnoCifW28GxAFsHV5t/NHxX0P2YzZD3Y2rDM
         ddNg==
X-Gm-Message-State: APjAAAUXMUcDS97p8gLu2+Jg3i7u2sH+qFkXJ+UUJGt4ss1BfBaFI4Iy
        s6E0fFBZ6NGThO2CkVC6KI/tyy9FkvcPgg==
X-Google-Smtp-Source: APXvYqy+pAhnrewVnvuOOpMWBscCwyZYHx3WfUVSpPmsFIWqKBek6M66YwQ29AAOj6DKzWLrCwE3Kw==
X-Received: by 2002:a63:4105:: with SMTP id o5mr4754738pga.308.1561653306202;
        Thu, 27 Jun 2019 09:35:06 -0700 (PDT)
Received: from ziepe.ca ([12.199.206.50])
        by smtp.gmail.com with ESMTPSA id a15sm2263271pgw.3.2019.06.27.09.35.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 09:35:05 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hgXMW-0001GB-LS; Thu, 27 Jun 2019 13:35:04 -0300
Date:   Thu, 27 Jun 2019 13:35:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [RFC PATCH 00/28] Removing struct page from P2PDMA
Message-ID: <20190627163504.GB9568@ziepe.ca>
References: <20190625170115.GA9746@lst.de>
 <41235a05-8ed1-e69a-e7cd-48cae7d8a676@deltatee.com>
 <20190626065708.GB24531@lst.de>
 <c15d5997-9ba4-f7db-0e7a-a69e75df316c@deltatee.com>
 <20190626202107.GA5850@ziepe.ca>
 <8a0a08c3-a537-bff6-0852-a5f337a70688@deltatee.com>
 <20190626210018.GB6392@ziepe.ca>
 <c25d3333-dcd5-3313-089b-7fbbd6fbd876@deltatee.com>
 <20190627063223.GA7736@ziepe.ca>
 <6afe4027-26c8-df4e-65ce-49df07dec54d@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6afe4027-26c8-df4e-65ce-49df07dec54d@deltatee.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 10:09:41AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2019-06-27 12:32 a.m., Jason Gunthorpe wrote:
> > On Wed, Jun 26, 2019 at 03:18:07PM -0600, Logan Gunthorpe wrote:
> >>> I don't think we should make drives do that. What if it got CMB memory
> >>> on some other device?
> >>
> >> Huh? A driver submitting P2P requests finds appropriate memory to use
> >> based on the DMA device that will be doing the mapping. It *has* to. It
> >> doesn't necessarily have control over which P2P provider it might find
> >> (ie. it may get CMB memory from a random NVMe device), but it easily
> >> knows the NVMe device it got the CMB memory for. Look at the existing
> >> code in the nvme target.
> > 
> > No, this all thinking about things from the CMB perspective. With CMB
> > you don't care about the BAR location because it is just a temporary
> > buffer. That is a unique use model.
> > 
> > Every other case has data residing in BAR memory that can really only
> > reside in that one place (ie on a GPU/FPGA DRAM or something). When an IO
> > against that is run it should succeed, even if that means bounce
> > buffering the IO - as the user has really asked for this transfer to
> > happen.
> > 
> > We certainly don't get to generally pick where the data resides before
> > starting the IO, that luxury is only for CMB.
> 
> I disagree. If we we're going to implement a "bounce" we'd probably want
> to do it in two DMA requests.

How do you mean?

> So the GPU/FPGA driver would first decide whether it can do it P2P
> directly and, if it can't, would want to submit a DMA request copy
> the data to host memory and then submit an IO normally to the data's
> final destination.

I don't think a GPU/FPGA driver will be involved, this would enter the
block layer through the O_DIRECT path or something generic.. This the
general flow I was suggesting to Dan earlier

> I think it would be a larger layering violation to have the NVMe driver
> (for example) memcpy data off a GPU's bar during a dma_map step to
> support this bouncing. And it's even crazier to expect a DMA transfer to
> be setup in the map step.

Why? Don't we already expect the DMA mapper to handle bouncing for
lots of cases, how is this case different? This is the best place to
place it to make it shared.

Jason
