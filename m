Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4BDC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A28820693
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xcvXOgMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfDKQkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:40:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33746 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfDKQkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 12:40:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id q1so8277211wrp.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 09:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=OEsAGu5FY2oqAqolGl6W2+S5SjflU5nYh0bRo2ivrKo=;
        b=xcvXOgMWMmGIZQyJfVYL9B4/04simq4Tb1B0B4HZf/38fKoJwnbfwJEUDd+5aqyZGF
         vn91/46j//qhcGZ2IKGkqLz0HfA8pxCQXL7EFeTVIia9ftVGSNhbUnGW/lvhuPi/mKhH
         s8NyT0er5Qqc0uv6lSfavsHwZTrAO452YO+S9a2d4sWitqWXqKtxbnkALPyX3vERuf33
         tAV6l7reP6hpnXydad3erl4EA5r8ioRKdZvqrdHW/Hceyica7+Nccpr5Bg8MSOSlKR/u
         YT/8IyV/Rk5roYSQsuTxN6SxNsflUD+L3eSClvbVnONHI1s8LpmeDRTA904mFlb/YxNr
         +e1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OEsAGu5FY2oqAqolGl6W2+S5SjflU5nYh0bRo2ivrKo=;
        b=pyLH659Pk/3znzwL5wiycGba3/4FbZqkjG2sL9w8Mbh2uN9wQPeFuXa6rLeMfZWUf5
         6p2OHmcCq9jLmYbbAr6osNoXfhtBsdpoc64WYo1I3NYd2H/diXkBnQnxqk1bsrky/V4D
         gYpI1ooSrac75SjIS5oSq51FfrTDgW/QHgz/LcbRygWdT6/K9w8etGoKolWgvjaomW0T
         h8LZ8XyBjvlu6tWbI/IVgrQLqHmpwnsRnpou+2g0hiEopCFgxIly4BbYldpi0Tbiwssv
         /uQYRGHpnMBlGZSF+RDKYsr47CeMN5AOxU48/IrYXMUqLuKl3QK8vhjuiDeXPvH9NVm/
         jkTw==
X-Gm-Message-State: APjAAAWOyoG50THry+vvrazZcf2gztxMgjx5MCPzuG31flaK6d4EnZhK
        4rm3BeuZNYkK21tJYzz9wRVcDQ==
X-Google-Smtp-Source: APXvYqy8kvXe8sp3uA6Vjd553WaEmvQqpcGB+IAUBjUEJ9mcsPgTvGgr+zWr257iifWdaeU9GNuWCQ==
X-Received: by 2002:adf:edcf:: with SMTP id v15mr7867744wro.20.1555000839751;
        Thu, 11 Apr 2019 09:40:39 -0700 (PDT)
Received: from [192.168.8.100] (195.118.130.77.rev.sfr.net. [77.130.118.195])
        by smtp.googlemail.com with ESMTPSA id g84sm9684634wmf.25.2019.04.11.09.40.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 09:40:38 -0700 (PDT)
Subject: Re: [PATCH v2 3/7] drivers/clocksource: timer-fsl-ftm: use common
 header for FlexTimer #defines
To:     Patrick Havelange <patrick.havelange@essensium.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Esben Haabendal <esben@haabendal.dk>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Jonathan Cameron <jic23@kernel.org>
References: <20190306111208.7454-1-patrick.havelange@essensium.com>
 <20190306111208.7454-4-patrick.havelange@essensium.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ba80affb-0d9d-8248-f995-788105394bb3@linaro.org>
Date:   Thu, 11 Apr 2019 18:40:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190306111208.7454-4-patrick.havelange@essensium.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2019 12:12, Patrick Havelange wrote:
> Common #defines have been moved to "linux/fsl/ftm.h". Thus making use of
> this file.
> Also FTM_SC_CLK_SHIFT has been renamed to FTM_SC_CLK_MASK_SHIFT.
> 
> Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> Reviewed-by: Esben Haabendal <esben@haabendal.dk>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
> Changes v2
>      - None
> ---
>  drivers/clocksource/timer-fsl-ftm.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-fsl-ftm.c b/drivers/clocksource/timer-fsl-ftm.c
> index 846d18daf893..e1c34b2f53a5 100644
> --- a/drivers/clocksource/timer-fsl-ftm.c
> +++ b/drivers/clocksource/timer-fsl-ftm.c
> @@ -19,20 +19,9 @@
>  #include <linux/of_irq.h>
>  #include <linux/sched_clock.h>
>  #include <linux/slab.h>
> +#include <linux/fsl/ftm.h>
>  
> -#define FTM_SC		0x00
> -#define FTM_SC_CLK_SHIFT	3
> -#define FTM_SC_CLK_MASK	(0x3 << FTM_SC_CLK_SHIFT)
> -#define FTM_SC_CLK(c)	((c) << FTM_SC_CLK_SHIFT)
> -#define FTM_SC_PS_MASK	0x7
> -#define FTM_SC_TOIE	BIT(6)
> -#define FTM_SC_TOF	BIT(7)
> -
> -#define FTM_CNT		0x04
> -#define FTM_MOD		0x08
> -#define FTM_CNTIN	0x4C
> -
> -#define FTM_PS_MAX	7
> +#define FTM_SC_CLK(c)	((c) << FTM_SC_CLK_MASK_SHIFT)
>  
>  struct ftm_clock_device {
>  	void __iomem *clksrc_base;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

