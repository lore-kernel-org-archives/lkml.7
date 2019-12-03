Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8149AC43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 06:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56FF72073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 06:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jWh0uDRm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfLCGnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 01:43:47 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34884 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbfLCGnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 01:43:47 -0500
Received: by mail-pj1-f68.google.com with SMTP id w23so29238pjd.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 22:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cEGTgxRGdDj6W2EYyG4VZuBBv7xt+SBCI6XOXHZWHJk=;
        b=jWh0uDRmn4BxfEJcpQT1SJWeF1vuWBV4t1aBQKrYRvPeqlY0LeGKunz+aL5wsFS5CB
         C9POZgQY5BMLaMZYhUT/BaJibe5aXKUkLwED4ow4eqojmZCVZkXCIjwIJ2tLqS6w0Jkz
         CboW71cXML5/ZTtJRXUgR9H/CAA077+ufOVyx7sCANZlVy6zy/83rkhgIJIRUZSutUeE
         ZWZg+LbDqW2coEBoN+KJGYSkTvXpHmP/BlV/uZPGttC/b8A+Jpu3NyNLAaABnsSJTPH+
         qyCPys3F0hFoGq5Km40JRbqRgy9No4hPP1B2HNnmxV9nwh1mwOsiQjVB5ch3qGUw6DyF
         BSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cEGTgxRGdDj6W2EYyG4VZuBBv7xt+SBCI6XOXHZWHJk=;
        b=o7KwG1y0Ck48lJZkMC4vUnO2y1DNQXloPO8QDd32/men1Nuootpb8zfPuvy+1M+RWK
         GOX7BJpu8JkA4vGVwHSOpxcOviVz7paHb9cqZDGpM36VeeMsFZLsPT+Z4savGgOsMrRH
         Wp8d68xpH03/6HoMnjrgXxBYm68a6NUNtYD86Tz4MweXvOo3IEM5aMzYPtq2m3P1RsG8
         c2UIJeer7wLZPdGTYSvefjPwS8WPZDV5YOduaWuBiY5S+wRn6EXMrFgbrB9l9zeED0Zj
         HfacARQooNhY/2Ozfs3m5Yyrtb+Ttx1h5vr/v9QW0ljt2rnPIW6mcbLfWLfWEUy956tE
         W3lA==
X-Gm-Message-State: APjAAAUxdMxxRCk5vQBTv6mTjRDumJNr/Pxu4ft+XjWbJvjn0TtIY7Mj
        /THmBs9NeHcuj/6TmObVxAB8DA==
X-Google-Smtp-Source: APXvYqwcNHUHXFiQgO/rqZKPE/lAtGo5B105XBKe40csH7F5K3Nds1jXuQGP75FC1my2Q0xENSK/iQ==
X-Received: by 2002:a17:90a:a4f:: with SMTP id o73mr3787706pjo.97.1575355426450;
        Mon, 02 Dec 2019 22:43:46 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id s2sm1925598pfb.109.2019.12.02.22.43.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2019 22:43:45 -0800 (PST)
Date:   Tue, 3 Dec 2019 12:13:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, rjw@rjwysocki.net, edubezval@gmail.com,
        linux-pm@vger.kernel.org, amit.kucheria@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/4] thermal/drivers/Kconfig: Convert the CPU cooling
 device to a choice
Message-ID: <20191203064343.4lu3ut6rs6kyq7nh@vireshk-i7>
References: <20191202202815.22731-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202202815.22731-1-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-12-19, 21:28, Daniel Lezcano wrote:
> The next changes will add a new way to cool down a CPU by injecting
> idle cycles. With the current configuration, a CPU cooling device is
> the cpufreq cooling device. As we want to add a new CPU cooling
> device, let's convert the CPU cooling to a choice giving a list of CPU
> cooling devices. At this point, there is obviously only one CPU
> cooling device.
> 
> There is no functional changes.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   V2:
>     - Default CPU_FREQ_COOLING when CPU_THERMAL is set (Viresh Kumar)
> ---
>  drivers/thermal/Kconfig     | 14 ++++++++++++--
>  drivers/thermal/Makefile    |  2 +-
>  include/linux/cpu_cooling.h |  6 +++---
>  3 files changed, 16 insertions(+), 6 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
