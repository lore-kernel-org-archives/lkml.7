Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7024C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF3B20830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rfHNYrLu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbfDCICJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:02:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46815 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfDCICI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:02:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id 9so7728438pfj.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 01:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZyFTbAeR477CeiGmus7+YTiUbAe2PCQXI3FX5QeFFHM=;
        b=rfHNYrLur7QeAHOxaFD1cP9NQI0ShZfJPQEw109CxZn8fbblOd1LWkTbz3+LkAOb1u
         ZFw7SpjCqdy7vH16Z7fhTz7D29EMAQmfWeNLrQRr4CpqRkjAY/p3G5gWq0cMj5C8xJ4r
         uoUt5vomIWn1NJPSLSJ5nnOZFyS7QzIoTNeoY/CshMiVQbLo4G3GDm0NqH42rqKhX8X4
         P4+KjD6tul4El11fye0Sr5PgjTTdb77fBgxZhrpBizdMGeGo5BOXg8zMiQg1c9dZjYe5
         slOF/zApW6IDya7DlDPvUaHmumlsi7t2Y28XvzOnp60VFVXfJ6rnMUO5tKl2sAJRp+82
         jkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZyFTbAeR477CeiGmus7+YTiUbAe2PCQXI3FX5QeFFHM=;
        b=sWfVgG7PyOWA3/9Kk+rI5lMO0wnlP/9HjeqxQcl9CD998IYa6YUbf+6hCw9KCIoXzp
         ytHOE64UuViUsdd34FFStfy+K9tyAmKEr/+28SH5A4aWyUJI5tIrIMq+DQhHFAgZi6Er
         dJ3CqGVNmOJehrVQNs8JNKI5LEsCegBOT/PagbInDy4kawKG6OSstLNwhmBu1PnKYq9t
         MQFQctPvvUPiNnP9BNJ+qsceiXOBcjWlt9jydcTP9+n91ivKP8K29Nu1clYpVHPxTFdA
         xgF37yDwZV1znJSOcjrO4Gvds8mIlyTX+IShurT5Jq190JPlp3Xecsy+h3/gjbqRNEAC
         fNWw==
X-Gm-Message-State: APjAAAU30yX6snqPLfuROKHxgPQ5T/Mg5coozi4HVifqUZzdEmr6zAva
        rXAau0dvuWSP3bBTaXI7V8+7bw==
X-Google-Smtp-Source: APXvYqygHpxPYotVgE+wF4RtI1W9U3n7qhQGh8jJsQ3kDxfiG66+QIopat+CZUWo1Erd+yH5Y+ZeIw==
X-Received: by 2002:a63:5c53:: with SMTP id n19mr5786832pgm.193.1554278527993;
        Wed, 03 Apr 2019 01:02:07 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id b26sm34802593pgn.4.2019.04.03.01.02.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 01:02:07 -0700 (PDT)
Date:   Wed, 3 Apr 2019 09:02:03 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH 3/6] mfd: da9063: remove platform_data support
Message-ID: <20190403080203.GE11301@dell>
References: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
 <20190318154759.21978-4-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190318154759.21978-4-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2019, Wolfram Sang wrote:

> There are no in-kernel users anymore, so remove this outdated interface.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/mfd/da9063-core.c | 20 ++------------------
>  drivers/mfd/da9063-i2c.c  |  1 -
>  drivers/mfd/da9063-irq.c  |  1 -
>  3 files changed, 2 insertions(+), 20 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
