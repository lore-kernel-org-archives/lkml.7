Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4A7C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB152080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fFbqkU8L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgAGKYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:24:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52012 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgAGKYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:24:22 -0500
Received: by mail-wm1-f68.google.com with SMTP id d73so18314949wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 02:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xjl5qI4XWd86lrzWYGglceX2lxOCEh0hpnATWDg+7Rg=;
        b=fFbqkU8L+jl9J3qDC+MPjxQYrDhIkkutyk67tR42/NMqXyZmvw52vAkrCo+SgP+Opp
         WeQChJOII6VgCZfw1U/3mCWDaspncmXaBCYHKVQyuvwdQOYSJqRz7txG9I2YnvrQlJ+z
         LCde1cyaU1y1BzCyZfOwhd0Be6VGwm9hnCZmtp7L8r5IirxsWga+IB5i8I2MsC4Lmjsg
         RSIUb2cztglqVDe10AwuqZvh8iG7ULEJqM8wlGaP2mKCbxH8sWOc1oKWtHmaIDLuObQI
         iALptcu5cBRHY2mS6UbqJ6dcfWWT+mUSpiEloEohjGH7eznqB3sOgQNrdifh24ASaVnt
         Df+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xjl5qI4XWd86lrzWYGglceX2lxOCEh0hpnATWDg+7Rg=;
        b=qrBSUa6yEFgCDM3du4FlpqZ6yDRek+JuM/t/rcWtdBLBDll8MljWxfSS/Qj6Fv7+e/
         KSaM1KOkaur0WdlqkBBzIKM1WkJk+WNWzeJ3T5COUX6dDfS20UJoNWFDk2OuHQQWAvOG
         Xi8RwUGxpRgENQfvgr5KFCARzWfPOn93IhYyWVBnxC+yixhgLHUbON4zoTwVoHf/ea0m
         HFm3ogSFuz+2nAMZ5e8umxTQZiIRH5zXusikfiQ3dPxpIeHiTkfPSvnN4h6a+0nBlX9g
         uI+gmsEHo4Qg86n2enhlmnjOQuJRB19OtN6qfCsuSlDsV/wdnftlpcS/xIFmyADreRyR
         /IlQ==
X-Gm-Message-State: APjAAAXiDy4j/EMIFYlOcGh96l1S9AwaD0X/5ELQN9K8fi+yi0FeKnHy
        JnvhXLubytxgc8pLY7zTcl+iCbFjiqk=
X-Google-Smtp-Source: APXvYqxs8u7r6bK4ViedeM1O4wSoN3ydmbiTSTPsycTkm22bGq482ktp6IJC58DuyaxJkpYHK/v/Fg==
X-Received: by 2002:a1c:14e:: with SMTP id 75mr39918120wmb.123.1578392659962;
        Tue, 07 Jan 2020 02:24:19 -0800 (PST)
Received: from dell ([2.27.35.135])
        by smtp.gmail.com with ESMTPSA id f1sm76317920wru.6.2020.01.07.02.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 02:24:19 -0800 (PST)
Date:   Tue, 7 Jan 2020 10:24:27 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mfd: dbx500-prcmu: Drop DSI pll clock functions
Message-ID: <20200107102427.GF14821@dell>
References: <20191228222615.24189-1-linus.walleij@linaro.org>
 <20191228222615.24189-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191228222615.24189-2-linus.walleij@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Dec 2019, Linus Walleij wrote:

> The DSI PLLs are handled by the generic clock framework
> since ages, this code is completely unused and misleading.
> Delete it.
> 
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mfd/db8500-prcmu.c       | 66 --------------------------------
>  include/linux/mfd/db8500-prcmu.h | 12 ------
>  include/linux/mfd/dbx500-prcmu.h | 20 ----------
>  3 files changed, 98 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
