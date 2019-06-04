Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2066DC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E891A2075B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="csCwSCTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfFDR4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 13:56:02 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46596 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfFDR4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 13:56:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id v9so10766424pgr.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 10:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SkUGowD8pcrm5ZeRTq7g+Ql6VYOGyQboxYDXMoBJ/6w=;
        b=csCwSCTFhgjq6/rrV+fl7rSWult4aU94HN9Z4Zf3rVS3lrufUUSoILoCbw8c5KvGG8
         GpndpXYQG/gurNtQPbUkfgZUBdqkrVjZ05QxkLtO03r5lCR4DQQXzaIirGDAs5nuUAI0
         kNrTVGYKlFYPyTb6KcUOKq7H63z9fPsCcIComRX+4XdFpQ1MTjClvi9fmjNNGV/aY8cb
         g0YYLlxfrNlrQE/BkEKj8Nxz6qh1gzZmC9nFfBdlI3FSgFhJvvpmsfJTZeWvkAoqJTS0
         Ix0IoFv48zCXpVaLFng6pzM+YWq6RrUsRUiIZTQiOynXol/Ib28rnTpXVae5s3/poLzt
         fAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SkUGowD8pcrm5ZeRTq7g+Ql6VYOGyQboxYDXMoBJ/6w=;
        b=HgLT1qP5T33xMN9gjPZOlqu47ailKbLVitlT/B6HBXMmLHAw12ackmi0q+U8N8H1hK
         g+MYBpwlqdMsYWjTx5f7E6u0fNmNWe6OjL2es4TrUFGwjBRPfuj891i2O1naaRwmKRbh
         fLsSLHemQW64AccDJvNA8NCxWypf47sNnaVVfwV4tNUfuUTlbmPrxNIb8+CdG4a4wbe2
         ifxYvvoyL/JGE8TQMHw0fmGtS6Ao8O7jxTqf2UELpt7MpAn4yAH5LPasZDLrCnXBzubw
         vW6SZucJ2U95IfRLTrGY0tS97rx1MWSPMV8FUchze5tqaZUD3LCjoCncK8kzka7RR8rg
         7KnA==
X-Gm-Message-State: APjAAAVtYhwkCmdEZArle7Daauz02CJ1WiPeeZwV1cm/GkNvMCVwl7Wp
        6y6XeAzefiLBGIJKi70iRBzIxg==
X-Google-Smtp-Source: APXvYqx/i6OtxIvclujv6uWTuuQCBw7URIcOAy2RCMPHz80bcWVC/CYPfw2lr1HIsi8C99Xa0jcTmg==
X-Received: by 2002:a17:90a:e397:: with SMTP id b23mr11208695pjz.140.1559670959831;
        Tue, 04 Jun 2019 10:55:59 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id q17sm28782358pfq.74.2019.06.04.10.55.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 10:55:58 -0700 (PDT)
Date:   Tue, 4 Jun 2019 10:55:54 -0700
From:   Benson Leung <bleung@google.com>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        open list <linux-kernel@vger.kernel.org>, bleung@google.com
Subject: Re: [PATCH v9 6/7] mfd: cros_ec: differentiate SCP from EC by
 feature bit.
Message-ID: <20190604175554.GA241153@google.com>
References: <20190531073848.155444-1-pihsun@chromium.org>
 <20190531073848.155444-7-pihsun@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <20190531073848.155444-7-pihsun@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2019 at 03:38:47PM +0800, Pi-Hsun Shih wrote:
> System Companion Processor (SCP) is Cortex M4 co-processor on some
> MediaTek platform that can run EC-style firmware. Since a SCP and EC
> would both exist on a system, and use the cros_ec_dev driver, we need to
> differentiate between them for the userspace, or they would both be
> registered at /dev/cros_ec, causing a conflict.
>=20
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>

Reviewed-by: Benson Leung <bleung@chromium.org>

>=20
> ---
> Changes from v8:
>  - No change.
>=20
> Changes from v7:
>  - Address comments in v7.
>  - Rebase the series onto https://lore.kernel.org/patchwork/patch/1059196=
/.
>=20
> Changes from v6, v5, v4, v3, v2:
>  - No change.
>=20
> Changes from v1:
>  - New patch extracted from Patch 5.
> ---
>  drivers/mfd/cros_ec_dev.c            | 10 ++++++++++
>  include/linux/mfd/cros_ec.h          |  1 +
>  include/linux/mfd/cros_ec_commands.h |  2 +-
>  3 files changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index a5391f96eafd..66107de3dbce 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -440,6 +440,16 @@ static int ec_device_probe(struct platform_device *p=
dev)
>  		ec_platform->ec_name =3D CROS_EC_DEV_TP_NAME;
>  	}
> =20
> +	/* Check whether this is actually a SCP rather than an EC. */
> +	if (cros_ec_check_features(ec, EC_FEATURE_SCP)) {
> +		dev_info(dev, "CrOS SCP MCU detected.\n");
> +		/*
> +		 * Help userspace differentiating ECs from SCP,
> +		 * regardless of the probing order.
> +		 */
> +		ec_platform->ec_name =3D CROS_EC_DEV_SCP_NAME;
> +	}
> +
>  	/*
>  	 * Add the class device
>  	 * Link to the character device for creating the /dev entry
> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> index cfa78bb4990f..751cb3756d49 100644
> --- a/include/linux/mfd/cros_ec.h
> +++ b/include/linux/mfd/cros_ec.h
> @@ -27,6 +27,7 @@
>  #define CROS_EC_DEV_PD_NAME "cros_pd"
>  #define CROS_EC_DEV_TP_NAME "cros_tp"
>  #define CROS_EC_DEV_ISH_NAME "cros_ish"
> +#define CROS_EC_DEV_SCP_NAME "cros_scp"
> =20
>  /*
>   * The EC is unresponsive for a time after a reboot command.  Add a
> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cro=
s_ec_commands.h
> index dcec96f01879..8b578b4c1ec7 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -884,7 +884,7 @@ enum ec_feature_code {
>  	EC_FEATURE_REFINED_TABLET_MODE_HYSTERESIS =3D 37,
>  	/* EC supports audio codec. */
>  	EC_FEATURE_AUDIO_CODEC =3D 38,
> -	/* EC Supports SCP. */
> +	/* The MCU is a System Companion Processor (SCP). */
>  	EC_FEATURE_SCP =3D 39,
>  	/* The MCU is an Integrated Sensor Hub */
>  	EC_FEATURE_ISH =3D 40,
> --=20
> 2.22.0.rc1.257.g3120a18244-goog
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXPawpgAKCRBzbaomhzOw
wuqOAQDHxLsRGVUpvAnCU+3vLBuD0PoerXLvqdemtfBFLW5fQQD/Zbs9RPU1NU89
uPzq7qBeCa9QNogmpzsY4aL00BXumAg=
=5x65
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
