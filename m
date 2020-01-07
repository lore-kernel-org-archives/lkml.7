Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611BDC33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 07:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29DAF206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 07:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DTexhIJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgAGHGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 02:06:23 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30804 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725914AbgAGHGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 02:06:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578380780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/efjXzZHBg1iCroxSDJqHPrwvRqUs+JXRk92V6GEKaU=;
        b=DTexhIJXIOMefzaoInUaxp09cs492MOYlRlr8IHFbB6Aj3wWCEY3SWr/eJa5O4HAdDjLYN
        QZCZEA4Y6XPDHRNbjURIGkRiIYdsIDfK1LCO8iMYe86STWXZDJdwFLidx5UPbvKTpma2kG
        ndjJ4lWIpkW34xEqOSdsF16WEHxUYpM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-Yn_dcOQeO26PnkbIrYzksg-1; Tue, 07 Jan 2020 02:06:19 -0500
X-MC-Unique: Yn_dcOQeO26PnkbIrYzksg-1
Received: by mail-qv1-f70.google.com with SMTP id f16so36240771qvr.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 23:06:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/efjXzZHBg1iCroxSDJqHPrwvRqUs+JXRk92V6GEKaU=;
        b=t7QdaQ3OwxJIvmsyOoFYRW1MCTFg/IIQJuEXtqXoPesz6RvFLzsSo+y6jzvKEELaGI
         kFp8460J+nK1lmE/7UqkPTE7MkOq5u3AQcLNJPUJX5ZZgXTDOHvmiQIHubJa+XizHv3S
         euhCaPOX/X3RoBsSWhQNlN7+NbzT6tTRUDKpuxx5k7cnEnniA9vIKdx7lW8S2B89X+Ei
         B+Sa/QbcUfne9GUa0V2oEbyecnxnZ/AvofP29Vv3zMDUjisDTwI0xr/V4GDPbCaRnA9Y
         rAZfGnbCrJxrldRmosGFf0CSGoCNGEj6NaLS+uj2MenSSSZxQvg4D0B46FuLh/BE4zc7
         3OYA==
X-Gm-Message-State: APjAAAWqMAq4YG228GEWWfmHNnaDsp7O3UauNvBQt/6h5YTTDRiy0cpz
        6b1VcLezZYwB+ppUkdOjCXms/mTuM5nTfPw3lGVxhvbb1gpHqXoJ9tBnfD7foJrz9rFJR9zRD4M
        +DSe/3r8tv2+gD02h0v/6tCOH
X-Received: by 2002:ac8:709a:: with SMTP id y26mr78234905qto.304.1578380779300;
        Mon, 06 Jan 2020 23:06:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqyK5Mb+pOAlU+KoIVfxx6YvoZ+HKotsgyRPL144jEGAH30ilnJpURC7Q9CI21MUoelMWJIJHQ==
X-Received: by 2002:ac8:709a:: with SMTP id y26mr78234888qto.304.1578380779070;
        Mon, 06 Jan 2020 23:06:19 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
        by smtp.gmail.com with ESMTPSA id o16sm21915243qkj.91.2020.01.06.23.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 23:06:18 -0800 (PST)
Date:   Tue, 7 Jan 2020 02:06:13 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Alistair Delva <adelva@google.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2] virtio_net: CTRL_GUEST_OFFLOADS depends on CTRL_VQ
Message-ID: <20200107020303-mutt-send-email-mst@kernel.org>
References: <20200105132120.92370-1-mst@redhat.com>
 <2d7053b5-295c-4051-a722-7656350bdb74@redhat.com>
 <20200106074426-mutt-send-email-mst@kernel.org>
 <eab75b06-453d-2e17-1e77-439a66c3c86a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eab75b06-453d-2e17-1e77-439a66c3c86a@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 10:29:08AM +0800, Jason Wang wrote:
> 
> On 2020/1/6 下午8:54, Michael S. Tsirkin wrote:
> > On Mon, Jan 06, 2020 at 10:47:35AM +0800, Jason Wang wrote:
> > > On 2020/1/5 下午9:22, Michael S. Tsirkin wrote:
> > > > The only way for guest to control offloads (as enabled by
> > > > VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) is by sending commands
> > > > through CTRL_VQ. So it does not make sense to
> > > > acknowledge VIRTIO_NET_F_CTRL_GUEST_OFFLOADS without
> > > > VIRTIO_NET_F_CTRL_VQ.
> > > > 
> > > > The spec does not outlaw devices with such a configuration, so we have
> > > > to support it. Simply clear VIRTIO_NET_F_CTRL_GUEST_OFFLOADS.
> > > > Note that Linux is still crashing if it tries to
> > > > change the offloads when there's no control vq.
> > > > That needs to be fixed by another patch.
> > > > 
> > > > Reported-by: Alistair Delva <adelva@google.com>
> > > > Reported-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > > > Fixes: 3f93522ffab2 ("virtio-net: switch off offloads on demand if possible on XDP set")
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > > 
> > > > Same patch as v1 but update documentation so it's clear it's not
> > > > enough to fix the crash.
> > > > 
> > > >    drivers/net/virtio_net.c | 9 +++++++++
> > > >    1 file changed, 9 insertions(+)
> > > > 
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 4d7d5434cc5d..7b8805b47f0d 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -2971,6 +2971,15 @@ static int virtnet_validate(struct virtio_device *vdev)
> > > >    	if (!virtnet_validate_features(vdev))
> > > >    		return -EINVAL;
> > > > +	/* VIRTIO_NET_F_CTRL_GUEST_OFFLOADS does not work without
> > > > +	 * VIRTIO_NET_F_CTRL_VQ. Unfortunately spec forgot to
> > > > +	 * specify that VIRTIO_NET_F_CTRL_GUEST_OFFLOADS depends
> > > > +	 * on VIRTIO_NET_F_CTRL_VQ so devices can set the later but
> > > > +	 * not the former.
> > > > +	 */
> > > > +	if (!virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ))
> > > > +			__virtio_clear_bit(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS);
> > > 
> > > If it's just because a bug of spec, should we simply fix the bug and fail
> > > the negotiation in virtnet_validate_feature()?
> > One man's bug is another man's feature: arguably leaving the features
> > independent in the spec might allow reuse of the feature bit without
> > breaking guests.
> > 
> > And even if we say it's a bug we can't simply fix the bug in the
> > spec: changing the text for a future version does not change the fact
> > that devices behaving according to the spec exist.
> > 
> > > Otherwise there would be inconsistency in handling feature dependencies for
> > > ctrl vq.
> > > 
> > > Thanks
> > That's a cosmetic problem ATM. It might be a good idea to generally
> > change our handling of dependencies, and clear feature bits instead of
> > failing probe on a mismatch.
> 
> 
> Something like I proposed in the past ? [1]
> 
> [1] https://lore.kernel.org/patchwork/patch/519074/


No that still fails probe.

I am asking whether it's more future proof to fail probe
on feature combinations disallowed by spec, or to clear bits
to get to an expected combination.

In any case, we should probably document in the spec how
drivers behave on such combinations.


> 
> >   It's worth thinking  - at the spec level -
> > how we can best make the configuration extensible.
> > But that's not something spec should worry about.
> > 
> > 
> > > > +
> > > >    	if (virtio_has_feature(vdev, VIRTIO_NET_F_MTU)) {
> > > >    		int mtu = virtio_cread16(vdev,
> > > >    					 offsetof(struct virtio_net_config,

