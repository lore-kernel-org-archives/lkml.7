Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCEBC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 18:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B6920B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 18:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Fz9mT5h+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731603AbfHFSCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 14:02:11 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35252 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfHFSCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 14:02:11 -0400
Received: by mail-qt1-f195.google.com with SMTP id d23so85512610qto.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 11:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DWmSMnF3B1mTPtWIyEYX2euOl5QowlPflL5LrFAqjMw=;
        b=Fz9mT5h+F2iLSvCsBQC5ggiqblN5sutWqjuhuF03Psd+Uf9SPIthU1SFjsJOpswgqI
         i/rgIdKvSW+0tmW7prrn9Y9533G5r4E6d8zM2DnGZ+TNNPM1MBH1FT1zMnZwkyxWU56W
         iIxNzxmjUm0QE0MLJTbJe3z6JqTvYF91SW6QufY/zMDl+9YGG4y5cVhS4ePPcReybl3S
         5KnATeu6yNsS0v/Exp3ApYHy7cwB4/w0c77CJqZUqewRB2Fv001+6QZuzn3886W/04vb
         HuXkgysTL1jkEq+Yt2WQvBYWRBxT7DYd/4ML1Ga5aZt50ou9KZTiM8DcK7BJNDl2Ss0U
         6iSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DWmSMnF3B1mTPtWIyEYX2euOl5QowlPflL5LrFAqjMw=;
        b=DpVhzPfCMNBeFzH1jmkSge596c6FsK4cbpjh7gPRPxb46n/CXIObiOV7fMYjKYbOe5
         j2O5wC+/e4KYFLOt+/V/heOmsN65q4JHHuR/Y7agDETgfUGriLbNKVXZwNuc2va5x1uN
         jSzCiwqnsXBUA78ipfjpw9zb9jY3o4ptJKiDDzVqkjezJmUaPYPrDSMTxUhLu/1W1Pxy
         LjeWASZYvtqowlBcQ7fB5WS/5Uw/gCQBK/YiVZYg9YwJ9xPWvIrVL0g18KPECnRPHdls
         5HnGtO6mtO423/HtYoTB+pei8NPIl4lyrIQ9ZCHd65qbqZ17mbftD2gHNTlYMXLU3R6K
         yskg==
X-Gm-Message-State: APjAAAWhxVvyGEKsmVB0dAhP4etV9WvYAM2MX8fBMwrFv6PulZ3Z+w3m
        t0KJgYIBKu3s12AOcu3K1AIKMg==
X-Google-Smtp-Source: APXvYqzwT9xNxemQscVlJmSlpGsNQA9yiKA1TtYWgT1CZ65aDe7RTogerUHwfzBX65WGTnxLLbQenA==
X-Received: by 2002:ac8:f99:: with SMTP id b25mr4258745qtk.142.1565114530121;
        Tue, 06 Aug 2019 11:02:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id w10sm263879qts.77.2019.08.06.11.02.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Aug 2019 11:02:09 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hv3mj-0000H9-63; Tue, 06 Aug 2019 15:02:09 -0300
Date:   Tue, 6 Aug 2019 15:02:09 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/15] mm: remove the mask variable in
 hmm_vma_walk_hugetlb_entry
Message-ID: <20190806180209.GN11627@ziepe.ca>
References: <20190806160554.14046-1-hch@lst.de>
 <20190806160554.14046-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806160554.14046-9-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 07:05:46PM +0300, Christoph Hellwig wrote:
> The pagewalk code already passes the value as the hmask parameter.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
>  mm/hmm.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
