Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06001C17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC7920674
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZZT3kTVK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfKKJZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 04:25:13 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34290 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfKKJZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:25:12 -0500
Received: by mail-wr1-f65.google.com with SMTP id e6so13829352wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 01:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VAhgFuknLH+5wiq8gpshwrQB5hsKGp5uyD1SKtlD5qw=;
        b=ZZT3kTVKlAhZeX/N1Fvo+J/MQqwPp8uIHJEUXfME6HpfveP8v/D27PTJfk90U4I90t
         mRCY+1phXU1NUxl7eV15hmK5Jssl7QqveGx+YJP6NsK9o4z9qV8DuQUUn0Clxw9Xo1Vf
         d+afqPzL/lG3S0DnazgdXV3z/eBii8U3kCEmsQekT3lWdpDZ4M28XaPdcket6px5zV04
         HUX1dgoE0fBPFv2531agmoF8MECttCNT9Gh1/a895oEFOK/goc7fjsW/n98WgKy9mUIA
         Bx71jjuXJSuDJc7PuYxJssZ+RLKbj5x/4W2KzOVch2qQBCx97p4nDoX9RboELD8dQMwq
         Ewsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VAhgFuknLH+5wiq8gpshwrQB5hsKGp5uyD1SKtlD5qw=;
        b=L+rpJZtQey19tzkfS7t5FjedG/+QS8yjy+ytOwUhEj0Hk7M6w56MvuR8uJ9sxn68rF
         JAoKUhj6GaMvwF/1IinMXC8yqi5ehOSBGMGHDkWQWzmFij66DowF652DekpycswZ5Pc4
         nEH9jN2zjGSVjiQY90H48Us69inGGBo8TCV1SQabK3TEA7/pe6ZO3Y519tMGZ1evta0H
         +y0pZOPE2oFVwyn8DL0b1txfr7TpjkeDHiEifHbMEPqs8tdFtYT2JMkQqaXYzvVyy7iI
         NK6sGNZHAA1DlaD8htM04wEoEJslPemz2oqAK9LPPXS6NJiNDRkpdVaTxC7r6KfhwJlx
         sZ+g==
X-Gm-Message-State: APjAAAWiSPd7YFzxPnvuqxiF+otmW0mvyioM1Gnm9XZOdGkysFqNTGvw
        G61PF4wn/Jsn08xZIcoj/R1a1Q==
X-Google-Smtp-Source: APXvYqyw8G9ReMr7hKfdQleBjqoUQ06hvaDyQGL44hHp1RrN1PqVZqBIUWqqsUUff682AmzCC8i97w==
X-Received: by 2002:adf:c105:: with SMTP id r5mr20303156wre.125.1573464310629;
        Mon, 11 Nov 2019 01:25:10 -0800 (PST)
Received: from dell ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id q15sm6492591wrs.91.2019.11.11.01.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 01:25:10 -0800 (PST)
Date:   Mon, 11 Nov 2019 09:25:02 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        daniel.thompson@linaro.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dan Murphy <dmurphy@ti.com>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V10 3/8] backlight: qcom-wled: Add new properties for
 PMI8998.
Message-ID: <20191111092502.GQ18902@dell>
References: <1572589624-6095-1-git-send-email-kgunda@codeaurora.org>
 <1572589624-6095-4-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1572589624-6095-4-git-send-email-kgunda@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Nov 2019, Kiran Gunda wrote:

> Update the bindings with the new properties used for
> PMI8998.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  .../bindings/leds/backlight/qcom-wled.txt          | 74 ++++++++++++++++++----
>  1 file changed, 63 insertions(+), 11 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
