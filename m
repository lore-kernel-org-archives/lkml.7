Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FC8C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A754120B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565020490;
	bh=GqH8P8Sc5z4BoLebSRYjQW+TVTAwhdGRVGtddclJmxY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=S4f0Qq5vA3hUb35zgP0GVpgsW+Bp4bYUaCOMQbR5Rg2yrFxlHaJh61r0pFUTEooXt
	 Cf5cyJjnSqagPAHBJbLMCldSvvVK/kpET1aG8opKQU7pWTdMNrESADlui3Z1RCaZBO
	 pomPS8uYfUE9ed40eaPXBfA6dBdIx2WU7WaKj66U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbfHEPyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 11:54:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729042AbfHEPyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 11:54:49 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A9212173C;
        Mon,  5 Aug 2019 15:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565020488;
        bh=GqH8P8Sc5z4BoLebSRYjQW+TVTAwhdGRVGtddclJmxY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vNvjROcPu+7yaOA4CmFHRvfPgFiNVGV+xXMikkoDn+sXkSwDhZ4+5hYxEAbBTD7VG
         vByLOYoOoBXdEGxacgnA2dPqb//W18X7uaqiqGW4RqdHW1qknvjED9mGzTKWw0WSVb
         Rv2TVfmT2BZ08O1V8VqJn5W3b2XANdgAoLDEnB9s=
Received: by mail-qk1-f182.google.com with SMTP id t187so7775081qke.8;
        Mon, 05 Aug 2019 08:54:48 -0700 (PDT)
X-Gm-Message-State: APjAAAXFX7sL2zEnAQuObWlVVDmA98ZBY0FcbgHQiMVA69M879zuNhBf
        vg+kvPNvvQMPO4FIV4386Mc8uWkFJb/4IaEigA==
X-Google-Smtp-Source: APXvYqw9FR3wqH+oZ5jAU/pdfSplNc6XBxfybOgvQPatkfulK2lt7S/NZVvHJvpqmoyDdmCwUTGKN+GG+Qi/B+5UxHI=
X-Received: by 2002:a37:a48e:: with SMTP id n136mr104724739qke.223.1565020487172;
 Mon, 05 Aug 2019 08:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190805145211.23161-1-dinguyen@kernel.org>
In-Reply-To: <20190805145211.23161-1-dinguyen@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 5 Aug 2019 09:54:34 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKUK+AQiy8jZ_aWuSsHMb5nSFJpiDMUAYbmK6pvc0p1_w@mail.gmail.com>
Message-ID: <CAL_JsqKUK+AQiy8jZ_aWuSsHMb5nSFJpiDMUAYbmK6pvc0p1_w@mail.gmail.com>
Subject: Re: [PATCHv2] drivers/amba: add reset control to primecell probe
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 5, 2019 at 8:52 AM Dinh Nguyen <dinguyen@kernel.org> wrote:
>
> The primecell controller on some SoCs, i.e. SoCFPGA, is held in reset by
> default. Until recently, the DMA controller was brought out of reset by the
> bootloader(i.e. U-Boot). But a recent change in U-Boot, the peripherals that
> are not used are held in reset and are left to Linux to bring them out of
> reset.
>
> Add a mechanism for getting the reset property and de-assert the primecell
> module from reset if found. This is a not a hard fail if the reset property
> is not present in the device tree node, so the driver will continue to probe.
>
> Because there are different variants of the controller that may have multiple
> reset signals, the code will find all reset(s) specified and de-assert them.
>
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v2: move reset control to bus code
>     find all reset properties and de-assert them
> ---
>  drivers/amba/bus.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 100e798a5c82..75e18b9e4808 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -18,6 +18,7 @@
>  #include <linux/limits.h>
>  #include <linux/clk/clk-conf.h>
>  #include <linux/platform_device.h>
> +#include <linux/reset.h>
>
>  #include <asm/irq.h>
>
> @@ -401,6 +402,18 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
>         ret = amba_get_enable_pclk(dev);
>         if (ret == 0) {
>                 u32 pid, cid;
> +               int count;
> +               struct reset_control *rstc;
> +
> +               /*
> +                * Find reset control(s) of the amba bus and de-assert them.
> +                */
> +               count = reset_control_get_count(&dev->dev);
> +               while (count > 0) {
> +                       rstc = of_reset_control_get_shared_by_index(dev->dev.of_node, count - 1);
> +                       reset_control_deassert(rstc);
> +                       count--;
> +               }

Aren't you going to need a put somewhere?

And then there's the fun possibility of deferred probe which could
happen on any of the resets.

Rob
