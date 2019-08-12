Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDCFC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 08:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3865420820
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 08:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OY9w3Qb2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfHLIFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 04:05:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37585 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfHLIFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 04:05:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id z23so10925450wmf.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 01:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ufGKwBzHzNSFgdcOablNE0vz1Z8KtfQ2TuFP4lhH54s=;
        b=OY9w3Qb2FPL1d33M1cJQ78ypsj3wJgGSSLa58LntOr6i8+Y/csGOZbC4Ker6pqyPs2
         mDavytQZlhhFhYAVgAjmMWni2VyzsDAx5zM+gi0AwjXuxGATwlfNCG4Ky9P0UNf8vpdJ
         KzQdyR7xciH9PyWU15yjV6Hk7icax2SIkpEvzxgQ3SNr78oaiNIPf8ywfJaBcMp/A9Ks
         Hba2yrD6v3GPn3Uxu+GHDXDrZ64Yp8ZwL4+CnvsWoXAYegzGZTJa872+hxrBlCaT4qrw
         8wI3Ln5V9zkazaJs5Fc/iZRNFAsiZ/oOh1PrtjstePthVp1CFTDR7x3a0WTj4WuOwcpu
         WbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ufGKwBzHzNSFgdcOablNE0vz1Z8KtfQ2TuFP4lhH54s=;
        b=VlXqcIF7A7/3fkqpuWtFinRKdwkZQbIoAZAPVogjzmGXLEtZQg34hbaIgE0QfL86o+
         s4xdjo+lbkAxknAbSq10Ot17QOYaXHiMo+SZkfTDqeEOsxkxH0NQsjcfgfZpIpAvaQpR
         PiMGkmJ3ZbnzyROqmDyj5tUYfJWJ5eyJcSwwPWMqWqSwYo5hdtNXlDhOF1YjwOGX/kQz
         hRlHJvV79BJsO45ENjoF1b7DCSyWTf7DPkhcJgSAK0tv1w4ZJOJ1M1AOELhEFgunU9D4
         YRisQfxPiqrVezvd8c0m/QDJ6DJRGw0Qaq9MFIGdU2gaBgbcV6W/g4TI1H4XPLaZa+Iv
         xLAQ==
X-Gm-Message-State: APjAAAVQIlbb6pde6HeztCYa5qM1BYIY81pjGO60kFFlzMw2S5V/zHUj
        6f2rHMyMq/khbpPeS265Do+UFA==
X-Google-Smtp-Source: APXvYqz6EhFotsYU49z2I1UAbp0US62x0A/jBhKf/LnRcG4G8QeOE3aQJV2P+8AsQawnjG/Y2744Aw==
X-Received: by 2002:a05:600c:d9:: with SMTP id u25mr3152884wmm.26.1565597108741;
        Mon, 12 Aug 2019 01:05:08 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id a142sm10918918wme.2.2019.08.12.01.05.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 01:05:08 -0700 (PDT)
Date:   Mon, 12 Aug 2019 09:05:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     daniel.thompson@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] backlight: lms283gf05: Fix a typo in the description
 passed to 'devm_gpio_request_one()'
Message-ID: <20190812080506.GH4594@dell>
References: <20190724213828.16916-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190724213828.16916-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2019, Christophe JAILLET wrote:

> The description passed to 'devm_gpio_request_one()' should be related to
> LMS283GF05, not LMS285GF05.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/video/backlight/lms283gf05.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
