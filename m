Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36ADAC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B76621473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XD50hFB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfDHPDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:03:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37652 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbfDHPC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:02:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id v14so15091853wmf.2;
        Mon, 08 Apr 2019 08:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fGBfhMWeRrQGORS5NyKcAVeIa/HorxH2EOZq3fBJ2tA=;
        b=XD50hFB6dJ8laiwAaakQZCIwHT6fYvZk9VUJqj+1HY31a9qLd10nCJ+moIAWSgvwGu
         9fk/0JBkyCNqySjlt7uxRJmHLFHEp1vwfKlTff2BbysEIrqL2l9tLcG3DdGCxDSGFfpG
         ybY8NnEAPzoryvfaw6088VemIS8VTZXR0A7lQDt9yMSzLZW6g5juv2+fcl/J7EWSvc72
         xlJVWr/3Om9GemvlTaPATFNwa/CAFKNYQt0D3pUsEJzjtYWnaDNT4ryMhGnymDK3dh0F
         yHlzsKq1SkvV5AkGQg5BqDMbDaT8FND0Rl+jci2kgHvQksEfz08qF1YyGPKNaVcWAWw0
         Li5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fGBfhMWeRrQGORS5NyKcAVeIa/HorxH2EOZq3fBJ2tA=;
        b=T7zOodkFXpW/fTlN3e46AdzCsFwM/gtqGBrYChCP3ztQajplr3AARAuoKIhtyTT4mq
         0KXpr6Pa7US/D1f/aWsgN98rOetu/KLZa5pggmqhzmk/XpqtsWwXhlYr2Z0hVHJwCP+S
         WFqwyqrLhJ5sGfXDG6ZHQocO7u4ImBE6sipz4KpIwcwbMb/4ybgZv0ypSm1L87s6mbc7
         UmWNKWFmXw0n1W8H/V2X8K++cJXLawp0fFrvquIkexazkW08foudziKfW6kkM0eHuD47
         bp8hYP557N8GxH2R7etuiTbJ63kJRLqRsHWZnlGsZ1FylnBF5yjs09t0/p/Ywefezedg
         NMfw==
X-Gm-Message-State: APjAAAUi4TRoAoisPqeLts4bvRX020BbnKwYF99h7Nu3MURtdUyvycND
        eFJL099Bna5IyOTu7kpYrHw=
X-Google-Smtp-Source: APXvYqyO+osh1QTlxvJbpoqfSoAUjcAQNH9tdPKMpHIxq1h+12wgTZdqeMJdMCGslx5D5+X9EeMJ1g==
X-Received: by 2002:a1c:9691:: with SMTP id y139mr17956721wmd.64.1554735777904;
        Mon, 08 Apr 2019 08:02:57 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id a11sm30933017wrx.5.2019.04.08.08.02.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 08:02:56 -0700 (PDT)
Date:   Mon, 8 Apr 2019 17:02:55 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] usb: host: xhci-tegra: Add Tegra186 XUSB support
Message-ID: <20190408150255.GA13288@ulmo>
References: <20190408081739.GB6644@ulmo>
 <Pine.LNX.4.44L0.1904081006330.1440-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1904081006330.1440-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2019 at 10:07:38AM -0400, Alan Stern wrote:
> On Mon, 8 Apr 2019, Thierry Reding wrote:
>=20
> > On Mon, Apr 01, 2019 at 12:40:44PM +0200, Thierry Reding wrote:
> > > From: Thierry Reding <treding@nvidia.com>
> > >=20
> > > Hi,
> > >=20
> > > This series introduces support for XUSB to the Tegra186 SoC. This is
> > > mostly the same as on earlier generations in that it provides an XHCI
> > > compatible interface with a bit of vendor-specific glue. Perhaps the
> > > most notable change is the removal of the IPFS wrapper. Patches for
> > > the UPHY related changes that control the PHYs for the XUSB controller
> > > were merged into v5.1.
> > >=20
> > > This version is a rebase of the series posted here:
> > >=20
> > >     http://patchwork.ozlabs.org/project/linux-tegra/list/?series=3D88=
193
> > >=20
> > > There have been no code changes and I collected Reviewed-by and Acked=
-by
> > > tags.
> > >=20
> > > Greg, can you pick up patches 1-3 with Rob's and Mathias' Acked-by,
> > > respectively? I'll pick up patches 4-6 into the Tegra tree.
> >=20
> > Hi Greg,
> >=20
> > would you mind picking up patches 1-3 of this series?
>=20
> FYI: Greg is on vacation for the coming week, with no email access.

Thanks for letting me know, Alan. I'll ping Greg again when he's back.

Thierry

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyrYpwACgkQ3SOs138+
s6EkeA/8C715419f8XxaZRrI3OuZ9lSHxmV5+wcNuR6Acb+qy5nYhDpG4bW97odQ
2VBkvUFPPlSciHcFsJ7qP70gd3mCLU0/1fvbuYwyRXJtak5XaJNWqcvOJJoNs4Iv
dZeOq+VVEiXYqle6ca6dT3j2Ofh81rpVcqWCTx2Olyo+uCUDv7V13kaW803QH6XJ
NMFAwB/ajxAcBEzg19pXDHttA4jJRNiz1ekt8cDi8D4h5lQy2ebRDjRO14VIeXGz
c1dx8gJXQihPc5HLy+bGl6mXNcmfw8tb9CJaD3ssZCIbzSYdYQcWA+vvFUT1Ltq5
IABNXL3HEJk7VWSSyJ66wsIonsdISVbQp9GbjKaRZbDAS25va7gaWMCUKEUQcFBy
sEWPRYJ4QASuRubFP6BZ9FhhNcm0Y0ALRnVIK5oQlTRqU7b/VLx0OalwFgy+zQu9
PG7NawTw8mVdWyAkdx2hUZ2IYgfWMnty53EYjuvsOSoLMZhTzyfaxSZfdi2IANHu
/MEKzKQvafzb+4KsEhPrBZfp1whhWjAZL35Qs17UXqPlEAXoYHaX+RXF/uB6S+Dl
6UrZlO/WXR4Pg/xh0r4AgcEePOgZdYjpg6lCq5DPHONSAnO4o+oyN/qtYAvlnJr8
kUJLDi/1iX6IW0JfOWiX89T1sO+YPx18eX2xMlTz9id0vIhDYF8=
=V6kD
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
