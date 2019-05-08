Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85D6C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 12:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98FFE21479
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 12:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZKHYRMee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbfEHMAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 08:00:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44499 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfEHMAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 08:00:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id c5so1609497wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 05:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=i4lKauK47NcaBmGgR9lDeQfByJwWe7Cp0nkxKBkV1JU=;
        b=ZKHYRMeeGodXXXgdaXWVsaSpBNZZAVboJUgLYiTu7TQh7Le3QQ9eifN8zyzI4hYiRJ
         oE/Fl2YcvYZEv7dlSwBIeu+9cr67i7+sN0l+q+/XxFv0xSQcjogy+Yqz5UbQJxutHGun
         JQi02iHXJhaXl2g0DDosMo9ZG26GKIEctc2GaNZZeaGQxp0Q3L4ORt9JAq0fXjlCkZof
         lUrQsG2U0GWce+5htmslKuUo93SSxXmKLC2yK7h+GH59m4FzMNXnSre839UXx+Fd67Et
         MM+a4g8zvvHJDulK/pxBVqQkGkCfBo4ql+tGMFQ2IY+lk50nypCShUKn+9gsYkACKaJg
         c0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=i4lKauK47NcaBmGgR9lDeQfByJwWe7Cp0nkxKBkV1JU=;
        b=RjZaOJjhB5IvkJhXP2r2yG1emVeywC37hJN5Yff5IqC5YbI7s0GfwGB4nIdSGHu/fP
         fm4rKz8AzSMbbsbAPDuATRbxZ9FWB1tDYlE/jLhIxeC7YDtGkfUDzN6jjVocq1WD46Pe
         ywnYwc0UAENSwVzXNuEL+HbT5jeblkbRToBMGvAwfA+vdyuPd29jzyrCN2iETz6oci2S
         jIkxFEQnMGt5HtAfBKVkRqxDNBmeLKKFzdV9fVJjUyJPjQbbY84tr6mw1bWNPUTw9Sla
         yuXvykyhvPwaRv3LUxks7KjVTh0epF1BnHg41gqRkj2upi4JI3leFEpi47qlZYgoc18d
         QzBA==
X-Gm-Message-State: APjAAAXtTy81Hoqk+3UtxdaNgGPJqpbt7btuTcp6CIyF4PN3jErJmNDo
        InJSWN+jzYqN6HFbi4P4oMGzoQ==
X-Google-Smtp-Source: APXvYqybIYNtwSNzHZtfhR5d74AwNOquue+jwfBrr9eUT0KES+NyVXR0oGuimD4MYfpNaXJYaiJ4RA==
X-Received: by 2002:a5d:4e90:: with SMTP id e16mr3957728wru.312.1557316816200;
        Wed, 08 May 2019 05:00:16 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id r2sm2266405wmh.31.2019.05.08.05.00.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 05:00:15 -0700 (PDT)
Date:   Wed, 8 May 2019 13:00:14 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     gwendal@chromium.org, bleung@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, dtor@chromium.org,
        rushikesh.s.kadam@intel.com,
        Vincent Palatin <vpalatin@chromium.org>
Subject: Re: [PATCH v4 2/3] mfd: cros_ec: instantiate properly CrOS FP MCU
 device
Message-ID: <20190508120014.GR31645@dell>
References: <20190508091956.5261-1-enric.balletbo@collabora.com>
 <20190508091956.5261-3-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190508091956.5261-3-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 May 2019, Enric Balletbo i Serra wrote:

> Support Fingerprint MCU as a special of CrOS EC devices. The current FP
> MCU uses the same EC SPI protocol v3 as other CrOS EC devices on a SPI
> bus.
> 
> When a MCU has fingerprint support (aka EC_FEATURE_FINGERPRINT), it is
> instantiated as a special CrOS EC device with device name 'cros_fp'. So
> regardless of the probing order between the actual cros_ec and cros_fp,
> the userspace and other kernel drivers should not confuse them.
> 
> Signed-off-by: Vincent Palatin <vpalatin@chromium.org>
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
