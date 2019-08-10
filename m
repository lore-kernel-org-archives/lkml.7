Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E65C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 18:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163A42086A
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 18:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfHJS50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 14:57:26 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35505 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfHJS50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 14:57:26 -0400
Received: by mail-qk1-f195.google.com with SMTP id r21so74294234qke.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 11:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n6gqfGDHe7+MTEnADmz166g2MOtyyjqswDo8TxgNKgo=;
        b=Q6ifeRUiJq/FlCl5IBuzL5lNwagaKSUMnyZ8bqTaIw7CF4rI61xezB1u4usfoeP5bn
         JIbPoiOqhQfExHGQRChBRHTn+4Ypx3TfEpabKUZFNr+1QjLi9p+R6hCCIUalZcimu8su
         1+PWhSEuywpvY1JVmIKNZbBgTsSHf8j1k64MRE8FM38H+eNUDM0cELPmPywemY+BXpak
         nb0nR8HkzFLkA35Oyjv+c/SYHVRvJQ1HRHdmvWgQSyxbCxXSKXOXnRH+Zgz7hKLZpTqq
         9ttIiwvHRbPR65WbG/5ljkAbTE/nlICu7AqpltSusmkLBKkaIMxtR/oaG14EnBR1sL3F
         1rSQ==
X-Gm-Message-State: APjAAAVAX+FKvVlMApeu/tPDhcJAYY3cE/zKCWoNT7uLuA1sIseOBm2q
        OrxYyjrZ6Ck/iEeplSkw4KJu6Q==
X-Google-Smtp-Source: APXvYqwuyeU8UtFCpYJUCrWlfgo5mzoYufqwOGAgTcpKSjKBKpcYs8i84bGcIhjBa4714/V3v9R2eQ==
X-Received: by 2002:a05:620a:1f0:: with SMTP id x16mr12879248qkn.11.1565463444927;
        Sat, 10 Aug 2019 11:57:24 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
        by smtp.gmail.com with ESMTPSA id l3sm100152qkb.67.2019.08.10.11.57.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 10 Aug 2019 11:57:23 -0700 (PDT)
Date:   Sat, 10 Aug 2019 14:57:17 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     virtualization@lists.linux-foundation.org,
        linuxppc-devel@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        David Gibson <david@gibson.dropbear.id.au>,
        Alexey Kardashevskiy <aik@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ram Pai <linuxram@us.ibm.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Message-ID: <20190810143038-mutt-send-email-mst@kernel.org>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhrj8kcp.fsf@morokweng.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 03:08:12PM -0200, Thiago Jung Bauermann wrote:
> 
> Hello,
> 
> With Christoph's rework of the DMA API that recently landed, the patch
> below is the only change needed in virtio to make it work in a POWER
> secure guest under the ultravisor.
> 
> The other change we need (making sure the device's dma_map_ops is NULL
> so that the dma-direct/swiotlb code is used) can be made in
> powerpc-specific code.
> 
> Of course, I also have patches (soon to be posted as RFC) which hook up
> <linux/mem_encrypt.h> to the powerpc secure guest support code.
> 
> What do you think?
> 
> >From d0629a36a75c678b4a72b853f8f7f8c17eedd6b3 Mon Sep 17 00:00:00 2001
> From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> Date: Thu, 24 Jan 2019 22:08:02 -0200
> Subject: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
> 
> The host can't access the guest memory when it's encrypted, so using
> regular memory pages for the ring isn't an option. Go through the DMA API.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> ---
>  drivers/virtio/virtio_ring.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index cd7e755484e3..321a27075380 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -259,8 +259,11 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
>  	 * not work without an even larger kludge.  Instead, enable
>  	 * the DMA API if we're a Xen guest, which at least allows
>  	 * all of the sensible Xen configurations to work correctly.
> +	 *
> +	 * Also, if guest memory is encrypted the host can't access
> +	 * it directly. In this case, we'll need to use the DMA API.
>  	 */
> -	if (xen_domain())
> +	if (xen_domain() || sev_active())
>  		return true;
> 
>  	return false;

So I gave this lots of thought, and I'm coming round to
basically accepting something very similar to this patch.

But not exactly like this :).

Let's see what are the requirements.

If

1. We do not trust the device (so we want to use a bounce buffer with it)
2. DMA address is also a physical address of a buffer

then we should use DMA API with virtio.


sev_active() above is one way to put (1).  I can't say I love it but
it's tolerable.


But we also want promise from DMA API about 2.


Without promise 2 we simply can't use DMA API with a legacy device.


Otherwise, on a SEV system with an IOMMU which isn't 1:1
and with a virtio device without ACCESS_PLATFORM, we are trying
to pass a virtual address, and devices without ACCESS_PLATFORM
can only access CPU physical addresses.

So something like:

dma_addr_is_phys_addr?



-- 
MST
