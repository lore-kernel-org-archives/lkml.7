Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3223BC76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 02:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C33D22387
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 02:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zRFzuYvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730843AbfGWCEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 22:04:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45095 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfGWCEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 22:04:54 -0400
Received: by mail-pl1-f194.google.com with SMTP id y8so19942116plr.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 19:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c+fYefKdegWfzNVcvBNCZFAqK5d+WzXI5vtjxfFF6J8=;
        b=zRFzuYvWEWhGryAT6Q8/QwGY+31z0WJLeKBR9uQowX7cZbFobNq11qUpTg8+BZ9xdX
         geyyg7Y+iGQzwrwj3w8cE1UZojdY1o3jWGaU9cpggpJHJO1wmLY1aPQwKWhPKX7GxOIm
         /NvsPv7aR2tvFuB2l39aNzgFqRfkVWHNr/zBjK6BcrfdIBv5z6Ljx1/ZPwVyrbRfH+fn
         WC0xIll82mi599BW7YbJ6tFjpvgPx0Lgi5B03JE0YEPlBUchR3PWyTjQSVOMMOY5KJ2F
         be5nLPczyeJJU4UOXcnq4KKqAfKifvC4IYRjLWX3B2c/N80/HngqF6zuF/cKP6wBQfJd
         yM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c+fYefKdegWfzNVcvBNCZFAqK5d+WzXI5vtjxfFF6J8=;
        b=gfi4zmwWquIKKMkJ0CabcuS3XJ9ATIl0RgkvG/XjiyFvYVodag18eDRrcFtmDl973/
         mnOvMGYeCQIKQaGRa7ZVjdLfN/VcxEhFeQ2biRa01onXYLuU4/IaSBifyDlyt6By2isD
         2yT1f4DrlSoWdgpUVgi38VCo2UOZ5uK41nPAXr8iuiY0iSbxoFs/a70fu6RZ4sT2m8e/
         SjIKxMjJvZVdwE9ydszUhIqtnE9oItbS1Jl0MffA6KtuJDgtBg9rlxVCYxTQ85hez+Ir
         j+rm1/sBIzJI9hVZHtA2gUYzJYLqZuJoehZOf2YlviZjZPQ1jtwLS47AZ2006g1hzEEQ
         W5Bw==
X-Gm-Message-State: APjAAAVbvTGunjuNe7O53Ua5rPtUFYOu8by9HlmE/PHPwYUUGpNxMGpw
        6/QCgxlFQ32vFz9OJPWTZzcC0w==
X-Google-Smtp-Source: APXvYqz1TZYMRg8AYFQKtJluS92AI/3l+SomVKMpEHPQggv0G3T/KfU0bla677YewN8LIbRxc6gdVw==
X-Received: by 2002:a17:902:4623:: with SMTP id o32mr76901784pld.112.1563847493573;
        Mon, 22 Jul 2019 19:04:53 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id z63sm6349546pfb.98.2019.07.22.19.04.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 19:04:52 -0700 (PDT)
Date:   Tue, 23 Jul 2019 07:34:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, vireshk@kernel.org,
        devicetree@vger.kernel.org, kgene@kernel.org,
        pankaj.dubey@samsung.com, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com
Subject: Re: [PATCH v2 0/9] Exynos Adaptive Supply Voltage support
Message-ID: <20190723020450.z2pqwetkn2tfhacq@vireshk-i7>
References: <CGME20190718143117eucas1p1e534b9075d10fbbbe427c66192205eb1@eucas1p1.samsung.com>
 <20190718143044.25066-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718143044.25066-1-s.nawrocki@samsung.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-07-19, 16:30, Sylwester Nawrocki wrote:
> This is second iteration of patch series adding ASV (Adaptive Supply 
> Voltage) support for Exynos SoCs. The first one can be found at:
> https://lore.kernel.org/lkml/20190404171735.12815-1-s.nawrocki@samsung.com
> 
> The main changes comparing to the first (RFC) version are:
>  - moving ASV data tables from DT to the driver,
>  - converting the chipid and the ASV drivers to use regmap,
>  - converting the ASV driver to proper platform driver.
> 
> I tried the opp-supported-hw bitmask approach as in the Qualcomm CPUFreq
> DT bindings but it resulted in too many OPPs and DT nodes, around 200
> per CPU cluster. So the ASV OPP tables are now in the ASV driver, as in
> downstream kernels.

Hmm. Can you explain why do you have so many OPPs? How many
frequencies do you actually support per cluster and what all varies
per frequency based on hw ? How many hw version do u have ?

I am asking as the OPP core can be improved to support your case if
possible. But I need to understand the problem first.

-- 
viresh
