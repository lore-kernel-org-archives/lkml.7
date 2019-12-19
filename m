Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD093C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F4924650
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="C0W0Svkg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfLSLBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 06:01:53 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46519 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfLSLBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 06:01:53 -0500
Received: by mail-qk1-f195.google.com with SMTP id r14so4246041qke.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 03:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r4FrNo5LLEspvU9m0EiGD3eytJBEaYUVyq8SH3ZcE3o=;
        b=C0W0Svkg0Llp9ZQuiZFYuGlJcklhQKzim592wdhPRyuZfzvO6Sy8GmgRlXLBdYyg8M
         CnrXmmjidsnz1OPlJ7lXISjmdDSwrtPul+4xso+ezWUJxWZKbQLz/mVUb+ZLF+eH9bTQ
         u75sjyRdj/GEuKHBsLnLOh9VFM4yqIFq36tZDoF6mvyeqaatSfPS9TCEk4HMmDsOFcz0
         WNHxhb1zWXDPywtVLafp3q4kuWplraaVjhNkKR/AiGQMnOon2GZ66zSaq0dyvqUj5U8D
         WAhrOKJsCtgkz2d5eRKxlVtMQKHP0XMUdWi5RzJITjwMjKCCJmwKqBNgL0SfgwQBAczw
         lsog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r4FrNo5LLEspvU9m0EiGD3eytJBEaYUVyq8SH3ZcE3o=;
        b=HCVMYWHNGCH41rmp3BDqkaYQpzY+hoBssWk5EUFQ8UJUOaX/YQC/YCBBlvWQC2QyVk
         0TypE/ODJML0xhrW6PiSEluUtE30YwpUCJpiR/5bw0G5rMcXkl2l0PbjbzicKWeKKVaN
         2tLyhl8IzAiZfD/oIInAJQUP5lpjk2RONJnYBzpI77MLpU8qCdkl0JezRaoaQP9bYErb
         ddOK81qiquo0VzKCe3VDL2QFm9H2Z1QEVfKOGWzhblhMV7zllKrQCLy52CvT7voSnOmN
         EW7YolqnRlmic7xGbNqa3qq/5MJUkBN4FghapsfTv04nau5SP+r/Rnyxqrj/NhvWbqct
         boCg==
X-Gm-Message-State: APjAAAWrGi5pMfL7yQqBFfqSjqzOgM1d4FJtdVJ4zc0l+QF8hJ84wrxw
        EXz5ZS3Udgxw3ubhyx3TzZefEERmFDHQ/DbiNMF5Og==
X-Google-Smtp-Source: APXvYqy4PaZdM7lBnMAneYnTWwRA+ttNw2J5709a9anujnDKaPB/StYNQhpvIdo1lY7WcNj00iKtDkcKHWISHo02XbM=
X-Received: by 2002:a37:6fc4:: with SMTP id k187mr7098160qkc.21.1576753312007;
 Thu, 19 Dec 2019 03:01:52 -0800 (PST)
MIME-Version: 1.0
References: <20191215183047.9414-1-digetx@gmail.com> <20191215183047.9414-2-digetx@gmail.com>
In-Reply-To: <20191215183047.9414-2-digetx@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 19 Dec 2019 12:01:41 +0100
Message-ID: <CAMpxmJUmLOZoKeeo4XMVEOWKRgwfS4O2szVboY-qTTYXg_aTVg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] gpio: tegra: Use generic readl_relaxed/writel_relaxed
 accessors
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-tegra@vger.kernel.org, devel@driverdev.osuosl.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

niedz., 15 gru 2019 o 19:31 Dmitry Osipenko <digetx@gmail.com> napisa=C5=82=
(a):
>
> There is no point in using old-style raw accessors, the generic accessors
> do the same thing and also take into account CPU endianness. Tegra SoCs d=
o
> not support big-endian mode in the upstream kernel, but let's switch away
> from the outdated things anyway, just to keep code up-to-date.
>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpio/gpio-tegra.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
> index 6fdfe4c5303e..f6a382fbd12d 100644
> --- a/drivers/gpio/gpio-tegra.c
> +++ b/drivers/gpio/gpio-tegra.c
> @@ -96,12 +96,12 @@ struct tegra_gpio_info {
>  static inline void tegra_gpio_writel(struct tegra_gpio_info *tgi,
>                                      u32 val, u32 reg)
>  {
> -       __raw_writel(val, tgi->regs + reg);
> +       writel_relaxed(val, tgi->regs + reg);
>  }
>
>  static inline u32 tegra_gpio_readl(struct tegra_gpio_info *tgi, u32 reg)
>  {
> -       return __raw_readl(tgi->regs + reg);
> +       return readl_relaxed(tgi->regs + reg);
>  }
>
>  static unsigned int tegra_gpio_compose(unsigned int bank, unsigned int p=
ort,
> --
> 2.24.0
>

The entire series looks good to me, but I'll wait for Thierry's acks
just in case.

Bart
