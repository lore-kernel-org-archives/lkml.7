Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E07FC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A1921874
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jp3giVDe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731322AbfIBJlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 05:41:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37470 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731307AbfIBJlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:41:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id z11so13299427wrt.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 02:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZL2haMI2aTtJurgKOti2qg6P2dpB10rrMYX8xsD2bK8=;
        b=Jp3giVDeY/0YoOVsPWRfoipAvNrzI7SL/np7C/5ElKhomtCfzrE5qjSsgFLnvv+6ZH
         lILykF95Pb4ijIZzZkaRiTqqBEIeFeKsVvMtQvJ6lBPBwxjaQVfXsjEyVLkPFCKXE4B3
         DrWHHs+HbI/F+q3dhSOuFdgQsNXLr0nM2yrOla+U/Aw8bvW0fsrUez9tDU4q4HSs2cB4
         3UtfZt8rdx6Gl4LZk1oY0gUY8s7knHlKkWdn3nwNRkUjShH/h3ie/SGOfYieJgjpA2XY
         2DI18qzAQKD2TsWZW7QDG9lKvubbZH1Kkkp4cH54fJQ0CZG37DAim0aE1ELf7PWuLK4/
         zkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZL2haMI2aTtJurgKOti2qg6P2dpB10rrMYX8xsD2bK8=;
        b=rGYL0qpMbhur4Kyon6aPpczrWaYCXymX7ynd6ra3QNt3yyBeOXKRx5xpVwJMnrqbKO
         jxhLGDvJPi0peJluRQ/Q4k7JSAGlAEtPZTEN4RsuFDOuleHPS4XeMyagMfhzqHEYqJFe
         aj3P0/4UNuOT8XYKBqTc9djSWLpjQEGpW754QGFKY8uZ+dgSu6hUR+OUXF9sVJcPStW4
         GbHIIrXOK91jlDBLe8g/s2zDpJwZyVP0Zba1EN5zm5YQmWP+sdeQOYtEoATVhv4BUXRl
         hNaAuiVbIxPzw53HeP2RXdHidFg1XAmUT4XRmjq3fs4/0nbuqI6HkOSzQ+0fKE1p5j9E
         Ptew==
X-Gm-Message-State: APjAAAVhWIsvGpbPLIbC9KzkLbDlIhXtL1kDJrYSG8gn6szV9QqkV5AW
        8sCGjeDn3Q6IY0/EGvGRrOxl5A==
X-Google-Smtp-Source: APXvYqz+ei3zvK9WDCLGPKSb6mZHeIVD4NjOj/SiGtZ3rCzqedIErcw16UBzZxGSMgr8fc4SWNzRbQ==
X-Received: by 2002:a5d:51c6:: with SMTP id n6mr14215758wrv.206.1567417312894;
        Mon, 02 Sep 2019 02:41:52 -0700 (PDT)
Received: from dell ([95.147.198.93])
        by smtp.gmail.com with ESMTPSA id j26sm4577684wrd.2.2019.09.02.02.41.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 02:41:52 -0700 (PDT)
Date:   Mon, 2 Sep 2019 10:41:50 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH v3 3/4] backlight: pwm_bl: Set scale type for CIE 1931
 curves
Message-ID: <20190902094150.GN32232@dell>
References: <20190709190007.91260-1-mka@chromium.org>
 <20190709190007.91260-4-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190709190007.91260-4-mka@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Jul 2019, Matthias Kaehlcke wrote:

> For backlight curves calculated with the CIE 1931 algorithm set
> the brightness scale type to non-linear. This makes the scale type
> available to userspace via the 'scale' sysfs attribute.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
> Changes in v3:
> - mark scale as non-linear instead of using the CIE1931 type which
>   has been removed
> - updated commit message
> 
> Changes in v2:
> - added Enric's 'Tested-by' tag
> - added Daniel's 'Acked-by' tag
> ---
>  drivers/video/backlight/pwm_bl.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
