Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A21C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 09:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59014216FD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 09:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562663224;
	bh=gBRbV35m5F7XIm4mY3P77vIRA1ulbfrdqYeY5XmCOgk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FxqMd98j6MCI9gr5EekhsrzkMPC1w2gaqAqVBb6q2mqMPnk71elbuaMthPAcNPupy
	 CP/jdatkEQk9CqJ7/sz4upS+w3ziH0U9169Ow+jfVp5SY7rrdZvq5ZWr91vKnas8lv
	 vNUcs922Sn0cDCKfFLwoi3NBZ/odMgCnsvC6aWBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfGIJHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 05:07:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfGIJHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 05:07:02 -0400
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32D5A216FD;
        Tue,  9 Jul 2019 09:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562663221;
        bh=gBRbV35m5F7XIm4mY3P77vIRA1ulbfrdqYeY5XmCOgk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gxorLcYJevSSmtpzy/o0ew1VV/QK4r2pm5NRoEH/VSxNz9qvy3wP64EGkH6vdnfn5
         xcaPE11FnphyP26cvOIJEE/cJwEmiqRLj8nwvBsJmE3hSHAANeOMpVVviPHzMIDUX0
         czxnOGsSYcDxeLI7YO03LwH2/5T7yhyHcyv3B938=
Received: by mail-lj1-f180.google.com with SMTP id m23so18770353lje.12;
        Tue, 09 Jul 2019 02:07:01 -0700 (PDT)
X-Gm-Message-State: APjAAAXhKMdbDUiK3kwPmOvPtrP+oKZm6JWFhR/oJKCrFz0/kpdhOT8c
        i89fyGLBWFzdkgM9fAN6DNY9UHyf8aIhGsINChI=
X-Google-Smtp-Source: APXvYqwRGEMAT7YRdSOSn3gQFgEwbb92VncYwQYDe1Ihzvsow5YWnFGx7ye2yBLB8agC6UeZtzmBb1KtmubvXQ6NpxE=
X-Received: by 2002:a2e:980a:: with SMTP id a10mr10458109ljj.40.1562663219477;
 Tue, 09 Jul 2019 02:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190708195613.205729-1-dianders@chromium.org>
In-Reply-To: <20190708195613.205729-1-dianders@chromium.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 9 Jul 2019 11:06:48 +0200
X-Gmail-Original-Message-ID: <CAJKOXPf9OTPaheUdiZtaDGU0sE2vsdRiLx5nptMt_EVKU7GObA@mail.gmail.com>
Message-ID: <CAJKOXPf9OTPaheUdiZtaDGU0sE2vsdRiLx5nptMt_EVKU7GObA@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Fix occasional hang after tuning on eMMC
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-rockchip@lists.infradead.org, briannorris@chromium.org,
        mka@chromium.org, groeck@chromium.org, sonnyrao@chromium.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Alim Akhtar <alim.akhtar@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jul 2019 at 00:48, Douglas Anderson <dianders@chromium.org> wrote:
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
> ---
> Marek (or anyone else using exynos): is it easy for you to test this
> and check if things are still broken when we land this patch?  If so,
> I guess we could have a quirk to have different behavior for just
> Rockchip SoCs but I'd rather avoid that if possible.
>
> NOTE: I'm not hoping totally in vain here.  It is possible that some
> of the CTO/DTO timers that landed could be the magic that would get
> exynos unstuck.

I have eMMC module attached to Odroid U3 (Exynos4412,
samsung,exynos4412-dw-mshc). What is the testing procedure? With your
patch it boots fine:
[    3.698637] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot
req 52000000Hz, actual 50000000HZ div = 0)
[    3.703900] mmc1: new DDR MMC card at address 0001
[    3.728458] mmcblk1: mmc1:0001 008G92 7.28 GiB

Best regards,
Krzysztof
