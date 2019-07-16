Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D3DC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 14:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8B820693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 14:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qYBVXqle"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387821AbfGPOQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 10:16:44 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45602 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbfGPOQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 10:16:44 -0400
Received: by mail-ot1-f65.google.com with SMTP id x21so21191932otq.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 07:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jVq/zyKNmBTqyWzD5MQLwwT+e3xMbKqpQWodHdoZ+Mk=;
        b=qYBVXqle+7vCUqLEVGwc67lXP5F/twwhlFE5Z3mnLHfQaL3woXgBZgCVi92TBDhjeJ
         2xYZtFtWIO5evm6dUtiAoTEGoDOsm7fC7AJucP0UX9gFrIopG668rPCYstFNF/deP0NO
         Yow3WDYPuKUXWR6NI8bIKWpEgK5Io9YYvt0wF0VNxQOMp4A/Yvrc6EGJuKBoAyR7WEFk
         BKTpMnxxGFDKUSaSEHeIdUeyft5UdLs/UKvUocHQGm9LDJsZL1rqSQe42AuAX+b4dBhv
         mjMEEk6vcD90usHttnGty2wR67IuGbimfqxxuyyfVqldMtrUTdVGUz7HAU4v4CZXe41f
         chrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jVq/zyKNmBTqyWzD5MQLwwT+e3xMbKqpQWodHdoZ+Mk=;
        b=C3VBxYd1jhrv7WQnLWz9NNxKFoaK4lU+YPPnL7lm7FjVwv6qoZtYCd0EqZDFEspUvY
         F4YyDymIdC2lkzl9ytyXulsPU24xX79wPs5Ljjef7GDs6BEHDjL2w4x7pI1d9d3CvRqz
         BjzNY2H90LGH7l4t6hELl1HGftp+DZ1l5IuvFUNMNI4Bxtky86qCE5fGlW29OoYj2iPE
         VZVRekdWVU7eBKeoqaQqqNTgm1uhPCBpiClCp5kl+bwaoGNY4sZ3zo9p4eDT/c0pLpn3
         7G8vu5nsoVzxeBAnJdrLnC4Pf5fZIetbdxUDPpx5DLECgAEhEMhgcOGwAKd9temWMB6n
         S/eg==
X-Gm-Message-State: APjAAAU00bf7+82BBEO0Dm7gD4j/xDpE1QieSEl5QdQohFERYAUoR+9z
        FoAv+l0xGfYlCZ0v6UAxyXuDxNpEoxUQq1SW6m4WgcGaVcuaozf9LVY=
X-Google-Smtp-Source: APXvYqwN9uylP2hsCV6+LMaCJG6qvXFU449tm2O5OEbnNN4gNeP8+80YgzfQ+LB6vAKflWj5X25PTd+HkjgUEvFFruA=
X-Received: by 2002:a05:6830:1cd:: with SMTP id r13mr12627965ota.99.1563286603085;
 Tue, 16 Jul 2019 07:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190716115725.66558-1-cychiang@chromium.org> <20190716115725.66558-6-cychiang@chromium.org>
In-Reply-To: <20190716115725.66558-6-cychiang@chromium.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Tue, 16 Jul 2019 22:16:32 +0800
Message-ID: <CA+Px+wXK9gJKZwzsG8BXh1gmoEyscxtMzB_VCrHz-nenBEL9AQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] ASoC: rockchip_max98090: Add HDMI jack support
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
> diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
> index c82948e383da..c81c4acda917 100644
> --- a/sound/soc/rockchip/rockchip_max98090.c
> +++ b/sound/soc/rockchip/rockchip_max98090.c
> +static struct snd_soc_jack rk_hdmi_jack;
> +
> +static int rk_hdmi_init(struct snd_soc_pcm_runtime *runtime)
> +{
> +       struct snd_soc_card *card = runtime->card;
> +       struct snd_soc_component *component = runtime->codec_dai->component;
> +       int ret;
> +
> +       /* enable jack detection */
> +       ret = snd_soc_card_jack_new(card, "HDMI Jack", SND_JACK_LINEOUT,
> +                                   &rk_hdmi_jack, NULL, 0);
> +       if (ret) {
> +               dev_err(card->dev, "Can't new HDMI Jack %d\n", ret);
> +               return ret;
> +       }
> +
> +       return hdmi_codec_set_jack_detect(component, &rk_hdmi_jack);
> +}
In the patch, you should select SND_SOC_HDMI_CODEC, because the patch
uses hdmi_codec_set_jack_detect which depends on hdmi-codec.c.
