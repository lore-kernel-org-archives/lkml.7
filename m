Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38643C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B28320673
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yJlAz8p/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfJBNFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 09:05:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50571 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfJBNFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 09:05:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id 5so7141952wmg.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 06:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=oa1SyzAEu7lQ65/WuegJuRCX8cMH/ghLRQXn6LaNmGE=;
        b=yJlAz8p/TBM+DaFx6Dd1bBTMjBRt8J/QTIpNnhXv8yCUyG2JPgePapdXLxj66UbZu+
         CtARvJgITV/7JdpoxE643+g+5FFIU7bdXSFBkY0e9Arkbm5gAGr70DIrrS57yRyjgk5z
         wuVIUh48WLhUrAZjvRLyVJQJS4Wfx+WEZo7zP5usQAIskgPT117efQ74Y0fRldCeJzW0
         eQbL7HOG3m6duMtUnBbbZ4mm8KPVfmjvLBZjZbvf1p1jmrS/fkhAOpDhmU75bRF2PPoj
         mEl7IdJNlwWj4L/sraKHhHtjvLl+c1EsVoPJRRTunPk8rdUxWX9GztI0Y6QByN5cQVYM
         UNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=oa1SyzAEu7lQ65/WuegJuRCX8cMH/ghLRQXn6LaNmGE=;
        b=IbPSAysW0g0koOzGsAP77FGMYgstfkeNeXgaTm6VshSUJoAscmPXpwbjjo/ZdUOoRY
         ySCtYOsN5IAFi0GZ+U3GrcxUsKUb2NDEkW6W0FQ5PO9oY7Xm5ebcKH1ub6xrSvBXDt9m
         z68UWc8Rs3QrPqR4HP+prvOL6cMAfdvZy0yHMMnpxyAYQlYK+2FAb0K8qgV2gk0XUwVf
         AGGB5Vi2vKl7B/iMK0j2k/Fi7Fipq8AO/UjIxzqPgaj6k/0/HaKmXq9qUaU3t5oyOi4F
         p8TFR995Gw9N1CpChmu3vG8sSzXq4N1/E60H0+zcy/gHxHYV3JgQvt94jdFp5up4BHuB
         livg==
X-Gm-Message-State: APjAAAWZDAiUDE98ydndiQtDDlWO5m8OPpvo2uOWqnLfWa+cwqqe9ATA
        6+3yWvVx+C8XwXnKhbBaL9xXHySAedc=
X-Google-Smtp-Source: APXvYqzu/FOF1bw50X/N303Uo2EjGJG035lhfcci7sQhM5Wb+9HfRmW3inFoW1vPoB6mXvAQ4Bry4A==
X-Received: by 2002:a1c:5f0b:: with SMTP id t11mr2889867wmb.76.1570021550064;
        Wed, 02 Oct 2019 06:05:50 -0700 (PDT)
Received: from dell ([2.27.167.122])
        by smtp.gmail.com with ESMTPSA id b184sm6453960wmg.47.2019.10.02.06.05.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Oct 2019 06:05:49 -0700 (PDT)
Date:   Wed, 2 Oct 2019 14:05:48 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Chris Chiu <chiu@endlessm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] mfd: intel-lpss: Add default I2C device properties for
 Gemini Lake
Message-ID: <20191002130547.GA19897@dell>
References: <20190904055625.12037-1-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190904055625.12037-1-jarkko.nikula@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Sep 2019, Jarkko Nikula wrote:

> It turned out Intel Gemini Lake doesn't use the same I2C timing
> parameters as Broxton.
> 
> I got confirmation from the Windows team that Gemini Lake systems should
> use updated timing parameters that differ from those used in Broxton
> based systems.
> 
> Fixes: f80e78aa11ad ("mfd: intel-lpss: Add Intel Gemini Lake PCI IDs")
> Tested-by: Chris Chiu <chiu@endlessm.com>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> This is not immediate stable material since there is no regression
> related to this. Those machines that need updated parameters have
> obviously never worked and I don't want this to cause regression either
> so better to let this get some test coverage first.
> ---
>  drivers/mfd/intel-lpss-pci.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
