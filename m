Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE19C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD83C20684
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfFFNPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 09:15:05 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50690 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfFFNPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 09:15:04 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C7E538027A; Thu,  6 Jun 2019 15:14:52 +0200 (CEST)
Date:   Thu, 6 Jun 2019 15:15:02 +0200
From:   Pavel Machek <pavel@denx.de>
To:     pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org,
        Andrea Merello <andrea.merello@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 163/276] mmc: core: make pwrseq_emmc (partially)
 support sleepy GPIO controllers
Message-ID: <20190606131502.GF27432@amd>
References: <20190530030523.133519668@linuxfoundation.org>
 <20190530030535.648236068@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Mjqg7Yu+0hL22rav"
Content-Disposition: inline
In-Reply-To: <20190530030535.648236068@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Mjqg7Yu+0hL22rav
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

(stable removed from cc list)

>  static void mmc_pwrseq_emmc_reset(struct mmc_host *host)
>  {
>  	struct mmc_pwrseq_emmc *pwrseq =3D  to_pwrseq_emmc(host->pwrseq);
> =20
> -	__mmc_pwrseq_emmc_reset(pwrseq);
> +	gpiod_set_value_cansleep(pwrseq->reset_gpio, 1);
> +	udelay(1);
> +	gpiod_set_value_cansleep(pwrseq->reset_gpio, 0);
> +	udelay(200);
>  }
> =20

If we can sleep here, does it make sense to use *sleep() here?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Mjqg7Yu+0hL22rav
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlz5EdYACgkQMOfwapXb+vI73QCcD0/77UA1q37UoIEdouGVsb1F
apYAnjysBsjTTVLIGvh1hy1Eoe4h/vGX
=xIuN
-----END PGP SIGNATURE-----

--Mjqg7Yu+0hL22rav--
