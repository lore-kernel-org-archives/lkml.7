Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C3DC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B113215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NriUHG6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730707AbfJDMGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 08:06:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34515 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfJDMGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 08:06:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id j11so1086644wrp.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 05:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=We68HJxGgO15qFx9UZUNDGh7sk7bT+Kwug0ALzuQsgY=;
        b=NriUHG6VukNQjGu8MNskrjCSxEZSffrlfYToRknIpZeqtR0c55oRRc+ol3gEWrRo1P
         7dvfIkwMUt2fzCwRZcIV4HqrRqFSvgsPPq0YV9NHuKfzoIqkZVrzcOTLjnBpty1d51JK
         WagYC6pI2Iu1aYkUPLhSt2Y0qiuZ5hgZCDDLGmJyd3QlcHo8C6Q6yl5ZbCowhn9nSDyD
         YZQau8nus69zchLlrcbI6rbCYMCHD2XYXzlHtKvo132ZHGG4WpSu6oU504ERhlIUUK7x
         G3xWYa4MQO40ioao2YQ8a7aA5Rvl/P/mP8XR1d7tNs1nEwgMQOXVT2/KOLNycDyAlrCm
         8NFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=We68HJxGgO15qFx9UZUNDGh7sk7bT+Kwug0ALzuQsgY=;
        b=q7M7W/GEqVd38OJTJ4jFRO0JO9G9DHqqmCuC/ToMZr6aN7lDBqhu33/HNszPx3X1dw
         DPe6xEhMEPgVxDLooEvCHePTPbpIlT9jkvVhSxg7eOIJ128c1A2ypYBrtXLjnByLs1Xb
         C10BXAxnn5mLr2Vv0rmgPbgYolvBKi/Y82ez96Fjyt+0dQ8/Pxhn6XMMSu2SJ3RmHm1u
         RuORWBjznts6X7o8zle7w8oY5G0PUaJ1nzrTwZLjk6uJTj5eJKTgknrSIkPFds9Ens03
         1orYj4AGhE4eg0TBT0RqluTxR69AZeGrMk2DIuvM58hT/23cWi5EAhM/pDT37Fn1+piV
         jyjg==
X-Gm-Message-State: APjAAAXKQsf1lfcZNMqbiIlxKXsBGTBINEg2PkYfRG1eg4id7v7OJBMm
        JMIK/r2+iJ5rIf7Ui1YawunT4Q==
X-Google-Smtp-Source: APXvYqwbVDl1j0TzxmmaS06SyhmcA22vQ72irFyeh55DhDFBpntHYV03Kg10QTCZ99RU2Jv4m0MTww==
X-Received: by 2002:adf:fb11:: with SMTP id c17mr12069368wrr.0.1570190790922;
        Fri, 04 Oct 2019 05:06:30 -0700 (PDT)
Received: from dell ([2.27.167.122])
        by smtp.gmail.com with ESMTPSA id f83sm6585666wmf.43.2019.10.04.05.06.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 05:06:30 -0700 (PDT)
Date:   Fri, 4 Oct 2019 13:06:28 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-kernel@vger.kernel.org, d.schultz@phytec.de,
        linux-rockchip@lists.infradead.org,
        christoph.muellner@theobroma-systems.com, tony.xie@rock-chips.com
Subject: Re: [PATCH 4/4] mfd: rk808: use DEFINE_RES_IRQ for rk808 rtc alarm
 irq
Message-ID: <20191004120628.GC18429@dell>
References: <20190917081256.24919-1-heiko@sntech.de>
 <20190917081256.24919-4-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190917081256.24919-4-heiko@sntech.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2019, Heiko Stuebner wrote:

> Do not open code the definition, instead use the nice DEFINE_RES_IRQ
> macro for it.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/mfd/rk808.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
