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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BF7C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 10:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE7C2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 10:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXizo33V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbfHMKUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 06:20:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51819 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfHMKUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 06:20:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so985747wma.1;
        Tue, 13 Aug 2019 03:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DGp8Ky+Dx3RwZAF3+cIDXjE3Lw7yKz13Y59bJZFavaY=;
        b=WXizo33V8sAI1NoXwVaBHDpkRghw2FEDAEE7507MOGaczRGTeGZuPkerWfNnnbJ8jW
         sqoWy5QRYzXozmnOREw4GfV0Csbb9NtuFVt85nnFR4AT0tbg5Z63Nm7oVRCOR/QOcBA3
         xjSSUK9LKBUCVEojIr185zkumGkHew36xMIhAXJBMTFXFGrtV8KOjBugysGPtWNU+nzN
         zat1XDmxipMbrfOgTAc228qhnHcheaWJYj/uPRSLGjMhrQ4FdA1uwp27bm3pbj/hr1pm
         R4N2tR2J9SBtexX7omQA3RvqktzwgQXTbjckrz/xaT6yPts3J+SblHBq2EhcJAE8YFW/
         7+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DGp8Ky+Dx3RwZAF3+cIDXjE3Lw7yKz13Y59bJZFavaY=;
        b=KOiaP3i929IvuKbF/UCEewvpNA1Bdbnp86B3inGUyDwi0ZTWYF3UEtJu6ljL2GDmZP
         s+Cad2A99B7u1cmAcoHECwDSrXx06SiGOHtrj7Ygq05Fx98gioSTtDPvOgbwgm8m/JU5
         tzVTd5FUxTzdAHznM+t0y1uTgGMjnxWRLBTKFPAB8fO70b0J+b8AiiM0qcl8x/AMN0Kc
         XGGu0XrYRicG1eAFZoAbajryH/pkbhap4HAXoQXwUHDSgN2jvVqpq9JKrAqhZVJGOAK8
         SxfpTnlWdfylAq5suW3blxsLH/q6M6a1s6fltverNO+ffHuOh1iqoX/83vumPWyfAUjs
         ZnuQ==
X-Gm-Message-State: APjAAAX4fra3nTdfnTcYfuefMYQVjB2UEqMG2xygB2g16OprzcNRUnm/
        IF+min1j7LNxkFePJoySzqw=
X-Google-Smtp-Source: APXvYqy5VmVPY41KHkJHihFGngBzzdR9qkE0lFoW7/lpMhssgPhoa6xVK2LVN5L+ObXT2QdROJMlDg==
X-Received: by 2002:a1c:7914:: with SMTP id l20mr2368868wme.130.1565691597468;
        Tue, 13 Aug 2019 03:19:57 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id e14sm952427wma.37.2019.08.13.03.19.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 03:19:56 -0700 (PDT)
Date:   Tue, 13 Aug 2019 12:19:55 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com, ldewangan@nvidia.com,
        jslaby@suse.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shardar Shariff Md <smohammed@nvidia.com>
Subject: Re: [PATCH 09/14] serial: tegra: set maximum num of uart ports to 8
Message-ID: <20190813101955.GN1137@ulmo>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
 <1565609303-27000-10-git-send-email-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6yHiY5vv/BiPjcMt"
