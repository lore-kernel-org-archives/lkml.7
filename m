Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3544FA372B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 07:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB482089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 07:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xWq5Hkde"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392768AbfJQH2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 03:28:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32812 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbfJQH2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 03:28:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id b9so1081846wrs.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 00:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lF+fgIZSn/XvW94K1ywke5vKThCmmdz9k3RaVW32JlY=;
        b=xWq5Hkde3q45K4PbAUMZnkHurefRtmRtgiCvKkBapdsqHhyI8Ee7NQgVyP0caZIy8i
         SkmQ1egZd2Ipk6BGM4y6AVJW9nvC+Xn8N8JdeokHXHBrBw4QK+COO33atNrzxg5d5lav
         nShDhgKGvxrmhHC9vz8BbXNWLBmsygaC5TapuRj9Lr9nwSYxpai6/9KlgrpXoTYA5lqH
         OEvuPup2lrG4cV2HbEGs8pg6Rhl7OlfjgoiMTd8ia7/O0zkZLEgPWYTKYVTKHGVrScGl
         6AeR9WuzrW03UrS+S7023opAzP3oRUr//UNnL+2NOnOuZLLH1pcxvM7LRDRO/YGJw6dG
         +Iqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lF+fgIZSn/XvW94K1ywke5vKThCmmdz9k3RaVW32JlY=;
        b=AsqJ8fT4Yz0hB2nydXPAEKYBedtYbSs3BjXlEVVrkwxuGzMFxQrAVDld95tw+15M2F
         +JFsYL23yE/7dIqQxxQTcts6i0AApcjT/azqg6X0lvk56iiNABd6+/QC0pevcg76cVn2
         8GoLV2bdtXpRzaVE7rtrM1pQtCZTjsVNyL8Fu0s3h9ImGCc/oKM3Wh6wflYCEfQvnjVi
         Hw+66y5+sNQ6Ksd0Da/Y9aNIAAzSnaMbpeBPnoOeMC1SMBw9ToDjokDkdNz4mW5FdTeg
         pRWabIY1MPLrgU+DoVd5pZQhr7/mNBNNYYZqWpIbpOAGyD+ANaQo64Wq+bX2rkgQvq1z
         YZRg==
X-Gm-Message-State: APjAAAXL4nTX/2ncyT1NdaV+EfjddmWhAd4DbTMSZ+3mn5v3Lgpu7Tj9
        xGtoCOt/tmYiBIP2pYa1aVXMKg==
X-Google-Smtp-Source: APXvYqxLpxoVGENRd1K1D0H43oFwhZes7gObxyyPv4AuhrB11kRaylbvgtEsJSg5Sud7bDf5lrdTVg==
X-Received: by 2002:a5d:6709:: with SMTP id o9mr1655680wru.116.1571297331032;
        Thu, 17 Oct 2019 00:28:51 -0700 (PDT)
Received: from dell ([95.149.164.47])
        by smtp.gmail.com with ESMTPSA id r140sm1610799wme.47.2019.10.17.00.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Oct 2019 00:28:50 -0700 (PDT)
Date:   Thu, 17 Oct 2019 08:28:49 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wen Su <Wen.Su@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH 2/4] mfd: Add for PMIC MT6359 registers definition
Message-ID: <20191017072849.GL4365@dell>
References: <1571218786-15073-1-git-send-email-Wen.Su@mediatek.com>
 <1571218786-15073-3-git-send-email-Wen.Su@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1571218786-15073-3-git-send-email-Wen.Su@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2019, Wen Su wrote:

> From: "wen.su" <wen.su@mediatek.com>

Should be:

  From: Wen Su <wen.su@mediatek.com>

> This adds MediaTek PMIC MT6359 registers definition for the
> following sub modules:
> 
> - Regulator
> - RTC
> - Interrupt
> 
> Signed-off-by: wen.su <wen.su@mediatek.com>

Same here.  Please change your Git config.

> ---
>  include/linux/mfd/mt6359/registers.h | 531 +++++++++++++++++++++++++++++++++++
>  1 file changed, 531 insertions(+)
>  create mode 100644 include/linux/mfd/mt6359/registers.h

Once you've fixed the above, please add my:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
