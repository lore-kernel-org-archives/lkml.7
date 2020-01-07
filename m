Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A14C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2459A207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RYNdios5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbgAGKXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:23:42 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37006 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgAGKXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:23:41 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so40682778wru.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 02:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=sJZpZyEhsxJHY5wwSitkRgs91j41pXyGZ4UJ5YuJ6cY=;
        b=RYNdios50Tg7YRTel98/N1F4JPePr6GaDGsO9A4uXISgPleJZIEMbH1NI/KviCZZyZ
         YMqpvrIMbmluLV2KDjOFsBxKQfFaaMWJEReoMej06Uu+GsQbDteEpXapfocPyLUMbWtX
         Cen0b42bLAtrQMJlPrAwliVbdOoaegPd47J//HghUX/h+BQnvuAz+aV5j/Eb1VEXTco0
         G0iBhUnNuO9P0AGvO2ioSR41+HZHcS4aKRMVRRVfGAV9tm3r1d7uJu2Vb05R0dxXPiCt
         ek/c1fIjbdwdOO0ShHkbe3OMT/2ffMXEb/yPhFdfHqcfQeb+3mFlsAS+IMouReZ0y6Ld
         NgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sJZpZyEhsxJHY5wwSitkRgs91j41pXyGZ4UJ5YuJ6cY=;
        b=VmaS/f4p9y6zBKeJA9m4k0xg2Bv4oyczHO07mnx1NMSeskx4YGfQS2Ybssnn2pk2bU
         HMSY+jaPXGClY3NDutZN5U87s4nK6dAMPk745y5jyusH7gogJmHPUYZRoGlccwmKkNbV
         87ark8GFNhOL+7+amldEhY6Ks5P6jGQMcKztqC8qUvy1aS1bNUtgPYjVZkGj4p4feNL8
         USmfy7rZUEazhTWUuItkFJmioy7EQVdrv0iC6j/a5nfL3SpQ2Va+ibHK+woaAUcDjbk2
         4mno/uFMcsNwjHuwkYykse9uixCr1P2/God0zHgjVo3C89zaniG3W1BcR9dEcGq+gMPb
         maQw==
X-Gm-Message-State: APjAAAUF3oW9qqc57Yt+mh1JhwMPaQtJcGKe1eM8S/KfBEQJmVH4JcYa
        I9Sku1EN/MhRfc5OvRqZUsC2Ng==
X-Google-Smtp-Source: APXvYqyalywJ3MPKpS5zzwyWK129KOKQVwZiZTEnpHF1MEAoei0L1XcUxDeL/2BWkN2cyQ3hNzWNaA==
X-Received: by 2002:a5d:4807:: with SMTP id l7mr110431049wrq.64.1578392619642;
        Tue, 07 Jan 2020 02:23:39 -0800 (PST)
Received: from dell ([2.27.35.135])
        by smtp.gmail.com with ESMTPSA id z4sm26253509wma.2.2020.01.07.02.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 02:23:39 -0800 (PST)
Date:   Tue, 7 Jan 2020 10:23:47 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mfd: dbx500-prcmu: Drop set_display_clocks()
Message-ID: <20200107102347.GE14821@dell>
References: <20191228222615.24189-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191228222615.24189-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Dec 2019, Linus Walleij wrote:

> The display clocks are handled by the generic clock framework
> since ages, this code is completely unused and misleading.
> Delete it.
> 
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mfd/db8500-prcmu.c       | 30 ------------------------------
>  include/linux/mfd/db8500-prcmu.h |  6 ------
>  include/linux/mfd/dbx500-prcmu.h | 10 ----------
>  3 files changed, 46 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
