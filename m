Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D82C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495C5208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CV7jH3ve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbfGaMl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:41:26 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46048 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbfGaMlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:41:25 -0400
Received: by mail-qt1-f194.google.com with SMTP id x22so61414978qtp.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 05:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ssT+JujOxDwS6NEpfq2Ge7MRteKET9yZx/jW5aTaxrI=;
        b=CV7jH3veMykUxgu+H5gGaJEiM7dHfRA3AWXtjSYfzu48EjQ0oDP+S8cs1UxQbidp/W
         MqKLYekmIDfV2RBQHTtrwRlnUCc5krtCPt3AASFeznsZkr+ipQT/XuC+Xn6vABBkKIFP
         enujxa2gQmDcqqBPQMXqNzw5a+lpfG5eB2A37iznAHNxxA9jQHhaTnP+cwJR1UO9lidY
         SP65bUUa5WqhqoZCyAGPCKh7SUkgLjT8qHxGXbgc7GA59ln/8F06imsHF08LgdqgZvE2
         /+AQjQMxZnEgE6iMjDFEfdphXGCtwyg1L1ebJpvApgpgereLtbGxAEtwqnD5666T6XAv
         R7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ssT+JujOxDwS6NEpfq2Ge7MRteKET9yZx/jW5aTaxrI=;
        b=IDcik/Qc+4OZxoXpkxoNNrHHUG+7jneDbBKQEgm4mjR8G1q83MuBA8c5TiLH5h3r1R
         AA+yegBrvbbvlU43dGidGF6gUHJI/kPJ6tbOM4Wva3l2FcnMlHArpdpe/eXJZy8tFTaF
         g+EASIhV7S3h119KtfPHRNvTTuqZiCNDDnM45YqS8FC/jLEaNNv5FV6SGMuO0xMwX8Gv
         H0Gi9gBfEdrzjWtcL8Q2LPeefND4fI0JKUtW8Qh6p9BCujqKNHuS0UrI14o2QULpfmjm
         HgdC0KNjTXzAL8T1/WUUptYmu52ykGM4kyUl11T/QbUUGq9il+l4rx51FJZ+X6eiijbi
         GGmQ==
X-Gm-Message-State: APjAAAUxOijqmLDgKjhmXL2VaEtJkGmiYCuhg5x/sKnJ4BpYjWOHxy8a
        nyFNTeqokBu8xGbW29ikVIlX6Q==
X-Google-Smtp-Source: APXvYqwbN0Zcgw/rqJW/uUJyj5pJV/gEvjkDyEf6dYni+Q8BnL4R5HKzXod/DVe6ENOwDm8+CZT9Rw==
X-Received: by 2002:a0c:acab:: with SMTP id m40mr88924921qvc.52.1564576884920;
        Wed, 31 Jul 2019 05:41:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id u4sm29623865qkb.16.2019.07.31.05.41.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Jul 2019 05:41:24 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hsnv2-0006PN-6Q; Wed, 31 Jul 2019 09:41:24 -0300
Date:   Wed, 31 Jul 2019 09:41:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH V2 4/9] vhost: reset invalidate_count in
 vhost_set_vring_num_addr()
Message-ID: <20190731124124.GD3946@ziepe.ca>
References: <20190731084655.7024-1-jasowang@redhat.com>
 <20190731084655.7024-5-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731084655.7024-5-jasowang@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 04:46:50AM -0400, Jason Wang wrote:
> The vhost_set_vring_num_addr() could be called in the middle of
> invalidate_range_start() and invalidate_range_end(). If we don't reset
> invalidate_count after the un-registering of MMU notifier, the
> invalidate_cont will run out of sync (e.g never reach zero). This will
> in fact disable the fast accessor path. Fixing by reset the count to
> zero.
> 
> Reported-by: Michael S. Tsirkin <mst@redhat.com>

Did Michael report this as well?

> Fixes: 7f466032dc9e ("vhost: access vq metadata through kernel virtual address")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
>  drivers/vhost/vhost.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 2a3154976277..2a7217c33668 100644
> +++ b/drivers/vhost/vhost.c
> @@ -2073,6 +2073,10 @@ static long vhost_vring_set_num_addr(struct vhost_dev *d,
>  		d->has_notifier = false;
>  	}
>  
> +	/* reset invalidate_count in case we are in the middle of
> +	 * invalidate_start() and invalidate_end().
> +	 */
> +	vq->invalidate_count = 0;
>  	vhost_uninit_vq_maps(vq);
>  #endif
>  
