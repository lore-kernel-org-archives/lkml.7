Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B51BC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F2C02070B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CgDYWAIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbfJDMH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 08:07:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38271 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729466AbfJDMH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 08:07:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id w12so6895930wro.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 05:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BdW+9Mux8Xy3MFNcNVfipPeeVfXEPHbL3cQVSS7KHjY=;
        b=CgDYWAICIsHL1H1yTpwOivNqlAyZsHKmwy+hBjEnEqq+8rajvn6WIgUEpXj0i4HiBq
         Q9REVH061gdwNTqIa7BvzdnfKmjxR2OZw2+nqk5hjxWGpJ9pQHijyJlK83AtZKkVUqEm
         +lB8Prfjliu2SaqdPvR3LUuUrTvGcUlEeQ0m6zSC7ArwxfJc/46z6A3wseROn6VSu8Sh
         q+J7a+IZWpg73E8mzN4oqQUlTbfGl97n97NrogJ//FQpPtVsVYjm77gXHqClnpA6+7MK
         gQyl2Pt1yCL/8qa+M6uGKwo17BP5F+R8swQrVctY2jbGGx+1w14CeuHGrwyQEp4GOTeY
         /sDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BdW+9Mux8Xy3MFNcNVfipPeeVfXEPHbL3cQVSS7KHjY=;
        b=QXzhVfdcMhPxPvNDB/FU1D74pZebGWCtOh0W8BkNBbGIQMcLThYdVNsvdJr2HL9gF3
         RRS9qVRVk8u0NdXQIpVyTLW7JUFdUo4uJnaC4a6hUYCL4DJCE7L8txm6cYuAk0fZkSF/
         0h0WJLu5MUmXfX/5dK5RjGgL8PSiW6wbRqO5LjBsP92oqdIKmBCGilrFf8Q72T6BBxtA
         rIhSUBGdvG5XhTHVven55n4ZCOIoQSqv1/tFrB8Ssgf+xNcGrWJVyxUk22eqq4HxsPfg
         fxwRSR8fCwH7eMaWw+bsEMli+UNahYJD2OpblQzpvaBi1zQHaEQlu1PfjgyAtBih1sJm
         NCyw==
X-Gm-Message-State: APjAAAV1d60TE6W9/EBkEJI/FmOpK5zFHA0z9DSK1pAqwpG+kcPra7ZC
        5eAQamL0TAbKC6LQiAf6WWYfrA==
X-Google-Smtp-Source: APXvYqyioV8godBqg5bZXDirA4WwtlIfhtI9Pg1jFdtyfEaWskHwFUhjh01Z4lPL0cpf538Gp/SBrw==
X-Received: by 2002:a05:6000:162e:: with SMTP id v14mr11816375wrb.112.1570190874325;
        Fri, 04 Oct 2019 05:07:54 -0700 (PDT)
Received: from dell ([2.27.167.122])
        by smtp.gmail.com with ESMTPSA id c4sm7746423wru.31.2019.10.04.05.07.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 05:07:53 -0700 (PDT)
Date:   Fri, 4 Oct 2019 13:07:52 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Himanshu Jha <himanshujha199640@gmail.com>
Subject: Re: [PATCH] mfd: ipaq-micro: Use devm_platform_ioremap_resource() in
 micro_probe()
Message-ID: <20191004120752.GD18429@dell>
References: <d9990bcc-2daa-67ad-4de5-7a849668d038@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9990bcc-2daa-67ad-4de5-7a849668d038@web.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2019, Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 18 Sep 2019 13:40:30 +0200
> 
> Simplify this function implementation by using a known wrapper function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/mfd/ipaq-micro.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
