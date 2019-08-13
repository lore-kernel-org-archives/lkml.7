Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839A8C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACD32064A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="My6DqltM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbfHMJmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 05:42:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32812 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfHMJmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 05:42:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so107240895wru.0;
        Tue, 13 Aug 2019 02:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WREN+U1ZBJtkCx6rZxLMPYPtq8iC0/1y5O5MBNsQ1KM=;
        b=My6DqltMM12YPnxB0MAoyuQSR0gEHqgIg8Vn3uc+eKTeWMDjUeVINKqtHJHo54Lda9
         32m9BF+G78qhswVZxsvLL/pNmSFHO8ge8GeS79yTD/uq4odLUyS+wYTYwo0bsavMFoNs
         OYaCVj3ili7cuOpHlgovXy680Bh0hohoWcU2CPRtSwx1WexIhltjx2tHF8ZIDG7IXLIm
         wTeYMdLVMR7w7a8j1OKvCcVYQMqtuR5fH/6PQ+8YVG6HgNJJhFE5+wk3vtQ1pSva0Iq6
         IutnBpjKJmC3iE/onxqKnQ6JkRSNeJF45T6W+zH4DgY9Jbz6Q0otwNp19cS7eXNmEMMg
         qR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WREN+U1ZBJtkCx6rZxLMPYPtq8iC0/1y5O5MBNsQ1KM=;
        b=Ye+PE1fBfmc1yeyPA61LYdbQbIf2K2okS8JTMCGiI8UTXUVNg14ymAtZfhF2Qdulh2
         9veERCosoqGTf8T2g6VlLD+Z+H5SAU2kp2XuTwu77tzPEuuErS4SGNEtFQxhMT3yEVQW
         kJCLzyOqtC7OHa4suyyIWtxCbLiWCGgqKTOL7sQI1ardI33hL+q2LLmfyJ3o/k/F4DT/
         WFuGKfO92BO7xXhgRfVCNb9QTmXTWKKLyR+QsHcoKp2cal2DQwTs2J63+ln8NM4ijJid
         qW8x/3WB7w4WIxey8MmpXIWNk8e+9Hbb902fKu2iRRgbC4xgRW+0onO1jIVuFyqiOAgY
         PtxA==
X-Gm-Message-State: APjAAAW0avRBX8N2eUobucwSNm2q0R3bjipMmwfWFuqVr4IN/EOKT8JH
        7W8BcgUJfaiw9Deb/NjAnxQ=
X-Google-Smtp-Source: APXvYqyu80loLBQ+pQU4CrxlM8ctJymubjJiPfnmpnRRC68p3OdSIMXFPPCyzEyrdm6rpEcoF8izZA==
X-Received: by 2002:a5d:55cf:: with SMTP id i15mr4069396wrw.151.1565689331175;
        Tue, 13 Aug 2019 02:42:11 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id n16sm762043wmk.12.2019.08.13.02.42.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 02:42:09 -0700 (PDT)
Date:   Tue, 13 Aug 2019 11:42:08 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com, ldewangan@nvidia.com,
        jslaby@suse.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shardar Shariff Md <smohammed@nvidia.com>
Subject: Re: [PATCH 02/14] serial: tegra: add support to ignore read
Message-ID: <20190813094208.GG1137@ulmo>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
 <1565609303-27000-3-git-send-email-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w/VI3ydZO+RcZ3Ux"
