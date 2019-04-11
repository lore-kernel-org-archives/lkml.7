Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9E9C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF55F2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mFZn8VKP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfDKNVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:21:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36489 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfDKNVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:21:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id y13so7365745wrd.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 06:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uRxGkieKZ6erotNh26J8cH5u6+2wuWz6FxzE797DTYQ=;
        b=mFZn8VKPmg/l7CM+8RPQrYWkC2Gqy9EXZjMAYyJtorHcWy+vVPNVciPdtir330OJwg
         e3D3ZnUYPMRPcTDK9cNudb8+ZvdTzYESTRUpUUc/GsEELxg0WCUXQf8DoqhFLDskfAa/
         sWGpCglBW0tUx5S/jMYql+0HcHDkPmyWy8m9McCIDaAl8TrJ4RnX3tBnMYw3M7yGMT/W
         /6MKib7UVOlXrqIIbDbv7RSltJvRb6FVxH24PguQ6r1qnc9jG2PzbUISK6F7XfoKxd/B
         XwPNkKZqXuZYGCXslB5MuYSPpXoa59pozPyBlnZo5FU3cZXVyANkIVH4jXy0l9msuaNz
         /qcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uRxGkieKZ6erotNh26J8cH5u6+2wuWz6FxzE797DTYQ=;
        b=RfDTEH1+5iFwPfVA1rxf9KQVbdSPuRMmi5DNX24Iq990b2nblLTpFowTlY3rQUW3os
         WyzwjUoNePsL7NHYFnoFLHIdpytaGlSsQayQegYXPCN+5F/XWL6H5IsH4UW34wZ72Jq5
         9DYp8tLzcY2PyBXxuZhNPh6PYZAYS+U819G/HqfD2nKFCGnhzwdWZDjwxwDCWqqyVnZf
         LC0yAHYHwzsCv9YNXEmXiEwWxyvywQjQ/kFryIeGuN8cMG9zevw3tAa7fKYzrCgSKlWE
         YYIEhEioH6mKSar6O51Dy3tuGh9CEAwpwZ7spInm8iM7vPdh6bXT5iRwpsgHfqtZIZV1
         LhsQ==
X-Gm-Message-State: APjAAAVn76kFUyAbRFBUaowX6Mt0ixv9ny+thQfTslIgoUqA3fxDHpiK
        bnb4ipMLWzQXdo3HzRbK/9ZOcd0f4+Q=
X-Google-Smtp-Source: APXvYqyjm0m6naUedLwlk/m3kWz659hDXmoUEiGVYsnVWflv+eXQ4x+vyUUBvPNd0graQX/BjnIqDQ==
X-Received: by 2002:adf:ba81:: with SMTP id p1mr32922363wrg.192.1554988899096;
        Thu, 11 Apr 2019 06:21:39 -0700 (PDT)
Received: from [192.168.0.44] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id 204sm8452928wmc.1.2019.04.11.06.21.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 06:21:38 -0700 (PDT)
Subject: Re: [PATCH] clocksource/drivers/tegra: rework for compensation of
 suspend time
To:     Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20190402030234.13488-1-josephl@nvidia.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b66bd5ef-1ab4-aa5e-6e97-5ccb7f7dd1cc@linaro.org>
Date:   Thu, 11 Apr 2019 15:21:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402030234.13488-1-josephl@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2019 05:02, Joseph Lo wrote:
> Since the clocksource framework has the support for suspend time
> compensation. Re-work the driver to use that, so we can reduce the
> duplicate code.
> 
> Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---


Awesome, thanks for this patch.

Applied for 5.2

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

