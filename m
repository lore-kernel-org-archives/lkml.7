Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98371ECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6991521928
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfIKJbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 05:31:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51820 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726696AbfIKJbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 05:31:32 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B8316C098D09
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 09:31:31 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id 72so24216856qki.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 02:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ut3tihE7bTGmYZVRoILxbz8fluSN7bHwSi8fhoDIScQ=;
        b=sOCgP6EwA2+M2+1yunt0gVSkCumdBIDjadmWkBH0wLP5/jaC19anwosFdyy2ItIZbA
         sOUbIrooTHv8fjU/Ke+Egne2Z2vg4UbcdK8c+gRDMOdcdAX0LZkeBjNrmptRZIEJgnZp
         mFh+jnA+5izsU7bEfCyCzJ1oryfvFuh2A/KuTv24rIIGRsFUx8vo8VsTMPgvYnCQr96j
         peG2HbUXbH6K/u9Ws4Kq/+KS7THuTfp1Bd1CAuHbWjc/BqcqM3hcGYOFGigHVkJnTEva
         1sctR+l8bUDAv62/CjfuMyBI2rjpVhc1dNL10dVY6LYtvX42+cmGdmlpoXRfidqETC9F
         iaiw==
X-Gm-Message-State: APjAAAUr/NUu6SLv8G5wbLayXbldtXO0vkweWyO/ftxZo6+wZW2sKBao
        qTQYmEV8JFQ0jCwbn3HQT49z14mIWCeRgIEvBfKUejCFCSDaP7VWHhUdlvegsN0CZMLCzUYcrU8
        ErFmSLAzMCJH7gZcNB+pror4v
X-Received: by 2002:ae9:f20f:: with SMTP id m15mr16057179qkg.199.1568194291043;
        Wed, 11 Sep 2019 02:31:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzfzPT6SmbrsRtarE+GakuNnjpB2pyzd8QrqvF/zQOj7HHkg+hOJA0Po72fFkFP2UoCQrr4Cg==
X-Received: by 2002:ae9:f20f:: with SMTP id m15mr16057160qkg.199.1568194290901;
        Wed, 11 Sep 2019 02:31:30 -0700 (PDT)
Received: from redhat.com ([80.74.107.118])
        by smtp.gmail.com with ESMTPSA id c29sm13406696qtc.89.2019.09.11.02.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 02:31:30 -0700 (PDT)
Date:   Wed, 11 Sep 2019 05:31:25 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Matej Genci <matej.genci@nutanix.com>
Cc:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] virtio: add VIRTIO_RING_NO_LEGACY
Message-ID: <20190911053030-mutt-send-email-mst@kernel.org>
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

And I guess we should be able to define this macro in
drivers/virtio/virtio_pci_modern.c
?

Will be handy to make sure we don't mask too much.

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
> -- 
> 2.22.0
> 
