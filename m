Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC4BC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D41D20842
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ClsxrPQn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfHLKaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:30:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33251 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbfHLKaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:30:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so104213984wru.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 03:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/xJkw3HJipqZsGqksy3Y3Kh8Zd6FZDx8Lzcx83UAp1E=;
        b=ClsxrPQnDz+StEaMCZFcJZvBHropFOtgMNmG2NxTqoUDwh6xgtGinyNwjek/gGcDsb
         QP1OJM6Xd1F2+jtVWeFLi1FSsRcufM8taxrEwcf0QUaqX+LUqCR3UVrdQTaqW2LpQ1y3
         dsDIJaW+Js6+nyJmMmkLZcAHA2Op1QVU1Zz2KJtwS5ol4eh1LyS+b6Wmj6TYA8FAvXWD
         8cfVzTGdcHIaSf4XbL3iIGj9rO5BeaiZuA8wzFzzEJc68yQgXpSSXAN0sTUNkAeyBUoj
         Q+kMB94rY4bxav5iCDcv+Z52AxWXy7i9GHlFR5KcPojz5YMEn3iZ+w/apQKAo6E42J5I
         Ux1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/xJkw3HJipqZsGqksy3Y3Kh8Zd6FZDx8Lzcx83UAp1E=;
        b=tQwB/vGbejfApzvmnX5RiTCbReq809EoDqfHsxvhB5y87QmUIMAglQ4loyvypg7W5l
         lit/kdZgHkEBUbpCqrnke98c/cxq9SC8Quyg8HzxvhZmMqpy2kU2x/eUueOHeGk8QTvb
         lDGOGPmojn6MWnBZuj2FxQS6GwQJOIFRyJ6v46g1BABtnvy+kobZuLRV8XInsNGD2sub
         RnU6kB47qKCRU27bxzRcoShxjENJxRq9nObySMD4rT5yp+9hiWypgo+HwjBt1OmFIMVx
         s9D9AOzxjhOa59iaIkXM3ga752+sKD5C6rvrGURhF7JckaZ6dsAPLxA989ZiWmnfSJYH
         XA9A==
X-Gm-Message-State: APjAAAU0YI2YrN6lGXvSEHsh+yv+cxD0Tc7jENsWgsvLLjzPBKRW8Aw6
        63UBJhvEsF46ytk2pc3Ltp4CSA==
X-Google-Smtp-Source: APXvYqysIRjAaDtd2ibOzQb9fjpi50O1qhEVT0kIXTChSIdIo1wq0xFRIV2BJs//0/kavloNGsljaA==
X-Received: by 2002:adf:ef07:: with SMTP id e7mr21348509wro.242.1565605811394;
        Mon, 12 Aug 2019 03:30:11 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id n8sm90185885wro.89.2019.08.12.03.30.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 03:30:10 -0700 (PDT)
Date:   Mon, 12 Aug 2019 11:30:09 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] mfd: db8500-prcmu: Mark expected switch fall-throughs
Message-ID: <20190812103009.GL26727@dell>
References: <20190728235614.GA23618@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190728235614.GA23618@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jul 2019, Gustavo A. R. Silva wrote:

> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> drivers/mfd/db8500-prcmu.c: In function 'dsiclk_rate':
> drivers/mfd/db8500-prcmu.c:1592:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    div *= 2;
>    ~~~~^~~~
> drivers/mfd/db8500-prcmu.c:1593:2: note: here
>   case PRCM_DSI_PLLOUT_SEL_PHI_2:
>   ^~~~
> drivers/mfd/db8500-prcmu.c:1594:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    div *= 2;
>    ~~~~^~~~
> drivers/mfd/db8500-prcmu.c:1595:2: note: here
>   case PRCM_DSI_PLLOUT_SEL_PHI:
>   ^~~~
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/mfd/db8500-prcmu.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
