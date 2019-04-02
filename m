Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498E5C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14CF82084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tZ2L0SlC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfDBEBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 00:01:44 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43303 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfDBEBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 00:01:44 -0400
Received: by mail-pl1-f193.google.com with SMTP id m10so5544380plt.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 21:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=stKXmzx3DxL5KNYh3hF2IIhkjabOnuBqp3kgdjxz5sE=;
        b=tZ2L0SlCT5CleQVyPb75+cCzDs6xfQR1cv73fjcWU6WmvZXv4Zalasz+PJZEvQYMLR
         U+uvKQD2J3aBPL52WSmcaPLDyxW5d16Y2V9fZqsq0cDGvNrsZnqIhZdHA8WGo4SP6O6O
         TVgB30+yxTtpPafZqt5kOYt3kPufA264l/AZYxMMH2RV4RqSIQ96QIDjz0zrSVYVL8tQ
         w7w/3/Pssyg6t9GmWP4GGxp5of0NLEvBWoIA73kCIYstgtyZR7YqvvNqiWCKDeucY9K0
         svBTIEx1MSlyjRyd3tIka/AEP7Vi6Nj9t3c54+fxZin8g+rFqUwpfPeauPLWo7JGVO7E
         kVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=stKXmzx3DxL5KNYh3hF2IIhkjabOnuBqp3kgdjxz5sE=;
        b=tWCjckhloYUjkIoJmEmckVGfhh4YZVGlpTki9fAqBllo9Dritgd9qLu3moSvTQXcOT
         2XhoTiqa2Pag54cqMo/AB1V32N0TbGVGLxbTzson3WQDLtw3gMOVYVYpDFoyzEKTUEgP
         uiGf1KXrZWDp99I68Fw+VvaA3hGDlJcsNq95b140Zk4F7kl4Se6s6kv84ny007qh/lpT
         mPhJmz2L+m3EeAd7yBOEavi8bbqpIA0xFySF14efvkcAOltsIyZnnAp9+lDOo0WHByMh
         N+8oOzwq7yIRcI5/nlSel6Pmio53GA4U+Wy15o7bTXG7rXlQffZe7/S0HxS8Jg/j/YR4
         qlfA==
X-Gm-Message-State: APjAAAUb6Mz7Y9OLNs9VbEb9g9ca0r14lFxs8Y2BVSc3LESlVwkg7X/z
        Y6nl+dBYIIf6ZBkkPorF/GheCA==
X-Google-Smtp-Source: APXvYqwA1P/68IrohJh0Vpjao9JmDIRg2cuCfT1gQpHnWNvIh7kxSB1OG0za53JjaX3JymATDxaSPA==
X-Received: by 2002:a17:902:8c8b:: with SMTP id t11mr10621553plo.15.1554177703637;
        Mon, 01 Apr 2019 21:01:43 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id i64sm16561967pfb.112.2019.04.01.21.01.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 21:01:42 -0700 (PDT)
Date:   Tue, 2 Apr 2019 05:01:37 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     groeck@chromium.org, gwendal@chromium.org, kernel@collabora.com,
        bleung@chromium.org, linux-kernel@vger.kernel.org,
        Vincent Palatin <vpalatin@chromium.org>
Subject: Re: [PATCH 1/2] mfd: cros_ec: instantiate properly CrOS FP MCU device
Message-ID: <20190402040137.GK4187@dell>
References: <20190307175253.14785-1-enric.balletbo@collabora.com>
 <20190307175253.14785-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190307175253.14785-2-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Mar 2019, Enric Balletbo i Serra wrote:

> From: Vincent Palatin <vpalatin@chromium.org>
> 
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
>  drivers/mfd/cros_ec_dev.c   | 10 ++++++++++
>  include/linux/mfd/cros_ec.h |  1 +
>  2 files changed, 11 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
