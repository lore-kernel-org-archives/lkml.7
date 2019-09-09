Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB45AC4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B8320863
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OE6c/504"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbfIIW30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 18:29:26 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:39167 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbfIIW30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 18:29:26 -0400
Received: by mail-ua1-f65.google.com with SMTP id s15so4893589uaq.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 15:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aw3KitC+gZjAstmoI82CIHR5PcpwjoN5I9nINWW5tjg=;
        b=OE6c/504gfqx+xO3l8yQTRuLIaUfZpmyT5bd/Y4/MMENKMVNlHOdbj6o9KvDbA9NVH
         IqSAw9xiB9jJ4LFy9nu/lRldThsV0HIziCBBq7vEwYVQ2k5Q82MS++D4zwXZ427rZHKZ
         NyE2Ab3zEfzf8I93dA9spyKWXxkdT25yuALaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aw3KitC+gZjAstmoI82CIHR5PcpwjoN5I9nINWW5tjg=;
        b=swQLKQYbuzpceK0fIYs1C5V6ITnXm3gV8bgiu3/kQsNhvAhi2sdJm2rl5CKE+toi96
         ttTASdwiBt+c3XKTdaTRaZDHi23Vqg0lgXEE5O2y0NSmCiUTMsSZVSnfmkCnk0scztKj
         I9CTFZAXEdecwYbjmURIhDtMWdyVVWnatZn6C++8NYrHsl5/VGsbZFjUr+/Wfth5YVqv
         GsZcYyM4mu81P4C9KsmLHkc4IHXh0t9+Cp8iT8KBXu4WTvlVgJmLJFF7LbrHIFCWT0ec
         LrnZagxFuNUhTLoaMmVIQq36sGOIbK3LYBF6/tXXxdV4QiF71CEmNKLInefjIbz2XhUx
         3sfQ==
X-Gm-Message-State: APjAAAU/m8xBgGzn6ISdVqHSNNI5pSmOsUs7OjY/d5kkJUjY90XYQuk7
        cIYQJmkQUW06MYbRTtWMWsHrJGn0ORU=
X-Google-Smtp-Source: APXvYqwQLHAA82z66sQcjBNasYAdqGo732ibsqnIXT5XQTkcEs7gvzEzstfex9+/uV3N8Rnk8vJr0Q==
X-Received: by 2002:a9f:24c4:: with SMTP id 62mr5992943uar.104.1568068163636;
        Mon, 09 Sep 2019 15:29:23 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id t6sm4546630vkf.41.2019.09.09.15.29.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2019 15:29:22 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id g11so9549909vsr.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 15:29:22 -0700 (PDT)
X-Received: by 2002:a67:2b86:: with SMTP id r128mr278682vsr.119.1568068161962;
 Mon, 09 Sep 2019 15:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190908101236.2802-1-ulf.hansson@linaro.org> <20190908101236.2802-4-ulf.hansson@linaro.org>
In-Reply-To: <20190908101236.2802-4-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 9 Sep 2019 15:29:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U=ohP9KFWrMYfdbT4WbOxGXFNMd71c7ej1G9Qrtim=7w@mail.gmail.com>
Message-ID: <CAD=FV=U=ohP9KFWrMYfdbT4WbOxGXFNMd71c7ej1G9Qrtim=7w@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] mmc: mtk-sd: Re-store SDIO IRQs mask at system resume
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Daniel Kurtz <djkurtz@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Sep 8, 2019 at 3:12 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> In cases when SDIO IRQs have been enabled, runtime suspend is prevented by
> the driver. However, this still means msdc_runtime_suspend|resume() gets
> called during system suspend/resume, via pm_runtime_force_suspend|resume().
>
> This means during system suspend/resume, the register context of the mtk-sd
> device most likely loses its register context, even in cases when SDIO IRQs
> have been enabled.
>
> To re-enable the SDIO IRQs during system resume, the mtk-sd driver
> currently relies on the mmc core to re-enable the SDIO IRQs when it resumes
> the SDIO card, but this isn't the recommended solution. Instead, it's
> better to deal with this locally in the mtk-sd driver, so let's do that.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/host/mtk-sd.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 6946bb040a28..ae7688098b7b 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -2408,6 +2408,9 @@ static void msdc_save_reg(struct msdc_host *host)
>         } else {
>                 host->save_para.pad_tune = readl(host->base + tune_reg);
>         }
> +
> +       if (sdio_irq_claimed(host->mmc))
> +               __msdc_enable_sdio_irq(host, 1);
>  }
>
>  static void msdc_restore_reg(struct msdc_host *host)

I don't personally have a Mediatek device setup to test this patch on.
If it's super urgent I could try to track down one and try to set it
up, but hopefully it's easier for someone else...

That being said, from code inspection it seems like you should be
adding your code to msdc_restore_reg(), not to msdc_save_reg().  Am I
confused?

-Doug
