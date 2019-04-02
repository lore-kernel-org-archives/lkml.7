Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2A3C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3981E20857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pLw4CdXT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfDBECA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 00:02:00 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43507 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfDBECA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 00:02:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id z9so5829252pgu.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 21:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QS3DKJXVq+2l2tRIr5cPVAuS7c5BQRUEv0NK4FSfEbk=;
        b=pLw4CdXTfbEtCfroT8iyA5wrA9rFuyDY0vL5huxGK582X5N4UNPi63WnP1lopSRajB
         HlNRjoBNMKcuCTEyzw4cfXl5/IQifpksuJ1hZxJ90NxlV5JntjxIc8fHfaSbZTq53xye
         EurTqD88ujiCdUq4kLf4WdVig7MS3o1XqdIoKllszjBLhVIXzpHzdJGlBqEVOVD6xHnx
         qagTHQY6fbIEnUqYJvQLBwGfQKo/T2vbGKQkC/12r5G9FX/TlRtQwdi9mGd4LEIB/arj
         Qg13gnwg9yrGL5Epf973dBETC+gWZu8Qa0jfr1J/yQTfftUjC2fO4OMUR+dwo5+yyhTz
         4Sqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QS3DKJXVq+2l2tRIr5cPVAuS7c5BQRUEv0NK4FSfEbk=;
        b=T6EK67JcxFpX+Gc91BQM9mDVUOB7noIigY2ELBQOmTQ07zxcCtwKb8BdNE2ZfDMPVS
         MAF4hFlK7QvVjjG+5w476t7yiIY/Tl/baWbon5yZ08/Tz7SLy/IFNrnZdtFznOm282TI
         szH4CbK3A5vxZ2FO237Ig3aGfbNCaSTv2hIbNTF1CeIMu2KHydhXzGMppfskNEHmne83
         MQWXHweuingsCKb/7WrpRs7QKhOR1rkCo4wkhsHSsOO8SLy5WS88syrqYX2xgquS2TOx
         HMH6QGeDqZpWFLzW4AGrvoLXlqsQqWvz8YR3XbKzCF82FWgCDkqZ20uugt3ijDcQHAZz
         eoMg==
X-Gm-Message-State: APjAAAX7b4Jka1RLW/P4B5kG4u9etxk7JwFC70HEEhBXLn+kFqR2YB4m
        8t1GXonpsTj9afhhkd+m/fXH/1doAa5S4w==
X-Google-Smtp-Source: APXvYqz/DdNcFM0DYTuepuInG+qmX1KbbrcyHieMnrm7DCQFacNwrLerS8W8wz50+xTX8t+xH4tb7g==
X-Received: by 2002:a65:50c2:: with SMTP id s2mr56488535pgp.112.1554177719698;
        Mon, 01 Apr 2019 21:01:59 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id b15sm16189140pgg.90.2019.04.01.21.01.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 21:01:58 -0700 (PDT)
Date:   Tue, 2 Apr 2019 05:01:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     groeck@chromium.org, gwendal@chromium.org, kernel@collabora.com,
        bleung@chromium.org, linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@google.com>
Subject: Re: [PATCH 2/2] mfd: cros_ec: instantiate properly CrOS Touchpad MCU
 device
Message-ID: <20190402040153.GL4187@dell>
References: <20190307175253.14785-1-enric.balletbo@collabora.com>
 <20190307175253.14785-3-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190307175253.14785-3-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Mar 2019, Enric Balletbo i Serra wrote:

> From: Wei-Ning Huang <wnhuang@google.com>
> 
> Support Touchpad MCU as a special of CrOS EC devices. The current
> Touchpad MCU is used on Eve Chromebook and used the same protocol as
> other CrOS EC devices.
> 
> When a MCU has touchpad support (aka EC_FEATURE_TOUCHPAD), it is
> instantiated as a special CrOS EC device with device name 'cros_tp'. So
> regardless of the probing order between the actual cros_ec and cros_tp,
> the userspace and other kernel drivers should not confuse them.
> 
> Signed-off-by: Wei-Ning Huang <wnhuang@google.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  drivers/mfd/cros_ec_dev.c   | 10 ++++++++++
>  include/linux/mfd/cros_ec.h |  1 +
>  2 files changed, 11 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
