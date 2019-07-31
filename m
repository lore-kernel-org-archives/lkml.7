Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD049C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAAF6206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbfGaTFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 15:05:37 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47477 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfGaTFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 15:05:37 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A9C6680244; Wed, 31 Jul 2019 21:05:22 +0200 (CEST)
Date:   Wed, 31 Jul 2019 21:05:34 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 024/113] tty: serial: msm_serial: avoid system
 lockup condition
Message-ID: <20190731190533.GA4630@amd>
References: <20190729190655.455345569@linuxfoundation.org>
 <20190729190701.631193260@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <20190729190701.631193260@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit ba3684f99f1b25d2a30b6956d02d339d7acb9799 ]
>=20
> The function msm_wait_for_xmitr can be taken with interrupts
> disabled. In order to avoid a potential system lockup - demonstrated
> under stress testing conditions on SoC QCS404/5 - make sure we wait
> for a bounded amount of time.
>=20
> Tested on SoC QCS404.

How long did it take to timeout?

Because... this is supposed to loop for 0.5 second with interrupts
disabled, but 500000*udelay(1) is probably going to wait for more than
that.

Is 500msec reasonable with interrupts disabled?

Should it use something like 5000*udelay(100), instead, as that has
chance to result in closer-to-500msec wait?

> +++ b/drivers/tty/serial/msm_serial.c
> @@ -383,10 +383,14 @@ static void msm_request_rx_dma(struct msm_port *msm=
_port, resource_size_t base)
> =20
>  static inline void msm_wait_for_xmitr(struct uart_port *port)
>  {
> +	unsigned int timeout =3D 500000;
> +
>  	while (!(msm_read(port, UART_SR) & UART_SR_TX_EMPTY)) {
>  		if (msm_read(port, UART_ISR) & UART_ISR_TX_READY)
>  			break;
>  		udelay(1);
> +		if (!timeout--)
> +			break;
>  	}
>  	msm_write(port, UART_CR_CMD_RESET_TX_READY, UART_CR);
>  }

Plus, should it do some kind of dev_err() to let users know that
something went very wrong with their serial?

Thanks,
								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1B5n0ACgkQMOfwapXb+vLVagCfSlen7wXaOMFM9NecWDAs/xmG
ImIAoJSLz4A1rXm1m/QO73wS1J/sgjvL
=YUqR
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
