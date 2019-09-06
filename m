Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC71CC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 05:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B680206CD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 05:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392232AbfIFFIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 01:08:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55666 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391415AbfIFFIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 01:08:02 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9E97669066
        for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2019 05:08:01 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id n135so5053474qke.23
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 22:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l2IJkNQk1WGVpYF2C2pNnjExkv8L64jyK1l0fhuGrQQ=;
        b=YCwKagdKhtBKaKjOT8SlxcUJ1gJjSfb7PtRbOBAcui62eCilIlBdVsVi7S9as1Wg4e
         y7DCBPD7lHDTXQCPV/SfvXnXxQ2mt5dxsjScjMMRyhNO49Hry9Rm0zV3I54+xmVaUKl6
         dBHhgD11rivcqQUHSCqkwsVunRAOopRSBFg4/mpfN5jo1mvq5BiEnUO1QlOWaT2YqD9x
         /DAhT+u9ZGsvfVY3ZAuuuXc7q6znfykF7pf6SrL3HzDuvOq5owA6WlFvA1+bUuSjrfr9
         l0K4yTRnzMI5NSetTWR4nsEEl8YaclJirUy/k3IqTLhhjV0axF+ind7Yk+06YLWIm04q
         YvaA==
X-Gm-Message-State: APjAAAWRPUjvDS4AQTrqVZ4IBJMpyOGdCXgG33ROcG6JuJv7+CReY+8F
        Cc6y6Yn4Y/EE2IvqXuavisEXc3aqEN0FgzBO6OMx4KgmsdcpTaduvhyYZ7y+fIwFs6DJDGzTV+L
        9RuFZ/9YFtPtcVpNDbbm+aqoC
X-Received: by 2002:ac8:149a:: with SMTP id l26mr7381728qtj.267.1567746481006;
        Thu, 05 Sep 2019 22:08:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzSVqXB2yJBiZ8qLNaAGXzVS5fYjQAlfJVZ4rV3ixHqyHyZ9tuPVELNAMJ1/UauLsyEphl8xA==
X-Received: by 2002:ac8:149a:: with SMTP id l26mr7381715qtj.267.1567746480788;
        Thu, 05 Sep 2019 22:08:00 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
        by smtp.gmail.com with ESMTPSA id b192sm2114746qkg.39.2019.09.05.22.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 22:07:59 -0700 (PDT)
Date:   Fri, 6 Sep 2019 01:07:53 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Alexey Kardashevskiy <aik@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Message-ID: <20190906001220-mutt-send-email-mst@kernel.org>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
 <20190810143038-mutt-send-email-mst@kernel.org>
 <20190810220702.GA5964@ram.ibm.com>
 <20190811055607.GA12488@lst.de>
 <20190811044431-mutt-send-email-mst@kernel.org>
 <20190812121532.GB9405@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812121532.GB9405@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 02:15:32PM +0200, Christoph Hellwig wrote:
> On Sun, Aug 11, 2019 at 04:55:27AM -0400, Michael S. Tsirkin wrote:
> > On Sun, Aug 11, 2019 at 07:56:07AM +0200, Christoph Hellwig wrote:
> > > So we need a flag on the virtio device, exposed by the
> > > hypervisor (or hardware for hw virtio devices) that says:  hey, I'm real,
> > > don't take a shortcut.
> > 
> > The point here is that it's actually still not real. So we would still
> > use a physical address. However Linux decides that it wants extra
> > security by moving all data through the bounce buffer.  The distinction
> > made is that one can actually give device a physical address of the
> > bounce buffer.
> 
> Sure.  The problem is just that you keep piling hacks on top of hacks.
> We need the per-device flag anyway to properly support hardware virtio
> device in all circumstances.  Instead of coming up with another ad-hoc
> hack to force DMA uses implement that one proper bit and reuse it here.

The flag that you mention literally means "I am a real device" so for
example, you can use VFIO with it. And this device isn't a real one,
and you can't use VFIO with it, even though it's part of a power
system which always has an IOMMU.



Or here's another way to put it: we have a broken device that can only
access physical addresses, not DMA addresses. But to enable SEV Linux
requires DMA API.  So we can still make it work if DMA address happens
to be a physical address (not necessarily of the same page).


This is where dma_addr_is_a_phys_addr() is coming from: it tells us this
weird configuration can still work.  What are we going to do for SEV if
dma_addr_is_a_phys_addr does not apply? Fail probe I guess.


So the proposal is really to make things safe and to this end,
to add this in probe:

	if (sev_active() &&
	    !dma_addr_is_a_phys_addr(dev) &&
	    !virtio_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM))
		return -EINVAL;


the point being to prevent loading driver where it would
corrupt guest memory. Put this way, any objections to adding
dma_addr_is_a_phys_addr to the DMA API?





-- 
MST
