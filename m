Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410B9C32750
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F42D214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VbvHp5gq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbfHLKWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:22:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53744 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbfHLKWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:22:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id 10so11639554wmp.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 03:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5m2IUZRROGymOefDRF7neqY5caAFmV8hI7w+ygmONvA=;
        b=VbvHp5gq3ZfIv129Gw/NtZ87lFa2bGMn4EuR83iecdeL2Csep9DpwQiL7+zz5JqjFK
         X8bIxV0RuZYkwYNxNlQfaKfvyhdfMRe+fsByZ+5/9Q4URPmHiuFfC+v/g4Na72n/MRMw
         r5gWKC5znHtVRRq1Mdy7xb3V/NfaocaWCQA7G19e1ZfLLTVKay0EAG6Eyp0ykdSV+4+H
         m8IfxciiLoaWNeDAQlVb35jDEAHgnVhlwiGdrJnKqaWswW3Ci+r549m18+lM5cv/jCuF
         1hFxRPVjIE+R+CsJoPvG28LQ6WUzne3g9QFS7qHahxLXO0k9kPM/IiwVA3zxzlc5GxvS
         W5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5m2IUZRROGymOefDRF7neqY5caAFmV8hI7w+ygmONvA=;
        b=TPmTs5FwLnmMXsS3JwktJ2kZHXLpGse7qgXAHlLxAnovzK//The9bsX4PrjInTl3Kb
         KVypH6G1v3ePw4ft5lPOa15ZUD6CtZX4EuNXlv+7Rk9cJ1LpjDyoM74mgvLuBQWYLV8m
         G7Nuu7v5Pj5dw8MaOE2dBxil+DYp6b1HWpOPe9Ps1uNFd4cWHcAsyNCkKsSaXsAJK+FV
         TaiZOSLiiT65c4qeAhFFoOEF9q5MmgpHUYWsd7gK3nanRYo5MONAxREDyMbLGtCUUYpC
         zDuDErD1jDFfLeyatb9+iNT9pmCipvSsEUIhVaN+zdlAxAObAmhSHnHl1u9wr682DcLN
         vOAQ==
X-Gm-Message-State: APjAAAUWXJkXknsUePJiJwkqxz7vR7kvwAOEh9b0t7+ZWt5M+yWkViQD
        dmNHwizBUtRYKjbSBH3FjU1ycQ==
X-Google-Smtp-Source: APXvYqybIDxE+3tj5T831ZEq1FImfdGr3gRRq6UGg2lHX1HJoq0eScbIUxcvMhMextMyi7Sx8dZgKQ==
X-Received: by 2002:a1c:6a0b:: with SMTP id f11mr19124477wmc.87.1565605358267;
        Mon, 12 Aug 2019 03:22:38 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id g26sm1478821wmh.32.2019.08.12.03.22.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 03:22:37 -0700 (PDT)
Date:   Mon, 12 Aug 2019 11:22:35 +0100
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
Subject: Re: [PATCH v3 07/10] mfd: mt6323: add mt6323 rtc+pwrc
Message-ID: <20190812102235.GJ26727@dell>
References: <20190729174154.4335-1-frank-w@public-files.de>
 <20190729174154.4335-8-frank-w@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190729174154.4335-8-frank-w@public-files.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2019, Frank Wunderlich wrote:

> From: Josef Friedl <josef.friedl@speed.at>
> 
> add entry for rtc and power-controller to mt6323
> 
> changes since v2: only splitting, second part of v2 part 4
> 
> Signed-off-by: Josef Friedl <josef.friedl@speed.at>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  drivers/mfd/mt6397-core.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
