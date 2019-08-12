Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95FBC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78044206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nqx4QaTP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfHLHZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:25:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50529 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfHLHZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:25:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so11182404wml.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xhe+IxDCKRZzWrWVNOpKioyhk+CyeZMLg9hkmvU5Amg=;
        b=nqx4QaTPBl/ZoYPz6PirVsvwIk/tCqORrsI/gdkPLsWJXJDh9PQo3N3Yp0T+nAIX6A
         jqQka2jzLJXxhI7hYL9Eb6xNIEgBD/0Fum3ToVlzHcur2wDLNZsGRldRIvbZKZXPsZoI
         KEtr2ut9m8dUPEp4XvdQxpsveaI6lqxtOPpWao9m6va9Z8kNzekwWZqwYY2j1yPJZMD0
         CmxreYJslauXvVQSlMwAgRnxhB9B4Zfxxsy+sOBqUabsVGpmeJfH+vNk/ExaigxhT61O
         1hAleFXtBRPx6b2ra/gpgtyXRBDZ9BFP7WPucPgjEVjRGkHyjHmmbArmAAyB7XjReDQ9
         Lk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xhe+IxDCKRZzWrWVNOpKioyhk+CyeZMLg9hkmvU5Amg=;
        b=SnfMaynwvkoaII59VEhjO10mlpj8FONNUQVdrxbEZ44Zw3Dx5E+10Q/3SXVxjPvT3s
         WIUjeQg5pkjUt8SvFTqGXSpMaW4ejIL4FvBtEZxjKnAnXI7AoeXc/fa28EPHhTyz5AFw
         4/pNrR5aCm6MYhzOmh/vK27pTi8ICyHzGjGCQWqyLCcG51/7OJTO9e0mGgxOtvXZvWHj
         FEZKHjMyXNwfQVYnTbEk8bEvrxoRckGjveoyzBg3fZUzMPNhxWfqGpdn6g3zGaXWpg27
         bALK5HA72wM3RFADCDSEab2vNPR1m8jF9aDD2F1HcRucxG+rB2vi0xxQIB6+TC2H8krM
         YtZg==
X-Gm-Message-State: APjAAAXpLWC2YfAWpMx3XkFMnCDfzXC/MC+3WBJs/Cq0Jb9mvpVrtHPz
        vYi9PFSzZPJcHKDg0IPN7/QP8g==
X-Google-Smtp-Source: APXvYqytaqjZgg25CyEuyy6o+ARKORgt1WqsWnAxrl3Rrg6HW2TuCuPzKCLC0hZjZFYY5+bWpdxS/g==
X-Received: by 2002:a1c:6145:: with SMTP id v66mr25432151wmb.42.1565594712668;
        Mon, 12 Aug 2019 00:25:12 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id t13sm123530612wrr.0.2019.08.12.00.25.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 00:25:12 -0700 (PDT)
Date:   Mon, 12 Aug 2019 08:25:10 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Collabora kernel ML <kernel@collabora.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH v5 05/11] mfd / platform: cros_ec: Rename config to a
 better name
Message-ID: <20190812072510.GI4594@dell>
References: <20190722133257.9336-1-enric.balletbo@collabora.com>
 <20190722133257.9336-6-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190722133257.9336-6-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019, Enric Balletbo i Serra wrote:

> The cros-ec-dev is a multifunction device that now doesn't implement any
> chardev communication interface. MFD_CROS_EC_CHARDEV doesn't look
> a good name to describe that device and can cause confusion. Hence
> rename it to CROS_EC_DEV.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> Tested-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/mfd/Kconfig             | 17 ++++++++++-------
>  drivers/mfd/Makefile            |  2 +-
>  drivers/platform/chrome/Kconfig | 22 +++++++++++-----------
>  3 files changed, 22 insertions(+), 19 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
