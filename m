Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3A0C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 11:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D969720663
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 11:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561547713;
	bh=QYAj5A5FpDXBPVQV8B1W7SDHpFYvv3+jE8YYAowYHa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xZ9PmviNGsG/6T7XuIdzXPt6Klu4YoJxIhe5zgtXRhPN3a7e4uMe/rCr3dJlqNxH7
	 WiBII+HhzyUO/YCksqjmqI3Tw9j9ZJdMsbywGnGPoYnCDcHaoyWBpzzibE0fhLBNux
	 5kaZRIScA7LySuXy+rcVK/5GCmf3arFWLfHOuGro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfFZLPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 07:15:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51624 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfFZLPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 07:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hCsFlXTmKIL5pbPF4lr3Dore+Wo+pEJWPvtSxDXBTMI=; b=TpPOXRwDyEDONpsXQa+v9AbLk
        qbyaMP/0I+qXgJwOfbCBrT1SnyzV5HZSRihDw5ZA1GH2Xlu1AbGOTnWqZRnwZYvzdPpYtqvo9U0lW
        wvELymQG3dNryhBAzwCZHsHoUTBLaGp+rHCXD+FnBROuU3AjBT8inns/uKlqmo9W2wr7w=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hg5tN-0007mE-59; Wed, 26 Jun 2019 11:15:09 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id A4FA6440046; Wed, 26 Jun 2019 12:15:08 +0100 (BST)
Date:   Wed, 26 Jun 2019 12:15:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [RFC][PATCH] regmap: Drop CONFIG_64BIT checks from core
Message-ID: <20190626111508.GA5316@sirena.org.uk>
References: <20190625233116.2889-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HrSaiTVTrTHIlYwZ"
Content-Disposition: inline
In-Reply-To: <20190625233116.2889-1-marex@denx.de>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HrSaiTVTrTHIlYwZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 26, 2019 at 01:31:16AM +0200, Marek Vasut wrote:
> Drop the CONFIG_64BIT checks from core regmap code, as it is well
> possible to access e.g. an SPI device with 64bit registers from a
> 32bit CPU. The CONFIG_64BIT checks are still left in place in the
> regmap mmio code however.

The issue with 8 bit registers was that we use unsigned long for
addresses and values and a 64 bit value won't fit in those on a 32 bit
system.  Some of the bulk APIs will work but things like individual
register writes and the caches will have problems.

--HrSaiTVTrTHIlYwZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0TU7sACgkQJNaLcl1U
h9DUbQf+KeXw2w35Ww7MW8vMYn5FgPDcYmnIsgBoo/fBgtNO9/u/88a7TdT75f1u
Y1yeW/frswYuHdEkjHABpXJOo1MGH3SNNBgPp1FkAVlkS6voxYs4ApoklPi6A+FD
uACxuhDjoTO5Rbw/44dLKsqJSR+YJiT0R/aSGA2qwFGlV/Y6G9w2KAcdJTkPFPTj
Q7gWi8/zrEr5fVl/+bS6mD4n20tMN+9gcjUWcW+hDnggt9lXduIfS8te2CLhIg1n
gEiWDBenZp0bt+zziUYqoPBqXDNBPsYwj8lKg/wMDu42WCR7l9h0FqDw+PcAZGLQ
DymTVkk2yqco1s2uJP7Zi81QT2tHhg==
=OBmU
-----END PGP SIGNATURE-----

--HrSaiTVTrTHIlYwZ--
