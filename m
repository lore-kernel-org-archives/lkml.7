Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DB6CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AEC92086A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqJnQc1d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388779AbfJ2Nh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 09:37:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42637 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388602AbfJ2Nh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:37:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id a15so1406808wrf.9;
        Tue, 29 Oct 2019 06:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9Vxx/pceeFOx76wAgdF24A70HB2cNZVkRe22Ux9K8qM=;
        b=hqJnQc1dzsFea4EpFfSVqlv/087Az26HhDBVvz+Pq0YQfh1FKXjH81aU5iamuEaJiI
         HgCuyNu94ewaw0ad9g89pq60HljuvA/kdvOrmNqFoejUulpmgyGoVrtDjEGT5WSLDYuN
         M1Ji8fEH8eVTa6mm44zZAhCO+0cxmDaBOie+Nd5XHsP5B30WISaPT3URXQau5a+iWfRY
         2qY6bbL6YCRM9XdJp1NbWVTrWmChxCA6xnW06rCn88slHoGOUyFoEo0L/2HvGGgvshJg
         5okKs3OY1XO4U2t3/vnfhGAK6+xAHfwe2QgtX/iBX/11dB8JQhDOwdSST+xstSzTZwdy
         bu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9Vxx/pceeFOx76wAgdF24A70HB2cNZVkRe22Ux9K8qM=;
        b=DlDU36qGx9aMIeAdqFG40IkPw7vmjcGcaFcAWGr+VkvUntAkZUprWSRoP5k4vXQv6J
         cOJ9k+laBZMp4f0osvrO7S9hz//Q97+s6Lle14Hf4MKT9x6MKcBFEeaPM72jZZAJpcV6
         M90ExgWS4mBcB2qN+m5LegbrCf0DTbjVEiFcuji4xa/RtguhN3a9jeLIUkRj8RnxUYvP
         6LObAWh+tq3sWh49kGHu/aISNpA8D3gMeIvbKPrNiALk/+fXgWLv2jA6quqrbvrsVWTO
         //olWynvAnj71l3cQcegzGLLCmv7j4I3xzE+PVKmVic4tEeqJYnrSbToEvn9G4WAZps9
         86Tw==
X-Gm-Message-State: APjAAAX9k6JVoBvVY7KwztzAvLKMZ8BrO5KB1bUSkX9seL33Rn0x0we7
        MlXQC6F+bD4v/1ivu8p7WF9ylgra
X-Google-Smtp-Source: APXvYqwAdzt7M7NZSS92aYMR+vT9nuB6XmH/vlRK1etClbrg2KBk60IFSDvqRKiKEMOGjY+L8YEzMw==
X-Received: by 2002:adf:fc10:: with SMTP id i16mr19039491wrr.157.1572356246914;
        Tue, 29 Oct 2019 06:37:26 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id p21sm2508458wmc.25.2019.10.29.06.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 06:37:25 -0700 (PDT)
Date:   Tue, 29 Oct 2019 14:37:24 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] soc/tegra: pmc: Remove unnecessary memory barrier
Message-ID: <20191029133724.GI508460@ulmo>
References: <20190926191755.27131-1-digetx@gmail.com>
 <20190926191755.27131-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BWWlCdgt6QLN7tv3"
Content-Disposition: inline
In-Reply-To: <20190926191755.27131-2-digetx@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BWWlCdgt6QLN7tv3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2019 at 10:17:55PM +0300, Dmitry Osipenko wrote:
> The removed barrier isn't needed because writes/reads are strictly ordered
> and even if PMC had separate ports for writes, it wouldn't matter since
> the hardware logic takes into effect after triggering CPU's power-gating
> and at that point all CPU accesses are guaranteed to be completed. That
> barrier was copied from the old arch/ code during transition to the soc/
> PMC driver and even that the code structure was different back then, the
> barrier didn't have a real useful purpose from the start. Lastly, the
> tegra_pmc_writel() naturally inserts wmb() because it uses writel(),
> and thus this change doesn't actually make any difference in terms of
> interacting with hardware. Hence let's remove the barrier to clean up
> code a tad.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>=20
> Changelog:
>=20
> v5: Extended the commit's message.
>=20
> v4: No changes.
>=20
> v3: No changes.
>=20
> v2: New patch that was added after Jon's Hunter pointing that it's better
>     not to change the barrier's placement in the code. In fact the barrier
>     is not needed at all.
>=20
>  drivers/soc/tegra/pmc.c | 2 --
>  1 file changed, 2 deletions(-)

Applied to for-5.5/soc, thanks.

Thierry

--BWWlCdgt6QLN7tv3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl24QJQACgkQ3SOs138+
s6HNfxAAhvdZb9TVwUyihU77Cp2yuc6tebSSK5Yl0IrOtTn4JKTl8uuFtEK7O3QQ
6MdTr9Ofp7fEtaaVYrO7rLt5u4tAq4l4Ft+bt740yREhbL8Il4dMIsgcFDghLNN4
GACFzwZzf7GwWGQtU3Sea8LiKDVpw8L+yyh6HMERXojFBQLby2Duww3qEWiXOoVd
qMRLaxshIiRk6EhAzIdvSYGOF5KTFClZPbsmaoIovEn7eQy6OgeMSz2OjicFTD8x
9OI0eCxlFGZEdYFe9UXoMzEREPg3b4rX06II+jdxC1cRCylm9GO89TcOxnPLYHK8
hlmjmhsSDwumUbURl08rKtW/GMLhY6QEjq+mpJpouGryusRX5M+0fmUN6A/yWn1j
GD7ZEO8D/TNM2uVEQoh7oGKYCrG6KIC9eXIb4F4UlxlusvRUB1gOO8sNUmc2pMUF
RLZ7fp2h+KJyPOSW7ozAoVF+KFv5+u3C13PzusAqw3OW+LNFrSKUVob5fXRwaJQG
vH06w6+uAhkfSKgnNlc/LyW3xvnDMNrcpjCUGVsD5ORbutLk4l55fhvO+84lgar1
UKyf4VdH6du1HFeemXWipknjnQTTUjjMLNsJmBdZF6CqhydBbjwlZmx1gIjuf2tP
qNqZXljihEpqdomc1/O7mlsdRQAfVvhcNUTestjRCGDgy1Syjgo=
=UCFl
-----END PGP SIGNATURE-----

--BWWlCdgt6QLN7tv3--
