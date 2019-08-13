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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20D3C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78EB22064A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYVuKFPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbfHMJqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 05:46:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40483 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfHMJqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 05:46:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so870899wmj.5;
        Tue, 13 Aug 2019 02:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pGE6nIvpaiVVUhX7DZmNiG2nOp+x8acceL+iSBstYcM=;
        b=rYVuKFPNGEkiAI4mAdwIrZAqYYlRg74LGzP/FqfN3KRAl04BgU2LDT0ooN+gBehQmj
         /l555e8cWWNK2goT9sBbT5EqhMP1gLF7vgQ/M6fIb9cC3HPE3TRJm/ml/knktUZ40/N3
         4h9ky+wG42pMu6BBsQhqdCLFA+gh4ntX24glERcmofvadd05+p7ov7/qT5d/nL6c1DFS
         oARFLO3fyE74qLu2zOIDbaxWz9FlS1JHWV5vZCYFaM2Ix9/shAInEsAiEInAWGxfTtIF
         u7J1EG5iz8GpIPvHdCtROpkX+htWW2BRqgVVqpHCWYYkNm1MmE7BldGOm6R/YeyadjEs
         HmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pGE6nIvpaiVVUhX7DZmNiG2nOp+x8acceL+iSBstYcM=;
        b=nLsbpxTkwzlU5L+pZXPvj6leXl9eCj3kGZCpoU0fOQuf59JXzF/vHNfeYm9dhI0ZHF
         GzP1dEEXarSnMPC1geeFI3CL0Ue/MYFccCVzFc6afsveMnALQxikIUUCKRH3joGa6KXc
         GUOa2w+g8MvH6QhoS6bsOdcz/3aKio2nL0qBWhWPfYZvk3d8USl0RrUGOjGOYZcwSjNt
         RWAVVmULdC79sIyft6pkTofc9IUYk4xM5vAAGt7GxAdZBrK3nC4Nmry97AF0eWPw5fsd
         afM09cEHs0/CY8Yfs6zRaEkX9D6e0Vcy0Y3nOF5jxj+FXvgg0FxlWeopnoK/z5+Q8Vn3
         2hPg==
X-Gm-Message-State: APjAAAXvQzJRfT1YXRzZc51DDzMDd0a7GRtJtb/YdldfbNPb1SXF63W2
        ZGdkI2d4GxB+HSu4zoncX3s=
X-Google-Smtp-Source: APXvYqzhJJDCDXaJoe7rhIv2x2LqEgsTUkJsLp0JppFAlMb3kN6r7l0DIjFcWeNZxnkdZJ02PqNuRQ==
X-Received: by 2002:a1c:ed0a:: with SMTP id l10mr2131266wmh.156.1565689558447;
        Tue, 13 Aug 2019 02:45:58 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id 6sm867244wmf.23.2019.08.13.02.45.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 02:45:57 -0700 (PDT)
Date:   Tue, 13 Aug 2019 11:45:56 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com, ldewangan@nvidia.com,
        jslaby@suse.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ahung Cheng <ahcheng@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>
Subject: Re: [PATCH 03/14] serial: tegra: avoid reg access when clk disabled
Message-ID: <20190813094556.GH1137@ulmo>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
 <1565609303-27000-4-git-send-email-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SdvjNjn6lL3tIsv0"
