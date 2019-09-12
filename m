Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80373ECDE20
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 05:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A5520830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 05:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXAw4ZfY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbfILFsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 01:48:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35645 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbfILFsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 01:48:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id g7so27044087wrx.2;
        Wed, 11 Sep 2019 22:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J+7yYlnuB8SfpTVafLWQ5fsDMfbAda9xsGBUVs8Fvp8=;
        b=WXAw4ZfYV5rE2nV/pMMkOQLd84SYrazXZPVLCd3K+Nm/SSXM+4mrp2rwiAqVUsFwUh
         r9Yha87/wwLrIFRTxPLaSobwXzeakc3dqoKr4eGm8i352Dihhdr8u0sGunzZnyx6uHV1
         WxqJaan5k1ea2oY1oPTLAAoV7PGlkV/+/yH2NJjxwIaQl1tLphDl1XZzqq2Eztry7C6o
         8gv+wDN6baCF6P/liN+rsL1AL/H7MPZ9QRcC3neKCCWNSC0KXnanP+mR2WTOZJAisjzQ
         NoZwENX/hvrbuLv5CHeo25eG2MLJj4+j+FWUaEiUg+q14+h5WUCrw5wFHhncWz0SyY/h
         Bjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J+7yYlnuB8SfpTVafLWQ5fsDMfbAda9xsGBUVs8Fvp8=;
        b=VhbmT/EbLMT3pJNqwfQbsljXrF7oqKLNbrTO0QHrssCjqtRFsjGmahrSq5QWYMmOj1
         B1H72Zd1CilDCdnqTULiiYm0j7wCoLfDbX95FZlLMuGCXDqpdicoZ7pM54Jkpypp+yfx
         SAsmUr3JLWh24hCzYnmHt8OW47oZ+6UHi9TYOedDE6fLGXPiYCRtA9Eeb1c/gvDtOMbR
         ZszB02XcbhBTdBXX0eSyN5Gt8m4awCNAvaK29gQgMX/jjWjX4kWEHOIgBumopevz0lfe
         URfmoNCgR8AIUhsd8YtHOXQRppOXHzE4inJ4hWGteZ5w/N/vcX0vIwIHKZHljerOs0kM
         xchw==
X-Gm-Message-State: APjAAAXBLmTd0q1U/RHf9VOA4g4DDXPytwDn3iYuDsKoYrDeu+3gO6sE
        bRI3pijmyV5i6B5VKZHRyXJte9B96Z2ClrggClAlmQ==
X-Google-Smtp-Source: APXvYqyiFcAWerCpqfDcaC0qwPj8N20mRn7E8xKm+Rmt7zy0lh+MRtJ2JTXCsp+wRS6givFhM6F9EsVts9tBy0ZmAbk=
X-Received: by 2002:adf:d84f:: with SMTP id k15mr31421304wrl.70.1568267296241;
 Wed, 11 Sep 2019 22:48:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190905103009.27166-1-zhang.lyra@gmail.com>
In-Reply-To: <20190905103009.27166-1-zhang.lyra@gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 12 Sep 2019 13:47:39 +0800
Message-ID: <CAAfSe-uG0oDHznmYXUfbC86pw6nZvGzLHfpnpu1oUX+uk1NASQ@mail.gmail.com>
Subject: Re: [PATCH] clk: sprd: add missing kfree
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gentle ping

On Thu, 5 Sep 2019 at 18:30, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>
> The number of config registers for different pll clocks probably are not
> same, so we have to use malloc, and should free the memory before return.
>
> Fixes: 3e37b005580b ("clk: sprd: add adjustable pll support")
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
> ---
>  drivers/clk/sprd/pll.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/clk/sprd/pll.c b/drivers/clk/sprd/pll.c
> index 36b4402bf09e..640270f51aa5 100644
> --- a/drivers/clk/sprd/pll.c
> +++ b/drivers/clk/sprd/pll.c
> @@ -136,6 +136,7 @@ static unsigned long _sprd_pll_recalc_rate(const struct sprd_pll *pll,
>                                          k2 + refin * nint * CLK_PLL_1M;
>         }
>
> +       kfree(cfg);
>         return rate;
>  }
>
> @@ -222,6 +223,7 @@ static int _sprd_pll_set_rate(const struct sprd_pll *pll,
>         if (!ret)
>                 udelay(pll->udelay);
>
> +       kfree(cfg);
>         return ret;
>  }
>
> --
> 2.20.1
>
