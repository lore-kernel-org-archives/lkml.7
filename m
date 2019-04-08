Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91D4C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7F52084C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iqNeVVke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbfDHSTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:19:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38097 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbfDHSTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 14:19:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id 10so8101979pfo.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 11:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PJbOrRJNXX4Wxouw9BNye/9zx7IIa0EjaQ389+BC/cM=;
        b=iqNeVVkewI0sp71pFLhiIoutQeE1aQ8QnOaJW3+1I8f/rW1CydEgWP0pRoMtvS44kK
         r1vA92ed/6dMa1l2Jn3XNqtZuyK8nJ2+DqpHr3CRpFCqCsVps9EarZ3CXUgOZN6wZ8oq
         YHTGaPllP/kRf68AnsfOYq6yaln/L5QsOZwoK2q5O9zI/MtbFxZlAWRnMOGL5ZUxHitG
         AfQKJBWPDOX9kaqWbSX6YT5RG0gc0+JZfUBA37jdrdVKUdY21WI+kKttp5qrGhQzNMXh
         eeOMS9R/0+cJiv/8+t1TZrPsz1myDbpOEgt3179okNL+xBjy8Ix4F71YPfm+azaoe6NR
         +N2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PJbOrRJNXX4Wxouw9BNye/9zx7IIa0EjaQ389+BC/cM=;
        b=kZORgYPfW7YXrJr2WOSBQmAmtEwNu02URc+QOZJ0FxrJKKLozW5+2HUx8/bRzOsF2F
         5NRjxjDAHQAk29WX8ZJgtGw6NSAl5dJWI6cMxpMkkQrlKyTfE6BaLgbRtQOw5Pp/osBn
         9NEtbrf+ZMlXky/ynoTfob9m+vS0rxR8ZsFpSqe7X+8y7HCwLxIi7ygUHMJgnSKqhFNU
         1EMEGcQQGhRZPpgy8fEXXvE11wy7svFAHq9+uGGD6xVujLrPzTaabUxJaMwMYfKt9/tK
         DpSSkQhx1J/6Kbjkgpb3f4nAhnVO+pIOnAkwkhKcGYb0H+gok7hS0Ok+4zFwYkswPSOw
         lT6w==
X-Gm-Message-State: APjAAAUbk7xIPOPPav6jqL4aRPAFXZyfUjDhI7NLKmjgg8GJiwDN5NDL
        JAcL57y/KNWJFqYwngdIks3SGA==
X-Google-Smtp-Source: APXvYqy1LYic9AMgTBArXJxlzvNt0St8guShI3+AxDeBIVY4pvdBL1HwJH0r+dhWj7ld21VJSvCHqg==
X-Received: by 2002:a63:cc0b:: with SMTP id x11mr12615970pgf.35.1554747585315;
        Mon, 08 Apr 2019 11:19:45 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id v7sm42140108pgh.53.2019.04.08.11.19.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 11:19:44 -0700 (PDT)
Date:   Mon, 8 Apr 2019 11:19:39 -0700
From:   Benson Leung <bleung@google.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     lee.jones@linaro.org, gwendal@chromium.org, bleung@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, dtor@chromium.org,
        rushikesh.s.kadam@intel.com, Wei-Ning Huang <wnhuang@google.com>
Subject: Re: [PATCH v3 4/4] mfd: cros_ec: instantiate properly CrOS Touchpad
 MCU device
Message-ID: <20190408181939.GB18975@google.com>
References: <20190408094141.27858-1-enric.balletbo@collabora.com>
 <20190408094141.27858-5-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
In-Reply-To: <20190408094141.27858-5-enric.balletbo@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Enric,

On Mon, Apr 08, 2019 at 11:41:41AM +0200, Enric Balletbo i Serra wrote:
> Support Touchpad MCU as a special of CrOS EC devices. The current
> Touchpad MCU is used on Eve Chromebook and used the same protocol as
> other CrOS EC devices.
>=20
> When a MCU has touchpad support (aka EC_FEATURE_TOUCHPAD), it is
> instantiated as a special CrOS EC device with device name 'cros_tp'. So
> regardless of the probing order between the actual cros_ec and cros_tp,
> the userspace and other kernel drivers should not confuse them.
>=20
> Signed-off-by: Wei-Ning Huang <wnhuang@google.com>
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
> index 79746e817cdb..be827910e9d0 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -659,6 +659,16 @@ static int ec_device_probe(struct platform_device *p=
dev)
>  		ec_platform->ec_name =3D CROS_EC_DEV_ISH_NAME;
>  	}
> =20
> +	/* Check whether this is actually a Touchpad MCU rather than an EC */
> +	if (cros_ec_check_features(ec, EC_FEATURE_TOUCHPAD)) {
> +		dev_info(dev, "CrOS Touchpad MCU detected.\n");
> +		/*
> +		 * Help userspace differentiating ECs from TP MCU,
> +		 * regardless of the probing order.
> +		 */
> +		ec_platform->ec_name =3D CROS_EC_DEV_TP_NAME;
> +	}
> +
>  	/*
>  	 * Add the class device
>  	 * Link to the character device for creating the /dev entry
> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> index b393bd4e4b73..981381fbb3fd 100644
> --- a/include/linux/mfd/cros_ec.h
> +++ b/include/linux/mfd/cros_ec.h
> @@ -26,6 +26,7 @@
>  #define CROS_EC_DEV_FP_NAME	"cros_fp"
>  #define CROS_EC_DEV_ISH_NAME	"cros_ish"
>  #define CROS_EC_DEV_PD_NAME	"cros_pd"
> +#define CROS_EC_DEV_TP_NAME	"cros_tp"
> =20
>  /*
>   * The EC is unresponsive for a time after a reboot command.  Add a
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

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlyrkLsACgkQHwn1ewov
5ljdvhAAlj5zGvWQQ9/pM5i/g4G+3auz6or5wmQIlVQMen3My7Fzfi8lCvJ1WSkI
33sfQnz5JZFVxYjJzQsggy8PwP1pgA4HLvrX4fw3DVmaNN0Hy5y5LnOGGZkhHEgT
FtUe+dOND4NPYnAti4Di6LlCU+ibDgKEy+1jO9vsobGIGrZkLqv8xDI9tVuG0xSs
5EmWYWDm5XGdZFg1OKwYA0DxtmMMsnkO5IAmYVxLHfr92uLN4epHRaooJCfG3Qu+
koyOQToKBz2R7SdbdE3CXcwWMuVyLbIXiw09dtslH1Qhc6BILjOBWtWexXwsm1pc
Vq0JhNR5C9/cg5qFGFh2nT6YJBZ96aLJJrpwayD+GMiazQPCPngb4JN9zMzGPvII
yrnJLU1tePXlvv6AU5YbDEzjY8OA47+L9jpZJbo3RX1naxq8XNYb7J1w/iQb1w1F
NLUN+4mMA8Wl4lsG+yCOvBmO8f7qTp1ZQy56uXHQREGgTHveDRz4rRKDbRp9TD4m
YceJxje3SLmtRpF82pKbfJ0MvFLkT8M5OW+sBYs5rIE3RG3g3w2QEBnPuYYmLDR/
zIiZFcNiYTcVM44ySOpBoqFTeD+ZOSXMh8KtW0aXb5zmp6qrL0V285mE02DBYFr3
hf4MnOJ+f94Yg3iobxHMd5WNnnU6S0Lo9OvSsLL/ZLhGDxGJ/WA=
=uevW
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
