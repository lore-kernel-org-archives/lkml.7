Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357F8C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14E9215EA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gXcmlRyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbfIBI4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:56:10 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35355 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730657AbfIBI4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:56:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id n10so3017763wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 01:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CIYzGm7b+iZT5BpqPDBT7FW2jnFNZ+zipZAzJDvUtCw=;
        b=gXcmlRyPodj9gi7dUy0gsEUmiWTtIS2lagvONI1YhqekOnwHyIUkqCnQp1IpwDzGg2
         zy1ZYx8JaqVdiPgzFdO0Q/tROD1q0LTo6r7djOjuD26+slOsqZ6+t4JQ2PCPZHlwjcQy
         Gxkse/R9BymujszdESyx+hTaYSgNBfrw9q9DdAcEOaN8fbQ3RCAFz3J0QA0QnjPZeLiE
         o0Vf8L44bUnDKSJB0y+gcrMr4+fHQY7iCj+iiQRkkxJ6M5jC5sDyitgmjBvZ1tg1fLpg
         d1v3ToN1EBK2fMIkBqs+7zMHMLBhPKI2/UQa5PalNJSz2D2U2Bmf9O1CscHJgJY8hSPR
         SrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CIYzGm7b+iZT5BpqPDBT7FW2jnFNZ+zipZAzJDvUtCw=;
        b=ZR6zMAiHyXrogp/NmkQlQhEUip5385zGWZ9kncXOoDcnQb4KiDvCIfmE9ZFnKwycuY
         r1H1J/C98oG99Zf+lmWel5llRfqDWHLmOM2UJAh+LZEl9YV4Em3ssgcRjf6X6J2xKOcw
         8Kk/YuU+n2DVBKj/MJivaxghRvEB5366/c5gRtyqwHqIe5t0kDcz6FGrgoeEnraZYOe1
         K3k+GdGYinAyIweOUWJP2F67c2y/JeuHfJTYN9gPFurzZHyKF2xTICDPByDDWxlW+wce
         GfnjLTNwPTSM8jeY/pyTMYsmCJ485EKskdyzFNUxG5Guy3YJiyxZHAWmohhpxgGdJDOe
         /aMA==
X-Gm-Message-State: APjAAAVgX1CcgTJEz7zqwrAAM4bpe5i/XtrmTkJnQnftOBtTi4xUGuTi
        emp/GW7fJUX3pTmCSynJLHL6dB12vYzheA==
X-Google-Smtp-Source: APXvYqy7+rsY6seOsY61PSgsFbNJgbDvEnMHS8Y7tU1Qd8BUlxYl16Vg1nIYNI8oPX2S2/K78Srbhg==
X-Received: by 2002:a1c:740b:: with SMTP id p11mr34709671wmc.6.1567414567524;
        Mon, 02 Sep 2019 01:56:07 -0700 (PDT)
Received: from dell ([95.147.198.93])
        by smtp.gmail.com with ESMTPSA id n14sm49223513wra.75.2019.09.02.01.56.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 01:56:06 -0700 (PDT)
Date:   Mon, 2 Sep 2019 09:56:04 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: intel-lpss: Consistently use GENMASK()
Message-ID: <20190902085604.GA32232@dell>
References: <20190816173342.21912-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190816173342.21912-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2019, Andy Shevchenko wrote:

> Since we already are using BIT() macro, use GENMASK() as well for sake of
> consistency.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: drop extra shift, move line closer to other bit definitions
>  drivers/mfd/intel-lpss.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
