Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BBBC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 21:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164C821880
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 21:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbfGXVjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 17:39:07 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38709 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfGXVjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 17:39:07 -0400
Received: by mail-qk1-f193.google.com with SMTP id a27so34931621qkk.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 14:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=28a4qMc4GebGixyPVlXegsBCWlKTvaQ82BrqmXv24hI=;
        b=VDUAdezJz7Jp0lAgg8vuCLXFaBlw/OkbeSBLv5SyQDJf0A4psk+BUnMYX9NITkB7mq
         2Q6jUWaVrW/l8F3VPG1npLWpU4idl59CPxJPPy9VQGMEUptbmuCrf9fqXgv9sETRA4uR
         pDFbsVwDSKaiQHERkK04EH3qSSKdZY4DyTXhgYD8q2iyzXk765YP1LZdRPVKqcEeAbcg
         eb/hf2CWrKxMY0do+RI1/fccg6LQdj5FD9IrO692a+lynDypBuEWjpqEWJjp4NmDd53m
         dQ47SPaantFhL0QAjgY4SQqYz+nrvF9chNQZ0sd8LF6M5zeJ8EnYJh6Sfks26D+DXaqh
         Ysqw==
X-Gm-Message-State: APjAAAU2h0KY8soNCvp+zaV7TGjAhizE9dnaGtOj6wc4ikYGj/ifWYoT
        GnQJhPpAXYlPKk10eucEk2Pl2g==
X-Google-Smtp-Source: APXvYqx5Vviay06G4wTpmKw6r6Rmn4S1f6AcbU39ZWHwDn0ZM/RIONGYIejuWx0pfdZo4Js4cYM76A==
X-Received: by 2002:a37:6944:: with SMTP id e65mr51570295qkc.119.1564004345710;
        Wed, 24 Jul 2019 14:39:05 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
        by smtp.gmail.com with ESMTPSA id g2sm21591961qti.68.2019.07.24.14.39.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 14:39:04 -0700 (PDT)
Date:   Wed, 24 Jul 2019 17:38:57 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     nitesh@redhat.com, kvm@vger.kernel.org, david@redhat.com,
        dave.hansen@intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        yang.zhang.wz@gmail.com, pagupta@redhat.com, riel@surriel.com,
        konrad.wilk@oracle.com, lcapitulino@redhat.com,
        wei.w.wang@intel.com, aarcange@redhat.com, pbonzini@redhat.com,
        dan.j.williams@intel.com, alexander.h.duyck@linux.intel.com
Subject: Re: [PATCH v2 QEMU] virtio-balloon: Provide a interface for "bubble
 hinting"
Message-ID: <20190724173403-mutt-send-email-mst@kernel.org>
References: <20190724165158.6685.87228.stgit@localhost.localdomain>
 <20190724171050.7888.62199.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724171050.7888.62199.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 10:12:10AM -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> Add support for what I am referring to as "bubble hinting". Basically the
> idea is to function very similar to how the balloon works in that we
> basically end up madvising the page as not being used. However we don't
> really need to bother with any deflate type logic since the page will be
> faulted back into the guest when it is read or written to.
> 
> This is meant to be a simplification of the existing balloon interface
> to use for providing hints to what memory needs to be freed. I am assuming
> this is safe to do as the deflate logic does not actually appear to do very
> much other than tracking what subpages have been released and which ones
> haven't.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

BTW I wonder about migration here.  When we migrate we lose all hints
right?  Well destination could be smarter, detect that page is full of
0s and just map a zero page. Then we don't need a hint as such - but I
don't think it's done like that ATM.


I also wonder about interaction with deflate.  ATM deflate will add
pages to the free list, then balloon will come right back and report
them as free.


> ---
>  hw/virtio/virtio-balloon.c                      |   40 +++++++++++++++++++++++
>  include/hw/virtio/virtio-balloon.h              |    2 +
>  include/standard-headers/linux/virtio_balloon.h |    1 +
>  3 files changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index 2112874055fb..70c0004c0f88 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -328,6 +328,39 @@ static void balloon_stats_set_poll_interval(Object *obj, Visitor *v,
>      balloon_stats_change_timer(s, 0);
>  }
>  
> +static void virtio_bubble_handle_output(VirtIODevice *vdev, VirtQueue *vq)
> +{
> +    VirtQueueElement *elem;
> +
> +    while ((elem = virtqueue_pop(vq, sizeof(VirtQueueElement)))) {
> +    	unsigned int i;
> +
> +        for (i = 0; i < elem->in_num; i++) {
> +            void *addr = elem->in_sg[i].iov_base;
> +            size_t size = elem->in_sg[i].iov_len;
> +            ram_addr_t ram_offset;
> +            size_t rb_page_size;
> +            RAMBlock *rb;
> +
> +            if (qemu_balloon_is_inhibited())
> +                continue;
> +
> +            rb = qemu_ram_block_from_host(addr, false, &ram_offset);
> +            rb_page_size = qemu_ram_pagesize(rb);
> +
> +            /* For now we will simply ignore unaligned memory regions */
> +            if ((ram_offset | size) & (rb_page_size - 1))
> +                continue;
> +
> +            ram_block_discard_range(rb, ram_offset, size);
> +        }
> +
> +        virtqueue_push(vq, elem, 0);
> +        virtio_notify(vdev, vq);
> +        g_free(elem);
> +    }
> +}
> +
>  static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>  {
>      VirtIOBalloon *s = VIRTIO_BALLOON(vdev);
> @@ -782,6 +815,11 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
>      s->svq = virtio_add_queue(vdev, 128, virtio_balloon_receive_stats);
>  
>      if (virtio_has_feature(s->host_features,
> +                           VIRTIO_BALLOON_F_HINTING)) {
> +        s->hvq = virtio_add_queue(vdev, 128, virtio_bubble_handle_output);
> +    }
> +
> +    if (virtio_has_feature(s->host_features,
>                             VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
>          s->free_page_vq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE,
>                                             virtio_balloon_handle_free_page_vq);
> @@ -897,6 +935,8 @@ static Property virtio_balloon_properties[] = {
>                      VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
>      DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
>                      VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
> +    DEFINE_PROP_BIT("guest-page-hinting", VirtIOBalloon, host_features,
> +                    VIRTIO_BALLOON_F_HINTING, true),
>      DEFINE_PROP_LINK("iothread", VirtIOBalloon, iothread, TYPE_IOTHREAD,
>                       IOThread *),
>      DEFINE_PROP_END_OF_LIST(),
> diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
> index 1afafb12f6bc..a58b24fdf29d 100644
> --- a/include/hw/virtio/virtio-balloon.h
> +++ b/include/hw/virtio/virtio-balloon.h
> @@ -44,7 +44,7 @@ enum virtio_balloon_free_page_report_status {
>  
>  typedef struct VirtIOBalloon {
>      VirtIODevice parent_obj;
> -    VirtQueue *ivq, *dvq, *svq, *free_page_vq;
> +    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *hvq;
>      uint32_t free_page_report_status;
>      uint32_t num_pages;
>      uint32_t actual;
> diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/standard-headers/linux/virtio_balloon.h
> index 9375ca2a70de..f9e3e8256261 100644
> --- a/include/standard-headers/linux/virtio_balloon.h
> +++ b/include/standard-headers/linux/virtio_balloon.h
> @@ -36,6 +36,7 @@
>  #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
>  #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
>  #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
> +#define VIRTIO_BALLOON_F_HINTING	5 /* Page hinting virtqueue */
>  
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12
