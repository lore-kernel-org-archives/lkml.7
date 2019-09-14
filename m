Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D7FC4CEC9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 19:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8605820828
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 19:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731290AbfINTit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 15:38:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56318 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729470AbfINTis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 15:38:48 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2E25B85546
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2019 19:38:47 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id z4so35948674qts.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2019 12:38:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KIGHcmUUN4jMJWs2R7tAQdbVbc2v6AIe7xkdq87Pa2A=;
        b=YPPTPu40vZMDwR9P0OCNyPs8Dm2T4mBLqwSsh4GWNR3Y65RJy3SBUdBaL4bS7jk/5E
         4u/a1HHp44qjX/8/ZCxZX6UvHGAR5GDLJECJzJXKQCI6xkalRor4w7kR5m+QJ1pbMj3K
         B9ZYXLWthg/swlX6R4Hk60DdbCGrWbQ+wAYbV1BHA4BeUbo4Di5bsyMskMmycQStn2qv
         xoLN0UySsELxdWSOUJLNKw5/lVqAcB0UPdi7zMzudWid74MObh5GHwSIhF5dDt/e3ZBt
         d2rgf+LwlOdHXjcbLGjN6CgBZdR3ZQyhqyNZWJw3AOeBOOcYpVubjkUYyzlyIVl+RgBm
         aswA==
X-Gm-Message-State: APjAAAWxyexTsDdDytHeUWDin6QtRvNPjOw0WAdQLYpKSM3vjXScaPW+
        hagIUnpKWXR+fBtzdTqDvtxO+W17RqQKOGlJy9tq/w1KGEMbZkdDcHfgO/VInKCC/bZCzir4uJC
        qiq5ImgpnFWoIeqDP8pcTLcOT
X-Received: by 2002:a05:620a:c:: with SMTP id j12mr49368897qki.127.1568489926544;
        Sat, 14 Sep 2019 12:38:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw7wOJHQxLUm66la0qX4SPSRkPiO4NywNevPf0TnyLpnxGz/aWmk5UQ6mtqxs1zvRBm/WQW7Q==
X-Received: by 2002:a05:620a:c:: with SMTP id j12mr49368877qki.127.1568489926312;
        Sat, 14 Sep 2019 12:38:46 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
        by smtp.gmail.com with ESMTPSA id 60sm15837153qta.77.2019.09.14.12.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2019 12:38:45 -0700 (PDT)
Date:   Sat, 14 Sep 2019 15:38:39 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] vhost: Fix compile time error
Message-ID: <20190914153325-mutt-send-email-mst@kernel.org>
References: <1568450697-16775-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568450697-16775-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2019 at 01:44:57AM -0700, Guenter Roeck wrote:
> Building vhost on 32-bit targets results in the following error.
> 
> drivers/vhost/vhost.c: In function 'translate_desc':
> include/linux/compiler.h:549:38: error:
> 	call to '__compiletime_assert_1879' declared with attribute error:
> 	BUILD_BUG_ON failed: sizeof(_s) > sizeof(long)
> 
> Fixes: a89db445fbd7 ("vhost: block speculation of translated descriptors")
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>



> ---
>  drivers/vhost/vhost.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index acabf20b069e..102a0c877007 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2074,7 +2074,7 @@ static int translate_desc(struct vhost_virtqueue *vq, u64 addr, u32 len,
>  		_iov->iov_base = (void __user *)
>  			((unsigned long)node->userspace_addr +
>  			 array_index_nospec((unsigned long)(addr - node->start),
> -					    node->size));
> +					    (unsigned long)node->size));

Unfortunately this does not fix the case where size is actually 64 bit,
e.g. a single node with VA 0, size 2^32 is how
you cover the whole virtual address space.

this is not how qemu uses it, but it's valid.

I think it's best to just revert the patch for now.

>  		s += size;
>  		addr += size;
>  		++ret;
> -- 
> 2.7.4
