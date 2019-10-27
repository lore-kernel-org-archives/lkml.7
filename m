Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97529CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 10:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7128820717
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 10:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfJ0KER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 06:04:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfJ0KER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 06:04:17 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D555D85536
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 10:04:16 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id j5so7722620qtn.10
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 03:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DIl+XjLva0/Mm7Hs+GCeYJOa+yDwPi8Nqp5nHz6nVLQ=;
        b=bBUEIYRkJ8KTFbi0CgwUyyj7FwLYoWqU194aDBgc2pVRuHpSKQVYUfY4BVccZmV7ER
         iAA4vEJ+2F6+C3hIP4bRGsfwSpSHcAjqrP59bFHnpMpWYwUCVyl3K6Uu9rAMzr/lcE/R
         ZIBxso3vUHoW9ltCGuoCT1hQexja4mV6ufdv8uaiJ/WXUH8WK8s4jDSgo7rs0VNGFtBi
         pPUhg8M07C//I+1nQtbl24cQ1TarDv/+IVwDbJInJnOkGsotNbqe5sgTaflk96ew47vB
         CQs5aFjANmrLu4xG9+T3KrRpcZ6DIJ4zo9yoBWtzLMSURDY136IttuzT/oK3yRK4w6tS
         ZEVA==
X-Gm-Message-State: APjAAAVugcqjPvPZZCsR6rgNj5iggpFbl/Bm5MIoVvQgh+HLUtZ0piDY
        Z2oHnior4JAH9LvMhKyxciZ+GbtO2Y+YbeChXZ1AAPf9FSSwlw3BgtCApgqt1qXOOlso1tnpvw7
        q+tEYPdPSkO4vlseXoFYlmexB
X-Received: by 2002:ac8:18eb:: with SMTP id o40mr12230183qtk.304.1572170656208;
        Sun, 27 Oct 2019 03:04:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxGQTCutbRGwG/hqehf3CeyndAKewdMdeoJOADviHDVuig69eSpbDhlBsX3tnjDPNRXLTAZiA==
X-Received: by 2002:ac8:18eb:: with SMTP id o40mr12230171qtk.304.1572170655989;
        Sun, 27 Oct 2019 03:04:15 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
        by smtp.gmail.com with ESMTPSA id b185sm5051949qkg.45.2019.10.27.03.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 03:04:14 -0700 (PDT)
Date:   Sun, 27 Oct 2019 06:04:10 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vringh: fix copy direction of
 vringh_iov_push_kern()
Message-ID: <20191027060328-mutt-send-email-mst@kernel.org>
References: <20191024035718.7690-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024035718.7690-1-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 11:57:18AM +0800, Jason Wang wrote:
> We want to copy from iov to buf, so the direction was wrong.
> 
> Note: no real user for the helper, but it will be used by future
> features.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

I'm still inclined to merge it now, incorrect code tends to
proliferate.

> ---
>  drivers/vhost/vringh.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 08ad0d1f0476..a0a2d74967ef 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -852,6 +852,12 @@ static inline int xfer_kern(void *src, void *dst, size_t len)
>  	return 0;
>  }
>  
> +static inline int kern_xfer(void *dst, void *src, size_t len)
> +{
> +	memcpy(dst, src, len);
> +	return 0;
> +}
> +
>  /**
>   * vringh_init_kern - initialize a vringh for a kernelspace vring.
>   * @vrh: the vringh to initialize.
> @@ -958,7 +964,7 @@ EXPORT_SYMBOL(vringh_iov_pull_kern);
>  ssize_t vringh_iov_push_kern(struct vringh_kiov *wiov,
>  			     const void *src, size_t len)
>  {
> -	return vringh_iov_xfer(wiov, (void *)src, len, xfer_kern);
> +	return vringh_iov_xfer(wiov, (void *)src, len, kern_xfer);
>  }
>  EXPORT_SYMBOL(vringh_iov_push_kern);
>  
> -- 
> 2.19.1
