Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71528C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 14:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4618020693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 14:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WY+b2Mmn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387875AbfGPOOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 10:14:48 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37382 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbfGPOOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 10:14:48 -0400
Received: by mail-ot1-f67.google.com with SMTP id s20so21220916otp.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 07:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7p9kaWKWZ1RnK2eKn4KEJD3Gj9Xqk7kKd80amljZoBA=;
        b=WY+b2MmneuNwICa5DrCLXAuS2Ym/kIa/8fMTCjzzSDHJaRASHD8bq7nmIJgrdweSsS
         lW3jjoD5QcJJIyyvCHoMNUlIZNjTS3gwCcZw+OiFN7hXiOSyH9ADvlW2kxHCOuH2cxIu
         tCPLZkrJeyPGTbnAW+q4j5QO0RReazYEWdOD+nCh71seMSMeaod6xltVYqgLck89i1vJ
         ZZ1RfI48FJt7Kn9XZo+yb2BCK+6bo4ZICo6ZZy7vGtmqivPeeukvE1Lo2owGb9dXyase
         pCjnZbOzTFcDjgWgJHPrhRewV2AbCD6W2rQ9OCijtmE14GAPIzcgj+hn06DV9EbJe+MC
         MqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7p9kaWKWZ1RnK2eKn4KEJD3Gj9Xqk7kKd80amljZoBA=;
        b=X5vD2kyM7e0E4JtNmVD4g6pD2sc1Pgye7zNcSG0DjX9JUyORt0rPhJqPpPL8z1CQVc
         yIzoxQswbPDBIzTOZou79Q9qb2XKjOhq/kUlPAkq1ASuCb+orr242WrrE/ENYtfyZkre
         BdWUH/5Kf9ZBNxR+zisysHUXiHbWr38dFHPP8/+otf2kLhitbn8KjbfBlqcKv7uZVr5M
         6WueqsDXSd3k/6Ssp8MUiDPjU8b0UsqWyXXUkMZtU3O48+1anTeF9Ngbw62N/Csuurg6
         NIE1xnF5OFl3V+JfGGcNV0ZGnEbomDeVcgSSmiJk6CF2JvUUMK2bokXcA0OQl9tVREsF
         aDDw==
X-Gm-Message-State: APjAAAV4MhkrTW97xSC0BCP5o04gTRRbk9GjARZm9hDmr19aPy6kk6mR
        i/J9+4tspNnOF68JSlqwdFQw27b+n+ALEVZaf3Ozyg==
X-Google-Smtp-Source: APXvYqxrx8/ntAt3Zd7iJAcVEIJOpeAV8oT/asIVbOOvcJcHbUCdJVyQnJvUXuhuaUoA8KWwL8LQ+jY6q3iS71MyDVI=
X-Received: by 2002:a9d:6195:: with SMTP id g21mr26395560otk.103.1563286487230;
 Tue, 16 Jul 2019 07:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190716115725.66558-1-cychiang@chromium.org> <20190716115725.66558-5-cychiang@chromium.org>
In-Reply-To: <20190716115725.66558-5-cychiang@chromium.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Tue, 16 Jul 2019 22:14:36 +0800
Message-ID: <CA+Px+wV6RSfv4GL8+EJzXGq2nqzKtH9p23VTo2s30h0To2rQtg@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] ASoC: rockchip_max98090: Add dai_link for HDMI
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

On Tue, Jul 16, 2019 at 7:58 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
>
> diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
> index b43657e6e655..d610b553ea3b 100644
> --- a/sound/soc/rockchip/Kconfig
> +++ b/sound/soc/rockchip/Kconfig
> @@ -40,9 +40,10 @@ config SND_SOC_ROCKCHIP_MAX98090
>         select SND_SOC_ROCKCHIP_I2S
>         select SND_SOC_MAX98090
>         select SND_SOC_TS3A227E
> +       select SND_SOC_HDMI_CODEC
>         help
>           Say Y or M here if you want to add support for SoC audio on Rockchip
> -         boards using the MAX98090 codec, such as Veyron.
> +         boards using the MAX98090 codec and HDMI codec, such as Veyron.
You should not need to select the option in this patch (but in next
patch), because this patch does not depend on anything from
hdmi-codec.c.
