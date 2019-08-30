Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA811C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 14:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31C523426
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 14:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbfH3OCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 10:02:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41978 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728098AbfH3OCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 10:02:40 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3C08A3CA20
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 14:02:40 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id n135so7360560qke.23
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 07:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dm3SQV6KNXW2r52/sYgn7Fx2GIZBh2qt4DQKQJwM1eI=;
        b=LzapZ/wgGReNjbbIgulJXoLjU/kA9LFS0hfScWq8QDh3OrhYydCacE2TceAQNLZlvE
         xf4n282OeiJyaFb51ruDiK2mOx+Q9XzjtUqE//Fe6dGBbAmsrEo2e10jOzZ7IDki7JLh
         8r3/q3UXZuLl7y18Qlv9QlLu5L1xTQDRdHA9CpZTyBdgYbqL+C+u0QD3EjTywFuKkwQi
         7zYSEVNlf4JuTlQ2kfgAQGv2wUz8Chkl9AVPHbSFGxGtpnTgM6qt84phnAt5HA6wCCmI
         IqMfxzJ2L4jzoMXmOracpi1BE4H6WuPPZTQHOhqhPEiou2TRahuS+iNmhIx6wRhTvhZ8
         pMdQ==
X-Gm-Message-State: APjAAAUb5YhxthliGzEoGuE2QSmSnFKOocrET2ACQUeES4oV6hliMBJB
        I1acy4yv1gd5Nmm63mt/dMuAPgjG36rrj2QcVzvK0mu6Gy700oDGdRHwBVchwqU4oz8ZSySNpPR
        QAB7OD3Ll4gRVr3Gk3QlKOREK
X-Received: by 2002:ae9:e207:: with SMTP id c7mr14781980qkc.262.1567173759587;
        Fri, 30 Aug 2019 07:02:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyzpK/f9AAF+jxF06AYZCj6OSOKjlMicezFhcQw9CYKtXu7XbuSnQ4ytRP0nU0sisqBK38Nqw==
X-Received: by 2002:ae9:e207:: with SMTP id c7mr14781962qkc.262.1567173759358;
        Fri, 30 Aug 2019 07:02:39 -0700 (PDT)
Received: from redhat.com (bzq-79-180-62-110.red.bezeqint.net. [79.180.62.110])
        by smtp.gmail.com with ESMTPSA id v13sm2651158qkj.109.2019.08.30.07.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 07:02:37 -0700 (PDT)
Date:   Fri, 30 Aug 2019 10:02:32 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Matej Genci <matej.genci@nutanix.com>
Cc:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio: Change typecasts in vring_init()
Message-ID: <20190830095928-mutt-send-email-mst@kernel.org>
References: <20190827152000.53920-1-matej.genci@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827152000.53920-1-matej.genci@nutanix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 03:20:57PM +0000, Matej Genci wrote:
> Compilers such as g++ 7.3 complain about assigning void* variable to
> a non-void* variable (like struct pointers) and pointer arithmetics
> on void*.
> 
> Signed-off-by: Matej Genci <matej.genci@nutanix.com>
> ---
>  include/uapi/linux/virtio_ring.h | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> index 4c4e24c291a5..2c339b9e2923 100644
> --- a/include/uapi/linux/virtio_ring.h
> +++ b/include/uapi/linux/virtio_ring.h
> @@ -168,10 +168,11 @@ static inline void vring_init(struct vring *vr, unsigned int num, void *p,
>  			      unsigned long align)
>  {
>  	vr->num = num;
> -	vr->desc = p;
> -	vr->avail = p + num*sizeof(struct vring_desc);
> -	vr->used = (void *)(((uintptr_t)&vr->avail->ring[num] + sizeof(__virtio16)
> -		+ align-1) & ~(align - 1));
> +	vr->desc = (struct vring_desc *)p;
> +	vr->avail = (struct vring_avail *)((uintptr_t)p
> +		+ num*sizeof(struct vring_desc));
> +	vr->used = (struct vring_used *)(((uintptr_t)&vr->avail->ring[num]
> +		+ sizeof(__virtio16) + align-1) & ~(align - 1));
>  }
>  
>  static inline unsigned vring_size(unsigned int num, unsigned long align)

I'm not really interested in building with g++, sorry.
Centainly not if it makes code less robust by forcing
casts where they weren't previously necessary.

However, vring_init and vring_size are legacy APIs anyway,
so I'd be happy to add ifndefs that will allow userspace
simply hide these functions if it does not need them.


> -- 
> 2.22.0
> 
