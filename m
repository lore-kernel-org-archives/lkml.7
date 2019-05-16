Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA9CC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 21:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F542070D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 21:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lxC0mVIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfEPVrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 17:47:24 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:42604 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfEPVrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 17:47:24 -0400
Received: by mail-ua1-f68.google.com with SMTP id e9so1893255uar.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 14:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=++a8Pfd1pmd0gtgzMiYzStSZkT1QAJ0q9LoMMmyznno=;
        b=lxC0mVIjA0SLzDUNfcqRwxoiM0ULrrdBItgvpMV0PYh4yCZN/egZlHDYXZIOCb0MWy
         MEptyIyNH17TyhG2+6tHcF8ypoGmsF8PJqLzkBm6+Qlwyk2Q/8Ro+UcRneAkuDiSuMtV
         KnOVeynDlXHVxD7AA7uJiQXAlzHOQX14yDO8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=++a8Pfd1pmd0gtgzMiYzStSZkT1QAJ0q9LoMMmyznno=;
        b=EfW2NjKMWOWx7vJ9Va8GfNeO1wZ2l+/13tG4NNAcJbxSLPec2cL6bWz0HjIu2X45kL
         YeWfxzX7SknEObvR8kf9nP/S9sf1WZyXO3T7iAyR3rfNL7IFfY/6qjCPELHIhkDBkKI5
         0Vw7/WlGqzO3BIJHrkd8zOcReB0kCW6YzFSXhvJJKqchGHG0QU7Y2hYFXZC+whIA7bAK
         z0tgSf474WDnLlvwkoWi7bJOweMfUKCb0BQ2PERHJHLfqXA54kuOLl15QSsgVsabl5xt
         9UOhx1NtmM+T6DTdCZFcaUS7vYdRslHkt6DDB/U2BuuxsSP4nbo5T6Zehf5bJzA+0Xya
         760g==
X-Gm-Message-State: APjAAAWagvB2+aqgT/6SO2OqWBlaKmwUVNpjrLjyR2Ym8dGYrbddfUsb
        R6t4iy3vsa8COXCsnxFwqD9VS5+kSQU=
X-Google-Smtp-Source: APXvYqw4ro8EHFHy90zKtK+pK9MaXKO5qXMgkBfHL8+CL5TIsuhX2wL0fYzCRmr7CxlsWuVZTlvpHQ==
X-Received: by 2002:a9f:3731:: with SMTP id z46mr12738375uad.16.1558043242763;
        Thu, 16 May 2019 14:47:22 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id 143sm4199125vkj.44.2019.05.16.14.47.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 14:47:22 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id q64so3324974vsd.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 14:47:22 -0700 (PDT)
X-Received: by 2002:a67:dd8e:: with SMTP id i14mr18643024vsk.149.1558042747509;
 Thu, 16 May 2019 14:39:07 -0700 (PDT)
MIME-Version: 1.0
References: <5cdae78b.1c69fb81.a32a9.870f@mx.google.com>
In-Reply-To: <5cdae78b.1c69fb81.a32a9.870f@mx.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 16 May 2019 14:38:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WDjUBvwoAaWNOmXPaLpZCccpAgRWDzRSnvsQ62TFwVmQ@mail.gmail.com>
Message-ID: <CAD=FV=WDjUBvwoAaWNOmXPaLpZCccpAgRWDzRSnvsQ62TFwVmQ@mail.gmail.com>
Subject: Re: next/master boot bisection: next-20190514 on rk3288-veyron-jaq
To:     "kernelci.org bot" <bot@kernelci.org>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        mgalka@collabora.com, Mark Brown <broonie@kernel.org>,
        matthew.hart@linaro.org, Kevin Hilman <khilman@baylibre.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

From: kernelci.org bot <bot@kernelci.org>
Date: Tue, May 14, 2019 at 9:06 AM
To: <tomeu.vizoso@collabora.com>, <guillaume.tucker@collabora.com>,
<mgalka@collabora.com>, <broonie@kernel.org>,
<matthew.hart@linaro.org>, <khilman@baylibre.com>,
<enric.balletbo@collabora.com>, Elaine Zhang, Eduardo Valentin, Daniel
Lezcano
Cc: Heiko Stuebner, <linux-pm@vger.kernel.org>,
<linux-kernel@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
Zhang Rui, <linux-arm-kernel@lists.infradead.org>

> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>
> next/master boot bisection: next-20190514 on rk3288-veyron-jaq
>
> Summary:
>   Start:      0a13f187b16a Add linux-next specific files for 20190514
>   Details:    https://kernelci.org/boot/id/5cda7f2259b514876d7a3628
>   Plain log:  https://storage.kernelci.org//next/master/next-20190514/arm/multi_v7_defconfig+CONFIG_EFI=y+CONFIG_ARM_LPAE=y/gcc-8/lab-collabora/boot-rk3288-veyron-jaq.txt
>   HTML log:   https://storage.kernelci.org//next/master/next-20190514/arm/multi_v7_defconfig+CONFIG_EFI=y+CONFIG_ARM_LPAE=y/gcc-8/lab-collabora/boot-rk3288-veyron-jaq.html
>   Result:     691d4947face thermal: rockchip: fix up the tsadc pinctrl setting error
>
> Checks:
>   revert:     PASS
>   verify:     PASS
>
> Parameters:
>   Tree:       next
>   URL:        git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   Branch:     master
>   Target:     rk3288-veyron-jaq
>   CPU arch:   arm
>   Lab:        lab-collabora
>   Compiler:   gcc-8
>   Config:     multi_v7_defconfig+CONFIG_EFI=y+CONFIG_ARM_LPAE=y
>   Test suite: boot
>
> Breaking commit found:
>
> -------------------------------------------------------------------------------
> commit 691d4947faceb8bd841900049e07c81c95ca4b0d
> Author: Elaine Zhang <zhangqing@rock-chips.com>
> Date:   Tue Apr 30 18:09:44 2019 +0800
>
>     thermal: rockchip: fix up the tsadc pinctrl setting error
>
>     Explicitly use the pinctrl to set/unset the right mode
>     instead of relying on the pinctrl init mode.
>     And it requires setting the tshut polarity before select pinctrl.
>
>     When the temperature sensor mode is set to 0, it will automatically
>     reset the board via the Clock-Reset-Unit (CRU) if the over temperature
>     threshold is reached. However, when the pinctrl initializes, it does a
>     transition to "otp_out" which may lead the SoC restart all the time.
>
>     "otp_out" IO may be connected to the RESET circuit on the hardware.
>     If the IO is in the wrong state, it will trigger RESET.
>     (similar to the effect of pressing the RESET button)
>     which will cause the soc to restart all the time.
>
>     Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
>     Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>     Signed-off-by: Eduardo Valentin <edubezval@gmail.com>

I can confirm that the above commit breaks my jerry, though I haven't
dug into the details.  :(  Is anyone fixing?  For now I'm just booting
with the revert.


-Doug
