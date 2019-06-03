Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FABC28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89DB12133D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u7hHGQ1K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfFCJhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:37:23 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33941 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbfFCJhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:37:23 -0400
Received: by mail-wm1-f66.google.com with SMTP id w9so3182686wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 02:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FH8JY4qDdnuY/nkK+8zanlK0WEZXZ9PGux3V1jYWA74=;
        b=u7hHGQ1KPja0igPZ1tQ98KrQncJ3i/kWVJBQMj5wioahCD2F6NNSGXVa6KEe8UAz6Z
         gJQqqSLxLtpuqyJ2//fNfZAl2IPP8Up+FNSoAuOYYbGydJFZwu5Qn7tMmyYEy3PSlDUZ
         SgaP+9CWWIPqZcI+0kXQVzcMv/t0BLomvbmfKtvGE+XdkcY5gQbGk0JxbHH7fUGHaGsq
         UTPwzOBeLs08FKCm/+UhAA7NtHJare8rDbWaYyBpdLvLtmB0NVCj6oyc4I1xWtXXxMtD
         bJtM77uyXBGUbwBE2XKsZAHUssodxR2VHgiE9zICnhQyzLcc84TyZs7gWcmCp/Cbg9TL
         uo8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FH8JY4qDdnuY/nkK+8zanlK0WEZXZ9PGux3V1jYWA74=;
        b=kwGufuksBbMqxyhhReYVmSPrTQHvSx924oFm0Q+X+aOWqvRFelGw496P9SbOyokLp6
         XVt2rC9xu5LY0DTrBPaFaAi+/VtCnooA3zqhgb1//VmWPrcJ5H8L4wI8E7fFbgyMVsYQ
         tHlUYVPp0ydTlEChIeHzqrasN/tggD4Xhax4J1utdNx1gbshrG7JX+RgW0hz2xlJy1z2
         OAFcdya2e4BiXba1YfDhPfoKU4YJJ6mW9u1cSXxfI2aWZEZl6rrEuvok40sPmB2Xq3EE
         D6fqjjvG8dQt2lyiV4UOepQSE/NHT/dpH98sFLWdNOV/zLxOS8tkrBU9qsrQ5l7i7FaV
         ENHw==
X-Gm-Message-State: APjAAAUwpSWiyucLKa+ZFNOhpbBd4LLh8NPKQ1sRNstHcp7bgM0LHvUY
        EazB8V9vA6xpwB/0+qC1hgRJAg==
X-Google-Smtp-Source: APXvYqygOO4Xq5aGTdEvmHkgjQC2ck/mOA4BrLfs9cgwsIQoR6QldAKRhoLObHom678jS81nbgIypA==
X-Received: by 2002:a1c:5546:: with SMTP id j67mr1759767wmb.80.1559554641286;
        Mon, 03 Jun 2019 02:37:21 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id b17sm6309777wmj.26.2019.06.03.02.37.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 02:37:20 -0700 (PDT)
Date:   Mon, 3 Jun 2019 10:37:19 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 3/5] dt-bindings: mfd: mt6397: Add bindings for MT6392
 PMIC
Message-ID: <20190603093719.GK4797@dell>
References: <20190515131741.17294-1-fparent@baylibre.com>
 <20190515131741.17294-4-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190515131741.17294-4-fparent@baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2019, Fabien Parent wrote:

> Add the currently supported bindings for the MT6392 PMIC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> 
> V3:
> 	* No change
> 
> V2:
> 	* New patch
> 
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
