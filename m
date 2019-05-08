Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A4BC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 12:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D91620989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 12:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XrMDzYQG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfEHMA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 08:00:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40514 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbfEHMA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 08:00:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so7585860wre.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 05:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=F9ix8avYy7Svxlos0D+qz7sr8oTpFebl7MgE1JRrAqQ=;
        b=XrMDzYQGjQZMd8qEvF2O4YWhKdejihOD+xYZxvwXfMgzIIf6CfUaLJuB+GItT6Mpy+
         K0Qhthte/4RgPrnnzLfIiYBuCUboFl8kTmlnK6vCRMTuP1AZ5z0xGnEzAgiYj13Uf0dy
         OuF/Z6TdEjpznNb1nQkKPbtRtSZc88V3Ot+ZGkKTFvgE4RJ7BGGSWxG7bmeJr0qD/d01
         Fws0BMPIMYneJtQthKSZrxxtx7aSg0kFA3ILbHAQXZY5uMulKIDraW0j0iCjNnqWcTx2
         4BUENJrLRLWmNt6h2tE7iAbZTFYb4JzbtVf3w7HxQTZFJsup+MYGaMqVx6BXoVVIzIBy
         c8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=F9ix8avYy7Svxlos0D+qz7sr8oTpFebl7MgE1JRrAqQ=;
        b=IXJqd+ysr5XS2Fe6Ho0u/Swer+XRzpaWZDNo3DG/Xic5JV0o3gL0D82OIYLQcpClil
         lKkAY9il1Yk24j/7oRPEVhyw9IVIb+sdlthFNOebmPY+8vWGeZSIcZmj7ttf+kUd5/Xf
         RC1xyfhB/VI/DQWkfyUkP46u7NjmSZ2z2uR3k133KsZ1kSdbXIYekMcbM1lRbAEGKmj9
         zHgjdnKwxhatYcBnE9isSzqZWU60P1n0ZIEQVqAhpKytGWG9YKBbKdn34BciOStFSJ+s
         Gh9MkT15UEhI9HRnFAQkdVnwNM17Gd9PvLZRsWw9Po9Zpf09hNG8Ag2ejZQM/60j9pkF
         SP+A==
X-Gm-Message-State: APjAAAU3OCtPPuTBeunrGNMvlw5+kpREiPPIeP/kDh9zEUJROsoOh3il
        XjlKsBzKNalMRUuG+4hIoLxAYA==
X-Google-Smtp-Source: APXvYqwXvv6BBxrCdtekKJ3eRNeVZcQ/WFpGfOZkr46cVtvRKJfaPsjQKGnFuNVe+YZeJ3n2vaPUlw==
X-Received: by 2002:a5d:488d:: with SMTP id g13mr26971022wrq.119.1557316824515;
        Wed, 08 May 2019 05:00:24 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id z7sm1557174wme.26.2019.05.08.05.00.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 05:00:23 -0700 (PDT)
Date:   Wed, 8 May 2019 13:00:22 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     gwendal@chromium.org, bleung@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, dtor@chromium.org,
        rushikesh.s.kadam@intel.com, Wei-Ning Huang <wnhuang@google.com>
Subject: Re: [PATCH v4 3/3] mfd: cros_ec: instantiate properly CrOS Touchpad
 MCU device
Message-ID: <20190508120022.GS31645@dell>
References: <20190508091956.5261-1-enric.balletbo@collabora.com>
 <20190508091956.5261-4-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190508091956.5261-4-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 May 2019, Enric Balletbo i Serra wrote:

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
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
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
