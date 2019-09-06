Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C9EC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C6D20854
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393944AbfIFOGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 10:06:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44758 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730753AbfIFOGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:06:44 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B286351EF1
        for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2019 14:06:43 +0000 (UTC)
Received: by mail-qk1-f197.google.com with SMTP id b143so6550794qkg.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 07:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XVlBYwWWxYZBuj80Wo4VR566is8MJKIph81f4lPbuDU=;
        b=cdehknMzRkh7tnPOcRnCnXH5AZel0TuXb+JvIUn4244fPtT3ghVSW1ldKgi9iNJTo+
         A5D0MW/Y+h7S6IEBh4/KY6JBjR88qgc0gboLjhRL5TJ2Y0l3XeXP0nX2/KZ//TNib12E
         rNMd03CS3fQkzo9QpNOvOBh6rtBFu9JnNiylsnYW7ss8sCaA7Oodfj4645HY/2yeiD5X
         eGpP1VJh9SJYOEqeKZOqxRa8gntfH1Ika5PUXb8WmVmXzUQ5InKlvbPoiploYbLGna3N
         gBAb6GaytaHzbBCJGVV15YorR7kyN5YEPj1XOekCOeCReurlNryTZ4EWZK8nkAQVORM5
         1+EA==
X-Gm-Message-State: APjAAAU1uBDYKfE5p/i93LQVJb9uwTkZSM72D+XJIOOmreU0wNlT8C50
        PV5CUSCmAHxElZj7KaLHBCM3PVrD4Y7ndN+E+1ysGoec4W5U6O91MuVzk2fie3BopIS/jSRdQ4T
        /vDx+J1pQwCLafOgiw5am2kyT
X-Received: by 2002:a05:620a:1592:: with SMTP id d18mr8385850qkk.468.1567778802400;
        Fri, 06 Sep 2019 07:06:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyFfHmt4BAMm3zXYOXNtxtGGgrko1UO/aCARKEq+SvfmFdpDLoU/MFEaF1sYtHtlkBh4NqgIw==
X-Received: by 2002:a05:620a:1592:: with SMTP id d18mr8385838qkk.468.1567778802258;
        Fri, 06 Sep 2019 07:06:42 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
        by smtp.gmail.com with ESMTPSA id l22sm2186175qtp.8.2019.09.06.07.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 07:06:41 -0700 (PDT)
Date:   Fri, 6 Sep 2019 10:06:36 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Matej Genci <matej.genci@nutanix.com>
Cc:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio: add VIRTIO_RING_NO_LEGACY
Message-ID: <20190906100456-mutt-send-email-mst@kernel.org>
References: <20190906124130.129870-1-matej.genci@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906124130.129870-1-matej.genci@nutanix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 12:42:14PM +0000, Matej Genci wrote:
> Add macro to disable legacy functions vring_init and vring_size.
> 
> Signed-off-by: Matej Genci <matej.genci@nutanix.com>
> ---
>  include/uapi/linux/virtio_ring.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> index 4c4e24c291a5..496db2f33830 100644
> --- a/include/uapi/linux/virtio_ring.h
> +++ b/include/uapi/linux/virtio_ring.h
> @@ -164,6 +164,8 @@ struct vring {
>  #define vring_used_event(vr) ((vr)->avail->ring[(vr)->num])
>  #define vring_avail_event(vr) (*(__virtio16 *)&(vr)->used->ring[(vr)->num])
>  
> +#ifndef VIRTIO_RING_NO_LEGACY
> +
>  static inline void vring_init(struct vring *vr, unsigned int num, void *p,
>  			      unsigned long align)
>  {
> @@ -181,6 +183,8 @@ static inline unsigned vring_size(unsigned int num, unsigned long align)
>  		+ sizeof(__virtio16) * 3 + sizeof(struct vring_used_elem) * num;
>  }
>  
> +#endif
> +
>  /* The following is used with USED_EVENT_IDX and AVAIL_EVENT_IDX */
>  /* Assuming a given event_idx value from the other side, if
>   * we have just incremented index from old to new_idx,

Thanks!
I am guessing vring_used_event/vring_avail_event should be within
this ifndef too? How about struct vring?


> -- 
> 2.22.0
> 
