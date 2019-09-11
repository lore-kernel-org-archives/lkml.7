Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D564C5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C49D2089F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfIKKyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 06:54:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:50440 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726696AbfIKKyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 06:54:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 625F7AFBA;
        Wed, 11 Sep 2019 10:54:41 +0000 (UTC)
Message-ID: <b0b824bebb9ef13ce746f9914de83126b0386e23.camel@suse.de>
Subject: Re: [PATCH v5 3/4] arm64: use both ZONE_DMA and ZONE_DMA32
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     catalin.marinas@arm.com, hch@lst.de, wahrenst@gmx.net,
        marc.zyngier@arm.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>
Cc:     f.fainelli@gmail.com, robin.murphy@arm.com,
        linux-kernel@vger.kernel.org, mbrugger@suse.com,
        linux-rpi-kernel@lists.infradead.org, phill@raspberrypi.org,
        m.szyprowski@samsung.com
Date:   Wed, 11 Sep 2019 12:54:38 +0200
In-Reply-To: <20190909095807.18709-4-nsaenzjulienne@suse.de>
References: <20190909095807.18709-1-nsaenzjulienne@suse.de>
         <20190909095807.18709-4-nsaenzjulienne@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-+mwqdWbEE6wWAYsMfkXS"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+mwqdWbEE6wWAYsMfkXS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-09-09 at 11:58 +0200, Nicolas Saenz Julienne wrote:
> +
>  /*
> - * Return the maximum physical address for ZONE_DMA32 (DMA_BIT_MASK(32))=
. It
> - * currently assumes that for memory starting above 4G, 32-bit devices w=
ill
> - * use a DMA offset.
> + * Return the maximum physical address for a zone with a given address s=
ize
> + * limit. It currently assumes that for memory starting above 4G, 32-bit
> + * devices will use a DMA offset.
>   */
> -static phys_addr_t __init max_zone_dma32_phys(void)
> +static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
>  {
>         phys_addr_t offset =3D memblock_start_of_DRAM() & GENMASK_ULL(63,=
 32);
> -       return min(offset + (1ULL << 32), memblock_end_of_DRAM());
> +       return min(offset + (1ULL << zone_bits), memblock_end_of_DRAM());
>  }

Hi all,
while testing other code on top of this series on odd arm64 machines I foun=
d an
issue: when memblock_start_of_DRAM() !=3D 0, max_zone_phys() isn't taking i=
nto
account the offset to the beginning of memory. This doesn't matter with
zone_bits =3D=3D 32 but it does when zone_bits =3D=3D 30.

I'll send a follow-up series.

Regards,
Nicolas


--=-+mwqdWbEE6wWAYsMfkXS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl140m4ACgkQlfZmHno8
x/7BUAf8DFgSHDr3lRvqtp8RR9IRwdyy2AUPrJxMxccznKYgaiaJpx9nyG2J8h2M
2RuPADsFlI9fX0698LVNDxwUhICkAYh5gxOw/S+KHQvpw6KDqOn5HNvAESc64TTQ
T+KDM+LR+j6W0fRNPUDWJvLJCYf0dXc2PmysKhJF+Gck5LmHPl+aNUmJjpVqa/HJ
cMUJAObpwDpLRySRBi5DtN+ZAv/SVwD1WhJkn/0FjWmBRBpwt9T0YVdPGbyJd877
kLjB51r2JQSn/+Za+2TjIx4E1Qf9APCKCYzp1Jd0ofb53DO5jFtMPZ7GQljKwVf1
d05+0WOR5OrHixfZhqXV1huP39T8Uw==
=iRPY
-----END PGP SIGNATURE-----

--=-+mwqdWbEE6wWAYsMfkXS--

