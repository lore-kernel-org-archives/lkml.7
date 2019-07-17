Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13754C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA86321848
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JDhYZ/XL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbfGQK2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 06:28:30 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42044 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfGQK2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 06:28:30 -0400
Received: by mail-oi1-f196.google.com with SMTP id s184so18070070oie.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 03:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3OqUE647HuitrzeN56x9jTuLb2Ydo4APiMUt/N1U1gk=;
        b=JDhYZ/XLSp5p+uzs8xtZ+lDFSxyDX6a3a83vp7yY0oH7QR/JUG3nl7G/bfr2BVUVVt
         AT9BWdwzjWgFGhHaPLqfM2IfAKu5tUziTQa2yq6iXjC1JXAIXDIL1bnk3A60xCcqM8v1
         iHXfabVCBA+o6US93D2wHx2oKFBhG9ostlX0XsIagP4+oak+j0c4An6AaDbPkN0LuELE
         sbSIgxgH+PAC7n3MJ4/wXWHhsuSGKXPdLnObSXx350+qAr5xmhsnP0WJC6CsTXqWdSD+
         HwOrD5rSZE1vq3fGbC6Ihq5Zkdwq7tmp9dJjt8JIhcj2TFk/S5P93TXmZQmTmaWwZ/NV
         JatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3OqUE647HuitrzeN56x9jTuLb2Ydo4APiMUt/N1U1gk=;
        b=KuSH1Pdq/0bSbhYql7FclxRBODSu7RWXHGv9vZHjgZCHnaKftW+VhRbsY3blEMgwzy
         uf+kW3UV8fr9xwvl8G8Fsb4CxZrnh4RAKt9qT1rxMjnbUXJKPtdnbvGCPT7s6N4a1cIL
         9cIb56B+PdsiWuNEynfg/ToJHOvBwOcdTQXxzc5iGv9nBwCU64AkwRD2sp0cizR0QsAV
         L29450DK0/w5Zik00nUDdl4qqc0vvBQ8itp/wecveuVzj4c5+gk9Pvn9e3AfQs4ocX5Q
         bipo9nSumW65dK8bBpBwcbQr439BlMevqYH2GXBMBAQu+jXNC9yEF4BFERXq7/DyRj7Q
         DoMQ==
X-Gm-Message-State: APjAAAWGIOF2MkYSnDvF/IUDa8jC29NQkOJCRmnPFFHZ3kvcDhNzkEgC
        DOztPiZNFOafaWP6dHP6WH+xQG3Ape6mQvbla+rtng==
X-Google-Smtp-Source: APXvYqwWwXVZ/BZHTjaG86aX6+cX+YF7cjf0miBCE15x0Nd7s4TeCOAZk+HlSzO1mf3x+jEgUAq8Br9lxzMLzaRz5tc=
X-Received: by 2002:aca:544b:: with SMTP id i72mr20169753oib.174.1563359308762;
 Wed, 17 Jul 2019 03:28:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190717083327.47646-1-cychiang@chromium.org>
In-Reply-To: <20190717083327.47646-1-cychiang@chromium.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Wed, 17 Jul 2019 18:28:17 +0800
Message-ID: <CA+Px+wX4gbntkd6y8NN8xwXpZLD4MH9rTeHcW9+Ndtw=3_mWBw@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] Add HDMI jack support on RK3288
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

On Wed, Jul 17, 2019 at 4:33 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
>
> This patch series supports HDMI jack reporting on RK3288, which uses
> DRM dw-hdmi driver and hdmi-codec codec driver.
>
> The previous discussion about reporting jack status using hdmi-notifier
> and drm_audio_component is at
>
> https://lore.kernel.org/patchwork/patch/1083027/
>
> The new approach is to use a callback mechanism that is
> specific to hdmi-codec.
>
> Changes from v4 to v5:
> - synopsys/Kconfig: Remove the incorrect dependency change in v4.
> - rockchip/Kconfig: Add dependency of hdmi-codec when it is really need
>   for jack support.
>
> Cheng-Yi Chiang (5):
>   ASoC: hdmi-codec: Add an op to set callback function for plug event
>   drm: bridge: dw-hdmi: Report connector status using callback
>   drm: dw-hdmi-i2s: Use fixed id for codec device
>   ASoC: rockchip_max98090: Add dai_link for HDMI
>   ASoC: rockchip_max98090: Add HDMI jack support
>
LGTM.

Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
