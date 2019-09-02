Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDABBC3A5A8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BC5217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fcsdc6Rs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbfIBJtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 05:49:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52190 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730356AbfIBJtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:49:15 -0400
Received: by mail-wm1-f67.google.com with SMTP id k1so13822693wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 02:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XaAC2UGpsh6Rl+xXtvt/zZ4Jj3WqlV6FbUQcE8k/OFE=;
        b=Fcsdc6RsuDuPiLa9pJ8ykgClftxCpIfBC4pIswB4N3NPQ/dju7ZCK2iNiSXswtyj/X
         onUbd2EYdbmi/UWWCD7zjcsDPMiG5XTAZG76ZhDiq630WGO0CJ8ctok2U9T1ws4CnIU0
         cd3LpxfkhDnVpdEAWCsJdlssixcxlRXmQZ1SgJxhMvp6UL07wzmdGcltI4n1yoGAaKlG
         tiqXclivUmF51+g3TukhyPU3JUJgXZGsqRjz3I/oPR6umzQZhomRnzIifIH0Wg2XqCkm
         5/WO/rUvC8XJPuBpPPRUeI8swzV5ri0OYmpkoQCaKoLzDV61bygBpJmLoi9eMqsfA+qB
         2q5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XaAC2UGpsh6Rl+xXtvt/zZ4Jj3WqlV6FbUQcE8k/OFE=;
        b=IuDXremhsq/8mqilQaU+mJrFbbFKekxDh/BvvH3tUi9t4C+WqKDsSQ+IZx6eK3RHQ0
         9LNLsg5HN2vBTNHSfT5gMKF95+PWe7EnIN5VO8VbpaUw2+FDZ9Z5rAhvvfgofG1lqtLO
         JkTbHk5GPzhwv/UEPTHYfTojEPlcMwPH7Z5XJCeB8Os4WMtgtTjhGqrEbPEjBNaDOgye
         kAr1klwmXSRt10u4mDVRxRGAdfxFG4Hdqj74OWyLNNTWMaKE4K1Dr4OYTKsKoMFyoP5c
         Fo1gwfXz9RHat7Px3bitg0L+KNK2BY40k8XBvNwbvfnF6KndRCLfFLII6OvTS7L3lYaQ
         0vag==
X-Gm-Message-State: APjAAAXGwHsrGEEtX+gChOCqoHtdW2gxI/IJc10krLTWLZx13jzKCmKY
        iP4l3uDHGl3+C3Rz5uoz0yB9Dw==
X-Google-Smtp-Source: APXvYqyAb3NYJI26X7MqFVxjVL23b6sr38r91MjidNGuAZG0y8cjvNgpZZPuH9ZCIogojja2cubR/w==
X-Received: by 2002:a7b:cf37:: with SMTP id m23mr7434346wmg.53.1567417753357;
        Mon, 02 Sep 2019 02:49:13 -0700 (PDT)
Received: from dell ([95.147.198.93])
        by smtp.gmail.com with ESMTPSA id n12sm19426057wmc.24.2019.09.02.02.49.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 02:49:12 -0700 (PDT)
Date:   Mon, 2 Sep 2019 10:49:11 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        "linux-arm-kernel @ lists . infradead . org Alessandro Zummo" 
        <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Josef Friedl <josef.friedl@speed.at>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Tianping Fang <tianping.fang@mediatek.com>
Subject: Re: [PATCH v6 06/13] mfd: mt6397: add mutex include
Message-ID: <20190902094911.GT32232@dell>
References: <20190818135611.7776-1-frank-w@public-files.de>
 <20190818135611.7776-7-frank-w@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190818135611.7776-7-frank-w@public-files.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Aug 2019, Frank Wunderlich wrote:

> From: Josef Friedl <josef.friedl@speed.at>
> 
> add missing mutex.h

In future, please use correct English grammar in commit messages.

I will fix them for this submission.

> Signed-off-by: Josef Friedl <josef.friedl@speed.at>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> changes since v5: separated from "power: reset: add driver for mt6323 poweroff"
> ---
>  include/linux/mfd/mt6397/core.h | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
