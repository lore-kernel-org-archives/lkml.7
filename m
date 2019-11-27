Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3E1C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5763E20715
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eHCTU1QY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfK0S7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 13:59:36 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:44828 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfK0S7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 13:59:36 -0500
Received: by mail-qv1-f68.google.com with SMTP id t11so545124qvz.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 10:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=geVGu8MBW5PeHjvdy4rCo2MPVBJQGl//bajAqe2ly1A=;
        b=eHCTU1QYxVuGhChIncMyHJ9Pm+6/dZy6dgMluWm3zrkYV9jdgNv+PuDkJdqjp/SQ68
         OAUxXumGOl5myH27v6FfcWTuDGABtRiSSQMK+xtAX4a4jCFMCvADUT2oCN+GwyYYlTZV
         YwQw+7TMamciR05gVvQZS1Tq4jRYuOAcAwghj/slaAzH/qIFSG5+RwI6zyiw2aVEwPI8
         UBfV74BpdOo0iL2DNIcEMk6Metyucdu2pJfjg8BNCka4XchEnxLK4ZVVPzXe53AZXFys
         XRx3BjrqTHHfWOezDRDr3bKoncCv+SKdRT/bXor99Ezi6spieeClLT4gsoP1gmDb9XWj
         kehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=geVGu8MBW5PeHjvdy4rCo2MPVBJQGl//bajAqe2ly1A=;
        b=jBCmB76FCSmWKZntXnCj/ijfCu79GdBPA3IyW0EjkEwKzEwzLKGsnltVRWOih5+nBe
         /sreDthTOzTRNg+tWf43gbxkAFiqntS0UvUssixQy64SVwI/OuR0bH6f5Hn0mPProNWs
         0zemueHWhbtGgHWT2OtjV7uW09vbqbnUsQ1GVCtamxtzeEVSX90vCchVOMJw3DPO2CfN
         BKnaHlQT4GK8q/dNJTcJL3rGAzm/p4sEC6CbjX16SHLpYCmFyzIj/TGdLiOtgkRvE+68
         MRLKkLwlWBAN4Yo9sZDHF0Vchh0QBBRujrdo7OBjAlhCuljjvJxqCjMhF7hojIH3dVZ9
         uhnw==
X-Gm-Message-State: APjAAAW2cQp8BwCj3foDC7CHy7/iIUraUoT1rGeQxiyv9K3MPH71hbk1
        BjPA4nBrlchFWJhDGwgK7hkVWevyIDgc5Tk23zDRiw==
X-Google-Smtp-Source: APXvYqwzbioROwUxTls76I+kI8XT3+8LulhD/EKcnF1Xcb3Thi0WYWiroVHFIWuQe7i3Hx6HMIOZ7Twk+gkVIhU3wA0=
X-Received: by 2002:ad4:4c4e:: with SMTP id cs14mr6646423qvb.198.1574881174864;
 Wed, 27 Nov 2019 10:59:34 -0800 (PST)
MIME-Version: 1.0
References: <20191127082145.6100-1-yuehaibing@huawei.com>
In-Reply-To: <20191127082145.6100-1-yuehaibing@huawei.com>
From:   Curtis Malainey <cujomalainey@google.com>
Date:   Wed, 27 Nov 2019 10:59:24 -0800
Message-ID: <CAOReqxhf4qU7DwLN104Mq_Q2BCdmPSC9sjJv2QsGY4uPEK-u6g@mail.gmail.com>
Subject: Re: [PATCH -next] ASoC: rt5677: Fix build error without CONFIG_SPI
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Ben Zhang <benzh@chromium.org>,
        Curtis Malainey <cujomalainey@chromium.org>,
        ALSA development <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 12:22 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> If CONFIG_SPI is n, SND_SOC_RT5677_SPI also is n, building fails:
>
> sound/soc/codecs/rt5677.o: In function `rt5677_irq':
> rt5677.c:(.text+0x2dbf): undefined reference to `rt5677_spi_hotword_detected'
> sound/soc/codecs/rt5677.o: In function `rt5677_dsp_work':
> rt5677.c:(.text+0x3709): undefined reference to `rt5677_spi_write'
>
> This adds stub helpers to fix this.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 461c623270e4 ("ASoC: rt5677: Load firmware via SPI using delayed work")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Curtis Malainey <cujomalainey@chromium.org>
> ---
>  sound/soc/codecs/rt5677-spi.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
