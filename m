Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0061AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6DE62085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wWuMidiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfHLHrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:47:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37163 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfHLHrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:47:22 -0400
Received: by mail-wm1-f65.google.com with SMTP id z23so10883735wmf.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=aPJyuhmK2M+KC6mnAARKtr39I2//Chy5Fd8BV6X7TQ0=;
        b=wWuMidiSyxxp89AVvVLBSgf5QaqTr4R+d+NeZRQ131gQPs0l46nHdRS2gnXD60VtJI
         uHJHMXHINPxsC0Zq6z4+joiCtgtRMUEFpgubKz4mWSbtuUbeT8Um7yqBb0pWzkP9tsgu
         E0z0N+u4PRGYEjFPrdFlThtw6Enp9iuTYiha4hQTZtjPr/7Vr+8DKsvbEQB+qFn3tz9X
         lTK8w0jztXsjmYw7V0239Cegup0SOL7rVbsN/sLQj2lTZWh3tP/wJprdP2VDMTDuqEJj
         9rqf5uj4DaXZId5t8LQTOiM3haYn5b2EXHz5p1aOsoV572cOysCCbbDbuE+9HlJ++mKp
         I0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=aPJyuhmK2M+KC6mnAARKtr39I2//Chy5Fd8BV6X7TQ0=;
        b=rlXn346HCAL2yqS4UsPpEdCebkC87nUTIRTONpcRGwOyDeV/CcqavkvmNT5zckBTt/
         dMWTZK1ymRfGzKm7zTNf1unfk36USMg6jqmfKTLyK2OxrzugjTUD47K9hq36ZZQk7/mA
         MalqoUR6C8pjDKV/Fri7Bzgbb5Pd0SLyl/J7VZYKMW/t9Zgi8THdpwLrx1zDvbuHINCS
         zwsQpyvOM0d0ABIGixVs3RO3Ks+7bm0a3rCI1S7J7QQP6jxHmKUuWyRX92SUv68rhajB
         xZxXcn8cTVqtdjQzkAIK7ib1tLCk/oHZEzb4P9Q5TiVuPaN7AWlksoNgRZ+iRfZr6I0P
         g1HQ==
X-Gm-Message-State: APjAAAXWY0/BsiQcqhUhBgEmedF/2yULHEGJl8qb5pg4XVn9vMKgvKlB
        qx1+bfI5ESJV6xuhABLaAO6JTw==
X-Google-Smtp-Source: APXvYqwDy88mekwhAswG43mfQirOZeC4mQUuqD9A3hFYkiGJfdoRgGFQms7qSxd30pj55V3Zoa2CaQ==
X-Received: by 2002:a1c:acc8:: with SMTP id v191mr26802733wme.177.1565596040719;
        Mon, 12 Aug 2019 00:47:20 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id 74sm4405124wma.15.2019.08.12.00.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 00:47:20 -0700 (PDT)
Date:   Mon, 12 Aug 2019 08:47:18 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/14] mfd: max14577: convert to i2c_new_dummy_device
Message-ID: <20190812074718.GX4594@dell>
References: <20190722172623.4166-1-wsa+renesas@sang-engineering.com>
 <20190722172623.4166-7-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190722172623.4166-7-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019, Wolfram Sang wrote:

> Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
> ERRPTR which we use in error handling.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.
> 
>  drivers/mfd/max14577.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
