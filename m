Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04A4C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871C220674
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XhG7FShA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfFXOmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 10:42:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44879 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729578AbfFXOmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:42:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16so14174090wrl.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 07:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WJSvq2LIxATKn+LWMv8CHJiothdM7oH+EVf+Mvst0+Y=;
        b=XhG7FShA6qBbp/WQt/e2IYiVRf7470DLLSVXOvlkyrs9TbPvViOD/uwQ/vLghdUpjC
         eTHY9SsI6KSJohznUNK/y2uTUk7eDLN9TtrWbc8dh0qJcTsr1nnC0FJLi0mZbrSfw3Tc
         QXUVIYjLGtQOW0luTCwwmsbW7nzBh7NrS7qIe7QrrawLQA7FkjLEId41jTu1axBOsyaj
         SHV6MV966pfX24QMfFyGFNT/0ZHN7f4k7k4kuNrdNusuEYw5zj7TVh7U3NFlPpu04icr
         8FeKDrQ16CGYx97n13J0E1HEl/E3u6dh0PiUIhf9t92hCuJ+SaGWzsBsyTe5ToI/7Yhx
         MteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WJSvq2LIxATKn+LWMv8CHJiothdM7oH+EVf+Mvst0+Y=;
        b=I1Y8mg2D9EcOnzq/QR5NFPZvIFdiphjPN+keiNb0GCgvLabZiZ4p9t14KmcetSEPAp
         3LaFbwpgv9EfnA/0gHb2GQe+WrfhF0GxlfLe36NpWVqhMAeX58++x6Rx8IDIGBrsfWn8
         BRmxZp6HyVFa4FbLb9/Bz+gMGOTCLA4MWpCHVkHtaBDE3AEA9NODwMZU3UZlf7dF7QhN
         Hy3V0jxLWtmFO9Ee8HrKD0c2WTze0jyJSFM2NT6ISpz/liU8TIYaLdralb69V6wb04IY
         NBKGv66Wu37Pph1opiASBPwhk+33U4EksREIH2FyredIeO/MO2LDnyKEToDx2KDa9EOV
         EztQ==
X-Gm-Message-State: APjAAAUFTH6FxD1fI7/0+Atq6qSrjT6XoUpVhx3zhZ4TxDjY+8REl8C7
        r8aQZF38byNxbCmYK5jxupKEvw==
X-Google-Smtp-Source: APXvYqwyX1hCtPOWVR/ZT7bPifdleHLNn5A9mPUiZdm00NxEthHXf/lcSAwUdmqXBO+nY60t/9/VIQ==
X-Received: by 2002:a5d:4703:: with SMTP id y3mr52167321wrq.35.1561387339642;
        Mon, 24 Jun 2019 07:42:19 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id a2sm17551916wmj.9.2019.06.24.07.42.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 07:42:18 -0700 (PDT)
Date:   Mon, 24 Jun 2019 15:42:17 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, broonie@kernel.org,
        lgirdwood@gmail.com, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/5] LM36274 Introduction
Message-ID: <20190624144217.GJ4699@dell>
References: <20190605125634.7042-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190605125634.7042-1-dmurphy@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Jun 2019, Dan Murphy wrote:

> Hello
> 
> The v5 patchset missed adding in the new validation code.
> Patch 1 of the v5 series was squashed into patch 4 of the v5 series.
> So this will reduce the patchset by 1.
> 
> Sorry for the extra noise on the patchsets.  The change was lost when I converted
> the patches from the mainline branch to the LED branch.
> 
> This change was made on top of the branch
> 
> repo: https://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds.git
> branch: ti-lmu-led-drivers
> 
> 
> Dan Murphy (5):
>   dt-bindings: mfd: Add lm36274 bindings to ti-lmu
>   mfd: ti-lmu: Add LM36274 support to the ti-lmu
>   regulator: lm363x: Add support for LM36274
>   dt-bindings: leds: Add LED bindings for the LM36274
>   leds: lm36274: Introduce the TI LM36274 LED driver
> 
>  .../devicetree/bindings/leds/leds-lm36274.txt |  82 +++++++++
>  .../devicetree/bindings/mfd/ti-lmu.txt        |  54 ++++++
>  drivers/leds/Kconfig                          |   8 +
>  drivers/leds/Makefile                         |   1 +
>  drivers/leds/leds-lm36274.c                   | 174 ++++++++++++++++++
>  drivers/mfd/Kconfig                           |   5 +-
>  drivers/mfd/ti-lmu.c                          |  14 ++
>  drivers/regulator/Kconfig                     |   2 +-
>  drivers/regulator/lm363x-regulator.c          |  78 +++++++-
>  include/linux/mfd/ti-lmu-register.h           |  23 +++
>  include/linux/mfd/ti-lmu.h                    |   4 +
>  11 files changed, 437 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-lm36274.txt
>  create mode 100644 drivers/leds/leds-lm36274.c

Can you finish of satisfying everyone's comments and re-send with all
the Acks you've collected so far?  If you turn this around quickly,
you might still get into v5.3.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
