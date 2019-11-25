Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC9BC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5502E20748
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+3KoedA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbfKYOIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:08:53 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41467 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbfKYOIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 09:08:53 -0500
Received: by mail-wr1-f67.google.com with SMTP id b18so18203717wrj.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 06:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iNWDGc0fQ00Ye1+fTt2khUxDXRk0OG4bs4g9Ax7i6qo=;
        b=P+3KoedA/0PLaVdbPw1oFWAjCaOhzr5tTq0ZarfinP2Ypvd8W1Nxi7yybCTNLi5zzA
         vW4Qd5Lesxsgi3vla0+/c9gXMFwU9ks3J0zwZTKZOpiMZBPVsVsvdeza/41sSSjHVTid
         o3qn/xkSM+yeggFbAkSOlPHSYl19wbGt/aCJACFgNb9d68eTSu+JpPlWYpCuAcYbL6hC
         wGeqB0EaIQMAW7hMrmKbB2KRm38Df5+aCcD8yBiMuGXvM8dhsqOmDtO4z/Jj8bBpf0e9
         9i1hPhpULNpC2+vFzYDo2u+TifKgWBC9qXsZ1D6xfbmS+/UrHzgWxxLV4/TuTHyE0XnP
         Dd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iNWDGc0fQ00Ye1+fTt2khUxDXRk0OG4bs4g9Ax7i6qo=;
        b=YsuEUw3YwW7fwyphKiVt8Hp4KOMY0BM/bExWcCwOsjOb7fnnCglVVWV/XMw37RMfWM
         BqRQd3LN2iQLspeS6nUm2L2AAxu6xq/JEj2j4wxB/dlRBhyXWyDX128B9s4jtBILH8iW
         db0IRyzrLy0nytsN23KcY1ydlvx/c7rJDFB3etK3CfRcgKzAZALnLo1lX9yp66tCpqsC
         3PDmIGDMSPI1h4XGLHqBYscYuDtar2bJjYWOzYqN1AnTEsSVviN39Nyubcw3x5xHcSjW
         GIRLiaF6UIklV/plZmrYo6TE4g7ZCKEmCPTHKZmhT7rBCFQbqIXv3W+WNlKdeXcKjoZe
         t6MQ==
X-Gm-Message-State: APjAAAWa/3mumTZUVpP28J4mxuYvtvOFS9xiqWcFWPc43rYsQd/Nl7vZ
        Ov8EvlGxr8P9vvxSaCfXvzKfdUsr+mLR/opXees/Cw==
X-Google-Smtp-Source: APXvYqz1pQJymB1hAXfiA1XYcDD52P69YAb4gkZr7unmgvJbz4fYyaF1bNGVq89E29zTD9J5VL7DdxhiDF3l53RQSvQ=
X-Received: by 2002:adf:9d87:: with SMTP id p7mr12042861wre.11.1574690930146;
 Mon, 25 Nov 2019 06:08:50 -0800 (PST)
MIME-Version: 1.0
References: <20191121132930.29544-1-krzk@kernel.org> <CY4PR12MB1813D2AE8B11E5F190581995F74E0@CY4PR12MB1813.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1813D2AE8B11E5F190581995F74E0@CY4PR12MB1813.namprd12.prod.outlook.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 25 Nov 2019 09:08:37 -0500
Message-ID: <CADnq5_MFfCfsUiJ-jjZa-rMf1PDJ7v6jPzCXN9ZnCZEvSsU1-w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Fix Kconfig indentation
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Nov 21, 2019 at 11:13 AM Deucher, Alexander
<Alexander.Deucher@amd.com> wrote:
>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ________________________________
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: Thursday, November 21, 2019 8:29 AM
> To: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>; Deucher, Alexander <Alexander.=
Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zhou, David=
(ChunMing) <David1.Zhou@amd.com>; David Airlie <airlied@linux.ie>; Daniel V=
etter <daniel@ffwll.ch>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freed=
esktop.org>; dri-devel@lists.freedesktop.org <dri-devel@lists.freedesktop.o=
rg>
> Subject: [PATCH] drm/amd: Fix Kconfig indentation
>
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
>         $ sed -e 's/^        /\t/' -i */Kconfig
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/gpu/drm/amd/acp/Kconfig | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/acp/Kconfig b/drivers/gpu/drm/amd/acp/Kc=
onfig
> index d968c2471412..19bae9100da4 100644
> --- a/drivers/gpu/drm/amd/acp/Kconfig
> +++ b/drivers/gpu/drm/amd/acp/Kconfig
> @@ -2,11 +2,11 @@
>  menu "ACP (Audio CoProcessor) Configuration"
>
>  config DRM_AMD_ACP
> -       bool "Enable AMD Audio CoProcessor IP support"
> -       depends on DRM_AMDGPU
> -       select MFD_CORE
> -       select PM_GENERIC_DOMAINS if PM
> -       help
> +       bool "Enable AMD Audio CoProcessor IP support"
> +       depends on DRM_AMDGPU
> +       select MFD_CORE
> +       select PM_GENERIC_DOMAINS if PM
> +       help
>          Choose this option to enable ACP IP support for AMD SOCs.
>          This adds the ACP (Audio CoProcessor) IP driver and wires
>          it up into the amdgpu driver.  The ACP block provides the DMA
> --
> 2.17.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
