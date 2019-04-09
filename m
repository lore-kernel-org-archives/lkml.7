Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A3FC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C14920855
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfDIMvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:51:04 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46347 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfDIMvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 08:51:03 -0400
Received: by mail-qt1-f193.google.com with SMTP id z17so19449794qts.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 05:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M0n7FmgYhbqZykzNZ4/Gzh+vUMrsv+gfkH1WJ+4V5Oo=;
        b=bLtzni0yi7H+re/ZCROSRubTMC49tyTXWNzDJprxmoRogtz60HqvNcTceylo/xFZf4
         vtQ4qt62CgfY348tduSLsXvk6GUS2kk+8YtjPpcohUpGlesAoXfSE6mQA9bzRMAmlwna
         LsLjTXLTsDhyWuX40+zbIsfrAhyim4ufD3iDovLKcuVV2v+3AaaopAk8RtgpqUUK2ePH
         x4oMhr0csS/XF1Gjq8XjeP0M8/AtEO4VRBDVbHjJjv6lFgdhI4d4Xj+7EyRVaOhffBw7
         DZ+gqr133ZSceNK8l1PSXL6U1CSaKWer0j6aNtIQFiX+OB5lJIKkLsemI1tQJG/TxQsu
         Xgow==
X-Gm-Message-State: APjAAAW0Trj3FzBZHrSdBhkT6kvn677GBNU5uaz3+OiLOUuDnoAdA99C
        an8qovm6R5A+9DbraYpQLcr2z2Ta+IU=
X-Google-Smtp-Source: APXvYqw36UOHKNhTlmB98HEDgDFgQLwYO3C/gO5PlLUDSiZiBAAmPtAgzYn4T4idSIFKkJWux1gyBQ==
X-Received: by 2002:aed:3fb8:: with SMTP id s53mr29039215qth.61.1554814262840;
        Tue, 09 Apr 2019 05:51:02 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id s54sm20988974qtb.83.2019.04.09.05.51.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 05:51:01 -0700 (PDT)
Date:   Tue, 9 Apr 2019 08:50:54 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vhost: reject zero size iova range
Message-ID: <20190409085041-mutt-send-email-mst@kernel.org>
References: <20190409041025.20922-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409041025.20922-1-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 12:10:25PM +0800, Jason Wang wrote:
> We used to accept zero size iova range which will lead a infinite loop
> in translate_desc(). Fixing this by failing the request in this case.
> 
> Reported-by: syzbot+d21e6e297322a900c128@syzkaller.appspotmail.com
> Fixes: 6b1e6cc7 ("vhost: new device IOTLB API")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Seems appropriate for stable.

> ---
>  drivers/vhost/vhost.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 5ace833de746..351af88231ad 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -911,8 +911,12 @@ static int vhost_new_umem_range(struct vhost_umem *umem,
>  				u64 start, u64 size, u64 end,
>  				u64 userspace_addr, int perm)
>  {
> -	struct vhost_umem_node *tmp, *node = kmalloc(sizeof(*node), GFP_ATOMIC);
> +	struct vhost_umem_node *tmp, *node;
>  
> +	if (!size)
> +		return -EFAULT;
> +
> +	node = kmalloc(sizeof(*node), GFP_ATOMIC);
>  	if (!node)
>  		return -ENOMEM;
>  
> -- 
> 2.19.1
