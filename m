Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061D0C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF3A2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q/4lJtDI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392159AbfJPJxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 05:53:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39620 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729546AbfJPJxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:53:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id v17so2029045wml.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 02:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Kwit4G7LvIBlpjMFksUWZpjvME4pHOuEuRyY1aF5G6s=;
        b=Q/4lJtDIdRVDo6AbijTWkrkhxgBk+lTJgWFSycEa0BN78vdIUxg2fMx4KI9KvzRPNX
         y53Jh8ZidY1qmv89VYRIWWXFIAPYzUEdkJlIfaiXLiIZtOcFjSiIg7O64Qb3Xyqo/Bz5
         CNW3/Z+WyZjE3fC/d5nqM1haY6G0qr0Nwz6l0iCaxDvoXVu1KL/HGWs0suf0gtRkWRYv
         xSnCunnttl6QvtglzGXOFTwTTz98vgcgv/FwLuALECX3nPnqqk8DUKCbkLqd+EjZmZf4
         wSaBV7Dz+b1zPaTo3zfOcjuwty4DK1Fp14/1/1a/EAxxSBhoddv231SYzvPzTCf8A7+u
         XpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Kwit4G7LvIBlpjMFksUWZpjvME4pHOuEuRyY1aF5G6s=;
        b=BuIWnUcNUEkfLhI5dKRdQVrHJMpx8znEFW7bRXOgfZKZ4QDaEP8WxEEpbF56NFPJA7
         UR8vpdObgu35XmBxnSbyrAPOv0qH+VaK3+ABUOi5D0EEHGbW1Boar3WvGqtUCfKfFFw8
         on60JQRxjyUEp7JlT+YYWVq99Sbup2eLHS4e/gb8YqhgYZfsLckUd4D8+d45MC79d7Ke
         f6jfKQHAx6bNcLEqvfrUj/IlIWAVV7tZ3J891e8vGsdhmaoHPXs6RCCicY/COwvxDZLc
         uQCvUlAD9ayw1QbwNmhjs1qziRrfoLR8GPU8JdqiGxGfPDsBBdiRJ1jn9eRNEF9v7ixX
         QMEA==
X-Gm-Message-State: APjAAAWKV2cDTAOQskU4Y7fG6XIahD3bqwYz9uMmKD4VbFcH31i4ej3G
        ovElqoWzfcInJ7UmGGexKKZm/w==
X-Google-Smtp-Source: APXvYqxKdZ3eBlcd7GVcpsuMPVIZNQlRRyz6O8bf4SQ93Tj2YOu8T31DuQRmb/wFB5nTllHgQo71EQ==
X-Received: by 2002:a1c:5458:: with SMTP id p24mr2489286wmi.32.1571219622135;
        Wed, 16 Oct 2019 02:53:42 -0700 (PDT)
Received: from dell ([95.149.164.86])
        by smtp.gmail.com with ESMTPSA id c4sm24024710wru.31.2019.10.16.02.53.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Oct 2019 02:53:41 -0700 (PDT)
Date:   Wed, 16 Oct 2019 10:53:38 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Subject: Re: [PATCH] mfd: mt6397: fix probe after changing mt6397-core
Message-ID: <20191016095338.GD4365@dell>
References: <20191003185323.24646-1-frank-w@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191003185323.24646-1-frank-w@public-files.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Oct 2019, Frank Wunderlich wrote:

> Part 3 from this series [1] was not merged due to wrong splitting
> and breaks mt6323 pmic on bananapi-r2
> 
> dmesg prints this line and at least switch is not initialized on bananapi-r2
> 
> mt6397 1000d000.pwrap:mt6323: unsupported chip: 0x0
> 
> this patch contains only the probe-changes and chip_data structs
> from original part 3 by Hsin-Hsiung Wang
> 
> Fixes: a4872e80ce7d2a1844328176dbf279d0a2b89bdb mfd: mt6397: Extract IRQ related code from core driver

I've fixed this line to use the standard formatting.

> [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=164155
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  drivers/mfd/mt6397-core.c | 64 ++++++++++++++++++++++++---------------
>  1 file changed, 40 insertions(+), 24 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
