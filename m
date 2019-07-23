Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30EFC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 09:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D68227C0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 09:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388877AbfGWJQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 05:16:54 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33839 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388860AbfGWJQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 05:16:52 -0400
Received: by mail-qk1-f194.google.com with SMTP id t8so30589793qkt.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 02:16:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p1+gYIBWMowLYRybQ6oWxpq5UdgeV2arIpG6bdXu/8w=;
        b=FuSxTCYDz94//rSADKgDpXxiyPFyKkIFU9sdocBWSbuhaqLDefHA7nNXtcD+w+aWsO
         a+r9fUwEApB3HnsLelyjzO5gKQoM5rlp8FmQ1KZcFmDKPtHNLMwxma0A5ah1msQe8OAn
         h8qmoIBIBNIX+OWxfuLv8ypLZV2x8gSmHIRFgep83ODuMjWsURMZdRwwhtMpMs+c2Lsw
         WE0Zh6Sj1yMOzrBuGFtKHBrKUtq2s6LyeKmRufsnNnP++sHQEVQrlKAcyxBp+KvtQv4j
         /rLXaIDscHotiywV3AyVYaQM8svfpldq0ieWB4wTNiKDl/ZF4ekOmM4W9pm0pS/pJLvq
         DafA==
X-Gm-Message-State: APjAAAV0/jf2YFyHuB7nYHQXNnZfe7RsiYKu2SjumZYzAorO//dUiMD0
        x+C79v/MdJ3+BAYxlyC94Fnuqg==
X-Google-Smtp-Source: APXvYqyu6jNlikk+iK+Qd5rby5/UX6t/lEzykZfn5ns4rVGJkT29eU29dnU+XKBwjNMXoWgetKh15w==
X-Received: by 2002:a37:6508:: with SMTP id z8mr48471820qkb.492.1563873411371;
        Tue, 23 Jul 2019 02:16:51 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
        by smtp.gmail.com with ESMTPSA id t12sm18734095qtr.49.2019.07.23.02.16.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 02:16:50 -0700 (PDT)
Date:   Tue, 23 Jul 2019 05:16:45 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] vhost: don't do synchronize_rcu() in
 vhost_uninit_vq_maps()
Message-ID: <20190723041144-mutt-send-email-mst@kernel.org>
References: <20190723075718.6275-1-jasowang@redhat.com>
 <20190723075718.6275-7-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723075718.6275-7-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 03:57:18AM -0400, Jason Wang wrote:
> There's no need for RCU synchronization in vhost_uninit_vq_maps()
> since we've already serialized with readers (memory accessors). This
> also avoid the possible userspace DOS through ioctl() because of the
> possible high latency caused by synchronize_rcu().
> 
> Reported-by: Michael S. Tsirkin <mst@redhat.com>
> Fixes: 7f466032dc9e ("vhost: access vq metadata through kernel virtual address")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

I agree synchronize_rcu in both mmu notifiers and ioctl
is a problem we must fix.

> ---
>  drivers/vhost/vhost.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 5b8821d00fe4..a17df1f4069a 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -334,7 +334,9 @@ static void vhost_uninit_vq_maps(struct vhost_virtqueue *vq)
>  	}
>  	spin_unlock(&vq->mmu_lock);
>  
> -	synchronize_rcu();
> +	/* No need for synchronize_rcu() or kfree_rcu() since we are
> +	 * serialized with memory accessors (e.g vq mutex held).
> +	 */
>  
>  	for (i = 0; i < VHOST_NUM_ADDRS; i++)
>  		if (map[i])
> -- 
> 2.18.1

.. however we can not RCU with no synchronization in sight.
Sometimes there are hacks like using a lock/unlock
pair instead of sync, but here no one bothers.

specifically notifiers call reset vq maps which calls
uninit vq maps which is not under any lock.

You will get use after free when map is then accessed.

If you always have a lock then just take that lock
and no need for RCU.

-- 
MST
