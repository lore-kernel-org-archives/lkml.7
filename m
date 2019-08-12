Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D595C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3137520665
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SF7YYcit"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfHLPLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 11:11:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36251 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbfHLPLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 11:11:33 -0400
Received: by mail-wm1-f66.google.com with SMTP id g67so12109591wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 08:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GUVrtoEfscx3IZ80Na3X/rWaOd9dRKNDQf1aNP1gKJQ=;
        b=SF7YYcitpnmLEfAIg1jOi9hmKo1i+Rcoivb2acbFvzJTcAy0/wOVgXhFfL/86Xv3Sx
         dC+O3vUZWV4HQcQKJEV8MAtHUgBFzbWrDZv2UXKJTpgvytBorP3RknUn6lZsPEozuxBP
         F3D72dCDxFyNY4KUClx+epNbiA4zhlB1+88AU39AEP7kRZc0KdP+bEFWPPAYe46iiWx6
         U+4S1sir5JuK91IbOrf2IoIRcfBuFdJrx6uLRoWwQWlxZ78ecsCRBXv+gwX/Cz+6kzR+
         xMza4uhVz+49uL8JYrZ9KKPp9w5Ty8IeyU7v+KTRjDUxmiKxRWfhwdpeq0662ruHnQQL
         ABhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GUVrtoEfscx3IZ80Na3X/rWaOd9dRKNDQf1aNP1gKJQ=;
        b=ccTGXYcmCY7FAJk7X3i5i3O7Xb9jqtGoU7Sfm0YW9dATEq/ZnSXZWSaAwg7+K1rptH
         a3GM6wZVPMDVyttn5fifUEKlJ2bzAGCTGflLX2RfLCxjjbO2FIwHp6s+WEDEzo3tbPI8
         5Wi8fAT/6z4v2Xh9qR0+N/0h4wxkoKrdel+WVFnI7BX1rpfZlLBtY/B0d1/W/Qa/phFN
         weHkR0cb8GJtn9sGCdGmopD9ROpdJi5d55kDdFc5AvCr2xlnniJdHNJR5PpxtiADAkX2
         GSWICdOaZ6sFg7asJh+poZvL7S4U0GSjob1O2RBmP8Dx9soAjW2t74khm8B9yz9QOLum
         ZJTQ==
X-Gm-Message-State: APjAAAVILAOoKfDSnUWCtgDCJPxrXM/P08TyKkxYul0roAvjT4Ku5WFJ
        tit2ERmmYCnmyRS7jgo/PHl6Cw==
X-Google-Smtp-Source: APXvYqzzq2N35RxoX6M2lYFHPFEysjYpmtcFojnVg276i12s+isDXsA6w+Dfor/LAfFbQnLudsik5w==
X-Received: by 2002:a1c:1b97:: with SMTP id b145mr26940656wmb.158.1565622691528;
        Mon, 12 Aug 2019 08:11:31 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id k1sm12674396wru.49.2019.08.12.08.11.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 08:11:30 -0700 (PDT)
Date:   Mon, 12 Aug 2019 16:11:29 +0100
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
Subject: Re: [PATCH v5 03/10] rtc: mt6397: move some common definitions into
 rtc.h
Message-ID: <20190812151128.GV26727@dell>
References: <20190812121511.4169-1-frank-w@public-files.de>
 <20190812121511.4169-4-frank-w@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190812121511.4169-4-frank-w@public-files.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2019, Frank Wunderlich wrote:

> From: Josef Friedl <josef.friedl@speed.at>
> 
> move code to separate header-file to reuse definitions later
> in poweroff-driver (drivers/power/reset/mt6323-poweroff.c)
> 
> Suggested-by: Frank Wunderlich <frank-w@public-files.de>
> Signed-off-by: Josef Friedl <josef.friedl@speed.at>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> changes since v4: none
> changes since v3: none
> changes since v2: add missing commit-message
> ---
>  drivers/rtc/rtc-mt6397.c       | 55 +-------------------------
>  include/linux/mfd/mt6397/rtc.h | 71 ++++++++++++++++++++++++++++++++++

include/linux/rtc/mt6397.h?

>  2 files changed, 72 insertions(+), 54 deletions(-)
>  create mode 100644 include/linux/mfd/mt6397/rtc.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
