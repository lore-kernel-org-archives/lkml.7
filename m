Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27B7C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 09:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BA3227B9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 09:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388912AbfGWJRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 05:17:34 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41793 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbfGWJRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 05:17:34 -0400
Received: by mail-qk1-f193.google.com with SMTP id v22so30563855qkj.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 02:17:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zIMuDv+zk7S1NCvH0qhLppn9YRoVaxQzRUcA6IGuXcs=;
        b=IyUjX5CRKbTCbTb3d543lfy22o5zLL1aIBbnBdqT8i+6Xd0AxeEEMAcvi5AHIFu0yn
         CkmEnY/HRrEyeLkrZQupiI6PFCLSD6E7kbqXB/dlkQwEgqmgrZvz6iYVGoTfIQae+8Q/
         gUzBVU8SE2QCavAvlj2YnB1fZpKlTJWnadBxjioHCpM1IeB5dn+GEcjFV3nLKtdzvFoL
         1BOzU4MYD6fVYeohMPE/fKErFR4SNuOThdc6P1idFfdei16DgOkaYp6gqV85mWzGeqBa
         SUxmrT6A1aZI9pfCmBXsAg7qLF/t/1XelK8uWaA05xp/9tfcmdru3w248BQDKuC4ZtnL
         WxVA==
X-Gm-Message-State: APjAAAVZ6xsO0EGbj13H5NSI7kaLqJy0ZjUSFn1ir0HkWclzxbh2ER8N
        Nt8QqIFYwLhQT4APXpikAabFjQ==
X-Google-Smtp-Source: APXvYqxCxrHJb2/RQUMnbweSxs5Cq2YkuyrJJ0kQghMt/IAIFI53AquzBnAmUMtJGKkqG286t9N46w==
X-Received: by 2002:a37:646:: with SMTP id 67mr47571333qkg.287.1563873453656;
        Tue, 23 Jul 2019 02:17:33 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
        by smtp.gmail.com with ESMTPSA id g54sm25451794qtc.61.2019.07.23.02.17.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 02:17:32 -0700 (PDT)
Date:   Tue, 23 Jul 2019 05:17:28 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] vhost: reset invalidate_count in
 vhost_set_vring_num_addr()
Message-ID: <20190723042143-mutt-send-email-mst@kernel.org>
References: <20190723075718.6275-1-jasowang@redhat.com>
 <20190723075718.6275-5-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723075718.6275-5-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 03:57:16AM -0400, Jason Wang wrote:
> The vhost_set_vring_num_addr() could be called in the middle of
> invalidate_range_start() and invalidate_range_end(). If we don't reset
> invalidate_count after the un-registering of MMU notifier, the
> invalidate_cont will run out of sync (e.g never reach zero). This will
> in fact disable the fast accessor path. Fixing by reset the count to
> zero.
> 
> Reported-by: Michael S. Tsirkin <mst@redhat.com>
> Fixes: 7f466032dc9e ("vhost: access vq metadata through kernel virtual address")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vhost/vhost.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 03666b702498..89c9f08b5146 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2074,6 +2074,10 @@ static long vhost_vring_set_num_addr(struct vhost_dev *d,
>  		d->has_notifier = false;
>  	}
>  
> +	/* reset invalidate_count in case we are in the middle of
> +	 * invalidate_start() and invalidate_end().
> +	 */
> +	vq->invalidate_count = 0;

I think that the code is ok but the comments are not very clear:
- we are never in the middle since we just removed the notifier
- the result is not just disabling optimization:
  if notifier becomes negative, then later we
  can think it's ok to map when it isn't since
  notifier is active.

>  	vhost_uninit_vq_maps(vq);
>  #endif
>  
> -- 
> 2.18.1
