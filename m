Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A69C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED59214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnlqEkHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfCLWqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 18:46:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54432 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfCLWqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 18:46:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id f3so4416824wmj.4;
        Tue, 12 Mar 2019 15:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OdPDRZNi6SHjV+ewKHn+NTn6VATw3DRdfa07qVBmTOs=;
        b=MnlqEkHNYixS9WxVEgbDlVOKOYE0vJZbfyYZS2T8MDuJzFZbJP5BtWNsX4uEO6d9BR
         UV/8qQvB70REz0TkNk+iRRkxg8X05a8gCPftqRF8lGXlwGhoD+Xn9ocMqFRWAZTNXgxv
         /i4GMR8N48AnwsUAlvBBRLglhZJ49tO6pr/cV4zVVFGE6a9mBMmfjiELwf381oNBOkAX
         nIAtQFoo1prWsntAiwVomnOsKXJcdDRG/NWFoUspr7dClY8mRMJiOp9x+GfwQPE3JrX8
         2A8OmnkNz7E4X7RV/LAS7NqYi90+ZAukN4GeCDQmwBAaRvaAzqiMTGefN1XAPzaaGzmO
         csAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OdPDRZNi6SHjV+ewKHn+NTn6VATw3DRdfa07qVBmTOs=;
        b=RCQ5GX7+Yon3F1LOSfryQvwzYqsbLJ8xyW3t6e0uvxV2euMt7OluOLS+cpagdroygf
         SSc3EcWDbckM0bB16/Afv6JPHOlloa1q8A2lYGMNNKKCJkJxGhByW4Ti+6Yv9re9uOAa
         lk8B1+MzhZdI8HOOXyiRXcysbdB4yWaWNGlIB9rDbte2jtiHr7b+c+wg299iEtlP34yh
         aLoU61gQuJibVncLM2ZYjEkxW78Y/vTcarxB8vWw5E0C90kujjq4YTOGwkpsuLOBY+XD
         98/dJG1EYTdg36gMzKmxvJYTZCAJMHvOppMi0hYCD7MwaOlk4Ntueo1PlBAwpg1wKFhM
         unWg==
X-Gm-Message-State: APjAAAWqfA4/Ptm8RgtKPxXDDJ/OmAO1pmXIYwFKDnSM77hJfpuUZcSm
        Czpp3Rk877erHc0PyE/aPxs=
X-Google-Smtp-Source: APXvYqxOyxGumsi9Cb2i07Xq8phy5uB5yk/SPxnlcWoXYoq6UmvZ89FVL523l9iJy4l3elI72AvNxg==
X-Received: by 2002:a1c:9ed5:: with SMTP id h204mr78617wme.140.1552430772979;
        Tue, 12 Mar 2019 15:46:12 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id k6sm31191655wrq.82.2019.03.12.15.46.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 15:46:11 -0700 (PDT)
Date:   Tue, 12 Mar 2019 23:46:11 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/platform/x86/dell-rbtn.c - add missing #include
Message-ID: <20190312224611.elsl2buuhkddecih@pali>
References: <17631.1552389966@turing-police>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7nc22qo4yobgowsb"
Content-Disposition: inline
In-Reply-To: <17631.1552389966@turing-police>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7nc22qo4yobgowsb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tuesday 12 March 2019 07:26:06 Valdis Kl=C4=93tnieks wrote:
> Building with W=3D1 complains:
>   CC [M]  drivers/platform/x86/dell-rbtn.o
> drivers/platform/x86/dell-rbtn.c:345:5: warning: no previous prototype fo=
r 'dell_rbtn_notifier_register' [-Wmissing-prototypes]
>   345 | int dell_rbtn_notifier_register(struct notifier_block *nb)
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/platform/x86/dell-rbtn.c:371:5: warning: no previous prototype fo=
r 'dell_rbtn_notifier_unregister' [-Wmissing-prototypes]
>   371 | int dell_rbtn_notifier_unregister(struct notifier_block *nb)
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Can you identify in which commit was introduced this problem? If yes,
then Fixes: keyword should be added into commit message.

> =20
> The real problem is a missing include. Add it to keep dell-rbtn.c and .h =
in sync
>=20
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
>=20
> diff --git a/drivers/platform/x86/dell-rbtn.c b/drivers/platform/x86/dell=
-rbtn.c
> index f3afe778001e..d50ca96d99f0 100644
> --- a/drivers/platform/x86/dell-rbtn.c
> +++ b/drivers/platform/x86/dell-rbtn.c
> @@ -17,6 +17,7 @@
>  #include <linux/acpi.h>
>  #include <linux/rfkill.h>
>  #include <linux/input.h>
> +#include "dell-rbtn.h"
> =20
>  enum rbtn_type {
>  	RBTN_UNKNOWN,
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--7nc22qo4yobgowsb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXIg2rwAKCRCL8Mk9A+RD
UlQrAKCp19B+YVLaIEg/aiud1DJD2AzXogCfSa4nOkhPh2pS7Ee1Frszc4d/7Qo=
=F+gJ
-----END PGP SIGNATURE-----

--7nc22qo4yobgowsb--
