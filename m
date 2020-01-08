Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A579FC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A718206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkoOEJ8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgAHIed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 03:34:33 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39026 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgAHIed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 03:34:33 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so2389303wrt.6;
        Wed, 08 Jan 2020 00:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jX0Klzp5UaveyVN/+/3AvXAeXp0+CqqhMniHJ22g+l0=;
        b=GkoOEJ8bEHGnPv0NL6Y/sFC5J5aWA9ICcbWhT/u2oQdKtCysCXfgA4ZLFed+V2nYBw
         g5mVHahI2a4wlIf0qQjtjieTacqQ1y5oSOTZ3oX5wloVWg3fvCdKrdFtYfywIzUTqSv3
         vsUu1nsBXQkOh3Fx/uhhfakNFbrmFQZgoyQN5h4gWv56tYTVpXfVEaDCK732R86DDvQQ
         /SKUbNTVuGtLSFFYrerjBZqGCkT+Wsn0OesYNduyjuopL9MhspyUPo3Ees+pMpsT7N9Q
         rLFEB0gAb1XBVIzOwvtN/Beo8ciLf0/o1YlnalthH/XKIRlxfbwsXG1I95fqvoR8FjNC
         rG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jX0Klzp5UaveyVN/+/3AvXAeXp0+CqqhMniHJ22g+l0=;
        b=sVLhJnzkVqPpVc4v555F2iDGT/TlaxB19AJhayb+0zeMWx0bMYXcfOIcLSNFLwU20U
         kq7GRaJAf2YDLVG2M2a/jPxNPTpODM8keUwBN215u9SnpYDBfQKJTNV4INILbE5R39fV
         +rDVzJEmEScPNmcmTu6OjvrPXQHtIpe8DxgwP4gOU0KyI/7GwqN9kPAy8LXmaO/NeBey
         s85mtpnuObH2udWc93KJk+wIvFmUfG9lwDvok1ysXWZRSBLPwhXgxfWUFdrI2tM5ymhY
         a+dIkP6mm+ogADmSRJztR/D8jEe8VCfOTFWLepaHuTOJDCwqvHFKAgZoK7qvkRpyW63L
         U9YQ==
X-Gm-Message-State: APjAAAW844rG3GzLq+8dXzv1UeIGC3sUuDizIImtNYFADU5AVAIs94+K
        /8Yd/6TuWTK6i+L1SqldmNHQr7foCwA2MLzYlxw=
X-Google-Smtp-Source: APXvYqxmcnRfZZ9RiVnC0PwvEAlnT5+dkD7rgkP0AyD649GpBjET5MasrA7qwnY8xO6DJ2IRjkuiJPC5YTLBpU0tfqE=
X-Received: by 2002:a5d:50ce:: with SMTP id f14mr3116204wrt.254.1578472470690;
 Wed, 08 Jan 2020 00:34:30 -0800 (PST)
MIME-Version: 1.0
References: <1578457515-3477-1-git-send-email-skomatineni@nvidia.com> <1578457515-3477-6-git-send-email-skomatineni@nvidia.com>
In-Reply-To: <1578457515-3477-6-git-send-email-skomatineni@nvidia.com>
From:   Nicolas Chauvet <kwizart@gmail.com>
Date:   Wed, 8 Jan 2020 09:34:19 +0100
Message-ID: <CABr+WT=qP1BJUfzgmr4AzN18Zp-trMEStF6SQ+AH7+aYBUuUww@mail.gmail.com>
Subject: Re: [PATCH v7 05/21] clk: tegra: Fix Tegra PMC clock out parents
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        digetx@gmail.com, mperttunen@nvidia.com,
        gregkh@linuxfoundation.org, sboyd@kernel.org,
        Rob Herring <robh+dt@kernel.org>, mark.rutland@arm.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, spujar@nvidia.com,
        josephl@nvidia.com, daniel.lezcano@linaro.org,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        markz@nvidia.com, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer. 8 janv. 2020 =C3=A0 05:27, Sowjanya Komatineni
<skomatineni@nvidia.com> a =C3=A9crit :
>
> Tegra PMC clock out parents are osc, osc_div2, osc_div4 and extern
> clock.
>
> Clock driver is using incorrect parents clk_m, clk_m_div2, clk_m_div4
> for PMC clocks.
>
> This patch fixes this.
>
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/clk/tegra/clk-tegra-pmc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/clk/tegra/clk-tegra-pmc.c b/drivers/clk/tegra/clk-te=
gra-pmc.c
> index bec3e008335f..5e044ba1ae36 100644
> --- a/drivers/clk/tegra/clk-tegra-pmc.c
> +++ b/drivers/clk/tegra/clk-tegra-pmc.c
> @@ -49,16 +49,16 @@ struct pmc_clk_init_data {
>
>  static DEFINE_SPINLOCK(clk_out_lock);
>
> -static const char *clk_out1_parents[] =3D { "clk_m", "clk_m_div2",
> -       "clk_m_div4", "extern1",
> +static const char *clk_out1_parents[] =3D { "osc", "osc_div2",
> +       "osc_div4", "extern1",
>  };
>
> -static const char *clk_out2_parents[] =3D { "clk_m", "clk_m_div2",
> -       "clk_m_div4", "extern2",
> +static const char *clk_out2_parents[] =3D { "osc", "osc_div2",
> +       "osc_div4", "extern2",
>  };
>
> -static const char *clk_out3_parents[] =3D { "clk_m", "clk_m_div2",
> -       "clk_m_div4", "extern3",
> +static const char *clk_out3_parents[] =3D { "osc", "osc_div2",
> +       "osc_div4", "extern3",
>  };
>
>  static struct pmc_clk_init_data pmc_clks[] =3D {
> --
> 2.7.4

Out of curiosity, this patch touch the clk-tegra-pmc.c file which is
later removed (by patch 11).
Is this change made for bugfix ? Is there a stable tag missing ?

--=20
-

Nicolas (kwizart)
