Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E12DC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65AD420B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JRr0iAoI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfEBQoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 12:44:07 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36247 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfEBQoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 12:44:07 -0400
Received: by mail-qk1-f195.google.com with SMTP id m137so1857877qke.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 09:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f4ibFJXvRn07AkRB9EEIU1REKuJjQVK60zzVIafbvUE=;
        b=JRr0iAoI+MM91RQu5rsmPJAedIzsKoYF4oA8RlnAKMvuuZ/R7kd7D6jWop+wCSo/IH
         sjZx/RTzm7bEAImU5BPlvdZbDYOxetIu5lUNjH5SUzMUueOLgxdNIsotblxkSYsuH8ei
         4yHzKCAOujHbiE3xq6PVq6FXLockojf1RGomAuLlXggsW53AGTifnYmEtSoW8KmW7JdL
         LLsjuiCApF6aWjynaZsPnWsROBXNZ+qRnDz5+PC9NqiBLGHLoKhOqQrnPeuKY1HCRv7h
         CnH3bK+ums2L6nLw1ajGrG0FjkZTT0C4HhS4ulTaF76wO/tyj+pBabQ0TdHsK9mP+VLq
         jFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f4ibFJXvRn07AkRB9EEIU1REKuJjQVK60zzVIafbvUE=;
        b=A+TMCiH1WS3upY7vXQ6ZiHJy1MGxo7dXA6xbIgTF72ma236Im6W2qU87T1qdoKcNc5
         bwqY/zARnoKwSMNtALElxD4BuH6pSd8hJqIX7AxjBX2Nf+56fZvIMyHnIavUVMk7oVA7
         NKy97vSK1d4D3P5nKBhWLpxjo2kI8B0fiudj4+UlJH5YC2R79z4srlzZYvcbYj5CO7fq
         cZa+m56ouvXVHq/DGCCz9MquO5x6BVJhfyYyTR2fQMPcaYELyfNqd4Axkb7bNVK1noAn
         6kfhNTm0qWEOgza52dBlCDxPvSqf7kegPE2dwuDlgyyi9seSsyb6Sfg9/UcNVYmaJAMn
         MjEA==
X-Gm-Message-State: APjAAAXXludNz/rWclskpQlaGDarDSL2fMR8lEIWpAszIXwm8oJdpdRr
        7uDYdNDssXAJYbWZiwP7y+2Y967eN7yb7WT8xVQUNA==
X-Google-Smtp-Source: APXvYqxYG/ata7SfkJHe93kUfj6sEEF1lUSMwcEiOOO+swPuj+74SX/aaBFPAxBXFOQaVg003EcEY/DtPNywIAO+hBk=
X-Received: by 2002:a37:508a:: with SMTP id e132mr3689247qkb.281.1556815446374;
 Thu, 02 May 2019 09:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190502110247.681-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190502110247.681-1-manivannan.sadhasivam@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 2 May 2019 22:13:55 +0530
Message-ID: <CAP245DUZ9PWoCWvcB8zP_zTEANqo++FCmmJhKESVW=LrBdfyGQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: multi_v7_defconfig: Enable panic and disk LED triggers
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux@armlinux.org.uk,
        Lists LAKML <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 2, 2019 at 4:33 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Most development boards and devices have one or more LEDs. It is
> useful during debugging if they can be wired to show different
> behaviours such as disk or cpu activity or a load-average dependent
> heartbeat. Enable panic and disk activity triggers so they can be tied
> to LED activity during debugging as well.
>
> There was a similar patch which added these triggers for ARM64 as well:
> https://patchwork.kernel.org/patch/10042681/
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  arch/arm/configs/multi_v7_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 2e9fa5312616..466ccc305a05 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -821,6 +821,8 @@ CONFIG_LEDS_TRIGGER_GPIO=y
>  CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
>  CONFIG_LEDS_TRIGGER_TRANSIENT=y
>  CONFIG_LEDS_TRIGGER_CAMERA=y
> +CONFIG_LEDS_TRIGGER_PANIC=y
> +CONFIG_LEDS_TRIGGER_DISK=y
>  CONFIG_EDAC=y
>  CONFIG_EDAC_HIGHBANK_MC=y
>  CONFIG_EDAC_HIGHBANK_L2=y
> --
> 2.17.1
>
