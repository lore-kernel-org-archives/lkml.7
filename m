Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A4FC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6E520862
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XsCW8Opn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbfJDMFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 08:05:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33165 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfJDMFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 08:05:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id b9so6901597wrs.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 05:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0kiQfs8vhDdOITptnzWw+B0dDpP2AER+UC8EB8Xy3mI=;
        b=XsCW8OpnLzjcS61aOo1Yh3fP+V59Xk+Dc0ZTrTPqN/J2nRW3e2A2aYvG1LM+ZXHVEv
         MTU0A6zz37X/lriIY3ltpdEtQip/d7rX0/gI53f4v8YvFg0yyfvZgNCJJLh1RA2qi1m8
         zElLoeK6+IENXsGTMukOHEiPKz0f/hWNXHpifX2gnuNT4urK/xorGBmrR1dYvzG2l+m+
         Kz6bWHvVCGB+i1Foh1pK3S9IK/VESQCurvDOSmp2xsckr4L/JOimZtJx27zWWKTctX9I
         WWNq8FiOSpjZdbMg4y88rQ8q/QDnzkz7g8QYmV+rgOi8A/2uF6bt/QXF6q6aLfYgTTjO
         nlUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0kiQfs8vhDdOITptnzWw+B0dDpP2AER+UC8EB8Xy3mI=;
        b=jq+C8BUhoysluJc/sVOjW+2wyhYAe7NAvgjPbFlGKx/IcQEBxw178yp/4l7oFnOJBX
         DUzeleYHhJRNJQojGRtdnJrhWuNtpHRAcdJYeUAfVdYOIhnAIIjdTDgPR5yfdo6CsxLi
         dORL0U/5REjCzF1lhBCFGV/VM7WSJ2UH2X3CgHT1xKcT/HOxz/31kF0WtuMpT3g+yJce
         a3WcVLix/GXVTgahch5xy2CsBYXcBxB6c33U5Y3q3iwXz5f+vawgAQRv48OZwSLYdYHP
         QycRdmc70UV4HbSAb86fKYi3a7JaG7DEEY1+2vqzpZSoROhZzpO45HpC6oEt9Dmc4vz7
         jmLQ==
X-Gm-Message-State: APjAAAXnh4ypFA7or76OccTwmA7LXYb7vMSMUJjW925/Fcl5r6IghWCv
        Moai5hwXK66IZlykqGUrtIs7vw==
X-Google-Smtp-Source: APXvYqyIxodV9sCnDx2rqHYS5wQ73rGu0Kh/d8gY7PvBN4bLJIU5EqfJnKy26vrR8jiNkoPHegsHFw==
X-Received: by 2002:adf:a1d2:: with SMTP id v18mr11336431wrv.302.1570190721062;
        Fri, 04 Oct 2019 05:05:21 -0700 (PDT)
Received: from dell ([2.27.167.122])
        by smtp.gmail.com with ESMTPSA id b7sm2009455wrx.56.2019.10.04.05.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 05:05:20 -0700 (PDT)
Date:   Fri, 4 Oct 2019 13:05:19 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-kernel@vger.kernel.org, d.schultz@phytec.de,
        linux-rockchip@lists.infradead.org,
        christoph.muellner@theobroma-systems.com, tony.xie@rock-chips.com
Subject: Re: [PATCH 2/4] mfd: rk808: fix rk817 powerkey integration
Message-ID: <20191004120519.GB18429@dell>
References: <20190917081256.24919-1-heiko@sntech.de>
 <20190917081256.24919-2-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190917081256.24919-2-heiko@sntech.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2019, Heiko Stuebner wrote:

> The pwrkey integration seems to stem from the vendor kernel, as the
> compatible is wrong and also the order of key-irqs is swapped.
> 
> So fix these issues to make the pwrkey on rk817 actually work.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/mfd/rk808.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
