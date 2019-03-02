Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3093FC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 22:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F063C20643
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 22:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551565446;
	bh=ciREeYA82V8S9LDMwOjslUWGLSyW5rSxe/U81Oan0kw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1SbxuJoJaojCGMyab7ZNObjrB7QtFafs0bhBkc7p5ZpWei1Sx7GgGxCDjCeYe5kim
	 VJCaJ/a9XKnYRRRvnDF7pW59+WUBEvNcSQO9sCDUfHKpw6wRCG6SLgnOPPQXiWMBCJ
	 sKf6Te7mNSSg7/pYbVPUbfAwuiEYSA5VkHqj7rJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfCBWXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 17:23:46 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40012 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfCBWXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 17:23:45 -0500
Received: by mail-qt1-f196.google.com with SMTP id j36so1420331qta.7
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2019 14:23:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dovG5uOCWcgYhvaJzJOM0tsh7kh+OufaS2DSOvU3Fwg=;
        b=rQv4T24lGQ0n3OUma2QBDt1owqTBSEqZ83YQJumHw+Ym+Pmez9LTCG5aOv/s98n7hx
         k/pqCIUnIyVzJ7zjyBT60VDtzY2Ymj9YXHqHe5UvIg+rwf0QEnoaFqXVuZ8AHWZ0gRnk
         7bZn0M76FZaQaeGyex3JqtumdwvLyuLvpqhMD6x5x02XAE+IQMiq6Ewlt5W1X/cZMmwo
         v16XCQYs2xWWFJ0mVpY1EY/sV1QPyKi3y+MFcex2ynYCLsZPz1ls/SLjDcgo5jWNJZ/d
         jMLrGGcG/kq2wa5iv3StLAWUcpSa/czpaO1qE2fYSbA1iV9FXOVsbvAa0Ra+ev6/UpYc
         B6rw==
X-Gm-Message-State: APjAAAXaZqy1G78Xxvx+ZJaPojKz+PH9D7pQbbe0FPNDhcJGgUM7Tc/D
        puhil+OxMVfjthskzbm7BO4=
X-Google-Smtp-Source: APXvYqzkV9wGIqT1xbCazAqpouTx2d8ZMGdjjW0A7rY4sAvEVM76SjY3UWTXshjyWO1e5DijRMB1gw==
X-Received: by 2002:aed:21c2:: with SMTP id m2mr9841943qtc.107.1551565424367;
        Sat, 02 Mar 2019 14:23:44 -0800 (PST)
Received: from dennisz-mbp.home ([2604:2000:1406:13e:1c79:146b:53ab:5b76])
        by smtp.gmail.com with ESMTPSA id n14sm1297196qtk.97.2019.03.02.14.23.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 14:23:43 -0800 (PST)
Date:   Sat, 2 Mar 2019 17:23:41 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Vlad Buslov <vladbu@mellanox.com>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/12] percpu: do not search past bitmap when allocating
 an area
Message-ID: <20190302222341.GA1196@dennisz-mbp.home>
References: <20190228021839.55779-1-dennis@kernel.org>
 <20190228021839.55779-3-dennis@kernel.org>
 <AM0PR04MB4481E8B4E51EB7FCFA72ABF088770@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR04MB4481E8B4E51EB7FCFA72ABF088770@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 02, 2019 at 01:32:04PM +0000, Peng Fan wrote:
> Hi Dennis,
> 
> > -----Original Message-----
> > From: owner-linux-mm@kvack.org [mailto:owner-linux-mm@kvack.org] On
> > Behalf Of Dennis Zhou
> > Sent: 2019年2月28日 10:18
> > To: Dennis Zhou <dennis@kernel.org>; Tejun Heo <tj@kernel.org>; Christoph
> > Lameter <cl@linux.com>
> > Cc: Vlad Buslov <vladbu@mellanox.com>; kernel-team@fb.com;
> > linux-mm@kvack.org; linux-kernel@vger.kernel.org
> > Subject: [PATCH 02/12] percpu: do not search past bitmap when allocating an
> > area
> > 
> > pcpu_find_block_fit() guarantees that a fit is found within
> > PCPU_BITMAP_BLOCK_BITS. Iteration is used to determine the first fit as it
> > compares against the block's contig_hint. This can lead to incorrectly scanning
> > past the end of the bitmap. The behavior was okay given the check after for
> > bit_off >= end and the correctness of the hints from pcpu_find_block_fit().
> > 
> > This patch fixes this by bounding the end offset by the number of bits in a
> > chunk.
> > 
> > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> > ---
> >  mm/percpu.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/percpu.c b/mm/percpu.c
> > index 53bd79a617b1..69ca51d238b5 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -988,7 +988,8 @@ static int pcpu_alloc_area(struct pcpu_chunk *chunk,
> > int alloc_bits,
> >  	/*
> >  	 * Search to find a fit.
> >  	 */
> > -	end = start + alloc_bits + PCPU_BITMAP_BLOCK_BITS;
> > +	end = min_t(int, start + alloc_bits + PCPU_BITMAP_BLOCK_BITS,
> > +		    pcpu_chunk_map_bits(chunk));
> >  	bit_off = bitmap_find_next_zero_area(chunk->alloc_map, end, start,
> >  					     alloc_bits, align_mask);
> >  	if (bit_off >= end)
> > --
> 
> From pcpu_alloc_area itself, I think this is correct to avoid bitmap_find_next_zero_area
> scan past the boundaries of alloc_map, so
> 
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> 
> There are a few points I did not understand well,
> Per understanding pcpu_find_block_fit is to find the first bit off in a chunk which could satisfy
> the bits allocation, so bits might be larger than PCPU_BITMAP_BLOCK_BITS. And if
> pcpu_find_block_fit returns a good off, it means there is a area in the chunk could satisfy
> the bits allocation, then the following pcpu_alloc_area will not scan past the boundaries of
> alloc_map, right?
> 

pcpu_find_block_fit() finds the chunk offset corresponding to the block
that will be able to fit the chunk. Allocations are done by first fit,
so scanning begins from the first_free of a block. Because the hints are
always accurate, you never fail to find a fit in pcpu_alloc_area() if
pcpu_find_block_fit() gives you an offset. This means you never scan
past the end anyway.

Thanks,
Dennis