Content-Disposition: inline
In-Reply-To: <1565609303-27000-3-git-send-email-kyarlagadda@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w/VI3ydZO+RcZ3Ux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2019 at 04:58:11PM +0530, Krishna Yarlagadda wrote:
> From: Shardar Shariff Md <smohammed@nvidia.com>
>=20
> Add support to ignore read characters if CREAD flag is not set.
>=20
> Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  drivers/tty/serial/serial-tegra.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/seria=
l-tegra.c
> index 19f4c24..93d299e 100644
> --- a/drivers/tty/serial/serial-tegra.c
> +++ b/drivers/tty/serial/serial-tegra.c
> @@ -542,6 +542,9 @@ static void tegra_uart_handle_rx_pio(struct tegra_uar=
t_port *tup,
>  		ch =3D (unsigned char) tegra_uart_read(tup, UART_RX);
>  		tup->uport.icount.rx++;
> =20
> +		if (tup->uport.ignore_status_mask & UART_LSR_DR)
> +			continue;
> +
>  		if (!uart_handle_sysrq_char(&tup->uport, ch) && tty)
>  			tty_insert_flip_char(tty, ch, flag);

Is it a good idea to ignore even sysrq characters if CREAD is not set?
According to termios, CREAD enables the receiver, so technically if it
isn't set you can't even receive sysrq characters. But I don't know if
there are any rules regarding this.

Is this the same way that other drivers work?

Thierry

>  	} while (1);
> @@ -562,6 +565,10 @@ static void tegra_uart_copy_rx_to_tty(struct tegra_u=
art_port *tup,
>  		dev_err(tup->uport.dev, "No tty port\n");
>  		return;
>  	}
> +
> +	if (tup->uport.ignore_status_mask & UART_LSR_DR)
> +		return;
> +
>  	dma_sync_single_for_cpu(tup->uport.dev, tup->rx_dma_buf_phys,
>  				TEGRA_UART_RX_DMA_BUFFER_SIZE, DMA_FROM_DEVICE);
>  	copied =3D tty_insert_flip_string(tty,
> @@ -1190,6 +1197,11 @@ static void tegra_uart_set_termios(struct uart_por=
t *u,
>  	tegra_uart_write(tup, tup->ier_shadow, UART_IER);
>  	tegra_uart_read(tup, UART_IER);
> =20
> +	tup->uport.ignore_status_mask =3D 0;
> +	/* Ignore all characters if CREAD is not set */
> +	if ((termios->c_cflag & CREAD) =3D=3D 0)
> +		tup->uport.ignore_status_mask |=3D UART_LSR_DR;
> +
>  	spin_unlock_irqrestore(&u->lock, flags);
>  }
> =20
> --=20
> 2.7.4
>=20

--w/VI3ydZO+RcZ3Ux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1ShfAACgkQ3SOs138+
s6FVpg/9GPeTbw/45dZ/HWvsmLm2iaqKG106inOD5HVGDZXJKkwDQOSrqGMMriL4
4P5s43rU58YErMzCly57ETyrADsZQbyI0N+/Bsk2kuN138RzhplzSFwad8K/J/V3
QMtXJQ5jHoaSi97NjGBVmSApgg2i3BT9Ro8vVEG1aje4KAswACcR+WZS9tTQ4u69
8TR1A5skZ5BSWrXz0gbxEKcrmlfHtLiqTtAtvRNNyqoSaspUETEv4LV1WywlkX/1
7xqwYm0RkuPuMoQnuGv2zH40ZPZPrnRj3OeEoAXYN42XauihHjcVfvVguvjSdObd
EmFyZQiseCVm07vLImYFXkh4kbSUAIYtO2RVBF9mbSiYsfJKjdGDgfCCvNpnUzbA
BKbgWBQAM1vsvdMenhZvISdtPNTO9bLpffHPydEwLFMLAecAfJyAzmUw6XNxW0k4
QVYlH49a5+V6C2cgoqzttMKyx9AbCxiGIAxYTOeqRJxLRAYy/eNFpvGdRml0S9tf
ZyUCysOxM413iZ+tRlbGWy3DI+lmDyqJEw/VE6I7CVfa44aRrdkzKTvHCgISRAEt
5BzVQw0yWrcXaDBdG7QnR8Wl0Gk/apezX3KL723FV0vUdYcX3ejIyWaBo4ijukG8
InudQyl4SNS25B8RknOJ9uJkrYfG7x0eC+0lFoV7xx6ojPif8oc=
=eDP7
-----END PGP SIGNATURE-----

--w/VI3ydZO+RcZ3Ux--
