Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABBBECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7613321721
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rjkLkkBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfJGL56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:57:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36705 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbfJGL56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:57:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id m18so12031588wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 04:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=B0q2SXnY7pAxin67ut4lnZBcx7ln61mIYC68maemLHk=;
        b=rjkLkkBfq1GZvIV/uQvsk9JV2Zz1kiFmG1dxKOGmb0SVH5v84yHVq5twm54lHwGPMq
         ypsFVEtkSTOlVNOiigDAFh+WRwAOZB0hnKoIjIItLgTVeT86p1cthIvvmPIR7TEJqlpy
         YIAFzqVZqCblpE/ZHnXWV8DZ1KSJcuGGf6WzKk8Q7B1KSLpFoXO46NdkKXsAkSo7r20l
         fX2Ou7tURT/zOJjDJdrXXV03fIIpIUHO5l9WUCNZjpbRJ8Ynw0RojjQPEj7zf5WVmNZf
         aelNT5a45miFk3f2r635jaq83jCp1CH/AufihsdtzDNjqiLaIK/g05jDDzM9ei1Xsu/n
         DiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=B0q2SXnY7pAxin67ut4lnZBcx7ln61mIYC68maemLHk=;
        b=YcRYIVs/x47ikxeA64cw5oHdSMOITzYX/5lNY9+7KsHbHMaPs2c+TvCy2/R9NUPH7B
         /qfJcC78SxwJVyUYrVbl6GAT8OdE8oCKyXs3n0Ekq5t98USH6Lb8SGWlQELGAf+W/IFC
         tM7uN82PL/eQ1DUwMg18ogLb6fWxhL337zNNZG95k0srk5Kb/qBVXx2Z8p8FAebX6xM+
         Y/ehWUcAfRUxLt6e/J9CS02OfEHhkN01b5YjoiyYXfdJ1vd58ZC6fStdQly3GHc6EmKF
         VZLLG2KwldjUKdy3QHaDMco5a1LxuMXRCirCUGzbjAhF4YUEaUj8ZdMkojIuFoeHBP/K
         ccPA==
X-Gm-Message-State: APjAAAXrSJygwcXiH+TY/GSV+3+z2g28LqcQzToap3YIvRn0CRrgb1XB
        /onhd4/aodWN9bfk9M0hsoE8EQ==
X-Google-Smtp-Source: APXvYqyVfjnxAijw5tnWnJhbAh1DjXRsxqUt+4mtnh/TiJHJrIrqGcypYsybS4IyumRlrkVVJ8FLQA==
X-Received: by 2002:a05:600c:248a:: with SMTP id 10mr20199658wms.97.1570449474109;
        Mon, 07 Oct 2019 04:57:54 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s10sm24800791wmf.48.2019.10.07.04.57.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 04:57:53 -0700 (PDT)
Subject: Re: [PATCH v2 RESEND] drm/bridge: dw-hdmi: Restore audio when setting
 a mode
To:     Cheng-Yi Chiang <cychiang@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        dianders@chromium.org, dgreid@chromium.org, tzungbi@chromium.org,
        alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Daniel Kurtz <djkurtz@chromium.org>,
        Yakir Yang <ykk@rock-chips.com>
References: <20191003041438.194224-1-cychiang@chromium.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <b8ad03db-b93f-44e0-ccd6-fc8bda1af223@baylibre.com>
Date:   Mon, 7 Oct 2019 13:57:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191003041438.194224-1-cychiang@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/10/2019 06:14, Cheng-Yi Chiang wrote:
> From: Daniel Kurtz <djkurtz@chromium.org>
> 
> When setting a new display mode, dw_hdmi_setup() calls
> dw_hdmi_enable_video_path(), which disables all hdmi clocks, including
> the audio clock.
> 
> We should only (re-)enable the audio clock if audio was already enabled
> when setting the new mode.
> 
> Without this patch, on RK3288, there will be HDMI audio on some monitors
> if i2s was played to headphone when the monitor was plugged.
> ACER H277HU and ASUS PB278 are two of the monitors showing this issue.
> 
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> ---
>  Change from v1 to v2:
>   - Use audio_lock to protect audio clock.
>   - Fix the patch title.
> 
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index aa7efd4da1c8..749d8e4c535b 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -1982,6 +1982,17 @@ static void hdmi_disable_overflow_interrupts(struct dw_hdmi *hdmi)
>  		    HDMI_IH_MUTE_FC_STAT2);
>  }
>  
> +static void dw_hdmi_audio_restore(struct dw_hdmi *hdmi)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&hdmi->audio_lock, flags);
> +
> +	hdmi_enable_audio_clk(hdmi, hdmi->audio_enable);
> +
> +	spin_unlock_irqrestore(&hdmi->audio_lock, flags);

Dumb question, why is this protected by a spinlock ?

Neil

> +}
> +
>  static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
>  {
>  	int ret;
> @@ -2045,7 +2056,7 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
>  
>  		/* HDMI Initialization Step E - Configure audio */
>  		hdmi_clk_regenerator_update_pixel_clock(hdmi);
> -		hdmi_enable_audio_clk(hdmi, true);
> +		dw_hdmi_audio_restore(hdmi);
>  	}
>  
>  	/* not for DVI mode */
> 

