Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744B1C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 13:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC3822525
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 13:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qRip7lOe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbfLENjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 08:39:18 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:46447 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729423AbfLENjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 08:39:17 -0500
Received: by mail-qv1-f67.google.com with SMTP id t9so1250409qvh.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 05:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XaigWdmI5xq4FMs2av8bkHyApZcxhq6LpPhTp6nGvME=;
        b=qRip7lOe3VRoTQ5FrwB0ZAGTGfT3s2hC9Kwn8x+da+8QHekxs2p6zJb0qerM0C4XoI
         YmTncNTrmx7HvHtgXwNUc3OilnVyEfxeX0Au0SeOoviDgNU5Y4GC87adAO/cfKzDbqha
         Et96WB1sz1po9iR1PfmTnngi1xE9kQx9fPRfJckNu6V5vGfWRCie3uyxbSo6vS0Ok4QB
         jY64W1kePPIAcZTE3niVcJCwUvMqTu7gwU3If3Gigb+W2UTUpFQG4neCCOclNjUBFanB
         PamNmjH/VH6PEg5ni+Xxb+Dgjk2PmQsbOJ5Z3AADJacmAHvRA1sWpv1YYkvCZZkRBm/c
         5OkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XaigWdmI5xq4FMs2av8bkHyApZcxhq6LpPhTp6nGvME=;
        b=UL4CtP7Q/yQRtGCvCg314VpKDlxATa+0KEtAs0Iuy9zink0zEuhbip4K7Pt+VsuKsi
         P2LU5hAcnaWnfxUT6LzzZUQBuz2sZ7Q8yG0qaBUZBNktZAm5PcZdwQMlIus55qcYJwJF
         dMc2eOK6rE4GK52jzZ9kL7jnd0GALHgLI/CmFXWzMomG12sWyck+V9qRtE5+CsM58ZsI
         bvUuERE9hALfNgcUp3gPhiwsB6rAF4eDATTp4BHVFcDm2M58QmGfW7kivpesG03NhdeN
         urWkje17+MWk/fy7t0Qo8pNfwe8Ae48S0UMY74o21UEe59/T1/TBChFuU+EY0xHWphTI
         hT7g==
X-Gm-Message-State: APjAAAVLSwRtpSi8SmWQaXeTigS8bLPYdAhMCIC6XUIGSR4ePCN/CpRJ
        Q2Zo20R1r2pKA0pkReYuW8B8ZPIQU15JoZkyz3gU9g==
X-Google-Smtp-Source: APXvYqxuFQ5+PLjy6NSb4LHSuBJR8bKMcu7Z5ND+z/oh/bYLknG6yt36p5znDqIpMcXkfF2pvyP+tGo0cWrrwjtH9N4=
X-Received: by 2002:a05:6214:245:: with SMTP id k5mr7437942qvt.182.1575553156646;
 Thu, 05 Dec 2019 05:39:16 -0800 (PST)
MIME-Version: 1.0
References: <20191204114732.28514-1-mihail.atanassov@arm.com> <20191204114732.28514-28-mihail.atanassov@arm.com>
In-Reply-To: <20191204114732.28514-28-mihail.atanassov@arm.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Thu, 5 Dec 2019 14:39:05 +0100
Message-ID: <CA+M3ks74aJH1EComQ24i6NeDftGHg-LPZ9VH7vje4W=a13-yDw@mail.gmail.com>
Subject: Re: [PATCH v2 27/28] drm/sti: Use drm_bridge_init()
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>, Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer. 4 d=C3=A9c. 2019 =C3=A0 12:48, Mihail Atanassov
<Mihail.Atanassov@arm.com> a =C3=A9crit :
>
> No functional change.
>
> v2:
>  - Also apply drm_bridge_init() in sti_hdmi.c and sti_hda.c (Sam,
>    Benjamin)
>
> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>

Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

> ---
>  drivers/gpu/drm/sti/sti_dvo.c  | 4 +---
>  drivers/gpu/drm/sti/sti_hda.c  | 3 +--
>  drivers/gpu/drm/sti/sti_hdmi.c | 3 +--
>  3 files changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/sti/sti_dvo.c b/drivers/gpu/drm/sti/sti_dvo.=
c
> index 68289b0b063a..20a3956b33bc 100644
> --- a/drivers/gpu/drm/sti/sti_dvo.c
> +++ b/drivers/gpu/drm/sti/sti_dvo.c
> @@ -462,9 +462,7 @@ static int sti_dvo_bind(struct device *dev, struct de=
vice *master, void *data)
>         if (!bridge)
>                 return -ENOMEM;
>
> -       bridge->driver_private =3D dvo;
> -       bridge->funcs =3D &sti_dvo_bridge_funcs;
> -       bridge->of_node =3D dvo->dev.of_node;
> +       drm_bridge_init(bridge, &dvo->dev, &sti_dvo_bridge_funcs, NULL, d=
vo);
>         drm_bridge_add(bridge);
>
>         err =3D drm_bridge_attach(encoder, bridge, NULL);
> diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.=
c
> index 8f7bf33815fd..c7296e354a34 100644
> --- a/drivers/gpu/drm/sti/sti_hda.c
> +++ b/drivers/gpu/drm/sti/sti_hda.c
> @@ -699,8 +699,7 @@ static int sti_hda_bind(struct device *dev, struct de=
vice *master, void *data)
>         if (!bridge)
>                 return -ENOMEM;
>
> -       bridge->driver_private =3D hda;
> -       bridge->funcs =3D &sti_hda_bridge_funcs;
> +       drm_bridge_init(bridge, dev, &sti_hda_bridge_funcs, NULL, hda);
>         drm_bridge_attach(encoder, bridge, NULL);
>
>         connector->encoder =3D encoder;
> diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdm=
i.c
> index 814560ead4e1..c9ae3e18fa5d 100644
> --- a/drivers/gpu/drm/sti/sti_hdmi.c
> +++ b/drivers/gpu/drm/sti/sti_hdmi.c
> @@ -1279,8 +1279,7 @@ static int sti_hdmi_bind(struct device *dev, struct=
 device *master, void *data)
>         if (!bridge)
>                 return -EINVAL;
>
> -       bridge->driver_private =3D hdmi;
> -       bridge->funcs =3D &sti_hdmi_bridge_funcs;
> +       drm_bridge_init(bridge, dev, &sti_hdmi_bridge_funcs, NULL, hdmi);
>         drm_bridge_attach(encoder, bridge, NULL);
>
>         connector->encoder =3D encoder;
> --
> 2.23.0
>
