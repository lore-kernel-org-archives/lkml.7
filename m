Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFA8C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B3E21921
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hlf36gHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbfGVNm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:42:29 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36863 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfGVNm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:42:28 -0400
Received: by mail-vs1-f68.google.com with SMTP id y16so26090639vsc.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qoQdDffqX8NBzaTkQfhvAHhztASiaANiufyf578HpGA=;
        b=hlf36gHZhD/tS5G06dvQKalHNMkuU0cPoYxvqMowCMiM9+5PuvZs+04mLOqMz2VeuW
         U8dAGoQv9k54c85MyxcwsDF2A+inBvqw62id8DJVpiPw7bvZbXA/njP/C0RrYsZMy3tG
         wpjnT74c3n53mUIeMtdr+TaEKIMxUwRK6caFdudW0oLatFOWjv7hKp5H2M2hUTQi+BwB
         ESp1bk+Fpi1F+8T/ue3qVOEWi4Oyjp7xADz8+qOfUpHdXJNxyfNoDoE/2S/6G4j2pOZ4
         idBpfMzjfaoP3PkIyenxLmYvTqcyTF1J3Pool3TykdtIKk1c0OWr8xEPfoWWYVvviyqa
         NPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qoQdDffqX8NBzaTkQfhvAHhztASiaANiufyf578HpGA=;
        b=BOZ03deh4xIPO3HuztmCiAA67itaPmWICUaJd0ohZYAi4fR6fub9Mith2kLj8Al9FJ
         FSCF7Xf6mEaXHiA4A7Lql3q6Je0F0sDmTMlKc2StAGhB0A2Z4oqvPAxkNA69jIG4eX34
         lZIlJIjtpmkJmis3g9J1DW756bxLiQG+Qlw2rEnJlYgnRoZ48mNEFitW3xmTq6Klvwl5
         fuzhJolWfXVwyJ7RD6nVj5Xv6T0G6vDUZg26IXu+Wuc4XavzHELeyXshD0H/rzqfebB/
         7jH1k/NppwI9nmw4RR4/1sL7o5yvV+OmCbWwmrfAj1OB2ZAZT8tlak1baonH+Uj8df4N
         Smxw==
X-Gm-Message-State: APjAAAX86SI8gS7Fyro6DD+CAFiycEEbH0qZZTtsmBzfXoQDQq5D1+E+
        0OcQeM/qOy6ZLQASUQPZp5DF3wjdd5EhSRB7J5Nnew==
X-Google-Smtp-Source: APXvYqxbn8CFIXmBHNgvuCDDcp2KcviU5e69X/Dns7ukIv9wF0j92U/Jl2H0QImdSFYkQRQTfAnh2+VcAVwgZp1J98Y=
X-Received: by 2002:a67:7a90:: with SMTP id v138mr41898336vsc.200.1563802947659;
 Mon, 22 Jul 2019 06:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190708195613.205729-1-dianders@chromium.org>
In-Reply-To: <20190708195613.205729-1-dianders@chromium.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 22 Jul 2019 15:41:51 +0200
Message-ID: <CAPDyKFqcbFZWiMc3zLFP7cvkNG0hMB91rfy6T=dbrFks9EWMsQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Fix occasional hang after tuning on eMMC
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Sonny Rao <sonnyrao@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Alim Akhtar <alim.akhtar@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jul 2019 at 21:56, Douglas Anderson <dianders@chromium.org> wrote:
>
> In commit 46d179525a1f ("mmc: dw_mmc: Wait for data transfer after
> response errors.") we fixed a tuning-induced hang that I saw when
> stress testing tuning on certain SD cards.  I won't re-hash that whole
> commit, but the summary is that as a normal part of tuning you need to
> deal with transfer errors and there were cases where these transfer
> errors was putting my system into a bad state causing all future
> transfers to fail.  That commit fixed handling of the transfer errors
> for me.
>
> In downstream Chrome OS my fix landed and had the same behavior for
> all SD/MMC commands.  However, it looks like when the commit landed
> upstream we limited it to only SD tuning commands.  Presumably this
> was to try to get around problems that Alim Akhtar reported on exynos
> [1].
>
> Unfortunately while stress testing reboots (and suspend/resume) on
> some rk3288-based Chromebooks I found the same problem on the eMMC on
> some of my Chromebooks (the ones with Hynix eMMC).  Since the eMMC
> tuning command is different (MMC_SEND_TUNING_BLOCK_HS200
> vs. MMC_SEND_TUNING_BLOCK) we were basically getting back into the
> same situation.
>
> I'm hoping that whatever problems exynos was having in the past are
> somehow magically fixed now and we can make the behavior the same for
> all commands.
>
> [1] https://lkml.kernel.org/r/CAGOxZ53WfNbaMe0_AM0qBqU47kAfgmPBVZC8K8Y-_J3mDMqW4A@mail.gmail.com
>
> Fixes: 46d179525a1f ("mmc: dw_mmc: Wait for data transfer after response errors.")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Alim Akhtar <alim.akhtar@gmail.com>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
> Marek (or anyone else using exynos): is it easy for you to test this
> and check if things are still broken when we land this patch?  If so,
> I guess we could have a quirk to have different behavior for just
> Rockchip SoCs but I'd rather avoid that if possible.
>
> NOTE: I'm not hoping totally in vain here.  It is possible that some
> of the CTO/DTO timers that landed could be the magic that would get
> exynos unstuck.
>
>  drivers/mmc/host/dw_mmc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index b53b6b7d4dd4..60c3a06e3469 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2034,8 +2034,7 @@ static void dw_mci_tasklet_func(unsigned long priv)
>                                  * delayed. Allowing the transfer to take place
>                                  * avoids races and keeps things simple.
>                                  */
> -                               if ((err != -ETIMEDOUT) &&
> -                                   (cmd->opcode == MMC_SEND_TUNING_BLOCK)) {
> +                               if (err != -ETIMEDOUT) {
>                                         state = STATE_SENDING_DATA;
>                                         continue;
>                                 }
> --
> 2.22.0.410.gd8fdbe21b5-goog
>
