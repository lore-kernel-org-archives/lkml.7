Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E145C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 02:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB2EB206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 02:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d/Nb48N/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfCEC2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 21:28:24 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:36768 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfCEC2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 21:28:24 -0500
Received: by mail-ua1-f67.google.com with SMTP id e15so6384922uam.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 18:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UIWyhct37LyOQxu0IQt8kyN+SpTgfQ6o8Q0WTmiq/9w=;
        b=d/Nb48N/Wbp7zGMmme78jQROkw8Ja93UYxLKipUcUMqES5UfOJdQjzDVU1UMmbQbmN
         FzbtV97i4b19YnzmrwjtnMghXmfYk1QKynkwzijGOYmvAkHnNM1O6CXuCCKZu1ceQC2s
         zwsQEMpxDcqB2WIyIq53NknJcCFTlUtndBffs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UIWyhct37LyOQxu0IQt8kyN+SpTgfQ6o8Q0WTmiq/9w=;
        b=bYOgJvdgj1tR6OKoYB/1qR8uz79d8C3nIMjlGzLCAvy3PW3Ee6eQZh9f33kXYv9I5Y
         Yv0flOdt8469D+dACC1lTvZPkt5CnfcSWJ4qXkA2z76rGobiJWGNzawjN03jdx3TXiCU
         Tjs+H/MHWn0SkwqfS7Aw3FAJetCVHaFhvcL6Dlu7rm/AIWA2QpQ4cqEZ8CN8adLBxb2z
         jLoP/iEdHAELo13ReZxGBAMI19+M4h5fQ3Zb6BX2WyLojzkw9lWxsaGA/F6OivNgSTTv
         tABKhrdOn8XB+wHr7hRuBa84ECdER60N344Y5OuIdUR1qW18eqNEbH8kMWXyJYVBJ7HC
         1XeQ==
X-Gm-Message-State: APjAAAVfnbK9tkFHL2gmIjotqvY6PBQR/aWrZ38+da9vdY+N9lXxRu6I
        cfSIQfX8KgGrFswh4iHR8+5JPTN77yw/yGVte9Xe3w==
X-Google-Smtp-Source: APXvYqyTD31g4e/nMnoEqCps0/l4A6PGdQktKZgGDwGvMIHmsAFCB2mPd/sVlF0C1Ebk57KlGJz1xyZX9FtJB/e4eU8=
X-Received: by 2002:a9f:2bc5:: with SMTP id f5mr11612729uaj.7.1551752903115;
 Mon, 04 Mar 2019 18:28:23 -0800 (PST)
MIME-Version: 1.0
References: <20190304203114.1894822-1-arnd@arndb.de> <20190304203114.1894822-3-arnd@arndb.de>
In-Reply-To: <20190304203114.1894822-3-arnd@arndb.de>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Tue, 5 Mar 2019 10:27:56 +0800
Message-ID: <CAFv8NwJX7Vv0aPx=Lp51UmroX9K5F2tj66oWLcOKhxWoiS2sBQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] ASoC: qcom: add i2c dependency for SND_SOC_SDM845
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 4:32 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> We must not select SND_SOC_MAX98927 unless CONFIG_I2C
> is also enabled:
>
> WARNING: unmet direct dependencies detected for SND_SOC_MAX98927
>   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && I2C [=n]
>   Selected by [y]:
>   - SND_SOC_SDM845 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && QCOM_APR [=y] && MFD_CROS_EC [=y]
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  sound/soc/qcom/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index 75ceb04d8bf0..b1764af858ba 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -98,7 +98,7 @@ config SND_SOC_MSM8996
>
>  config SND_SOC_SDM845
>         tristate "SoC Machine driver for SDM845 boards"
> -       depends on QCOM_APR && MFD_CROS_EC
> +       depends on QCOM_APR && MFD_CROS_EC && I2C
>         select SND_SOC_QDSP6
>         select SND_SOC_QCOM_COMMON
>         select SND_SOC_RT5663
> --
> 2.20.0
>
Hi Arnd,
Thank you for the fix.
Acked-by: Cheng-Yi Chiang <cychiang@chromium.org>