Content-Disposition: inline
In-Reply-To: <1565609303-27000-10-git-send-email-kyarlagadda@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6yHiY5vv/BiPjcMt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2019 at 04:58:18PM +0530, Krishna Yarlagadda wrote:
> From: Shardar Shariff Md <smohammed@nvidia.com>
>=20
> Set maximum number of UART ports to 8 as older chips have 7 ports and
> Tergra194 and later chips will have 8 ports. Add this info to chip data
> and register uart driver in platform driver probe.
>=20
> Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  drivers/tty/serial/serial-tegra.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/seria=
l-tegra.c
> index e0379d9..329923c 100644
> --- a/drivers/tty/serial/serial-tegra.c
> +++ b/drivers/tty/serial/serial-tegra.c
> @@ -62,7 +62,7 @@
>  #define TEGRA_UART_TX_TRIG_4B			0x20
>  #define TEGRA_UART_TX_TRIG_1B			0x30
> =20
> -#define TEGRA_UART_MAXIMUM			5
> +#define TEGRA_UART_MAXIMUM			8
> =20
>  /* Default UART setting when started: 115200 no parity, stop, 8 data bit=
s */
>  #define TEGRA_UART_DEFAULT_BAUD			115200
> @@ -87,6 +87,7 @@ struct tegra_uart_chip_data {
>  	bool	allow_txfifo_reset_fifo_mode;
>  	bool	support_clk_src_div;
>  	bool	fifo_mode_enable_status;
> +	int	uart_max_port;
>  };
> =20
>  struct tegra_uart_port {
> @@ -1323,6 +1324,7 @@ static struct tegra_uart_chip_data tegra20_uart_chi=
p_data =3D {
>  	.allow_txfifo_reset_fifo_mode	=3D true,
>  	.support_clk_src_div		=3D false,
>  	.fifo_mode_enable_status	=3D false,
> +	.uart_max_port			=3D 5,
>  };
> =20
>  static struct tegra_uart_chip_data tegra30_uart_chip_data =3D {
> @@ -1330,6 +1332,7 @@ static struct tegra_uart_chip_data tegra30_uart_chi=
p_data =3D {
>  	.allow_txfifo_reset_fifo_mode	=3D false,
>  	.support_clk_src_div		=3D true,
>  	.fifo_mode_enable_status	=3D false,
> +	.uart_max_port			=3D 5,
>  };
> =20
>  static struct tegra_uart_chip_data tegra186_uart_chip_data =3D {
> @@ -1337,6 +1340,7 @@ static struct tegra_uart_chip_data tegra186_uart_ch=
ip_data =3D {
>  	.allow_txfifo_reset_fifo_mode	=3D false,
>  	.support_clk_src_div		=3D true,
>  	.fifo_mode_enable_status	=3D true,
> +	.uart_max_port			=3D 5,

You say in the commit message that the older chips have 7 ports, but
here you say they have 5. Which one is it?

>  };
> =20
>  static const struct of_device_id tegra_uart_of_match[] =3D {
> @@ -1386,6 +1390,7 @@ static int tegra_uart_probe(struct platform_device =
*pdev)
>  	u->type =3D PORT_TEGRA;
>  	u->fifosize =3D 32;
>  	tup->cdata =3D cdata;
> +	tegra_uart_driver.nr =3D cdata->uart_max_port;
> =20
>  	platform_set_drvdata(pdev, tup);
>  	resource =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -1411,6 +1416,13 @@ static int tegra_uart_probe(struct platform_device=
 *pdev)
>  		return PTR_ERR(tup->rst);
>  	}
> =20
> +	ret =3D uart_register_driver(&tegra_uart_driver);
> +	if (ret < 0) {
> +		pr_err("Could not register %s driver\n",
> +		       tegra_uart_driver.driver_name);
> +		return ret;
> +	}

I don't think this is the right place for this. You're going to try to
register the driver once for each instance of the Tegra UART that will
be probed.

I'm surprised that this works at all because there's a BUG_ON() early
in uart_register_driver() that checks for the existence of drv->state,
which means that the second instance of tegra_uart_probe() should
trigger that and cause the kernel to crash.

I think it's better to either create an additional of_device_id table
that is used to match on the top-level node's compatible string and
which only contains the maximum number of ports for the given SoC, or
you could add code to tegra_uart_init() that counts the number of ports
that do match and initialize tegra_uart_driver.nr using that number. It
would something like this:

	unsigned int count =3D 0;

	for_each_matching_node(np, &tegra_uart_of_match)
		count++;

	tegra_uart_driver.nr =3D count;

You could also add additional checks in the loop, perhaps something
like:

	for_each_matching_node(np, &tegra_uart_of_match)
		if (of_device_is_available(np))
			count++

Though that would prevent any UARTs from getting added via dynamic
device tree manipulation.

Thierry

> +
>  	u->iotype =3D UPIO_MEM32;
>  	ret =3D platform_get_irq(pdev, 0);
>  	if (ret < 0) {
> @@ -1472,13 +1484,6 @@ static int __init tegra_uart_init(void)
>  {
>  	int ret;
> =20
> -	ret =3D uart_register_driver(&tegra_uart_driver);
> -	if (ret < 0) {
> -		pr_err("Could not register %s driver\n",
> -			tegra_uart_driver.driver_name);
> -		return ret;
> -	}
> -
>  	ret =3D platform_driver_register(&tegra_uart_platform_driver);
>  	if (ret < 0) {
>  		pr_err("Uart platform driver register failed, e =3D %d\n", ret);
> --=20
> 2.7.4
>=20

--6yHiY5vv/BiPjcMt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1SjsgACgkQ3SOs138+
s6GqXg/+NqGJwKhw2nj6tpNZg3ykfwbqXlLcPpA/uRSgYEWHoS/NVI2dGYI3/oOn
opBCKPAvPtvc9SeStwOuFK/qW5Ltn+yI3l+2wboMdMKJq04gNiSUs6CbBo17htAg
V+L/FDBa+W4dJ/tfBtjW75AW0eBN98MPbrS058dNCLH/W62wVFpMQqaMTqOZo8ib
u0Xxk056X9Lzd287Btm0YHY7s/kpF4wsRC6KZoV6cARjStgfYK4h9lVrgOau7CeM
yoJWC9wuWvCYeC7C3b+zEhrVNHrAh5V09k/ywnTeV8/lbbPjmCP0fL4Q4tMFixow
RFY9ij6JjcywcV1a0ig/EIjRlrMQLMmYXnnt8Q2F8qDpDezKEMk3yaaPNku6x/Vm
JNiX9k+arX1NBAdvbtfYiXqWGI7cIhNCVybNL78fP8oS8wUQe+is1pmUksABvQR+
10Z6qVbq8KXaUI9Icv4nq24RRHZlD9mbUvdocQ56k7ttwg6xGQkjGbPYg6pAf87D
RwnOByaLOiOVa9XZ0yVGRLNMVKHiCvio3V0QX6d5Krsfg7JvcprJTvijcKWawZLb
WtqBIGWiEUDi83+S8+ikjrMo/kvwhkOfpo+TQ7+mJfC8LdibuJTrQgTfbe+8mwVP
v/p+/oXl/TuET8yQZl6en1xTLk+FVV5X+Deoh4rK6lBp7Wf9aDM=
=GSjq
-----END PGP SIGNATURE-----

--6yHiY5vv/BiPjcMt--
