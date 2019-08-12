Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9B2C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA1E2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SnhAzWfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfHLHsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:48:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35067 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbfHLHsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:48:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id k2so17862188wrq.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=W8WcwmLi0Keqjqp1dlbohi1JK99Y2to0yKuNcuzaSIc=;
        b=SnhAzWfFl0VBd5gVo6j5gC5cYc2SXxssTyJ/pWH6lgJ/xGlnm+sDURAoOt5jngWEVt
         OE5AoLEDr8NQql1pveh6rCMYQp3G7VvRdXa31F7KwbRXF8MCM7lSEsnaG/VoXfW8fn1t
         5sNwMqwnsZ3RXDZCcNVA3bv5ZrM/DGLwRu/K3HroCOyxdFBXuNlh10PHjq7zLy5CzJGn
         D3C6OzfItrQdR8/Hu+Wjl83I8vvKbGiICc26MYDyv4pKhkZMnRgwTXptbBx+jzHVbYBA
         kYlfXHhhHc+wQoMmfldD/y0JJHi5AY81HS36JRvd+mC27QVpPzaFrF0cBOXFReeFIWXr
         K6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=W8WcwmLi0Keqjqp1dlbohi1JK99Y2to0yKuNcuzaSIc=;
        b=kDaL/TwiPDEZgR3sTtb4V8YoCoUuCvkI331UyLEafFj070iQ/TOHn1tDj6Bv1nENkD
         g+bPQHjGMbUwbLGTAn7dRlG7Gqekka4e2WTyr88Xm3brpop2DVYoOVc06k0Y69fJZiAa
         uJbCGfcQh0R54Nu2wGPoTyYtUgSUu/G/Uj/Gyz/bxEuZyUqR3wLfHEwik7cnscc5PQpp
         LsZrwuzsxL4BgHbIcuDm2gNog60KG01kzhwA5bLayB13Rhv9mk+OrxbCLtl+ikc+PLGO
         rwEnJBGZ+bYl7N9XJ6jIPizwU6UBQKrsbj7ycMKCblqZrmEk056Hoy11XY+u9wHfz7wR
         FkHQ==
X-Gm-Message-State: APjAAAW2ROGA0HhbRhUheDmQb6DOV1ZeEbevKSa/k9LXPdkuOhiKnXkf
        h20QBhuJBi0OSqamkyqV8/gWWw==
X-Google-Smtp-Source: APXvYqzVwL2tZXxtuOk75TDD2iXuB6iq2HovoexBdlGIuyJl2OpWK6S+QzXVvcXvxPBvSj6tDy3emA==
X-Received: by 2002:adf:91c2:: with SMTP id 60mr41263939wri.334.1565596093391;
        Mon, 12 Aug 2019 00:48:13 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id w13sm43979199wre.44.2019.08.12.00.48.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 00:48:12 -0700 (PDT)
Date:   Mon, 12 Aug 2019 08:48:11 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/14] mfd: palmas: convert to i2c_new_dummy_device
Message-ID: <20190812074811.GE4594@dell>
References: <20190722172623.4166-1-wsa+renesas@sang-engineering.com>
 <20190722172623.4166-14-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190722172623.4166-14-wsa+renesas@sang-engineering.com>
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
>  drivers/mfd/palmas.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
