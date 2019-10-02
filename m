Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BAFC352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03706222C2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570037380;
	bh=ixObYksDcwdxsYpVuABnzIv7db50ZTLDQefHZ5mzzVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ux63gAnUSVP4lzeTsUaW69BiBCAf1FbA4hN1Xr2FEBnI8s7TvErZfnaH5tnpmNcNs
	 fE8sHgYjlQayD6FuiBky+80ZVmLSFfHOz6AZExvTvu9nuZwQidNcsheDa6WqHgORHj
	 sdEn7xSOP7zpx7QJ4poovUfZVFDRRIiKcKY/C9R0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfJBR3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 13:29:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54143 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfJBR3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 13:29:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id i16so8085462wmd.3;
        Wed, 02 Oct 2019 10:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=knUYYHU2RbGFZMJdC/t7iP8HF/H6gnHVaApA8Esfhxo=;
        b=Z1xOXOi8giWYdBPsef30cFsZDIGE91qMj6llDgJPW4MAnTRsze81s3Kt21KZmE3BSc
         QGlspolGvKF4BNpt2F3kZ9KF/4itPArZYTl/BNoHNHP//3TfdFxYP8QozdwUA5O6mwfT
         tm0rnM2XkGoQCEwYUHlRVeCOl2XkRt+1tznNCmAOvGn6oQ1y4LupJCA9LZ+gAE9tZvCF
         FEDhvfCCq5lXO3BN5I1JrKc/iQfi3EWTk1Z+vpop+uwyzFznEJ2TuO5S8YXmSb0Lb4m1
         82GSVrKRg4Z1RqNjG16aRMDX7a+k1/Fa132GGVyxOjBKuPVBMoG/s8CB8r28GVipSSCn
         bSSA==
X-Gm-Message-State: APjAAAUST5AX9Hs/ljqKDY8T6zIZv4/vdHHvdxSLVVCTV3i0hplH4eCg
        SEtxQFtToUnpz44AtM5AgJM=
X-Google-Smtp-Source: APXvYqyH9fArHRTfXWfzqVQgaYVpo3bxfKpOmbUVndDKpAsFqO6SiYYHhg1MSaFN+BTdgbZp7amG7Q==
X-Received: by 2002:a1c:f004:: with SMTP id a4mr3750737wmb.42.1570037374987;
        Wed, 02 Oct 2019 10:29:34 -0700 (PDT)
Received: from kozik-lap ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id n8sm11547015wma.7.2019.10.02.10.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Oct 2019 10:29:34 -0700 (PDT)
Date:   Wed, 2 Oct 2019 19:29:31 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        kgene@kernel.org, mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        robh+dt@kernel.org, willy.mh.wolff.ml@gmail.com
Subject: Re: [PATCH v3 3/4] ARM: dts: exynos: map 0x10000 SFR instead of
 0x100 in DMC Exynos5422
Message-ID: <20191002172931.GE21463@kozik-lap>
References: <20191002060455.3834-1-l.luba@partner.samsung.com>
 <CGME20191002060506eucas1p28c9670128f5adfb628d7e84ce55c6e60@eucas1p2.samsung.com>
 <20191002060455.3834-4-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191002060455.3834-4-l.luba@partner.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 08:04:54AM +0200, Lukasz Luba wrote:
> There is a need to access registers at address offset near 0x10000.
> These registers are private DMC performance counters, which might be used
> as interrupt trigger when overflow. Potential usage is to skip polling
> in devfreq framework and switch to interrupt managed bandwidth control.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi | 2 +-

Thanks, applied but re-ordered with previous one. Applying first
interrupts enables the interrupt mode which does not make sense without
extended mapping

Best regards,
Krzysztof

