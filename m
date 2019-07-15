Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B99C76195
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 512552145D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731876AbfGOUgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:36:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729505AbfGOUgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 16:36:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9E07D308FEC0;
        Mon, 15 Jul 2019 20:36:24 +0000 (UTC)
Received: from redhat.com (ovpn-125-108.rdu2.redhat.com [10.10.125.108])
        by smtp.corp.redhat.com (Postfix) with SMTP id 26AFF608CA;
        Mon, 15 Jul 2019 20:36:17 +0000 (UTC)
Date:   Mon, 15 Jul 2019 16:36:11 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     virtualization@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        David Gibson <david@gibson.dropbear.id.au>,
        Alexey Kardashevskiy <aik@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Michael Roth <mdroth@linux.vnet.ibm.com>,
        Mike Anderson <andmike@linux.ibm.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Message-ID: <20190715163453-mutt-send-email-mst@kernel.org>
References: <20190323165456-mutt-send-email-mst@kernel.org>
 <87a7go71hz.fsf@morokweng.localdomain>
 <20190520090939-mutt-send-email-mst@kernel.org>
 <877ea26tk8.fsf@morokweng.localdomain>
 <20190603211528-mutt-send-email-mst@kernel.org>
 <877e96qxm7.fsf@morokweng.localdomain>
 <20190701092212-mutt-send-email-mst@kernel.org>
 <87d0id9nah.fsf@morokweng.localdomain>
 <20190715103411-mutt-send-email-mst@kernel.org>
 <874l3nnist.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874l3nnist.fsf@morokweng.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 15 Jul 2019 20:36:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 05:29:06PM -0300, Thiago Jung Bauermann wrote:
> 
> Michael S. Tsirkin <mst@redhat.com> writes:
> 
> > On Sun, Jul 14, 2019 at 02:51:18AM -0300, Thiago Jung Bauermann wrote:
> >>
> >>
> >> Michael S. Tsirkin <mst@redhat.com> writes:
> >>
> >> > So this is what I would call this option:
> >> >
> >> > VIRTIO_F_ACCESS_PLATFORM_IDENTITY_ADDRESS
> >> >
> >> > and the explanation should state that all device
> >> > addresses are translated by the platform to identical
> >> > addresses.
> >> >
> >> > In fact this option then becomes more, not less restrictive
> >> > than VIRTIO_F_ACCESS_PLATFORM - it's a promise
> >> > by guest to only create identity mappings,
> >> > and only before driver_ok is set.
> >> > This option then would always be negotiated together with
> >> > VIRTIO_F_ACCESS_PLATFORM.
> >> >
> >> > Host then must verify that
> >> > 1. full 1:1 mappings are created before driver_ok
> >> >     or can we make sure this happens before features_ok?
> >> >     that would be ideal as we could require that features_ok fails
> >> > 2. mappings are not modified between driver_ok and reset
> >> >     i guess attempts to change them will fail -
> >> >     possibly by causing a guest crash
> >> >     or some other kind of platform-specific error
> >>
> >> I think VIRTIO_F_ACCESS_PLATFORM_IDENTITY_ADDRESS is good, but requiring
> >> it to be accompanied by ACCESS_PLATFORM can be a problem. One reason is
> >> SLOF as I mentioned above, another is that we would be requiring all
> >> guests running on the machine (secure guests or not, since we would use
> >> the same configuration for all guests) to support it. But
> >> ACCESS_PLATFORM is relatively recent so it's a bit early for that. For
> >> instance, Ubuntu 16.04 LTS (which is still supported) doesn't know about
> >> it and wouldn't be able to use the device.
> >
> > OK and your target is to enable use with kernel drivers within
> > guests, right?
> 
> Right.
> 
> > My question is, we are defining a new flag here, I guess old guests
> > then do not set it. How does it help old guests? Or maybe it's
> > not designed to ...
> 
> Indeed. The idea is that QEMU can offer the flag, old guests can reject
> it (or even new guests can reject it, if they decide not to convert into
> secure VMs) and the feature negotiation will succeed with the flag
> unset.

OK. And then what does QEMU do? Assume guest is not encrypted I guess?

> --
> Thiago Jung Bauermann
> IBM Linux Technology Center