Content-Disposition: inline
In-Reply-To: <1565609303-27000-4-git-send-email-kyarlagadda@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SdvjNjn6lL3tIsv0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2019 at 04:58:12PM +0530, Krishna Yarlagadda wrote:
> From: Ahung Cheng <ahcheng@nvidia.com>
>=20
> This avoids two race conditions from the UART shutdown sequence both
> leading to 'Machine check error in AXI2APB' and kernel oops.
>=20
> One was that the clock was disabled before the DMA was terminated making
> it possible for the DMA callbacks to be called after the clock was
> disabled. These callbacks could write to the UART registers causing
> timeout.
>=20
> The second was that the clock was disabled before the UART was
> completely flagged as closed. This is done after the shutdown is called
> and a new write could be started after the clock was disabled.
> tegra_uart_start_pio_tx could be called causing timeout.
>=20
> Given that the baud rate is reset at the end of shutdown sequence, this
> fix is to examine the baud rate to avoid register access from both race
> conditions.
>=20
> Besides, terminate the DMA before disabling the clock.
>=20
> Signed-off-by: Ahung Cheng <ahcheng@nvidia.com>
> Signed-off-by: Shardar Mohammed <smohammed@nvidia.com>
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  drivers/tty/serial/serial-tegra.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/seria=
l-tegra.c
> index 93d299e..d908465 100644
> --- a/drivers/tty/serial/serial-tegra.c
> +++ b/drivers/tty/serial/serial-tegra.c
> @@ -126,6 +126,8 @@ struct tegra_uart_port {
> =20
>  static void tegra_uart_start_next_tx(struct tegra_uart_port *tup);
>  static int tegra_uart_start_rx_dma(struct tegra_uart_port *tup);
> +static void tegra_uart_dma_channel_free(struct tegra_uart_port *tup,
> +					bool dma_to_memory);
> =20
>  static inline unsigned long tegra_uart_read(struct tegra_uart_port *tup,
>  		unsigned long reg)
> @@ -458,6 +460,9 @@ static void tegra_uart_start_next_tx(struct tegra_uar=
t_port *tup)
>  	unsigned long count;
>  	struct circ_buf *xmit =3D &tup->uport.state->xmit;
> =20
> +	if (WARN_ON(!tup->current_baud))
> +		return;

Are the race conditions that you are describing something which can be
triggered by the user? If so, it's not a good idea to use a WARN_ON,
because that could lead to some userspace spamming the log with these,
potentially on purpose.

Thierry

> +
>  	tail =3D (unsigned long)&xmit->buf[xmit->tail];
>  	count =3D CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
>  	if (!count)
> @@ -829,6 +834,12 @@ static void tegra_uart_hw_deinit(struct tegra_uart_p=
ort *tup)
>  	tup->current_baud =3D 0;
>  	spin_unlock_irqrestore(&tup->uport.lock, flags);
> =20
> +	tup->rx_in_progress =3D 0;
> +	tup->tx_in_progress =3D 0;
> +
> +	tegra_uart_dma_channel_free(tup, true);
> +	tegra_uart_dma_channel_free(tup, false);
> +
>  	clk_disable_unprepare(tup->uart_clk);
>  }
> =20
> @@ -1066,12 +1077,6 @@ static void tegra_uart_shutdown(struct uart_port *=
u)
>  	struct tegra_uart_port *tup =3D to_tegra_uport(u);
> =20
>  	tegra_uart_hw_deinit(tup);
> -
> -	tup->rx_in_progress =3D 0;
> -	tup->tx_in_progress =3D 0;
> -
> -	tegra_uart_dma_channel_free(tup, true);
> -	tegra_uart_dma_channel_free(tup, false);
>  	free_irq(u->irq, tup);
>  }
> =20
> --=20
> 2.7.4
>=20

--SdvjNjn6lL3tIsv0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1ShtQACgkQ3SOs138+
s6GjFQ/+LK+5YJjV2isYgf+/bdshv1sa/XjzklRGk/Dq00ZXUlB6lCF01Ajx6wkG
UEqJL37x8g8/qYI955SLMnppmTYgp8d/te7PAsAjjQ43fWpo/rrmdceeAldVTJwi
C3BAuz/vy2lfZZSuqrQoo9Q6YaT7k/fBnDYARHPn2iVaAPygcRdy87D/cTJJE9OA
L/RYQI/lYVrxh6G+mSTv+AqmRV7HytQ9EZqCYOXP9Vbzj83s4i88z0DB6SkTOOjb
xXCzqJ9xN7hN6COzjVrx2j1Kh7x+FJoj/LcETaxfFbTEKJSQxUaQN9SWOW7khp2V
dnbRogc+Ic1TsTZj3J4+ckmbjz0kDzRhFzw1W2x+6R+dwfLzRtNAxEXD9QH9F3e2
u+vixUfT7ysEpxZ1LSVDga78kSd6N81WHcxiuwwry5T6pSLVEVf0WF7lkf2gPhNC
qnCTVCYjYlaWbTSIgINmKn6By/gmSfOTEJ+98SSaomBSBh/NkiD75WO8YNyqRdMd
17eNRiMeztA+h4yjxky/yq9ip7Jd2mq2s0GyikwfcIULBU6FE80LDKJgT5x5lh8J
j0bNWRHIlJLICgAEPfJ0wYG/m9Pdx8YcBubjwudYbIKUkV5zeXOSYqITxMV/tieC
ppmhsxevWB0gQ2ZhI3ZgJ4kyrqSZq9zo4Gs/+yV0MJTGSNcxw8Y=
=vzYG
-----END PGP SIGNATURE-----

--SdvjNjn6lL3tIsv0--
