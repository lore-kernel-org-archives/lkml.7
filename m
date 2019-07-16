Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBC5C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 14:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280B72173E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 14:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Py5/obzL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387859AbfGPOMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 10:12:48 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46361 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfGPOMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 10:12:47 -0400
Received: by mail-oi1-f196.google.com with SMTP id 65so15638130oid.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 07:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2XmDxxbJ7tU8jfvsRxWlaoaHsfnqizOFxorb/Xd+co=;
        b=Py5/obzLg1G6q0q9QNni2A4i6WspW9cxnxlS1QfRxEg9BRt1PWoOjwnaxWlw95wDhQ
         zk2XLC499vm6MTxijwxdPPDVhCQaRCFyw+qJHWt86AFA40hRMjwDOMZvCgKaj30892nR
         3Y8vkOpVAnYdsAR5GQ+/ylt+8cSq9qlPxSumsex88ZyIHEBPsauTOuHf7FrJRJlSNJ0G
         xBmJ7n3Wiqq/pFgIxlIeJn3Ms4InCCNSdUmRXMfbYZ6pVE4XIRvI/r3dn+K84uxn5ttw
         1GFLELKY4droqXKN0zwWh5as8vN/6BK+LpPAHSpEFtr3f0XWt77DBVSuhXUHhjHdb072
         ArzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2XmDxxbJ7tU8jfvsRxWlaoaHsfnqizOFxorb/Xd+co=;
        b=s+qhI7HFXZfUWk0ac7Rr/hte0cfk8aQpuNrqy6NDw12GO8jhahMclqNZM2TeeLoFnL
         5zBF7+G5yvzAS8C2RgxOsJ3ML8Md6vP+J7uGECbRnJM+zfDO1eTign3Fjmw+lH3Ps5Ak
         ouIa1H68JQaICXg6C6aQVF/y2khqZs67sHgR09Zji51G/B/xV/9sl05toHZ8Rs/5Vjfv
         +JaKCiATwP54liNTxV83aOR15kaUPc0tg9ArS9yxIYA0ijxHecY3d1wTsqk+I15s3SZU
         w4veolen+0OykF3plxkWZ2VP8cH7wHpPbeTbUduXQdcfKkW0P+i0BI5CSGfvVF+sAB0l
         NwIQ==
X-Gm-Message-State: APjAAAUZtU+bsbAsM5oUISrgNXwE56DxUQS8qP2fGrsDEOq4oSb8IZbp
        uwsbaw/YjaUgaz23xeUhKAx3oiBd0lwlNzEzUxHNBlG5ZhRCDUvkRU0=
X-Google-Smtp-Source: APXvYqwhUee7Js74E9R15ZB55hgPPsCjc9xmGxHsFteJRH0BqOq9zdyWRfoMvFTu0iFTMewZbXes9U0eh+oPZWTTRe8=
X-Received: by 2002:aca:4d84:: with SMTP id a126mr17188257oib.23.1563286366223;
 Tue, 16 Jul 2019 07:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190716115725.66558-1-cychiang@chromium.org> <20190716115725.66558-3-cychiang@chromium.org>
In-Reply-To: <20190716115725.66558-3-cychiang@chromium.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Tue, 16 Jul 2019 22:12:35 +0800
Message-ID: <CA+Px+wWuCBvWra8+=szQOrvr3iv2YPMeoHHVtJ1vmaZWEEQ44A@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] drm: bridge: dw-hdmi: Report connector status
 using callback
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>,
        Douglas Anderson <dianders@chromium.org>, dgreid@chromium.org,
        tzungbi@chromium.org,
        ALSA development <alsa-devel@alsa-project.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 7:57 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
>
> Change the Kconfig of DRM_DW_HDMI so it selects SND_SOC_HDMI_CODEC.
> This is for the typedef of hdmi_codec_plugged_cb to be used in dw-hdmi.c.
Not sure why you select SND_SOC_HDMI_CODEC in this patch.  To have
definition of hdmi_codec_plugged_cb, include hdmi-codec.h should be
sufficient.

>
> diff --git a/drivers/gpu/drm/bridge/synopsys/Kconfig b/drivers/gpu/drm/bridge/synopsys/Kconfig
> index 21a1be3ced0f..309da052db97 100644
> --- a/drivers/gpu/drm/bridge/synopsys/Kconfig
> +++ b/drivers/gpu/drm/bridge/synopsys/Kconfig
> @@ -4,6 +4,7 @@ config DRM_DW_HDMI
>         select DRM_KMS_HELPER
>         select REGMAP_MMIO
>         select CEC_CORE if CEC_NOTIFIER
> +       select SND_SOC_HDMI_CODEC
So that it is weird to select this option.

>
>  config DRM_DW_HDMI_AHB_AUDIO
>         tristate "Synopsys Designware AHB Audio interface"
> @@ -20,7 +21,6 @@ config DRM_DW_HDMI_I2S_AUDIO
>         tristate "Synopsys Designware I2S Audio interface"
>         depends on SND_SOC
>         depends on DRM_DW_HDMI
> -       select SND_SOC_HDMI_CODEC
Also strange for deselecting the option.  Should be in another commit
for another reason?
