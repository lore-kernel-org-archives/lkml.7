Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1034C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E8D2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfFXH7X convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 03:59:23 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39168 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfFXH7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:59:23 -0400
Received: by mail-ot1-f67.google.com with SMTP id r21so12611829otq.6;
        Mon, 24 Jun 2019 00:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4YpoyfmTg/yJjXBJUEW8lIAq0BX0A3h1rodT0G3oFiE=;
        b=OaVgX3dYDGfmHXyCBD02Dkeu7I+SJ3wvGnmeoA+qkx34DR/OFEVLzQEvZVvtY+08vO
         NcOjqOvGt6ev857Kjcu1Z6eBK7/EslJjqcPsidgfkRBbYu28RjyVs5ASEnzrbiYbvaOb
         ThP+JZWq6JyhEf+nVDK8W7jpcfEuZlrBzVAjda3mGwpfzIUxahtH2WjVCg8gD77Sf8PT
         TxnnxGmxbhc2AvudyQIYktw19gjmrj8hEf/Jmt0LeH3KcONssYCLVrdB7LGM2AZzCg5d
         TG3jGtk2q/mU2r1jSeQ6xR7O1IwxM1LpwqET1IcxCvtCYQw84bXmIzcphSwJU32SSsjr
         5PnA==
X-Gm-Message-State: APjAAAUA7SsS9pLApFjmt+1dhxayy+PURf3lB+UNBMS5mdFMJXkOhgLa
        jzcGFbiC8D7YVfcCpTEMUugVhhcm8HfLUOpUH4g=
X-Google-Smtp-Source: APXvYqwhwIK4NZgkquLOyqT8QbysnSfbWAaf17D1uMjFj2Kp4TzxuPY6nfGxD9epLJ/u1+zuUN+dib7gFMfkh1MQqQ0=
X-Received: by 2002:a9d:69ce:: with SMTP id v14mr15870540oto.39.1561363162185;
 Mon, 24 Jun 2019 00:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190622114208.24427-1-sam@ravnborg.org>
In-Reply-To: <20190622114208.24427-1-sam@ravnborg.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Jun 2019 09:59:11 +0200
Message-ID: <CAMuHMdXhVNGsEsUbmzYiFJcDN2uR5WFEFT5qdHdo0pF=0BGphA@mail.gmail.com>
Subject: Re: [PATCH] sh: prevent warnings when using iounmap
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Inki Dae <inki.dae@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On Sat, Jun 22, 2019 at 1:45 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> When building drm/exynos for sh, as part of an allmodconfig build,
> the following warning triggered:
>
>   exynos7_drm_decon.c: In function ‘decon_remove’:
>   exynos7_drm_decon.c:769:24: warning: unused variable ‘ctx’
>     struct decon_context *ctx = dev_get_drvdata(&pdev->dev);
>
> The ctx variable is only used as argument to iounmap().
>
> In sh - allmodconfig CONFIG_MMU is not defined
> so it ended up in:
>
> \#define __iounmap(addr)        do { } while (0)
> \#define iounmap                __iounmap
>
> Fix the warning by introducing a static inline
> function for iounmap.
> This is similar to several other architectures.
>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Thanks for your patch!

> --- a/arch/sh/include/asm/io.h
> +++ b/arch/sh/include/asm/io.h
> @@ -369,7 +369,11 @@ static inline int iounmap_fixed(void __iomem *addr) { return -EINVAL; }
>
>  #define ioremap_nocache        ioremap
>  #define ioremap_uc     ioremap
> -#define iounmap                __iounmap
> +
> +static inline void iounmap(void __iomem *addr)
> +{
> +       __iounmap(addr);
> +}

The alternative would be to make __iounmap() static inline, which may be
better from the viewpoint of consistency within this header file.

Regardless:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
