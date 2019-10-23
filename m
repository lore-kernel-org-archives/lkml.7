Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7A1CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9806F2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="viCUfLzz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390362AbfJWIc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 04:32:58 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38929 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732361AbfJWIc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:32:58 -0400
Received: by mail-ot1-f68.google.com with SMTP id s22so16678775otr.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 01:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L8bkA9mtw+vWpI8oRxFifBMw8ummqV2rsVRmeQUbBco=;
        b=viCUfLzzS1NUVQ5Tnwemu4lRHQh7rs8CcijmjomS/9Miv9Fu+1airI68eF8A8nJSyM
         546inlstZ+rsV3j10IwzBsycIFGDPHrgXpTekkK2mvUwZ8G3lCLjyeEM7EQy/lZHZhaB
         E5ZzJt4Q/pPYmawXeV71ABnjju8sA8DJIMrKRYDgXJbiwCuKZsPLIjF+dRKIDvkcbLbB
         PqQsxIkRG98Hk2GjN6zHwsA4r1gwOzIDXX1ehjEkdS0m14uNImJD2Ybj2n3J9f6LxhoR
         vIFuKY91tEAHwK1Lh0VLR3AqD94qvyZtf73j7lbvTR4BDSKOqQihceTRTuyCyrprb6I3
         jZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L8bkA9mtw+vWpI8oRxFifBMw8ummqV2rsVRmeQUbBco=;
        b=IcSg8uqshEGkw9i8pn/qvJjgL0LF4GiomLpBztwEsNb2OqiBWvBZWD9DczN1Xsjj90
         jRyPxx3gWDLYTsikeqViFv4uhdZ3A8UBaJSiNPkn6SpH/XwfrsxvgWyYRWvfmrrGnX6P
         7Qq+NleIqp4JirNbX4dxvXq9R7j9nvgqinl8CeIepBvgL0Tyts3gAdatxhpSHWWQJ+di
         rmJ7hcwiB3uuO7wljnAZR8HV8xJ595vYiw5btP4iHcSaXykcUjmFpGuTURo1XQPYhd2G
         ebLOGu8BBcuBFl+vCoC52efJASZFk2lDeyWu8pBdqTB0wcI+qQDuVEe594oTNOfOXvum
         WHaw==
X-Gm-Message-State: APjAAAWrqkvDo6DcidKuSMFKL1PS2/jZTgpip3CLXn3fZzjPn9ri2CP+
        AMKvqY5IYEdE8Sh7fMCQ1AO+Yb1X6f81QxKTlQFJVA==
X-Google-Smtp-Source: APXvYqx9C835htw9b+vjF88aUM7e4S/FRS+3eHUvwsbpuC8bReEl39lomHdHjZsPRkBvLfkVQLrdUBNmVyoQXSiyMP0=
X-Received: by 2002:a9d:7d12:: with SMTP id v18mr4103680otn.103.1571819576961;
 Wed, 23 Oct 2019 01:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20191023063103.44941-1-maowenan@huawei.com>
In-Reply-To: <20191023063103.44941-1-maowenan@huawei.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Wed, 23 Oct 2019 16:32:46 +0800
Message-ID: <CA+Px+wX7-tn-rXeKqnPtp74tU5cLxhJwF6XZ_jeQX-tnAfvO5g@mail.gmail.com>
Subject: Re: [PATCH] ASoC: mediatek: Check SND_SOC_CROS_EC_CODEC dependency
To:     Mao Wenan <maowenan@huawei.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?B?U2h1bmxpIFdhbmcgKOeOi+mhuuWIqSk=?= 
        <shunli.wang@mediatek.com>, yuehaibing@huawei.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        tglx@linutronix.de, KaiChieh Chuang <kaichieh.chuang@mediatek.com>,
        ALSA development <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 2:31 PM Mao Wenan <maowenan@huawei.com> wrote:
>
> If SND_SOC_MT8183_MT6358_TS3A227E_MAX98357A=y,
> below errors can be seen:
> sound/soc/codecs/cros_ec_codec.o: In function `send_ec_host_command':
> cros_ec_codec.c:(.text+0x534): undefined reference to `cros_ec_cmd_xfer_status'
> cros_ec_codec.c:(.text+0x101c): undefined reference to `cros_ec_get_host_event'
>
> This is because it will select SND_SOC_CROS_EC_CODEC
> after commit 2cc3cd5fdc8b ("ASoC: mediatek: mt8183: support WoV"),
> but SND_SOC_CROS_EC_CODEC depends on CROS_EC.
>
> Fixes: 2cc3cd5fdc8b ("ASoC: mediatek: mt8183: support WoV")
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
>  sound/soc/mediatek/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
> index 8b29f39..a656d20 100644
> --- a/sound/soc/mediatek/Kconfig
> +++ b/sound/soc/mediatek/Kconfig
> @@ -125,7 +125,7 @@ config SND_SOC_MT8183_MT6358_TS3A227E_MAX98357A
>         select SND_SOC_MAX98357A
>         select SND_SOC_BT_SCO
>         select SND_SOC_TS3A227E
> -       select SND_SOC_CROS_EC_CODEC
> +       select SND_SOC_CROS_EC_CODEC if CROS_EC
>         help
>           This adds ASoC driver for Mediatek MT8183 boards
>           with the MT6358 TS3A227E MAX98357A audio codec.
> --
> 2.7.4
>

Just realized your patch seems not showing in the list
(https://mailman.alsa-project.org/pipermail/alsa-devel/2019-October/thread.html).
I have no idea why.
