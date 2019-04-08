Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB58C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1334C20855
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZckTTg4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfDHSTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:19:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46823 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbfDHSTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 14:19:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id 9so8077066pfj.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 11:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yDf+bjEQQKv8NtjCpQxswqSz4Roxfl6YCWudYFf6pLQ=;
        b=ZckTTg4/U1VqUUEXfNVGNNWwL7oiYIBPctsHrSwEKDRNbM60z44kbA7Ud145V3+WXL
         0hEgohyXZotMGO02gslrIgWHdM9uTHtcQFbpBQ+q9Fe2D4deWro7dyYbctorJsJz6Wrr
         8DBh2NgbGcq4bEe+X6nGYxM6eS8xn9GBVs7IE2QaWIaKm0PUUr7HiaSTpGzBtaizb/fP
         +zi+3LvYsI3nlI9E7nWNGLM2UJm+t1lN3p3LBvJ7rQFYyjp898UWNVKrMQDO9GC7VD0J
         VA18wt1AkocMAw2YtN2grE8TMUXhT26aq2KqJSRkhzStoFrxiGnTxUxWe6ngKf0ylUQF
         dM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yDf+bjEQQKv8NtjCpQxswqSz4Roxfl6YCWudYFf6pLQ=;
        b=Vt0tosbNhcfOf7Ei7QBnkqRpipW6lDJpMLxH8HQE2cwPQBEc6/WVVwV8PpGgHgyflk
         /86UA2HApICI7Qpc7EQLxxnlyfEP42vy4LSlgGmKmtSfO/qlPofk9w3yXnt7C3dt8svT
         HVkufdaPcU1Cyel4hOKF2enqw3V53C9oIuHZ8UjUpZN9zLTHkShF1HJebbe8oMIZKdVc
         aSATrSe5SCCsLeWBlPq9cwmqP0UAVVkavd6nbfaSxrUfY2tibbtWN3DNZZRM3OUTf7X7
         6sho6iRwTsUy6GjVjS3mVLCPppv9bzJcMBiwy80jIKlBenhgvLWPj4qnLlvfcwqJ2r1F
         D6LQ==
X-Gm-Message-State: APjAAAXuiix+xkDIbwv6KoDVYGGCOD3kkpMpHgpMMCxpGNl/KYJF4w0t
        0rZHo2R/vPkwLBEGGsKchgzr8g==
X-Google-Smtp-Source: APXvYqxuVvfs35NfVNRVIrjhQQkJkwejv5qJk8YHKFEFADKEAvYKhPNdAXHwRq1XOwBL8IEye/g/UQ==
X-Received: by 2002:a63:7808:: with SMTP id t8mr28488948pgc.127.1554747548039;
        Mon, 08 Apr 2019 11:19:08 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id i2sm43605818pfo.9.2019.04.08.11.19.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 11:19:06 -0700 (PDT)
Date:   Mon, 8 Apr 2019 11:19:01 -0700
From:   Benson Leung <bleung@google.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     lee.jones@linaro.org, gwendal@chromium.org, bleung@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, dtor@chromium.org,
        rushikesh.s.kadam@intel.com,
        Vincent Palatin <vpalatin@chromium.org>
Subject: Re: [PATCH v3 3/4] mfd: cros_ec: instantiate properly CrOS FP MCU
 device
Message-ID: <20190408181901.GA18975@google.com>
References: <20190408094141.27858-1-enric.balletbo@collabora.com>
 <20190408094141.27858-4-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20190408094141.27858-4-enric.balletbo@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Enric,

On Mon, Apr 08, 2019 at 11:41:40AM +0200, Enric Balletbo i Serra wrote:
> Support Fingerprint MCU as a special of CrOS EC devices. The current FP
> MCU uses the same EC SPI protocol v3 as other CrOS EC devices on a SPI
> bus.
>=20
> When a MCU has fingerprint support (aka EC_FEATURE_FINGERPRINT), it is
> instantiated as a special CrOS EC device with device name 'cros_fp'. So
> regardless of the probing order between the actual cros_ec and cros_fp,
> the userspace and other kernel drivers should not confuse them.
>=20
> Signed-off-by: Vincent Palatin <vpalatin@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
>=20
> Changes in v3: None
> Changes in v2: None
>=20
>  drivers/mfd/cros_ec_dev.c   | 10 ++++++++++
>  include/linux/mfd/cros_ec.h |  1 +
>  2 files changed, 11 insertions(+)
>=20
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 1daccd4e05a3..79746e817cdb 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -636,6 +636,16 @@ static int ec_device_probe(struct platform_device *p=
dev)
>  	device_initialize(&ec->class_dev);
>  	cdev_init(&ec->cdev, &fops);
> =20
> +	/* Check whether this is actually a Fingerprint MCU rather than an EC */
> +	if (cros_ec_check_features(ec, EC_FEATURE_FINGERPRINT)) {
> +		dev_info(dev, "CrOS Fingerprint MCU detected.\n");
> +		/*
> +		 * Help userspace differentiating ECs from FP MCU,
> +		 * regardless of the probing order.
> +		 */
> +		ec_platform->ec_name =3D CROS_EC_DEV_FP_NAME;
> +	}
> +
>  	/*
>  	 * Check whether this is actually an Integrated Sensor Hub (ISH)
>  	 * rather than an EC.
> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> index ce50628aa5e7..b393bd4e4b73 100644
> --- a/include/linux/mfd/cros_ec.h
> +++ b/include/linux/mfd/cros_ec.h
> @@ -23,6 +23,7 @@
>  #include <linux/mutex.h>
> =20
>  #define CROS_EC_DEV_NAME	"cros_ec"
> +#define CROS_EC_DEV_FP_NAME	"cros_fp"
>  #define CROS_EC_DEV_ISH_NAME	"cros_ish"
>  #define CROS_EC_DEV_PD_NAME	"cros_pd"
> =20
> --=20
> 2.20.1
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlyrkJUACgkQHwn1ewov
5lg2NQ//d00NswlgY5QWjcEINe5+lS3+Ox75Nduic4iWM7leH3xacFgSHazAmBDU
kIGRdq9JWWMO4sHsUl150lUnJdRwJ0P4ceZrF1XrAa3LX9SlmjPQ4WDNB48Kxink
mccrZzQvQmRjFkadPEuydxLsV9l7A1ggKR7L6Tk0N+8azVaxE6SGbYKto1JbOwO4
3I5Q7UD46sG/WIsvk0CweT9IRU0HazzZiul48xHbdwP1vg2P/ppBYqAA6ZlcYpKz
YrCDcMOiZDARPPM0t4onw374CY0zh8bmvJfCByHQljS3Wp13KbIvYDK6EHWlcMm3
nP2CImBrgzshu7Jg7pu2FZWmVrgOfvcVbEkGLdUtvjnjBmUI00hBST0fL95M+4zq
Yi4W5oWQxQ4WZYnt5JbKfnvyyCXtvnTelX/avkjc1BfC7gfrvE3EniGcpmiSdOy5
+oAnXwaaNZK7MjBgMelV8/Y/z0If6Fd73Y2nNMJbnuzwbBRTS2hJEIc23zJq9+6/
H36wvZ04uuLj07JVIwoecn71k2zoKvcE03sbiM24sYq2UpEEYhg65PAksq5c+e7V
S2+YfcfyO9putKjefIAyqBKDdUFvSiHy6A3GyKD7BK7z7N0ZkxjpnWQKsz9ugCtm
P4D4+dI2+A0jJAZOrp8leNecRY6txVKPS/aMGgfPyapwrMIrYu0=
=uZqH
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
