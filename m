Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E45C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F23820833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbfDINOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 09:14:22 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41518 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfDINOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 09:14:21 -0400
Received: by mail-qt1-f194.google.com with SMTP id w30so19610822qta.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 06:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UmZLaJ9WnQvS4R9DmOc5Vf+eoIpB6BGb4MVg7gNWaOs=;
        b=QfVdCEKOAg630HnallFI7PG7ZbDnFjxW6jLVnjjOhKHiZMa96a4W3pdUzWEwCJ5gKa
         AUusB8rc9oJbpHDD5mhR3ulMgIZjTELgNHBYIqw3xIAxd8y1qrWeWIioVAilPFYa1WQC
         icNk0CQ/OZChWiCMiKDH2fntStJQEM8Y+PGUmPGDXyUAM1zHGltEAc4rBbo7Y/7h8gXR
         rHAND15WVap3vZyy0zM/SEoQAFQcUaQNt3TNf2tH02SMoRbYf0AYI1lRnUujHNqG7jeq
         Ph4DNA6oS7O3CO7/OGUSVPAdXn3ej8uqCuvOl+6lbnqRZiP34MssMNFf5FTG6aFkpqK8
         CX3Q==
X-Gm-Message-State: APjAAAVbsyPHomv/ZdmAcnI8fbUDJF494ih1Gpx0ev9eKJWDNcb91pT/
        8Tkbi7GZ/zCZGo8Jmo72R2kGMg==
X-Google-Smtp-Source: APXvYqx9Yl3qNCk9jSc2Lp9kA36NyJUpOu1CZ4tscgGfUToa+tZdwUysok4sEZzsM7UZF11iQT5jLA==
X-Received: by 2002:ac8:2d94:: with SMTP id p20mr28697596qta.62.1554815660319;
        Tue, 09 Apr 2019 06:14:20 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id v8sm20329082qtc.69.2019.04.09.06.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 06:14:19 -0700 (PDT)
Date:   Tue, 9 Apr 2019 09:14:16 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH net] vhost: flush dcache page when logging dirty pages
Message-ID: <20190409085607-mutt-send-email-mst@kernel.org>
References: <20190409041647.21269-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409041647.21269-1-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 12:16:47PM +0800, Jason Wang wrote:
> We set dirty bit through setting up kmaps and access them through
> kernel virtual address, this may result alias in virtually tagged
> caches that require a dcache flush afterwards.
> 
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Fixes: 3a4d5c94e9593 ("vhost_net: a kernel-level virtio server")

This is like saying "everyone with vhost needs this".
In practice only might affect some architectures.
Which ones? You want to Cc the relevant maintainers
who understand this...

> Signed-off-by: Jason Wang <jasowang@redhat.com>

I am not sure this is a good idea.
The region in question is supposed to be accessed
by userspace at the same time, through atomic operations.

How do we know userspace didn't access it just before?

Is that an issue at all given we use
atomics for access? Documentation/core-api/cachetlb.rst does
not mention atomics.
Which architectures are affected?
Assuming atomics actually do need a flush, then don't we need
a flush in the other direction too? How are atomics
supposed to work at all?


I really think we need new APIs along the lines of
set_bit_to_user.

> ---
>  drivers/vhost/vhost.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 351af88231ad..34a1cedbc5ba 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1711,6 +1711,7 @@ static int set_bit_to_user(int nr, void __user *addr)
>  	base = kmap_atomic(page);
>  	set_bit(bit, base);
>  	kunmap_atomic(base);
> +	flush_dcache_page(page);
>  	set_page_dirty_lock(page);
>  	put_page(page);
>  	return 0;

Ignoring the question of whether this actually helps, I doubt
flush_dcache_page is appropriate here.  Pls take a look at
Documentation/core-api/cachetlb.rst as well as the actual
implementation.

I think you meant flush_kernel_dcache_page, and IIUC it must happen
before kunmap, not after (which you still have the va locked).

> -- 
> 2.19.1
