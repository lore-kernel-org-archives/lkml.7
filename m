Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCF6C3A5A7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7D32173E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GjeWNFh0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730748AbfIBIk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:40:29 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40685 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730727AbfIBIk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:40:28 -0400
Received: by mail-wm1-f68.google.com with SMTP id t9so13634316wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 01:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xl3Ai/AmJFR6ZhTztzr3SBL0HsX+mzfXY2ojYs65AK8=;
        b=GjeWNFh0qzJtRNv2HvHvICds/YkS4LdvROFX4CYEyI+4pLuL3eNmjv3XCtsie8gXNe
         UptA6Vkinbxf2B4m2QNS2dJHMEtorZsE7he4AlyM6kxnQkbxQ1f7tXSrgZUlCujENiiQ
         KbDmM6mjgN1X8aIchZswmgojxyWJM8ZqFivrjFpBFHNiFl0ZK7dp2qGlBzByaJTsVy2O
         z02Ylk8HPjyWcmTuIKetoNU+djS6Hrh5wyc9L0icwNq/d6/cUgz5YMLD9DL24TFF7m0f
         G4YU3dPXlkUJVnHG/Nn0VffzjL7K/0IPs2J4ObsxpAclJ2CtmHwogXVcuk3OqX95oeqZ
         P57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xl3Ai/AmJFR6ZhTztzr3SBL0HsX+mzfXY2ojYs65AK8=;
        b=fgaJwndnQ/g/92HrVXp/4QNdx8Z6JsDClO/IbwPAPZ2CCUljooSy1H/vDPhXIToUyJ
         6nBWeI18nwhqVmeFADErVVgjgR60dwW6v0GwgBIpXVu07cM8jcd3M5rc26to2+J4DVce
         KJNMLHADbL175gsf3cK+NnBzT1+jWSVH2vhfTfGI8GFRmGbgqE2Stu0pY3+wlpKendSK
         cE3/jcpnl/uy6U2sbD+K/V7L11Us0D4wQqTkkBRXfdd/hqoVf86Be3LGG77BYozGK2P7
         UUWLAxlfozNV6OEJxLrjVIbe7E4TYsQ9mlWaFTJMkDNvaRkcibF6rA8i+uZgI6j8fcG5
         HO8Q==
X-Gm-Message-State: APjAAAWzzcB4cxpPkiw5OGiG0U5IqfuOMcHzYN4wNM+Z+24ZfZdRS84k
        mr+7DkYPH1gFW4DbvmVDyiEGaQ==
X-Google-Smtp-Source: APXvYqxQxojiBDTKZPusJic1q3Feb7uYrPchzyphP+/xVK/9HREqN30l5NNGO3CqPCl1x/VhD0itdQ==
X-Received: by 2002:a1c:a383:: with SMTP id m125mr34928752wme.57.1567413626783;
        Mon, 02 Sep 2019 01:40:26 -0700 (PDT)
Received: from dell ([95.147.198.93])
        by smtp.gmail.com with ESMTPSA id v186sm32753984wmb.5.2019.09.02.01.40.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 01:40:26 -0700 (PDT)
Date:   Mon, 2 Sep 2019 09:40:24 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Alexander Shiyan <shc_work@mail.ru>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] video: backlight: Drop default m for
 {LCD,BACKLIGHT_CLASS_DEVICE}
Message-ID: <20190902084024.GR4804@dell>
References: <20190813115853.30329-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190813115853.30329-1-geert@linux-m68k.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2019, Geert Uytterhoeven wrote:

> When running "make oldconfig" on a .config where
> CONFIG_BACKLIGHT_LCD_SUPPORT is not set, two new config options
> ("Lowlevel LCD controls" and "Lowlevel Backlight controls") appear, both
> defaulting to "m".
> 
> Drop the "default m", as options should default to disabled, and because
> several driver config options already select LCD_CLASS_DEVICE or
> BACKLIGHT_CLASS_DEVICE when needed.
> 
> Fixes: 8c5dc8d9f19c7992 ("video: backlight: Remove useless BACKLIGHT_LCD_SUPPORT kernel symbol")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/video/backlight/Kconfig | 2 --
>  1 file changed, 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
