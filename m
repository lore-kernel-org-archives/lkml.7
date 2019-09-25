Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A9BC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 14:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 398C821D7C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 14:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="lazSvqe+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408128AbfIYOuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 10:50:32 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:50252 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfIYOuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 10:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1569423030; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZDBS8kzsJvkPXNA7E89mme3Edh+YPdmEM5FwJycTpEo=;
        b=lazSvqe+/UcqO20OmSwiSPUafrOafmGhAjFhLu4g0o10d9MQ2m7nnZG04er+DtGS71YLKt
        7bdANLZHL3Dr2qWisn7gqrm7wQy3Uk535r/HvbQZeN5mMZR/hMz0Tqeyc8hCRMTZ4a1WWC
        pKKvARrAkPtAVzvYkh7BR+AyhTlqY9E=
Date:   Wed, 25 Sep 2019 16:50:25 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 29/36] drm/ingenic: use bpp instead of cpp for
 drm_format_info
To:     Sandy Huang <hjc@rock-chips.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Message-Id: <1569423025.1909.1@crapouillou.net>
In-Reply-To: <1569243189-183445-4-git-send-email-hjc@rock-chips.com>
References: <1569243189-183445-1-git-send-email-hjc@rock-chips.com>
        <1569243189-183445-4-git-send-email-hjc@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sandy,


Le lun. 23 sept. 2019 =E0 14:53, Sandy Huang <hjc@rock-chips.com> a=20
=E9crit :
> cpp[BytePerPlane] can't describe the 10bit data format correctly,
> So we use bpp[BitPerPlane] to instead cpp.
>=20
> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> ---
>  drivers/gpu/drm/ingenic/ingenic-drm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c=20
> b/drivers/gpu/drm/ingenic/ingenic-drm.c
> index ec32e1c..70ccec5 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
> @@ -375,7 +375,7 @@ static void=20
> ingenic_drm_plane_atomic_update(struct drm_plane *plane,
>=20
>  	width =3D state->crtc->state->adjusted_mode.hdisplay;
>  	height =3D state->crtc->state->adjusted_mode.vdisplay;
> -	cpp =3D state->fb->format->cpp[plane->index];
> +	cpp =3D state->fb->format->bpp[plane->index] / 8;

That wouldn't work with 15-bit rgb555...


>=20
>  	priv->dma_hwdesc->addr =3D drm_fb_cma_get_gem_addr(state->fb, state,=20
> 0);
>  	priv->dma_hwdesc->cmd =3D width * height * cpp / 4;
> --
> 2.7.4
>=20
>=20
>=20

=

