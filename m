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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972B1C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A46320843
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ounGMCCt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbfHMJwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 05:52:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41189 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbfHMJwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 05:52:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id j16so4893293wrr.8;
        Tue, 13 Aug 2019 02:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oH9CVh9gmVeJHcvQJ/Os+97M33Mq/JlC7yYO0dPPriA=;
        b=ounGMCCtFmxbo256LzcETIMFc6e0TWnudwVu1O7cSATGIbcJyadK9KbnNLZRTgixRw
         vQJKT5eOprVrrqnRF/iUMAqdyPMjdfWg66949imUdt5E9/BB2ohw2kKYFa1IOAorVQqE
         /XPo1Lw7REL5Efhe6ULC/KK7miOhTnJzQVVlc8nk++EO0j01w4LRDji/ursGTotF2j0m
         ClCs3b4Wdx8kPmFJ+XTsh804XzjzpkgotqRNdKq+avFC1jMACLLnxeBH5EW5OviFWGEc
         K1GJDt12tUofkEiQeqmYXfW7+dMJspi3ANixq0U4J9cQPT4n09SdxSKX9zJYnvp6c+27
         +4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oH9CVh9gmVeJHcvQJ/Os+97M33Mq/JlC7yYO0dPPriA=;
        b=OJZhkV0GwC+NZbQLxeVFvibKCGKNGlKVVHzXy0g1dgAbJqoQcqFx+LuYuquS0R3jn0
         bqqAj3KxElKjoPRyUDgwZrN0zgxQUKQLEYpq/AAhsN85maoWFb+8ZNkre+hkw2vOwer4
         hVSSmxjq1Hrjco2syupkp5sdme+05UO+BdwmeohF2GSItj2/PMtsjyL6CjcBYYpuvvDR
         EuyzVCRUkrGew/qscXw0WTAIHDaZDoGigbSJwrJtp++G8JsKVuQXpbTwkdoM0DqwveKL
         JlEQIrna5rkXRwEKr5lV0r9muQ3MMFnC5xEAH0GhkkzErHXAFME0IfOhCKZZdQPPfBXq
         ohdw==
X-Gm-Message-State: APjAAAVNq0sllrIYAxJT1Lqas+fu/7e8OLeVhqPaZwzWUgJAaX9k4I4o
        7b7+ZYyMdjTTFXA1BWneEZ0=
X-Google-Smtp-Source: APXvYqz07B6svSsW51U9prMIdXC+G8MdU4xSpnQW0LRESapxwEuzy56nVqI37LSm7cYN/FR9GKZrIw==
X-Received: by 2002:adf:ee45:: with SMTP id w5mr12189040wro.148.1565689941503;
        Tue, 13 Aug 2019 02:52:21 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id j15sm7689063wrn.70.2019.08.13.02.52.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 02:52:20 -0700 (PDT)
Date:   Tue, 13 Aug 2019 11:52:19 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com, ldewangan@nvidia.com,
        jslaby@suse.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shardar Shariff Md <smohammed@nvidia.com>
Subject: Re: [PATCH 06/14] serial: tegra: report error to upper tty layer
Message-ID: <20190813095219.GK1137@ulmo>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
 <1565609303-27000-7-git-send-email-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mGCtrYeZ202LI9ZG"
