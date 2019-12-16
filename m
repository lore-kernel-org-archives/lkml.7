Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31546C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0809120733
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xbo/lwqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfLPQRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 11:17:15 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37106 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfLPQRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 11:17:13 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so8011704wru.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 08:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=r3ZGFYVqEiHwYj/KwvD5Pu4+HTWz/KZ7Kiw/TxOn57I=;
        b=xbo/lwqOQy1FS7C+xsYSQcx5bgukzpffD2E22Gt2BGvjQIeMuv0YnpsfV8OlRk/c1l
         lUKBWCY89izvWtL2Li/GnK0jVcO43iIwYYs7qsAzvTxsADEWbW5yYZuEXMIdfm5DnExM
         6ri7EUiveI2iMptBammNBQI0/nmcfXVf8XIQsxCicVH0cGr6cXIuPfgCiyMeQaR90EL7
         2d82MtLPM7zZVM6FQil0MXXwM5f3v8ZfrSNnmcM8mRYr4i/VDi8V5yG9NbnIq5WJCi6J
         KWa06ztKcC9ETLPv7kwKNtrvE+Viu0W+R8Rd01swoaBcJYuP1tDb4BAHg0LrheAsUksJ
         4keA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=r3ZGFYVqEiHwYj/KwvD5Pu4+HTWz/KZ7Kiw/TxOn57I=;
        b=bt9dFuc5inmHj1Mek/ky1YQTWFBXoUU4gObA8lEUn2TucMVOgqy6CzAnIkHZtCxFcc
         FIbaI8vLRodB5aRp938qbMF99PE5kYEhrTxm0i6QndLCe+h9ru2Hmebu1YGQjnxHl5he
         c2nR5Jsun2PLni90FVJKCB4Che6V/jwrqQ7s+yfIIxdvwl0XmY/BSYMRL8uMfCrgacrc
         ZpcTK3HlAr4loDLDl1WxEm5JENFni07u2VdSkCzFng+wfNj9C3dbNh6w7kNzF1DXFEan
         xivXGBzr2sVl0XmSVCaoowVG9Eg7afmHhdm7GhI0DfacaxENRFDQYQyoW8/o7gIPktpJ
         SITQ==
X-Gm-Message-State: APjAAAXcNYp8BaEXgmUS6kqSrcpgNpRzM6UYSvTKLTvaLqeE9jOa4rQm
        qQeqjg1dNje2V5r3cMUBEYo/PA==
X-Google-Smtp-Source: APXvYqziVssigAv2YlptZeqjNq6fPlpxFmzjNGrhVJGnWBGQLzm5s6+4MSYn72RUTN5cM6L52pW9eQ==
X-Received: by 2002:adf:dfd2:: with SMTP id q18mr31049989wrn.152.1576513031335;
        Mon, 16 Dec 2019 08:17:11 -0800 (PST)
Received: from dell ([185.17.149.202])
        by smtp.gmail.com with ESMTPSA id o66sm18121839wmo.20.2019.12.16.08.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 08:17:10 -0800 (PST)
Date:   Mon, 16 Dec 2019 16:17:10 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     sam@ravnborg.org, bbrezillon@kernel.org, airlied@linux.ie,
        daniel@ffwll.ch, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] mfd: atmel-hlcdc: add struct device member to
 struct atmel_hlcdc_regmap
Message-ID: <20191216161710.GO2369@dell>
References: <1576249496-4849-1-git-send-email-claudiu.beznea@microchip.com>
 <1576249496-4849-4-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1576249496-4849-4-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Dec 2019, Claudiu Beznea wrote:

> Add struct device member to struct atmel_hlcdc_regmap to be
> able to use dev_*() specific logging functions.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/mfd/atmel-hlcdc.c | 3 +++
>  1 file changed, 3 insertions(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
