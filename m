Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC9EC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354B9216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QpvJLcej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbfG3JhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:37:22 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37323 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730463AbfG3JhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:37:21 -0400
Received: by mail-qt1-f195.google.com with SMTP id y26so62342063qto.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 02:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2U2XELV6OQ7Q7usKr+BHGIyWi1o0ek672exBpyDXgPY=;
        b=QpvJLcejliU1b0iPLW/IKiK4O69hLE2vF90QgluyUk6DICdEnd2LBG93PM8PQBe/Vk
         IUqJlxtWwvYS6WZsKTqg/9Ge+5pcXxFUg1km6E0b3S8W66BCGquRsQvlS/DP3gSus1ku
         +Vh3Q+k38UJrLoAL18uuzM7GXmbkJLsLGmS63JpreJEPeBBPAt4BzQCB4dxTkzGTFjD6
         TzTmvsb8iQgFP6sD1sZ5Fm3f9R+Y2gbMFITXkC4cR3X/Fs6DqgHVJU2ooOZZSJs2phL4
         YeF5bmaPtiucrDm1XtYAMbpiVY1V5ZX1Dxmcs8+C+WUEaD2NYAJaost81g4p1ZlJnkoR
         2UkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2U2XELV6OQ7Q7usKr+BHGIyWi1o0ek672exBpyDXgPY=;
        b=WPuGjh0Et5qrjlsC6cZhbScoRVkbUO/0mLljeLqmFs7DrOnuQtjs1wHGAxjjwIdNBy
         W3IBKG24ubTNaHxMd7KPlw+OTHnBAithXI39mIix0iWviBLFlxQKRPbd/d7XMfEpQa5h
         s+G9Nql1h5lOL1Wd/N6h9F5fyVHrDqImPBaQ9sJ1qEJCYYeROp7reMhWGePCtF/3vBB3
         RECf7DxiK5GhdUaCjZOdlcmW/s3e+mF9f9Rej+h4SZs6srUpK2ySG+WvUO+ZDZBdRaVy
         P+gQM5Ufbat1qF7NOy9SgtrQRO+ILOmo6GyRzGYBm5u2tzJk0bR7JJDtjpyOHRuBuiMG
         pdXg==
X-Gm-Message-State: APjAAAXANivJ6WeNmSFxVcgE7Ra2PLe6j6oviAFgeobsWQJWHspbaRy+
        FO7DHCHTTcXDxM34ISU37v0FCQhDkOJ3L5AMg0c5pQ==
X-Google-Smtp-Source: APXvYqw++xmk4Rm4JFPEbxhw5iuhrucLQNtXIKLxG9r03NlYXhGzckzRaIlD8ksq8xztS0T6so9iHAJ7x22JPWBQiLQ=
X-Received: by 2002:ac8:3364:: with SMTP id u33mr82742323qta.115.1564479439876;
 Tue, 30 Jul 2019 02:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190729222752.GA20277@embeddedor>
In-Reply-To: <20190729222752.GA20277@embeddedor>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Tue, 30 Jul 2019 11:37:09 +0200
Message-ID: <CA+M3ks6mxV4PTWWj_0AuLcwj-SPWi85-VwXHx7iBbuo=kCPggg@mail.gmail.com>
Subject: Re: [PATCH] drm: sti: Mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar. 30 juil. 2019 =C3=A0 00:27, Gustavo A. R. Silva
<gustavo@embeddedor.com> a =C3=A9crit :
>
> Mark switch cases where we are expecting to fall through.
>
> This patch fixes the following warning (Building: arm):
>
> drivers/gpu/drm/sti/sti_hdmi.c: In function =E2=80=98hdmi_audio_configure=
=E2=80=99:
> drivers/gpu/drm/sti/sti_hdmi.c:851:13: warning: this statement may fall t=
hrough [-Wimplicit-fallthrough=3D]
>    audio_cfg |=3D HDMI_AUD_CFG_CH78_VALID;
> drivers/gpu/drm/sti/sti_hdmi.c:852:2: note: here
>   case 6:
>   ^~~~
> drivers/gpu/drm/sti/sti_hdmi.c:853:13: warning: this statement may fall t=
hrough [-Wimplicit-fallthrough=3D]
>    audio_cfg |=3D HDMI_AUD_CFG_CH56_VALID;
> drivers/gpu/drm/sti/sti_hdmi.c:854:2: note: here
>   case 4:
>   ^~~~
> drivers/gpu/drm/sti/sti_hdmi.c:855:13: warning: this statement may fall t=
hrough [-Wimplicit-fallthrough=3D]
>    audio_cfg |=3D HDMI_AUD_CFG_CH34_VALID | HDMI_AUD_CFG_8CH;
> drivers/gpu/drm/sti/sti_hdmi.c:856:2: note: here
>   case 2:
>   ^~~~
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied on drm-misc-next,

Thanks,

Benjamin

> ---
>  drivers/gpu/drm/sti/sti_hdmi.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdm=
i.c
> index f03d617edc4c..1617c5098a50 100644
> --- a/drivers/gpu/drm/sti/sti_hdmi.c
> +++ b/drivers/gpu/drm/sti/sti_hdmi.c
> @@ -849,10 +849,13 @@ static int hdmi_audio_configure(struct sti_hdmi *hd=
mi)
>         switch (info->channels) {
>         case 8:
>                 audio_cfg |=3D HDMI_AUD_CFG_CH78_VALID;
> +               /* fall through */
>         case 6:
>                 audio_cfg |=3D HDMI_AUD_CFG_CH56_VALID;
> +               /* fall through */
>         case 4:
>                 audio_cfg |=3D HDMI_AUD_CFG_CH34_VALID | HDMI_AUD_CFG_8CH=
;
> +               /* fall through */
>         case 2:
>                 audio_cfg |=3D HDMI_AUD_CFG_CH12_VALID;
>                 break;
> --
> 2.22.0
>
