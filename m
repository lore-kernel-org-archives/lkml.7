Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83603C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA8C207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbfDBK1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:27:37 -0400
Received: from sauhun.de ([88.99.104.3]:38700 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfDBK1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:27:36 -0400
Received: from localhost (p5486CD10.dip0.t-ipconnect.de [84.134.205.16])
        by pokefinder.org (Postfix) with ESMTPSA id 741DE2CF606;
        Tue,  2 Apr 2019 12:27:34 +0200 (CEST)
Date:   Tue, 2 Apr 2019 12:27:34 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: Re: [PATCH v5 7/8] i2c: iproc: add NIC I2C support
Message-ID: <20190402102733.GD2960@kunai>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
 <20190214175725.60462-8-ray.jui@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6WlEvdN9Dv0WHSBl"
Content-Disposition: inline
In-Reply-To: <20190214175725.60462-8-ray.jui@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6WlEvdN9Dv0WHSBl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +#define IDM_CTRL_DIRECT_OFFSET       0x00

And this IDM thing is also never used outside of the I2C context? In
other words, it also doesn't need a seperate DT node?


> +	/* indicates no slave mode support */
> +	bool no_slave;

I would suggest to not use a flag, but to nullify the {un}reg_slave
callbacks in probe depending on the type. That will also tell the
i2c-core that slave functionality is not supported. And you can use if
(!algo->reg_slave) as a flag, too.

> +	iproc_i2c->type =
> +		(enum bcm_iproc_i2c_type) of_device_get_match_data(&pdev->dev);

No need to cast a void*.


--6WlEvdN9Dv0WHSBl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyjORUACgkQFA3kzBSg
KbZmdw/9GNjBVJL/3oOGEZFDISLOBXCpa+MekxPn+H439sj9T661k+CV8XQZH12K
TcchO9mzMA4w5nMFPKYGw3+aJ6cZXbXuvYwZfXu97u8zrfrN6dLcR4erWZi7/yMR
Ckk0e2lcuOzXVp8JAiLtpWnix1dvc6c0vm4F50n+fD8UjGCkIn/Ur+syRCwsQnMB
JD3Fb8m/Y+g0OSGOLtbJCg4UFnnz4rDrIecRUfUZgukKpL6alRyiKoE2ldQUecrh
8ftdrE0DA0FGnByRjboeLEWWUxMFAF3a3C4OFmytZ8P9nqihTfhwoRIfFLupmywU
bUPHN00gol6EHw1tGPxu2KxuJ0n/yRgGr7ASw+CBbvDgpWhha4hBShT/bCfIufcq
1vIDA5M2wkG12FLn9MbwjjCXAR7WuWZbqI65UgwU4f9OKsbhC28S3siirKUSnRGg
KR5Kv5jTgSZVSSdjWNG5xS1xKh1sp8iQUcQQRaOua60FqmHY1HvKc6HLogLJK5gH
j/ByoLKqy16KTG1uOSmVEtEdNEQ5xiba84UvncJrIQcrvZnZlSQZml8EQ4njoK9Q
vfQmCl7Tyx+S+GKSnMABvsHhvhf1GZf0EFYagwTPUZi4lsoK4Gvu2vu3YvD3D5Zn
CqjsZsUHqW1jLPNYv9hDHO5eov/ZpRa7kJwuxcwmGLuvwbneSFU=
=vf6X
-----END PGP SIGNATURE-----

--6WlEvdN9Dv0WHSBl--
