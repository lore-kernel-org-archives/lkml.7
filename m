Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE361C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 22:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9724B20840
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 22:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="CZN+V5K4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfCAWmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 17:42:44 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:34154 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfCAWmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 17:42:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1551480162; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2mWCqCu6FkQ1M8VZvzI8zeyLlnHvUojcmAp519wTHpU=;
        b=CZN+V5K4a00QxAjd/Dt4yH2FKWzpBsuTDEsjadKJDHJWU1H/ih2snyDS2lnqrviu+2syZz
        tvn1rEqxQGZtRDhb2nUW//Z1j5GgRlWCXt0WBkZ4tJFOf6aglY/3Xo8hD2q4bGG4N/uZxC
        XGsqRuT8lC6V/ptNNZMfdhI3hFXej+g=
Date:   Fri, 01 Mar 2019 19:42:33 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/2] drm/panel: simple: Add Sharp LS020B1DD01D panel
 support
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Message-Id: <1551480153.1526.1@crapouillou.net>
In-Reply-To: <20190301222439.GA30998@ravnborg.org>
References: <20190228185854.11824-1-paul@crapouillou.net>
        <20190301222439.GA30998@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le ven. 1 mars 2019 =E0 19:24, Sam Ravnborg <sam@ravnborg.org> a =E9crit :
> Hi Paul.
>=20
> On Thu, Feb 28, 2019 at 03:58:52PM -0300, Paul Cercueil wrote:
>>  The Sharp LS020B1DD01D is a simple 2.0" 240x160 16-bit TFT panel.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  Tested-by: Artur Rojek <contact@artur-rojek.eu>
>>  ---
>>   drivers/gpu/drm/panel/panel-simple.c | 28=20
>> ++++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>=20
>>  diff --git a/drivers/gpu/drm/panel/panel-simple.c=20
>> b/drivers/gpu/drm/panel/panel-simple.c
>>  index 9e8218f6a3f2..3ab604f5477e 100644
>>  --- a/drivers/gpu/drm/panel/panel-simple.c
>>  +++ b/drivers/gpu/drm/panel/panel-simple.c
>>  @@ -2278,6 +2278,31 @@ static const struct panel_desc=20
>> sharp_lq150x1lg11 =3D {
>>   	.bus_format =3D MEDIA_BUS_FMT_RGB565_1X16,
>>   };
>>=20
>>  +static const struct display_timing sharp_ls020b1dd01d_timing =3D {
>>  +	.pixelclock =3D { 2000000, 4200000, 5000000 },
>>  +	.hactive =3D { 240, 240, 240 },
>>  +	.hfront_porch =3D { 66, 66, 66 },
>>  +	.hback_porch =3D { 1, 1, 1 },
>>  +	.hsync_len =3D { 1, 1, 1 },
>>  +	.vactive =3D { 160, 160, 160 },
>>  +	.vfront_porch =3D { 52, 52, 52 },
>>  +	.vback_porch =3D { 6, 6, 6 },
>>  +	.vsync_len =3D { 10, 10, 10 },
>>  +	.flags =3D DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_LOW,
>>  +};
>>  +
>>  +static const struct panel_desc sharp_ls020b1dd01d =3D {
>>  +	.timings =3D &sharp_ls020b1dd01d_timing,
>>  +	.num_timings =3D 1,
>>  +	.bpc =3D 6,
>>  +	.size =3D {
>>  +		.width =3D 42,
>>  +		.height =3D 28,
>>  +	},
>>  +	.bus_format =3D MEDIA_BUS_FMT_RGB565_1X16,
>>  +	.bus_flags =3D DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_NEGEDGE,
>>  +};
>>  +
>>   static const struct drm_display_mode shelly_sca07010_bfn_lnn_mode=20
>> =3D {
>>   	.clock =3D 33300,
>>   	.hdisplay =3D 800,
>>  @@ -2767,6 +2792,9 @@ static const struct of_device_id=20
>> platform_of_match[] =3D {
>>   		.compatible =3D "sharp,lq150x1lg11",
>>   		.data =3D &sharp_lq150x1lg11,
>>   	}, {
>>  +		.compatible =3D "sharp,ls020b1dd01d",
>>  +		.data =3D &sharp_ls020b1dd01d,
>>  +	}, {
> For all three patches I am missing dt-bindings documentation.

Yes, I looked at=20
Documentation/devicetree/bindings/display/panel/simple-panel.txt,
and saw that it was never documented with new compatible strings, so I=20
thought
that for this driver it wasn't needed. I didn't see the other files.=20
I'll add
the dt-bindings doc in V2.

> also for all three patches you get a "+1" for adding all of
> .flags, .bus_format, .bus_flags.
>=20
> 	Sam

Thanks,
-Paul
=

