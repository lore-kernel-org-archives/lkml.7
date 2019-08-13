Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEC0C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35EC420679
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElQFKkMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbfHMJsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 05:48:38 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53294 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfHMJsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 05:48:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id 10so889875wmp.3;
        Tue, 13 Aug 2019 02:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O5RNYQ/pIxNnsl2jiqY8E9iJasfstc8DMldf5IawoNU=;
        b=ElQFKkMaFL1kgBgMTEWmorIjNtk/TTzL2UuCTEHFKXiz9+vNBhMx/RNL4FDCdITYvB
         49VsSMZNRbGLjusFwbArr+2bnNu514amW8cZKhDeIk5Cjs54ao3oXrDaDSJ/JZuPCD0h
         uwaSZQMOFf/dt2gfZjTJTRiZ/oY3wCwIWPNS+JvGqxaSI1zimLaYZDrBc0YqwmEJzNzS
         Tz5p2bggY1C1bpBJMIaJn/A9rqD7+SYNPSX688vwqrzmfrWMh26OrCTrzQ4F57wd00Tq
         l6wUo573t+o7dm2p2U0O0/iEDYG8outNyuWTd48cLyiw+CJjdb+G2LNDf0zrBdQqHjMV
         zTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O5RNYQ/pIxNnsl2jiqY8E9iJasfstc8DMldf5IawoNU=;
        b=q/mV6Ab21s9dAq4DVv8jLi3EgPW9mKkuWf6ZVlo98vnWNguVYzqtIHSCwzf8fTetxa
         fpNrjnWv86xJawjSD5/7eLQk2uwf3cNDkBPnVFTX589sPCkUf54Vxs0qlPJiuepnwLgE
         CkTFCqCYdTrtl7DvfzQe6kdpKEL8nB85rnSy7Uv2LIpQBFKT8Y16ZBhTQsUK26cHqouB
         5yq7RcaZ3OxTdKRStJ/vx/O9eNM55NNCc6qMtsDUsdGvxh8tTWGS62NMrcmy1YOJ/h6p
         9GKNAW3CXWpe86siAemReJB+sP60e70GfmVRmVnzFSpyG1Hg+1Rtctek7CRDvcTDS8b3
         Ir0A==
X-Gm-Message-State: APjAAAUpx2FL0X1vMrmREQ/J+HJpd9iaEgRVrZQ7MWr3KzRjeuhc5RsI
        fVTuZxynj4RW5LbC65+xBNs=
X-Google-Smtp-Source: APXvYqw40PfFx6A7DfkQoninorUojIQNdwEEmloNMQ6AlDORXn9VZdnIGMfeVsaj2DHd3756z8ah3Q==
X-Received: by 2002:a7b:c383:: with SMTP id s3mr2186427wmj.44.1565689714826;
        Tue, 13 Aug 2019 02:48:34 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id 25sm747482wmi.40.2019.08.13.02.48.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 02:48:33 -0700 (PDT)
Date:   Tue, 13 Aug 2019 11:48:32 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com, ldewangan@nvidia.com,
        jslaby@suse.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shardar Shariff Md <smohammed@nvidia.com>
Subject: Re: [PATCH 05/14] serial: tegra: flush the RX fifo on frame error
Message-ID: <20190813094832.GJ1137@ulmo>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
 <1565609303-27000-6-git-send-email-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Xssso5lpTBgMxDfe"
Content-Disposition: inline
In-Reply-To: <1565609303-27000-6-git-send-email-kyarlagadda@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Xssso5lpTBgMxDfe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2019 at 04:58:14PM +0530, Krishna Yarlagadda wrote:
> From: Shardar Shariff Md <smohammed@nvidia.com>
>=20
> FIFO reset/flush code implemented now does not follow programming
> guidelines. RTS line has to be turned off while flushing fifos to
> avoid new transfers. Also check LSR bits UART_LSR_TEMT and UART_LSR_DR
> to confirm fifos are flushed.

You use inconsistent spelling for FIFO here.

> Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  drivers/tty/serial/serial-tegra.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/seria=
l-tegra.c
> index ae7225c..f6a3f4e 100644
> --- a/drivers/tty/serial/serial-tegra.c
> +++ b/drivers/tty/serial/serial-tegra.c
> @@ -266,6 +266,10 @@ static void tegra_uart_wait_sym_time(struct tegra_ua=
rt_port *tup,
>  static void tegra_uart_fifo_reset(struct tegra_uart_port *tup, u8 fcr_bi=
ts)
>  {
>  	unsigned long fcr =3D tup->fcr_shadow;
> +	unsigned int lsr, tmout =3D 10000;
> +
> +	if (tup->rts_active)
> +		set_rts(tup, false);
> =20
>  	if (tup->cdata->allow_txfifo_reset_fifo_mode) {
>  		fcr |=3D fcr_bits & (UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
> @@ -289,6 +293,17 @@ static void tegra_uart_fifo_reset(struct tegra_uart_=
port *tup, u8 fcr_bits)
>  	 * to propagate, otherwise data could be lost.
>  	 */
>  	tegra_uart_wait_cycle_time(tup, 32);
> +
> +	do {
> +		lsr =3D tegra_uart_read(tup, UART_LSR);
> +		if (lsr | UART_LSR_TEMT)
> +			if (!(lsr & UART_LSR_DR))

Can't both of these go on the same line?

Thierry

> +				break;
> +		udelay(1);
> +	} while (--tmout);
> +
> +	if (tup->rts_active)
> +		set_rts(tup, true);
>  }
> =20
>  static int tegra_set_baudrate(struct tegra_uart_port *tup, unsigned int =
baud)
> --=20
> 2.7.4
>=20

--Xssso5lpTBgMxDfe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1Sh28ACgkQ3SOs138+
s6EtEg//doVYuGtPItd+PnimbHPvK65iBFfPnNyDNeLkFEWRXc9Lr/YNMEZRvXXk
jSCB5dOOO6bawhT2cAqpph/9dza4Vvc+944teuITF9d42ymDjjMfcFjAFegqtFsb
zTlE8CzX2bs1y+0xks/8LGhHgaUPDU1NgVHnhwWjo2IIZvnOBjL8eWalCwfiNO6M
jo9UOV5xAZyXOk+RtheaE4VfGcgSBW3TbqWtl1TjhZ73E9d/S+r4eHo918GhD+n6
c4/Z9155gI0KEJyvQBGBSUaWAW6Ok9Yzq9rn2IjW9/uaU7Su3n+UBuv1bIB50Juj
ihpWn/k/07mM+T8AKeu0COxpmoLUvbYM9kU0gAz7xLFsFws68/+nJfUigmwCZgLA
BnOixrT6rgSmZcyR/50fep2hrqwBNZ51fZ2u5fKWBBUGDGwbsef4wLKmih5OC6Le
5+bDoP70Z8xhLZYEeXsSOTn4lPka+6NRXha8W+LE3OYeeBYOrNYfDUc/jPeif47J
guZLpd1CH3bJnvR0mQR0DIZGKhRMd3Czbcw+opvnepeVO7kmzSkUl1bbX/6J9h7I
ODfTut2Y6Q9OzqdwJObm3VpnchB/uEHkMrOVMYjYPzkhbH5sgX2mXr60+O8VAzHI
My0BQvCge2+Ybv3e8SV1YusY6pV4Fjp8svAC9LmuB0WnAxJszZw=
=dpAL
-----END PGP SIGNATURE-----

--Xssso5lpTBgMxDfe--
