Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A81C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F5C20820
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t3Qr2H34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfHLKUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:20:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33554 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbfHLKUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:20:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id p77so10533211wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 03:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wqTQ6b6cfwbQrBuBsS4ZVRP0NDej0Y0Ylh0VQUZjqgY=;
        b=t3Qr2H34fWbt8fRrhsE0KTVByOzaYjedOJJltCPnMeMOlXg2a9+YRp164xeuTD4YbM
         lrgMQ9GSXc3yAU9Ua5Pvg2u0KKi7OdsS+1mbgAxIYKSG+v6wt0MmSFjY3wPhTgiJZwHG
         3SmIlbvswNbBNVK6ECgHoKHH8MMnaenIIWEIIDfMAPNz0pyf8vXAy/fD1SNgTGoiHx6M
         AMiRQLzKIuE1mTDr9xRSn/UGxK/YhEOIsMCX9BlBbqY/Ouczt3p8B93bzuenedMJw6i/
         4dJHtCJ9XUDX3uCnhcnpxO7mICVkJw9DoJYJ3hz0cR1rjUiIjy8vSw9kSwQgO1gVbCGm
         junA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wqTQ6b6cfwbQrBuBsS4ZVRP0NDej0Y0Ylh0VQUZjqgY=;
        b=jB6R35ls2Jr7yQZJ3bwH0cRQ1wYw3n1RVvRX44XWGbi5I/liRhzQpuUiQzgQ5/CfyC
         AUermDmxBV+xFwozbQEXBnDl/i8QbAdL21IAr7zSYWfxhrwPD5DFkgLWnLf8T4FaT5C6
         hMjnyPCPlwhLqVJM5q4pp7812axEaWPqDi8g4+WaP/AH5hFVEOrQdDfqN5wvC8aYRbk/
         QH207Dow0yDJ20TUyzvNy+WVPR8ZmcRtijzFOxOusLL2q6B2aXkMC80xQ9kjdi0maTd+
         1OFf/UPetOlW5rh9G0R80Ztawc9MkK7RWH4rA6sf9kJGnljOkUy+xnV4zznb5lVYCkuy
         ZvOg==
X-Gm-Message-State: APjAAAWHUBJCmZr9jTeyfmuN4s8TwNnnoez7jpyU7iM61zI26pIwB7cZ
        ydZMg/Uft8VthZCHEcBjyELWIw==
X-Google-Smtp-Source: APXvYqzRSyrYT9+CnNldwN3uU/Yytvk4N9NCIYzWkwcCnwMNp8R3C+kWgZvgsTeSyQKkAOTnKXzSyg==
X-Received: by 2002:a1c:6c0d:: with SMTP id h13mr24864195wmc.74.1565605238212;
        Mon, 12 Aug 2019 03:20:38 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id x13sm465212wmj.12.2019.08.12.03.20.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 03:20:37 -0700 (PDT)
Date:   Mon, 12 Aug 2019 11:20:35 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allison Randal <allison@lohutok.net>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Eddie Huang <eddie.huang@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Richard Fontana <rfontana@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Tianping . Fang" <tianping.fang@mediatek.com>,
        Josef Friedl <josef.friedl@speed.at>
Subject: Re: [PATCH v3 01/10] dt-bindings: add powercontroller
Message-ID: <20190812102035.GH26727@dell>
References: <20190729174154.4335-1-frank-w@public-files.de>
 <20190729174154.4335-2-frank-w@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190729174154.4335-2-frank-w@public-files.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2019, Frank Wunderlich wrote:

> From: Josef Friedl <josef.friedl@speed.at>
> 
> add mt6323-rtc and mt6323-pwrc to mt6397 mfd DT bindings
> an example is shown in mt6323-poweroff.txt
> 
> changes since v2: separated rtc-mt6397.txt to part 2
> 
> Suggested-by: Frank Wunderlich <frank-w@public-files.de>
> Signed-off-by: Josef Friedl <josef.friedl@speed.at>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  .../devicetree/bindings/mfd/mt6397.txt        | 10 +++++++++-
>  .../bindings/power/reset/mt6323-poweroff.txt  | 20 +++++++++++++++++++
>  2 files changed, 29 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
> index 0ebd08af777d..44acb9827716 100644
> --- a/Documentation/devicetree/bindings/mfd/mt6397.txt
> +++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
> @@ -8,6 +8,7 @@ MT6397/MT6323 is a multifunction device with the following sub modules:
>  - Clock
>  - LED
>  - Keys
> +- Power controller
> 
>  It is interfaced to host controller using SPI interface by a proprietary hardware
>  called PMIC wrapper or pwrap. MT6397/MT6323 MFD is a child device of pwrap.
> @@ -22,8 +23,10 @@ compatible: "mediatek,mt6397" or "mediatek,mt6323"
>  Optional subnodes:
> 
>  - rtc
> -	Required properties:
> +	Required properties: Should be one of follows
> +		- compatible: "mediatek,mt6323-rtc"
>  		- compatible: "mediatek,mt6397-rtc"
> +	For details, see Documentation/devicetree/bindings/rtc/rtc-mt6397.txt

Please use relative paths.

E.g: ../bindings/rtc/rtc-mt6397.txt

Apart from that, the MFD parts look okay to me.

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
