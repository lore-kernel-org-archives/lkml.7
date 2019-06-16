Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E017C31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 20:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F3B220657
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 20:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfFPUA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 16:00:59 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54958 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbfFPUA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 16:00:58 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 6642C8022F; Sun, 16 Jun 2019 22:00:46 +0200 (CEST)
Date:   Sun, 16 Jun 2019 22:00:56 +0200
From:   Pavel Machek <pavel@denx.de>
To:     pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 058/118] PCI: designware-ep: Use aligned ATU window
 for raising MSI interrupts
Message-ID: <20190616200056.GF6676@amd>
References: <20190613075643.642092651@linuxfoundation.org>
 <20190613075647.132827503@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="DEueqSqTbz/jWVG1"
Content-Disposition: inline
In-Reply-To: <20190613075647.132827503@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DEueqSqTbz/jWVG1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pc=
i/controller/dwc/pcie-designware-ep.c
> index de8635af4cde..739d97080d3b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -385,6 +385,7 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u=
8 func_no,
>  {
>  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
>  	struct pci_epc *epc =3D ep->epc;
> +	unsigned int aligned_offset;
>  	u16 msg_ctrl, msg_data;
>  	u32 msg_addr_lower, msg_addr_upper, reg;
>  	u64 msg_addr;
> @@ -410,13 +411,15 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep,=
 u8 func_no,
>  		reg =3D ep->msi_cap + PCI_MSI_DATA_32;
>  		msg_data =3D dw_pcie_readw_dbi(pci, reg);
>  	}
> -	msg_addr =3D ((u64) msg_addr_upper) << 32 | msg_addr_lower;
> +	aligned_offset =3D msg_addr_lower & (epc->mem->page_size - 1);
> +	msg_addr =3D ((u64)msg_addr_upper) << 32 |
> +			(msg_addr_lower & ~aligned_offset);

This warks but is really... interesting code.

would (msg_addr_lower - aligned_offset) make more sense?

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--DEueqSqTbz/jWVG1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0Gn/gACgkQMOfwapXb+vJiMQCfaMErZYfiEOA4QXiLbdOfTZpG
gHYAn1SX8FSkEgxzVN/KwVpBCF9NdHAS
=YktC
-----END PGP SIGNATURE-----

--DEueqSqTbz/jWVG1--
