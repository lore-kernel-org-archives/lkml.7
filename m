Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C50C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4CE9206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kkH8LCw6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfLPPWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:22:43 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38905 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbfLPPWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 10:22:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so7760496wrh.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 07:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qLjeAIGdVG2CAGqrqkDVZm71lWq9H9Eq0kShaFA5C18=;
        b=kkH8LCw60Q4gtYMmg4us/7jO+sM6+roSBcF2Q6uyA+jQZ3cULiu6CqYEB55pDtjCPp
         tlHbIYxoXQ52On9zJgaLJ0+w0M/RG4Bw61a15MYPv/j+Qzsv8Zy07iy3cetlHdZroJKW
         rwlUpvP36tCOUlbDM9Us1RMnXeHWGvWXxMsOlfsWVTuUZ512BbX9D9H7IpMZCgZAGMLP
         91Fp5ooQjGBMo9vZ8mHYD5wJQ4YdfyrsyqYmlRXdsaV+njbGMj+McmdU3MQgtPJbW3Ua
         v4esrLjpptQmVawCAFP9AKgRLGtU5U2xere4vUxM98aMD77XxZmGCFxc2n6uZTkts0A9
         O1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qLjeAIGdVG2CAGqrqkDVZm71lWq9H9Eq0kShaFA5C18=;
        b=MyttmHhscjUXTCQCB+hhU4ZdxDg8VMVt43pNOzbZG0TZdZTBEFSLu0Yy1tyjmoP/d2
         iUDhGMNjF8cb9VSapeGgsREMsHi6UnxeNeFpl4LIHvTiHkWx8gmnuGDb9/YIoguqCkSj
         VJvF7ZYMJb4P/VrZg+vGwsB5PVTCDsHJX2CgFMBdD2guKOZZfQVJ4AnwYVM++djOeIdo
         FiAsgj4MbcgJokszSXH8L38SuS1R+CW8E8RJJ+3iH1Ggil1lpvGOg9G0gVt2dGgyHv1y
         6egxx+q56/TWjWy2u5WSd8YSWqXeOjtMrfb18tfEVP42GK1hPkd6Ji0NIRB9fHLwwi1P
         T7YQ==
X-Gm-Message-State: APjAAAXnC8Nu197cw6DXbnSlbkvsz9G4JC3/U8IGBAzU8yPWWXjjRk9Z
        123ncKr3+rJTylX1ujxXV9T6eA==
X-Google-Smtp-Source: APXvYqwqcvX/5Yl6rT4Ou+vaTqr6E/+0/LcKrmUU3eQtD677huDYJ6VQOAwdzpeO5hEPA8AhyLoJkA==
X-Received: by 2002:adf:d848:: with SMTP id k8mr29961381wrl.328.1576509761304;
        Mon, 16 Dec 2019 07:22:41 -0800 (PST)
Received: from dell ([185.17.149.202])
        by smtp.gmail.com with ESMTPSA id b17sm21923340wrp.49.2019.12.16.07.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 07:22:40 -0800 (PST)
Date:   Mon, 16 Dec 2019 15:22:40 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH] mfd: ab8500: Fix ab8500-clk typo
Message-ID: <20191216152240.GG2369@dell>
References: <20191211114639.748463-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191211114639.748463-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2019, Linus Walleij wrote:

> Commit f4d41ad84433 ("mfd: ab8500: Example using new OF_MFD_CELL MACRO")
> has a typo error renaming "ab8500-clk" to "abx500-clk"
> with the result att ALSA SoC audio broke as the clock
> driver was not probing anymore. Fixed it up.
> 
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Fixes: f4d41ad84433 ("mfd: ab8500: Example using new OF_MFD_CELL MACRO")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mfd/ab8500-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
