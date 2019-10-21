Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEA9CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 17:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1702086D
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 17:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbfJURz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 13:55:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:44906 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726289AbfJURz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 13:55:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0BA09AC40;
        Mon, 21 Oct 2019 17:55:27 +0000 (UTC)
Message-ID: <9208de061fe2b9ee7b74206b3cd52cc116e43ac0.camel@suse.de>
Subject: Re: [PATCH v6 3/4] arm64: use both ZONE_DMA and ZONE_DMA32
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Qian Cai <cai@lca.pw>
Cc:     f.fainelli@gmail.com, mbrugger@suse.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Rob Herring <robh+dt@kernel.org>,
        linux-rpi-kernel@lists.infradead.org, m.szyprowski@samsung.com,
        Robin Murphy <Robin.Murphy@arm.com>, phill@raspberrypi.org,
        will@kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-arm-kernel@lists.infradead.org, wahrenst@gmx.net
Date:   Mon, 21 Oct 2019 19:55:25 +0200
In-Reply-To: <A1A8EEF0-2273-4338-B4D8-D9B1328484B4@lca.pw>
References: <6703f8dab4a21fe4e1049f8f224502e1733bf72c.camel@suse.de>
         <A1A8EEF0-2273-4338-B4D8-D9B1328484B4@lca.pw>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-HpXuUqy8wDt6AUMeP1G+"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HpXuUqy8wDt6AUMeP1G+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-10-21 at 13:25 -0400, Qian Cai wrote:
> > On Oct 21, 2019, at 1:01 PM, Nicolas Saenz Julienne <nsaenzjulienne@sus=
e.de>
> > wrote:
> >=20
> > Could you enable CMA debugging to see if anything interesting comes out=
 of
> > it.
>=20
> I did but nothing interesting came out. Did you use the same config I gav=
e?

Yes, aside from enabling ZONE_DMA.

> Also, it has those cmdline.
>
> page_poison=3Don page_owner=3Don numa_balancing=3Denable \
> systemd.unified_cgroup_hierarchy=3D1 debug_guardpage_minorder=3D1 \
> page_alloc.shuffle=3D1

No luck, still works for me even after adding those extra flags. IIRC most =
of
them (if not all) are not even parsed by the time CMA is configured.

So, can you confirm the zones setup you're seeing is similar to this one:

[    0.000000][    T0] Zone ranges:
[    0.000000][    T0]   DMA      [mem 0x00000000802f0000-0x00000000bffffff=
f]
[    0.000000][    T0]   DMA32    [mem 0x00000000c0000000-0x00000000fffffff=
f]
[    0.000000][    T0]   Normal   [mem 0x0000000100000000-0x00000093fcfffff=
f]

Maybe your memory starts between 0xe0000000-0xffffffff. That would be
problematic (although somewhat unwarranted).

Regards,
Nicolas


--=-HpXuUqy8wDt6AUMeP1G+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl2t8Q0ACgkQlfZmHno8
x/6stwf9HqWsWOip+MXq4sVWh+Y20OExIRxrBFOULlN6U/sctaP4D865ew+u+Q+w
+W9JEpEC77RF5P5lrvYt+TgLFjggGREe7qZhjsfVNQBXUvrwsO5m842eoP852h6e
japrXbQa51kSW5bdKgwSpi8+ZWw39O0IGNO/+kbts8eesc3IVbWYXOZ7lz0MIn44
OxocoMYDmWtCSR459p3O980E8KUzkyJD/4R9cGGfkO66RCPXaDy2pb2e2YD0mYL3
ArxUeTX2rLCjQcC7qGKFnCs/i50c5oRfdX25MZmn8t+c8ZNy0s8RuSvVR0uYj/HB
4t43gk/N8RDsPoNRxMFiDbJ3c0mbXA==
=LNBk
-----END PGP SIGNATURE-----

--=-HpXuUqy8wDt6AUMeP1G+--