Content-Disposition: inline
In-Reply-To: <1565609303-27000-7-git-send-email-kyarlagadda@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mGCtrYeZ202LI9ZG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2019 at 04:58:15PM +0530, Krishna Yarlagadda wrote:
> Report overrun/parity/frame/break errors to top tty layer. Add support
> to ignore break character if IGNBRK is set.
>=20
> Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  drivers/tty/serial/serial-tegra.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/seria=
l-tegra.c
> index f6a3f4e..7ab81bb 100644
> --- a/drivers/tty/serial/serial-tegra.c
> +++ b/drivers/tty/serial/serial-tegra.c
> @@ -374,13 +374,21 @@ static char tegra_uart_decode_rx_error(struct tegra=
_uart_port *tup,
>  			tup->uport.icount.frame++;
>  			dev_err(tup->uport.dev, "Got frame errors\n");
>  		} else if (lsr & UART_LSR_BI) {
> -			dev_err(tup->uport.dev, "Got Break\n");
> -			tup->uport.icount.brk++;
> -			/* If FIFO read error without any data, reset Rx FIFO */
> +			/*
> +			 * Break error
> +			 * If FIFO read error without any data, reset Rx FIFO
> +			 */
>  			if (!(lsr & UART_LSR_DR) && (lsr & UART_LSR_FIFOE))
>  				tegra_uart_fifo_reset(tup, UART_FCR_CLEAR_RCVR);
> +			if (tup->uport.ignore_status_mask & UART_LSR_BI)
> +				return TTY_BREAK;
> +			flag =3D TTY_BREAK;
> +			tup->uport.icount.brk++;
> +			dev_err(tup->uport.dev, "Got Break\n");

I know this is preexisting, but why do we want to output an error
message in these cases. Isn't it perfectly legal for this to happen?

Thierry

>  		}
> +		uart_insert_char(&tup->uport, lsr, UART_LSR_OE, 0, flag);
>  	}
> +
>  	return flag;
>  }
> =20
> @@ -562,6 +570,9 @@ static void tegra_uart_handle_rx_pio(struct tegra_uar=
t_port *tup,
>  			break;
> =20
>  		flag =3D tegra_uart_decode_rx_error(tup, lsr);
> +		if (flag !=3D TTY_NORMAL)
> +			continue;
> +
>  		ch =3D (unsigned char) tegra_uart_read(tup, UART_RX);
>  		tup->uport.icount.rx++;
> =20
> @@ -1224,6 +1235,8 @@ static void tegra_uart_set_termios(struct uart_port=
 *u,
>  	/* Ignore all characters if CREAD is not set */
>  	if ((termios->c_cflag & CREAD) =3D=3D 0)
>  		tup->uport.ignore_status_mask |=3D UART_LSR_DR;
> +	if (termios->c_iflag & IGNBRK)
> +		tup->uport.ignore_status_mask |=3D UART_LSR_BI;
> =20
>  	spin_unlock_irqrestore(&u->lock, flags);
>  }
> --=20
> 2.7.4
>=20

--mGCtrYeZ202LI9ZG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1SiFMACgkQ3SOs138+
s6GvUg//Z9O5WEPe9rTu+9sjypaZEmAIc3UQ0IqGTCFG5787p+iokxU/hFJceWHB
8dinTSHuRtj0h+Oohj0vrmuduDEV9PpeXJq/3DChXFkv/FXnp9TXmwUAIz/d4vll
73X3Q0YIhdad3rQKAbaN8sAoNZM6Sem7GiXxwgbBwdEWOfboXHJ6+B4DCaPWggAI
smLYQaTkLGhaP6nxCjFTDxlOa64ogcsQ8UBBAmtuunYuHlnZhSXZNw6+hx6DLq2A
96ySRNVMRzdR0SAqwv0zNm2CxgxJbd8li1r46jLo9od6oTB+mGgrGL6QIT+HY3Rx
VRVEsA9dXpzARh7jucVelOZt7Jne2vWPgnZachYCDuuOL1XdjuSy+I8f90YS2eaX
cjg+U1l9lVoBWy5s8BQWRRaQd8Fv6Prmurw6Y2EwfUHebNAuSIj8bBoDg7KImd+j
OBnp2i/eZweGMJs29SmHZJCkKrKq2f33mlRCfPrni9fMtFtuyv/3CHr4Dq0ktCHz
LtIYvyLo3PX7xdZxni5TilP9i0VGsRmXaRzSAhKAwl5+IZQeJl22tE1z2Fwbxvf7
2W8lxpJsP6ccwCvFry0r4Gx0FAEVRS7QNuf556xzDqO0dN0pY4kzYlGy2vUkcDkB
dQBCiMtdS8huuJMz3rGCDZLr/NUwbnjrDkpcvZK2nIu5gzsH5Hg=
=CqDS
-----END PGP SIGNATURE-----

--mGCtrYeZ202LI9ZG--
