Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33C3C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02952077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="RXtm8B0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfDZUeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 16:34:14 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33136 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfDZUeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 16:34:14 -0400
Received: by mail-qt1-f193.google.com with SMTP id g7so5672114qtc.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 13:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=vNqrtosD3Wa6mctcoU8eA66v5qv1B2uC9ZjPAJ2B54s=;
        b=RXtm8B0ifFFnWr6lyY1EPadQ14vZX00kRBy81EQXlhPLJ7Rg2Hb5aUA299MY/6eQrR
         RXFxdk7hx5sEtoeR246Le6tsSKsUpQbn/gOSNS+Ff9x2P9yu+HF3FJqkEWuVMAD3DsT5
         0EU6MKOjSpTwF/fzl2cpLEtBrekwQ7ktXPhlMrRv70q1i0JUbIoBW2kmh+kzA0+IfqRE
         n36cArn74CTC1qEP6Ip4gNJKKRoL25n8GDtQVJaeQPhszADdazNmkK464YRvNY7LjWYA
         IylPWLjtVXj4WWmKmXJYqg/CkuqNBaSDJJxRdjrT1cnrlFlHr3pP7GOHdEET0XXK8/ks
         etOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=vNqrtosD3Wa6mctcoU8eA66v5qv1B2uC9ZjPAJ2B54s=;
        b=BSR/NmXTXy8Hz+IDhInJCDM2+SnC48n7HmfXvbB5JmXw7mFePOuyFh2gtqYTAp0hOb
         6NxHtWBj32E0Aj22RIZdA27Mgcs5aVuR9/Q6HMnhvDRONtA7epQxNrLk2oNhpcoXfv+C
         0ESjfwYm/gIaeONXbkwTl9/F0ATQdxxgCp4J4n7FfjkqKyPHpHayMgBFFWxKogiEi6MF
         u921UgLwjKSXaaTP6DhXbvWbIjOF5zSr5reNWjcWcAOv5+SzpN4y4zQcMlocwySQ9Rnh
         20gGyli/jo7I5nzH/SRnTPTSvLTyHDXgIIzDI+hc9CaTcm6DgKINQJaeqDdgiXjs93uO
         RTRQ==
X-Gm-Message-State: APjAAAUVV43TdOjInmiyVV+ApKtY4aobthFOEDnK9Mgymg9MCiX+XfUC
        S6/GLVAX3O4/N7duTCiodXDCYA==
X-Google-Smtp-Source: APXvYqzsmvR+kc1cn4LW8OWb4wsz4KVln3yvZyHdNLJX35ZDFfQySitj8lczXefdpbsKwuBNb+upCg==
X-Received: by 2002:ad4:4102:: with SMTP id i2mr4292931qvp.218.1556310853452;
        Fri, 26 Apr 2019 13:34:13 -0700 (PDT)
Received: from tpx230-nicolas.collaboramtl (modemcable154.55-37-24.static.videotron.ca. [24.37.55.154])
        by smtp.gmail.com with ESMTPSA id n66sm9689693qkf.49.2019.04.26.13.34.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 13:34:11 -0700 (PDT)
Message-ID: <2367b550d815bdf4c50aae692a5549f9be6a0802.camel@ndufresne.ca>
Subject: Re: [PATCH v6 01/17] media: videodev2.h, v4l2-ioctl: add rkisp1
 meta buffer format
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Jacob Chen <jacob-chen@iotwrt.com>,
        linux-rockchip@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        sakari.ailus@linux.intel.com, hans.verkuil@cisco.com,
        tfiga@chromium.org, zhengsq@rock-chips.com,
        laurent.pinchart@ideasonboard.com, zyc@rock-chips.com,
        eddie.cai.linux@gmail.com, jeffy.chen@rock-chips.com,
        devicetree@vger.kernel.org, heiko@sntech.de,
        Jacob Chen <jacob2.chen@rock-chips.com>
Date:   Fri, 26 Apr 2019 16:34:10 -0400
In-Reply-To: <20180308094807.9443-2-jacob-chen@iotwrt.com>
References: <20180308094807.9443-1-jacob-chen@iotwrt.com>
         <20180308094807.9443-2-jacob-chen@iotwrt.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-mOui5ucgkVhFyJMZ5z0C"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mOui5ucgkVhFyJMZ5z0C
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeudi 08 mars 2018 =C3=A0 17:47 +0800, Jacob Chen a =C3=A9crit :
> From: Shunqian Zheng <zhengsq@rock-chips.com>
>=20
> Add the Rockchip ISP1 specific processing parameter format
> V4L2_META_FMT_RK_ISP1_PARAMS and metadata format
> V4L2_META_FMT_RK_ISP1_STAT_3A for 3A.
>=20
> Signed-off-by: Shunqian Zheng <zhengsq@rock-chips.com>
> Signed-off-by: Jacob Chen <jacob2.chen@rock-chips.com>
> Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
> ---
>  drivers/media/v4l2-core/v4l2-ioctl.c | 2 ++
>  include/uapi/linux/videodev2.h       | 4 ++++
>  2 files changed, 6 insertions(+)
>=20
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-co=
re/v4l2-ioctl.c
> index 1be54429d601..bdd469290d66 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1257,6 +1257,8 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *f=
mt)
>  	case V4L2_META_FMT_VSP1_HGO:	descr =3D "R-Car VSP1 1-D Histogram"; brea=
k;
>  	case V4L2_META_FMT_VSP1_HGT:	descr =3D "R-Car VSP1 2-D Histogram"; brea=
k;
>  	case V4L2_META_FMT_UVC:		descr =3D "UVC payload header metadata"; break=
;
> +	case V4L2_META_FMT_RK_ISP1_PARAMS:	descr =3D "Rockchip ISP1 3A params";=
 break;
> +	case V4L2_META_FMT_RK_ISP1_STAT_3A:	descr =3D "Rockchip ISP1 3A statist=
ics"; break;
> =20
>  	default:
>  		/* Compressed formats */
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev=
2.h
> index e20d10df75c1..359ad8bbf9bf 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -698,6 +698,10 @@ struct v4l2_pix_format {
>  #define V4L2_META_FMT_VSP1_HGT    v4l2_fourcc('V', 'S', 'P', 'T') /* R-C=
ar VSP1 2-D Histogram */
>  #define V4L2_META_FMT_UVC         v4l2_fourcc('U', 'V', 'C', 'H') /* UVC=
 Payload Header metadata */
> =20
> +/* Vendor specific - used for IPU3 camera sub-system */

Did you mean "RK_ISP1 camera sub-system" ?

> +#define V4L2_META_FMT_RK_ISP1_PARAMS	v4l2_fourcc('R', 'K', '1', 'P') /* =
Rockchip ISP1 params */
> +#define V4L2_META_FMT_RK_ISP1_STAT_3A	v4l2_fourcc('R', 'K', '1', 'S') /*=
 Rockchip ISP1 3A statistics */
> +
>  /* priv field value to indicates that subsequent fields are valid. */
>  #define V4L2_PIX_FMT_PRIV_MAGIC		0xfeedcafe
> =20

--=-mOui5ucgkVhFyJMZ5z0C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSScpfJiL+hb5vvd45xUwItrAaoHAUCXMNrQgAKCRBxUwItrAao
HMr/AKCH5EVntTk1jT5u0f41G/tqfeI+CwCgwiiFz0hcOaFAjBEJIqWm5+mUPpM=
=9X8/
-----END PGP SIGNATURE-----

--=-mOui5ucgkVhFyJMZ5z0C--

