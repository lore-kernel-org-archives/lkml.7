Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C99C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E36C6208C2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G8Apsdac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfEFHhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 03:37:53 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39198 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfEFHhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 03:37:52 -0400
Received: by mail-ot1-f65.google.com with SMTP id o39so10595405ota.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 00:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VBzgaXpZlMW3qUziKMTrNIsU6hoCECAA0i8m2SW5Vno=;
        b=G8Apsdac6cxEre7pzQch8MuGvLvy4OAtrerFD+8qUqPq00aP7B+rH2m2zh3fNiP683
         JehsG+fRLsRyp//KRtYczGH4yN3/qRae0Yoz8nUiIYy4QvgA/EvZh6vlT0qAf4y+Pc3c
         Jm656p/xZ+K2CNY+PrRf/kDB65dlgip3ZR4nZ6wuj3PmsRWHhQaLqT+BygaLHxG4RSNx
         5bSTtESxQhLlea8qgJPl+qgXiTLgKMP7y/IqUkE/37dbXGtZvYfqaEnEjUXo6aM3r6Gt
         YOoIsa1QbIkID6YMdwJ267M+ofqNBXOy08lz0fdr/O+QHIEyi0pGeUOMIe6zCIYaXAIy
         Kt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VBzgaXpZlMW3qUziKMTrNIsU6hoCECAA0i8m2SW5Vno=;
        b=jIssYLBfSXiOHXI6V0/ss9rcTQ5XBWOfscbvQKWr0Yb7Ufd+ls7Jya+PwrrcDMJKJp
         tcqqxObB6OtlvdiMAVor2tAN6hazzhhYnyktbNA0bx5PzZtwZeVhuuxFYmDYt/mETvdE
         5VpduTcN+/LuyJhJPnTDxQhGC1z2oJKvEA5+dpqqs2ZiyJfCfJv7Q8fNvuGQUDNz0d7d
         9C2S084KJ3zAtg8+SuLfbidPC0/72evChcKlwSq211Dx8iLc59S2i6VMpirR8hDEp3QV
         rVxV1OCAzkeO9Vlw1oyZ1dGTPuAxmpAu132tu/oh7lcAI9LjvHP13K5pXWMr77rVnn3c
         09Iw==
X-Gm-Message-State: APjAAAU5s2KZMmp4gwLDiYnhtt8+7y8DN/72PeCac9awiznjyX7bVqCc
        XFnZVWYzIS5M6t7CGG0SvVxaPrm2KFmwasaZLd3exw==
X-Google-Smtp-Source: APXvYqyK4/SAtmNGvtd8ck3bkArJwNTGFExfjP5d2CwifK0lVSo64KVSCvSjMkZDMJ2Qwp4Isu90YKRnrZ8jvsp4Ctc=
X-Received: by 2002:a05:6830:b:: with SMTP id c11mr15200300otp.281.1557128271074;
 Mon, 06 May 2019 00:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <ee4a22c3491628abf94c8d356dccd67984604811.1555049554.git.baolin.wang@linaro.org>
 <20190418102606.AE0181126DA9@debutante.sirena.org.uk>
In-Reply-To: <20190418102606.AE0181126DA9@debutante.sirena.org.uk>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 6 May 2019 15:37:39 +0800
Message-ID: <CAMz4kuLK_XS93Wpq+BkXVAJA3M+vFnL8pR0gR7aRpYxBzwLv9w@mail.gmail.com>
Subject: Re: Applied "ASoC: sprd: Add reserved DMA memory support" to the asoc tree
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Thu, 18 Apr 2019 at 18:26, Mark Brown <broonie@kernel.org> wrote:
>
> The patch
>
>    ASoC: sprd: Add reserved DMA memory support
>
> has been applied to the asoc tree at
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2
>
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.

I did not find this patch in your sound git tree and the linux-next
tree, so could you check if you missed this patch? Or did I miss
anything? Thanks a lot.

>
> Thanks,
> Mark
>
> From 25a073bb9ceda91b8bf731b20ac01b68cc8877a9 Mon Sep 17 00:00:00 2001
> From: Baolin Wang <baolin.wang@linaro.org>
> Date: Fri, 12 Apr 2019 14:40:17 +0800
> Subject: [PATCH] ASoC: sprd: Add reserved DMA memory support
>
> For Spreadtrum audio platform driver, it need allocate a larger DMA buffer
> dynamically to copy audio data between userspace and kernel space, but that
> will increase the risk of memory allocation failure especially the system
> is under heavy load situation.
>
> To make sure the audio can work in this scenario, we usually reserve one
> region of memory to be used as a shared pool of DMA buffers for the
> platform component. So add of_reserved_mem_device_init_by_idx() function
> to initialize the shared pool of DMA buffers to be used by the platform
> component.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  sound/soc/sprd/sprd-pcm-dma.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/sound/soc/sprd/sprd-pcm-dma.c b/sound/soc/sprd/sprd-pcm-dma.c
> index 9be6d4b2bf74..d38ebbbbf169 100644
> --- a/sound/soc/sprd/sprd-pcm-dma.c
> +++ b/sound/soc/sprd/sprd-pcm-dma.c
> @@ -6,6 +6,7 @@
>  #include <linux/dma/sprd-dma.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
>  #include <sound/pcm.h>
>  #include <sound/pcm_params.h>
> @@ -530,8 +531,14 @@ static const struct snd_soc_component_driver sprd_soc_component = {
>
>  static int sprd_soc_platform_probe(struct platform_device *pdev)
>  {
> +       struct device_node *np = pdev->dev.of_node;
>         int ret;
>
> +       ret = of_reserved_mem_device_init_by_idx(&pdev->dev, np, 0);
> +       if (ret)
> +               dev_warn(&pdev->dev,
> +                        "no reserved DMA memory for audio platform device\n");
> +
>         ret = devm_snd_soc_register_component(&pdev->dev, &sprd_soc_component,
>                                               NULL, 0);
>         if (ret)
> --
> 2.20.1
>


-- 
Baolin Wang
Best Regards
