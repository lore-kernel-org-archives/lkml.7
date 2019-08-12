Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F0CC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54412085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="byHzQiAd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfHLHsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:48:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33165 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfHLHsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:48:01 -0400
Received: by mail-wm1-f65.google.com with SMTP id p77so10276045wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=E1i1E8TWvO1VSrOqM8vbWck6cQCOPIB0uEJKJYjbhrY=;
        b=byHzQiAdskyAz1hTiWRZbB545tZhX2+uf857cBNYla9a+9uXIde1M030thzJc2/S63
         lOxYfiwskh0rHwbsjflBJCY0laTKpWieT1G8vawhHeudg86YSQmWfRMRvi4gR/uBiPe/
         e6jXP0o55bzizb6R1ew5WfEWmVIr06yVovy+VM9OKmoY7tRvMFnShPgU0W171X6FuEVq
         rcxU6qtm7Ybk4eC6Wu6Vf1I9Ir+7mPgMQmhKQDOnFVQohZRm8bHTHjmrJR4pyR2EtU7M
         oi/R88jD7do6wKlE1Zhe/X2inHxk3m9WyqYZT9iwhZnlOYy0I60T8h22OxIJT0LrseOa
         o9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=E1i1E8TWvO1VSrOqM8vbWck6cQCOPIB0uEJKJYjbhrY=;
        b=kNcntcQXgbHYxvIVSiwVwJgTwc6RpEGRqeOLydUtqgp/EIm7ovHawllO0cdWJPCK0k
         YxNmjPcmVhBIUPkaru9L+FyF/RySpHsqqnl5KI0EdqU+uZo4/ohz1h/GaFrbXBUlSBG0
         YzvC2QXymXDA740UKbNhVCsFb2xVMu7sPinEd1G/LZSTp97qtf7BeZi15C/vA2oTPRex
         C2L0uIWNTES8ohrU7qrcZgnn2+GCl6kw1fLh3/xjSfCe5w5EhCILxvw5mPE9WsQ0eI7f
         I0v45K2nTEGHmLv9zuq0/PYrWjstZ5pW6USnHV+qmlWpS0F7rtuJaT7/p7nIn5dBlrFD
         s3ZQ==
X-Gm-Message-State: APjAAAVjpIpwrUGgUR2W1EUm7zrh30bQUorl3n6726uPKp/LcNngoRPw
        iVSENPUBdrz56Xkl6gRskQDvDw==
X-Google-Smtp-Source: APXvYqx3fMfzlURgW+h/0aIr27PGHhyA9XZzTN6TwwQgDOI4uHFCeuPBiBvvUBoR/Szm+OFB1/8zfw==
X-Received: by 2002:a7b:c0d0:: with SMTP id s16mr12265125wmh.65.1565596078875;
        Mon, 12 Aug 2019 00:47:58 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id x6sm19128678wmf.6.2019.08.12.00.47.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 00:47:58 -0700 (PDT)
Date:   Mon, 12 Aug 2019 08:47:57 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/14] mfd: max8997: convert to i2c_new_dummy_device
Message-ID: <20190812074757.GC4594@dell>
References: <20190722172623.4166-1-wsa+renesas@sang-engineering.com>
 <20190722172623.4166-12-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190722172623.4166-12-wsa+renesas@sang-engineering.com>
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
>  drivers/mfd/max8997.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
