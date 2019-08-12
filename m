Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88444C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00FF020684
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="XNfChPFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfHLNyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 09:54:24 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47299 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727136AbfHLNyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 09:54:23 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
        id 466clc5Gzkz9sN1; Mon, 12 Aug 2019 23:54:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1565618060;
        bh=M9fkWHdcEUWxow+UKyurPCc6awYRSJcQDFkH60t6zw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XNfChPFXwvqdC699kOEIy0Vv+oqCy3B16t+DVeHfqEhPuYXrv4IbL35jznMyfU7fK
         xOG5C9V9cbX93SGcIh3DMAgNEHFmoczgaOoRGnafCrGMLC0NYRRdQDDxDKSyaVS9X/
         M9Vlcq+UBH20ge76b4ysegxd1UGPTyJxvCHp8GEQ=
Date:   Mon, 12 Aug 2019 19:51:56 +1000
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ram Pai <linuxram@us.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        virtualization@lists.linux-foundation.org,
        linuxppc-devel@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Alexey Kardashevskiy <aik@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Message-ID: <20190812095156.GD3947@umbus.fritz.box>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
 <20190810143038-mutt-send-email-mst@kernel.org>
 <20190810220702.GA5964@ram.ibm.com>
 <20190811055607.GA12488@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NtwzykIc2mflq5ck"
Content-Disposition: inline
In-Reply-To: <20190811055607.GA12488@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NtwzykIc2mflq5ck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2019 at 07:56:07AM +0200, Christoph Hellwig wrote:
> sev_active() is gone now in linux-next, at least as a global API.
>=20
> And once again this is entirely going in the wrong direction.  The only
> way using the DMA API is going to work at all is if the device is ready
> for it.  So we need a flag on the virtio device, exposed by the
> hypervisor (or hardware for hw virtio devices) that says:  hey, I'm real,
> don't take a shortcut.

There still seems to be a failure to understand each other here.  The
limitation here simply *is not* a property of the device.  In fact,
it's effectively a property of the memory the virtio device would be
trying to access (because it's in secure mode it can't be directly
accessed via the hypervisor).  There absolutely are cases where this
is a device property (a physical virtio device being the obvious one),
but this isn't one of them.

Unfortunately, we're kind of stymied by the feature negotiation model
of virtio.  AIUI the hypervisor / device presents a bunch of feature
bits of which the guest / driver selects a subset.

AFAICT we already kind of abuse this for the VIRTIO_F_IOMMU_PLATFORM,
because to handle for cases where it *is* a device limitation, we
assume that if the hypervisor presents VIRTIO_F_IOMMU_PLATFORM then
the guest *must* select it.

What we actually need here is for the hypervisor to present
VIRTIO_F_IOMMU_PLATFORM as available, but not required.  Then we need
a way for the platform core code to communicate to the virtio driver
that *it* requires the IOMMU to be used, so that the driver can select
or not the feature bit on that basis.

> And that means on power and s390 qemu will always have to set thos if
> you want to be ready for the ultravisor and co games.  It's not like we
> haven't been through this a few times before, have we?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NtwzykIc2mflq5ck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1RNrcACgkQbDjKyiDZ
s5IeEA//dnRJ6mVj+RhQveMWMmeAiLbWMfnm//uTigHRNS3wsKGZnHuzpbBnRoCc
lEX8grJ+aGO69ZFe4N41Fad605IFGUjnxTtQn6kMx85m7F6z1+Bdi0B4H/k9iZ77
jr/rVpXQ9lv93Sns8vg9rZloaLf3xt1ZBN7hjecvVNSN5esttOlczRXSCq8m3rGE
2wYsyLox6y/juyLl/f+MOADagIb5ca652DrmInAaER3HgNnMmZGjr+gAjgvzNWRC
iYF3i/T/+NQLSS2IgG3eo9kzz3TF9FxmbtpqCynyr/JOUOf+M6vN9IZnr6MDSspR
OnUgRJLIOVjAUcG5EDwfoZQIbuJ7rJZ68/q75aJpMWpfrAsEiKPVD42lhDRtPzuT
fyT2lVp0ZF+VfSL4lc7nFq/yEG8YCJO2ZtgulzCFo72mPieeMZj3UyBOn0eJZ6Ui
lAOZHKgkDuhvNYXigewhujz+kTJ2UlV0ioZ0fOs9ohqOMd3t9RcIn2HIhI1j+2hN
drDFJUL6roSn+3rMA8MxCqeumTjFXGEGa9K+MIrVHpCnfgLgxV3Z2Z/gy8TNdetk
qobrJcniwJGse95D0BXoU6FDLRTOBsyNXa1ruMT0srHClrFIVRkGGr8fveJvUo/z
9pxHx2HQa0ePV1VCTj0h9YficujWGsF+RwC57aQOeCUFqLYz+0c=
=pHtB
-----END PGP SIGNATURE-----

--NtwzykIc2mflq5ck--
