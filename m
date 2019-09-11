Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD03ECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6AB42089F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbfIKJ35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 05:29:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59810 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbfIKJ35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 05:29:57 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3F2D844FB1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 09:29:57 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id m6so23015202qtk.23
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 02:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zt5S4a6X6LyLwhE9vIVWQMU/7PuQubto3A7P5mD1PK4=;
        b=oUKGv3BxorCDpLJzFdSC4G3kft2qQgisArdnIlDtGK2DeMsNPGC3HuuN7s6BezPjix
         R8IrB8japaZ84ut2kSvAtkf4LlDqQ8gyhlDJqj9w8L0lL0mE4U9C8FpXy8Hnlc9zxYsq
         l8UPsF4W2jZu8lMmOAb9C9D4CCCl24URELv1Id3LEr/q+nigexiwMVp13pRLToNTDxOZ
         Y5TyPC9Q0qKg1m925CuhgpC2pXmiWk1b/CxDaYABiyoSJ+zl/lwFEBisVtPDBAI+mcpb
         nsb5LYod5/BKyjEZVSeBoRkeQhmAlhbzs4M3rEqkYd4Ged0A8k9TPZ3BETu0Ct3tB+/M
         9n/w==
X-Gm-Message-State: APjAAAVIwfbliy6NvuAGejNEhRaS55bd4Beeq+wp2DMp9XV6bKrN7Ht7
        In4ZsMySA7lST8DRW95zoMgTIJ0NGqM3TmPcIPPlKwL76fhZbbrtrG6x6GxgZLofmY4N/ciO5fF
        e9wjAaTpyy6eDu9RpAf+K+0Au
X-Received: by 2002:a37:48cd:: with SMTP id v196mr33105328qka.419.1568194195927;
        Wed, 11 Sep 2019 02:29:55 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyE8k+b7UWHLIlJ8Xibf2YSLj1PYH2HcRg+svLgOynqAQVbEpwFlt5nBwF+4ii6zLUj2pOgDg==
X-Received: by 2002:a37:48cd:: with SMTP id v196mr33105319qka.419.1568194195786;
        Wed, 11 Sep 2019 02:29:55 -0700 (PDT)
Received: from redhat.com ([80.74.107.118])
        by smtp.gmail.com with ESMTPSA id h68sm9749151qkf.2.2019.09.11.02.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 02:29:55 -0700 (PDT)
Date:   Wed, 11 Sep 2019 05:29:50 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Matej Genci <matej.genci@nutanix.com>
Cc:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] virtio: add VIRTIO_RING_NO_LEGACY
Message-ID: <20190911052825-mutt-send-email-mst@kernel.org>
References: <20190910175335.231660-1-matej.genci@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910175335.231660-1-matej.genci@nutanix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 05:53:44PM +0000, Matej Genci wrote:
> Add macro to disable legacy functions vring_init and vring_size.
> 
> Signed-off-by: Matej Genci <matej.genci@nutanix.com>
> ---
> 
> V2: Put all legacy APIs inside guards.
> 
> ---
>  include/uapi/linux/virtio_ring.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> index 4c4e24c291a5..efe5a421b4ea 100644
> --- a/include/uapi/linux/virtio_ring.h
> +++ b/include/uapi/linux/virtio_ring.h
> @@ -118,6 +118,8 @@ struct vring_used {
>  	struct vring_used_elem ring[];
>  };
>  
> +#ifndef VIRTIO_RING_NO_LEGACY
> +
>  struct vring {
>  	unsigned int num;
>  
> @@ -128,6 +130,8 @@ struct vring {
>  	struct vring_used *used;
>  };
>  
> +#endif /* VIRTIO_RING_NO_LEGACY */
> +
>  /* Alignment requirements for vring elements.
>   * When using pre-virtio 1.0 layout, these fall out naturally.
>   */
> @@ -135,6 +139,8 @@ struct vring {
>  #define VRING_USED_ALIGN_SIZE 4
>  #define VRING_DESC_ALIGN_SIZE 16
>  
> +#ifndef VIRTIO_RING_NO_LEGACY
> +
>  /* The standard layout for the ring is a continuous chunk of memory which looks
>   * like this.  We assume num is a power of 2.
>   *
> @@ -195,6 +201,8 @@ static inline int vring_need_event(__u16 event_idx, __u16 new_idx, __u16 old)
>  	return (__u16)(new_idx - event_idx - 1) < (__u16)(new_idx - old);
>  }
>  
> +#endif /* VIRTIO_RING_NO_LEGACY */
> +
>  struct vring_packed_desc_event {
>  	/* Descriptor Ring Change Event Offset/Wrap Counter. */
>  	__le16 off_wrap;

OK almost but vring_need_event is actually useful for all variants
so should be outside the guards :) Sorry about it.

-- 
MST
