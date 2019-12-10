Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAB3C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67BE320663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfLJIL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 03:11:56 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43168 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfLJILz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 03:11:55 -0500
Received: by mail-ot1-f66.google.com with SMTP id p8so14731356oth.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 00:11:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zUF00rSBZ0rnjT0she8dgiVuY2HTDNpwSRiMpgHNEPo=;
        b=JrHKV25z641rC4YUp3fMWtpvuHnCbHKTg7bQ/EowcloId68Noial+jQ4mN4Ruz9iNX
         Q/bJACdVsv1YbxcAnzcyyhl7I9/VHdFeuaGeMICB8K0mk344mnLTftfSgOV1DK3vsQ2n
         c8u/WYKmAa8tJMbmlg1qPhw72x8g4GePwNriWFxMhNHhCTjXZJrsxSoftoqhxCoWOI/X
         3J3ekGfAlHwAalUcn7t1dY6lAv+V+4F1qAOo2AdmuO8Gmdtxwk5vAt+F+zUNSK5GHpKm
         PHNLaWivCgQbSjiRxDAiLorQ2otl+kL/r5GNAoR0gdG8+43RO7kxPo9zaBusVzlptQ6n
         chtg==
X-Gm-Message-State: APjAAAX3dFPGoVsj+yDqcePgfwBvbXOrL2ICFCKEIc+iyXWJYgR/AmJo
        pNijC8ySNxNPOvB46RbHdlB3YJTdgcZNk0QsA4Y=
X-Google-Smtp-Source: APXvYqww83pIOrUu0BN3bShrtAYoiA5OS6W6KDKkqzWuPHgtSkW0JmeBXySfxHjIFw+GE00Owf4MpkhUCPqxMM2DCHQ=
X-Received: by 2002:a9d:6c81:: with SMTP id c1mr23733892otr.39.1575965514778;
 Tue, 10 Dec 2019 00:11:54 -0800 (PST)
MIME-Version: 1.0
References: <20191016210629.1005086-1-ztuowen@gmail.com> <20191016210629.1005086-4-ztuowen@gmail.com>
In-Reply-To: <20191016210629.1005086-4-ztuowen@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 10 Dec 2019 09:11:43 +0100
Message-ID: <CAMuHMdXOnAO1h-uMf719muYhD4QEiVi7oMMeeGbuVd+mRrJcCA@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] mfd: intel-lpss: use devm_ioremap_uc for MMIO
To:     Tuowen Zhao <ztuowen@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        acelan.kao@canonical.com, "Luis R. Rodriguez" <mcgrof@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC Christoph (ioremap() API cleanup)

On Thu, Oct 17, 2019 at 10:44 PM Tuowen Zhao <ztuowen@gmail.com> wrote:
> Some BIOS erroneously specifies write-combining BAR for intel-lpss-pci
> in MTRR. This will cause the system to hang during boot. If possible,
> this bug could be corrected with a firmware update.
>
> This patch use devm_ioremap_uc to overwrite/ignore the MTRR settings
> by forcing the use of strongly uncachable pages for intel-lpss.
>
> The BIOS bug is present on Dell XPS 13 7390 2-in-1:
>
> [    0.001734]   5 base 4000000000 mask 6000000000 write-combining
>
> 4000000000-7fffffffff : PCI Bus 0000:00
>   4000000000-400fffffff : 0000:00:02.0 (i915)
>   4010000000-4010000fff : 0000:00:15.0 (intel-lpss-pci)
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=203485
> Cc: <stable@vger.kernel.org>
> Tested-by: AceLan Kao <acelan.kao@canonical.com>
> Signed-off-by: Tuowen Zhao <ztuowen@gmail.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/intel-lpss.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
> index bfe4ff337581..b0f0781a6b9c 100644
> --- a/drivers/mfd/intel-lpss.c
> +++ b/drivers/mfd/intel-lpss.c
> @@ -384,7 +384,7 @@ int intel_lpss_probe(struct device *dev,
>         if (!lpss)
>                 return -ENOMEM;
>
> -       lpss->priv = devm_ioremap(dev, info->mem->start + LPSS_PRIV_OFFSET,
> +       lpss->priv = devm_ioremap_uc(dev, info->mem->start + LPSS_PRIV_OFFSET,
>                                   LPSS_PRIV_SIZE);
>         if (!lpss->priv)
>                 return -ENOMEM;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
