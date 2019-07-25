Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8E6C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80C5218DA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jfhn1IH6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388353AbfGYKGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 06:06:01 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45608 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387953AbfGYKGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:06:00 -0400
Received: by mail-qt1-f195.google.com with SMTP id x22so43543001qtp.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 03:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dY1dpg/OHfGT/mutmAs25ca6whmcjcdibSv9ZWjkmsM=;
        b=Jfhn1IH6hkL03mon/JSCxCgfxtUbbHpAWLvoKakLq9+OvKHCgOwv54x4UYs6F+oQMn
         pYkQIJEg75i+hHconcv4V1/srr2zzQ2gLAF18fBF3ME7Lvqc9OSkQogjIIcoEHtIYzD7
         NNOk23BB7KD8mkF2N8cBwWxrirrIwIZ3Q64/Qs4CiRdRhGrXqGztvhuRIsUjCcx7OsNh
         1K2hL6DNo+hoWiB/V+VadwE/INHTA+S7S2oEyb+FW0F1AAaeEosEGU3YUvgpHt443Dvu
         NWKMDxuEbXYfUF6UQWng1gU1awRncLz4AvRJgscAlnEgrW9grqqxYPfBxrxKl2dxOCEc
         99bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dY1dpg/OHfGT/mutmAs25ca6whmcjcdibSv9ZWjkmsM=;
        b=cFp8B5lRkVJRmkTHG+WLlJncd/N95OSTmw+IgEQPXp1RKC2i0hoVj7g8DVkv2l9LG6
         6RzFVthTJHS4mNvApjZKyQQIiev24J4b80vin+K4s1alb4rTXxnIiL/OSdHY3nE96fBS
         j7xoP442suGAgkkgWGbjuacDqRzxYnSQOByFmeW1XctVUd9ujvQ2Itg/Rbxod/XGAg2k
         2qNcwE33+x7DRgjhPLZuOI67O7iihwIcWzZW9Q2YDAcgPn3IQR5zCHibOa/wRvOOqfaO
         rMCpsoOg9XfePYkVA6iulG3YPoJ8fwCXW2Gyfe29xIWbKFof0Jc6efZiLJv1DFhyoWwn
         8r+Q==
X-Gm-Message-State: APjAAAXilsjSGjiz0RG4w7Gjl4mnsB3/f0WoIuqU+kN+idLYgRnbjT30
        p0kHKsTUakMmInvnD+msZa1kDjypVfs1C+gnWTrOkQ==
X-Google-Smtp-Source: APXvYqyNGztGQcRtMMJsWvdYYDKXUmMJH8KY8KYoJe4UVpVBo8GDSkeBtSiY93R7Znfd5M96vEy07a17By30LwrGnqE=
X-Received: by 2002:aed:36c5:: with SMTP id f63mr62620869qtb.239.1564049160250;
 Thu, 25 Jul 2019 03:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <1563811560-29589-1-git-send-email-olivier.moysan@st.com> <1563811560-29589-3-git-send-email-olivier.moysan@st.com>
In-Reply-To: <1563811560-29589-3-git-send-email-olivier.moysan@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Thu, 25 Jul 2019 12:05:49 +0200
Message-ID: <CA+M3ks6aA2YpHG3Kb+JxxECvdWYkgOVabYqL4-QTUDYkM6N67Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: display: sii902x: Change audio mclk binding
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>, jernej.skrabec@siol.net,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Jyri Sarha <jsarha@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun. 22 juil. 2019 =C3=A0 18:06, Olivier Moysan <olivier.moysan@st.com> =
a =C3=A9crit :
>
> As stated in SiL9022/24 datasheet, master clock is not required for I2S.
> Make mclk property optional in DT bindings.
>
> Fixes: 3f18021f43a3 ("dt-bindings: display: sii902x: Add HDMI audio bindi=
ngs")
>
Applied on drm-misc-next.
Thanks,
Benjamin

> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> Reviewed-by: Jyri Sarha <jsarha@ti.com>
> Acked-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  Documentation/devicetree/bindings/display/bridge/sii902x.txt | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/sii902x.txt=
 b/Documentation/devicetree/bindings/display/bridge/sii902x.txt
> index 2df44b7d3821..6e14e087c0d0 100644
> --- a/Documentation/devicetree/bindings/display/bridge/sii902x.txt
> +++ b/Documentation/devicetree/bindings/display/bridge/sii902x.txt
> @@ -26,9 +26,8 @@ Optional properties:
>         - clocks: phandle and clock specifier for each clock listed in
>             the clock-names property
>         - clock-names: "mclk"
> -          Describes SII902x MCLK input. MCLK is used to produce
> -          HDMI audio CTS values. This property is required if
> -          "#sound-dai-cells"-property is present. This property follows
> +          Describes SII902x MCLK input. MCLK can be used to produce
> +          HDMI audio CTS values. This property follows
>            Documentation/devicetree/bindings/clock/clock-bindings.txt
>            consumer binding.
>
> --
> 2.7.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
