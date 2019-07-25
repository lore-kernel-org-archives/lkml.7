Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFED1C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910F2218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bZG05YAA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388082AbfGYKFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 06:05:44 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36278 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387953AbfGYKFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:05:44 -0400
Received: by mail-qk1-f194.google.com with SMTP id g18so35951183qkl.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 03:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7MqY5TdYDukrmEcvyvH1Gy2JxiZVpxAfuPKcTJpAIOc=;
        b=bZG05YAAVga3Lrh/0yIRiZu0OwBZ1sptqRJR8ItXyufWxbjZiVGIoqJ0QpP+TPerhF
         VS0hlrNFycUS3jM5WWtRoTESWbMzjpbMJgoMIj2JvhSvGV8FVTTpKMFtDJdX9DvdLpM6
         9DRwIIX/Qy19YhgVSoNRaga21XU0ELRRBHGN2XVRcrCVDHwsYoEyrRoa/m2wMLE0DfON
         diKx1f2P1O9zbznpnDIteD9wOHwQ/zzPS3GCxbbLKKO1EAKn3XcjR9ESC3eEnrRNBXfq
         D5x8VcJmwr7IFSNLpFwemFmEYv6f9thE4MW8BI/eQmHOwtYrPEkfgzCM7MUc4qpuJRo3
         GiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7MqY5TdYDukrmEcvyvH1Gy2JxiZVpxAfuPKcTJpAIOc=;
        b=J5nCR9lu7vKqraGvYhRvYba6Pe8A1JRvcj+fHPd7p8vWzy5qTob1MZXU+4Cgm+n9Wl
         sjz+NypZ6TOXeyoElTNvZ9b66nffbV9OoK2M0e0mDmm5qqMEdCVIuItHHS2ixq3DO/ou
         ligYsk6xx7Jg5VcbgV9k/lSG9y8AUdesNLXLIFwmfu3jxzah3qVSTvJSToXqFPFKXx+r
         4lzktp6ku28v+K/2WjpYtUSCgVbNVDb1zsVRr/qvoRQkFBV+81MGumVDCKd7Gb+KmXzn
         cPTXeHRwbQKWlvPiYWobgiKaz8NCRXiEo13qwHLEtAsEoyhXCZzaMY/pi+oYlH/L2z3o
         mieA==
X-Gm-Message-State: APjAAAUWv5LbW+0IUVTuJLC44UXW5FisaU7BrG9lFDs2ZhHKiZORlGnx
        5C69m9AMFycv17WSbR3zsuhS2Hp3dMBas5X/QOo15g==
X-Google-Smtp-Source: APXvYqyhCeRsfUMKnaFdLn3aJWF2r7C0su+s5w1UqLu1cTlcNydCdWit5JkkqefwAGH3hmKajOG/V6rCyDq9aRuGQfA=
X-Received: by 2002:a37:bcc7:: with SMTP id m190mr56245928qkf.433.1564049143158;
 Thu, 25 Jul 2019 03:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <1563811560-29589-1-git-send-email-olivier.moysan@st.com> <1563811560-29589-2-git-send-email-olivier.moysan@st.com>
In-Reply-To: <1563811560-29589-2-git-send-email-olivier.moysan@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Thu, 25 Jul 2019 12:05:32 +0200
Message-ID: <CA+M3ks5v7vF_mPBr4mkwsHidc-N4jfJDgqWWE7qRv0LDsYJ-pQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drm/bridge: sii902x: fix missing reference to mclk clock
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
> Add devm_clk_get call to retrieve reference to master clock.
>
> Fixes: ff5781634c41 ("drm/bridge: sii902x: Implement HDMI audio support")
>
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> Reviewed-by: Jyri Sarha <jsarha@ti.com>
> Acked-by: Andrzej Hajda <a.hajda@samsung.com

Applied on drm-misc-next.
Thanks,
Benjamin

> ---
>  drivers/gpu/drm/bridge/sii902x.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/si=
i902x.c
> index c2f97e5997a1..962931c20efe 100644
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c
> @@ -751,6 +751,7 @@ static int sii902x_audio_codec_init(struct sii902x *s=
ii902x,
>                 sii902x->audio.i2s_fifo_sequence[i] |=3D audio_fifo_id[i]=
 |
>                         i2s_lane_id[lanes[i]] | SII902X_TPI_I2S_FIFO_ENAB=
LE;
>
> +       sii902x->audio.mclk =3D devm_clk_get(dev, "mclk");
>         if (IS_ERR(sii902x->audio.mclk)) {
>                 dev_err(dev, "%s: No clock (audio mclk) found: %ld\n",
>                         __func__, PTR_ERR(sii902x->audio.mclk));
> --
> 2.7.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
