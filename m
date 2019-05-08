Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F16C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4F621019
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vEkqFmBv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfEHIEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:04:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33539 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfEHIEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:04:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id e11so12842859wrs.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 01:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4Acp/6oDD74k6p5VNFgaJ01iX7kpt0PfB8zkeh7h98U=;
        b=vEkqFmBv0/MnEs1wycFGDbk/i9F7vCyBezB/oSZbZRfUhWLq528595rXLhxmRs6lmm
         FMvTqKQS4rcAN4QGzesFif/NdhuBtx69eM6zOCPMHy+Qic83ZpWAPbroFJ/UdmMQUYgW
         4efbraS2xE+8+XBk7ImVFMZW01KgR2dhA2ZI0xi9cEdVF3x9lFxhqC94uXtJp7kYTDD9
         2F76ZM85WgFAb9dvKJ1xOvFSmsNKtQI6Oisx1hLROAoMhkMl37icfdjZBw5aabKsRv/8
         HwKY4nPJB7PeEa0u+NUE5FvnY0iMUCvJYk1Mj5ykwfWs+aJcZjcWuNBcp+fUFqWe3dmu
         uOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4Acp/6oDD74k6p5VNFgaJ01iX7kpt0PfB8zkeh7h98U=;
        b=Qw1bZexRtAAHlTmqEwV2VUVKlZNnDOLPqhQ9vEkmcOiyrtUMpFLb9j8H4d6oEQtn4e
         uEZukizQFx9KbXRWNDMhRYb97oNBqIWwvN+cyVArkOEogX+L2aiPNOcCO3WMxfciI2or
         +fEWipl5mG+djrVMj47OsNZJWygYYatHKgxXuzw6VyQyiqYH54mWCyeC5Xlud3w8+fOh
         FpeK8xcA6ZL0AeTLV5TRVDzMPbhF+2HVVxSHyT7PStJbO6NBWJ0FBP1WkHf+/QdYkQ2E
         QStG1riT5k0Lspg9dzKtZBzu9XrieyzJ+WfrwXMJMeSjYqyE2Q/loqYklVZ3dl7LvuM7
         bCTQ==
X-Gm-Message-State: APjAAAWjOzpFr3K11cauHnuvv/6GL2tBN3p1dDnJBOn5EEfT1s31LKA3
        v3zy4/vnLE9uU53/+iX7rJogvw==
X-Google-Smtp-Source: APXvYqz3jd+ocM4x9acmF1cNa5n8/12EvAdEySoeUdTT555Ig+z3xJUXDgi4uhThJqQ8+8N0Or8OiA==
X-Received: by 2002:a5d:4fd2:: with SMTP id h18mr19311wrw.117.1557302659181;
        Wed, 08 May 2019 01:04:19 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id t6sm12224246wrn.3.2019.05.08.01.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 01:04:18 -0700 (PDT)
Date:   Wed, 8 May 2019 09:04:16 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     tony@atomide.com, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] LM3532 backlight support improvements and relocation
Message-ID: <20190508080416.GB3995@dell>
References: <20190407182514.15427-1-jacek.anaszewski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190407182514.15427-1-jacek.anaszewski@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 Apr 2019, Jacek Anaszewski wrote:

> The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:
> 
>   Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds.git tags/lm3532-driver-improvements

Pulled, thanks.

> for you to fetch changes up to b3e9d18dc4a5e4d329dea32b59bdde5e012ae64a:
> 
>   leds: lm3532: Introduce the lm3532 LED driver (2019-04-06 21:06:07 +0200)
> 
> Thanks,
> Jacek Anaszewski
> 
> ----------------------------------------------------------------
> LM3532 backlight driver improvements and relocation.
> ----------------------------------------------------------------
> Dan Murphy (4):
>       dt: lm3532: Add lm3532 dt doc and update ti_lmu doc
>       ARM: dts: omap4-droid4: Update backlight dt properties
>       mfd: ti-lmu: Remove LM3532 backlight driver references
>       leds: lm3532: Introduce the lm3532 LED driver
> 
>  .../devicetree/bindings/leds/leds-lm3532.txt       | 101 +++
>  Documentation/devicetree/bindings/mfd/ti-lmu.txt   |  20 -
>  arch/arm/boot/dts/omap4-droid4-xt894.dts           |  27 +-
>  drivers/leds/Kconfig                               |  10 +
>  drivers/leds/Makefile                              |   1 +
>  drivers/leds/leds-lm3532.c                         | 683 +++++++++++++++++++++
>  drivers/mfd/ti-lmu.c                               |  11 -
>  include/linux/mfd/ti-lmu-register.h                |  44 --
>  include/linux/mfd/ti-lmu.h                         |   1 -
>  9 files changed, 813 insertions(+), 85 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3532.txt
>  create mode 100644 drivers/leds/leds-lm3532.c

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
