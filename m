Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E63CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BABA214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="avrjOdXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfJUIhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 04:37:05 -0400
Received: from ozlabs.org ([203.11.71.1]:41959 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfJUIhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 04:37:05 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
        id 46xVPB4GFcz9sPL; Mon, 21 Oct 2019 19:37:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1571647022;
        bh=P4+BLRFMUZOzcZoVFqPd/m5gwNGJV4F8kQoNpmmm7xA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=avrjOdXbIP98E9IET/dkB7o//V/WUQGuUZauaU4YAvbsL0iyAbQT2hdQRmWjeEtZo
         9O9YxymQ60Bi6NXIO5IUyMVUzVZQwJA4XWrkWh3oqnn11r/hQ7lDikvL9i2P05SRlS
         qBAWHB7eC/SE7bNC8DQDz1J6xg+SKHjJu2mzfdIs=
Date:   Mon, 21 Oct 2019 19:36:50 +1100
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@ozlabs.org,
        mdroth@linux.vnet.ibm.com, aik@linux.ibm.com, paul.burton@mips.com,
        robin.murphy@arm.com, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, jasowang@redhat.com, andmike@us.ibm.com,
        sukadev@linux.vnet.ibm.com
Subject: Re: [PATCH 2/2] virtio_ring: Use DMA API if memory is encrypted
Message-ID: <20191021083650.GG6439@umbus.fritz.box>
References: <1570843519-8696-1-git-send-email-linuxram@us.ibm.com>
 <1570843519-8696-2-git-send-email-linuxram@us.ibm.com>
 <1570843519-8696-3-git-send-email-linuxram@us.ibm.com>
 <20191015073501.GA32345@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Sw7tCqrGA+HQ0/zt"
Content-Disposition: inline
In-Reply-To: <20191015073501.GA32345@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Sw7tCqrGA+HQ0/zt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2019 at 09:35:01AM +0200, Christoph Hellwig wrote:
> On Fri, Oct 11, 2019 at 06:25:19PM -0700, Ram Pai wrote:
> > From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> >=20
> > Normally, virtio enables DMA API with VIRTIO_F_IOMMU_PLATFORM, which mu=
st
> > be set by both device and guest driver. However, as a hack, when DMA API
> > returns physical addresses, guest driver can use the DMA API; even thou=
gh
> > device does not set VIRTIO_F_IOMMU_PLATFORM and just uses physical
> > addresses.
>=20
> Sorry, but this is a complete bullshit hack.  Driver must always use
> the DMA API if they do DMA, and if virtio devices use physical addresses
> that needs to be returned through the platform firmware interfaces for
> the dma setup.  If you don't do that yet (which based on previous
> informations you don't), you need to fix it, and we can then quirk
> old implementations that already are out in the field.
>=20
> In other words: we finally need to fix that virtio mess and not pile
> hacks on top of hacks.

Christoph, if I understand correctly, your objection isn't so much to
the proposed change here of itself, except insofar as it entrenches
virtio's existing code allowing it to either use the DMA api or bypass
it and use physical addresses directly.  Is that right, or have I
missed something?

Where do you envisage the decision to bypass the IOMMU being made?
The virtio spec more or less states that virtio devices use hypervisor
magic to access physical addresses directly, rather than using normal
DMA channels.  The F_IOMMU_PLATFORM flag then overrides that, since it
obviously won't work for hardware devices.

The platform code isn't really in a position to know that virtio
devices are (usually) magic.  So were you envisaging the virtio driver
explicitly telling the platform to use bypassing DMA operations?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Sw7tCqrGA+HQ0/zt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2tbhcACgkQbDjKyiDZ
s5JyXg//T3Ppsd9Nw4UJ0S7vuihqdegF9xf5Id+ggjipfZl02lYq6KHjlrkDkMXH
HVHUoVYy0626P9inLv/Yt9cqA70zVNKVt5gItWX+FUETTio5hv1vcz5pB28nGln/
uauetB6MmSZnnRcMkzguJjRO53cJJIR2ft+qKz6BhVksdhE+JufUYuWgCM92znTp
e+ku518x0fc5t4mqCBjIf/EZ0S0F3GqXH61q38USXZhfaJDJiaR/krUYvB+Opm6y
k505kcbvfLybLlZyb6EOQyjQGskvQsBbSXbzJRImbUPA8hrFQY0JMozfxcUKz56G
PGvl9KKWz/Wr+NwwCcPi6/oM1t+iisn6UGsW9j4888nFzMDVlQgWMBP2oPD5vNiS
JvmxsmveiRl+0YZ6mPPG6GLg0msmW8TPM5lYVBpG+yJs24C/AY0yUkgjzSX9wjdd
6zuO5ZJumgblftxiYZ5SoMX/RZ1tlTn9o35B5wOA8rbvBEGbdVEPlrhxzpxKUA41
M+63HFoZOZ4zRtV/qBP4Z3lhqzsatDsDPq3FIH5GOtJAVs9yiaJPjF4449plpzMS
mSoJgCD9g0M0aQJXYb1gv/1BrAuO2kQSoounFzDWP0hmTPdGd3QQifF8n3x4j4h6
xuGMCq/7AXeE6xZsBnw7+bqX0NLIRgIb7a6d3nyJeVzfgJWvq/M=
=ybRR
-----END PGP SIGNATURE-----

--Sw7tCqrGA+HQ0/zt--
