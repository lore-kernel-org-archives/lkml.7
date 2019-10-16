Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58E5C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA23E2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zprs0y8k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390394AbfJPHwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:52:23 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53251 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfJPHwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:52:23 -0400
Received: by mail-wm1-f66.google.com with SMTP id i16so1727837wmd.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=l+eDQw7b9v7Rw46oLorXW5Yed3sU+eig9M618FB+PL4=;
        b=Zprs0y8kBPQ3qjTVj/r66c07zEzYHAzGc1PwpC8CEkHTDvqlLmt7M9IKkPG10MDX01
         D861ajFGmQM6HGs3TOMfSMF0Pe83Ip5jRZ55/ycWUp9KZ9IK11efTLb8xGOQhKdgb0wF
         xJjMI/h6Nl++vvudQQmifg+LMHoaMDAbSZKphm54kioxj9bGuPlc+qtMQ+nkiv/iSpel
         EhhAppoZJC+rVWeLFhgJb7pSEBRI7Xr5x3Xjkb+zL6MH+BhLHPhaESB7c8B95pqXhR1N
         q6WBHssNi/PNZA9Jkx8v2UHWiXPdNn7uPZ2K1uQsUWs+xYohzd7Ue5lt8SD9gFiVq90Y
         RpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=l+eDQw7b9v7Rw46oLorXW5Yed3sU+eig9M618FB+PL4=;
        b=PJNHCWgV5NUoWE09Ezm6/fSyAPUefIwk8J7ushiYi2zuIDo5kzC9AEuZhMu9pZLLk+
         UVMrIBOflGgzcp2DP3EdY4rKMX1giw6FAkUNHQQfeplmskBJqW7YP4kFwsFaX4R6eeY4
         fE+mBgzlbSw2JAOwOLicyGZmiLRv29V9oXTvXZjK4AQwhgh5zYePXb9+ZRWEwkjwNS2c
         nQ16n1X0UTvFYqG+twxnpe+Rxu3Q0kRF8eN1UufRWH5ZLetue3atgNQCdk+MQr3DIvv4
         Wrfq9oYYZRZq+Hv73yqmt8/k/g2G3kjZFs0QLUXxrf2dQVdWv+El3UBQDPx7A0YBmo4u
         f6Jg==
X-Gm-Message-State: APjAAAXGPfojVpJuTdfAuA8MOU5YzaoXvjQLazvTEwXJYJdpbSKtMCsA
        0ufLFvaq6mXoGxseCp/D0UeN4WNyH8k=
X-Google-Smtp-Source: APXvYqy2R+5UwjDoVktwSQkiSJQLn97WIr2FWHdpPx/CIry4HyNQrzJNEJ4i9wILKyZVVU8qvWRaBA==
X-Received: by 2002:a7b:cf05:: with SMTP id l5mr2044282wmg.119.1571212340927;
        Wed, 16 Oct 2019 00:52:20 -0700 (PDT)
Received: from dell ([95.149.164.86])
        by smtp.gmail.com with ESMTPSA id l11sm1630442wmh.34.2019.10.16.00.52.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Oct 2019 00:52:20 -0700 (PDT)
Date:   Wed, 16 Oct 2019 08:52:18 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] backlight: pwm_bl: Don't assign levels table
 repeatedly
Message-ID: <20191016075218.GB4365@dell>
References: <20191002095541.v2.1.I4f2ede1f55ddd1c72b0303b7fd7f73a782fa33e5@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191002095541.v2.1.I4f2ede1f55ddd1c72b0303b7fd7f73a782fa33e5@changeid>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Oct 2019, Matthias Kaehlcke wrote:

> pwm_backlight_probe() re-assigns pb->levels for every brightness
> level. This is not needed and was likely not intended, since
> neither side of the assignment changes during the loop. Assign
> the field only once.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
> Changes in v2:
> - removed curly braces from for loop
> 
>  drivers/video/backlight/pwm_bl.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
