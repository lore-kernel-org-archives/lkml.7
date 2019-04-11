Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4900DC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16019217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sXot5j6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfDKNka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:40:30 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43347 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfDKNk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:40:29 -0400
Received: by mail-lf1-f68.google.com with SMTP id g7so4727569lfh.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 06:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2yWMzf+z1Jk9L/7ameJjD6k33YuMN+IHwR0h4etbCwc=;
        b=sXot5j6ZgCj+Zk2b2KUNu0gk2aqRXWqwGQ4v7T6eTqwwbf9QprCTUET/5btJ0xTI2U
         8upRZfo12QzEVGYUUWsiAwJrvcgirsbjRA3cHs5SKrSEkBi5dE6eJe1Cqe6hMs6mdq9x
         uCGwKP09Vt+LAIGM4sd77PiqLBrVvjIx5+iT4dMLA/XpzYeY8Lul9ODIajVMKAGSznWN
         f/8of7207uUpMTxHHzqOfhPi0q2YYVqN9zbsSMMkx5Js9n4z6UgrTW0FT0TyQNk2U3OS
         nplbjqvs9Zk8LI5ibQ21Im3onT0TyoKpyC3ydUdzPPpvq7k0/QuUvn0W68Hef4wAKZfW
         Fomw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2yWMzf+z1Jk9L/7ameJjD6k33YuMN+IHwR0h4etbCwc=;
        b=StaXrrOtpU3V+ulZyXc88JHuv0Qjxp/SKPRViM48bTaullbORodLX0kTbFUORfVlEF
         vL4gv0f55aRuLaO/Y+Gf1ZN6I9m/dICx7Am+9+74G7OD5EVLcOkj/MB3WLrUWOzR71cD
         fvn3KC6EsJJcSNAWfn4t6nOsHQ4fX166S+aElNU3iHLz1cY/xMmIr/82KoYieHHb1OXv
         M+lhQiNsvc/mw/1JBqjrrMuDtER/Ue3caS+6ELXzJdOmdYjhQDtYCR/VBPy/TwCvznf1
         tq9O3pu1MWNZDO9pnHJar4EoMoEFyny6sGzZr4qVXwZ3/33wRiwLmNdLDCgKpSHP3xl9
         1AQg==
X-Gm-Message-State: APjAAAVZ4u4VeqZNpqRNqVbj/F86CCGtU6Ua5QrVFWGx6mYofR7sRn7f
        yU/R50/Ysg74/VRb44uZ+v79aLecURtEohSU80LY6g==
X-Google-Smtp-Source: APXvYqxwSZVo7dW1p5oRMZGimWlK7DPwxBs36OWM69yh+7zC27Excnyf9qOqxSjEhZedDkjiY8YfvlKFeU4F9c77J8M=
X-Received: by 2002:ac2:4285:: with SMTP id m5mr26481123lfh.103.1554990027800;
 Thu, 11 Apr 2019 06:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <e7ca1df3b3159d6e1c65c6a2a9f01a7ecabcc821.1554882235.git.baolin.wang@linaro.org>
In-Reply-To: <e7ca1df3b3159d6e1c65c6a2a9f01a7ecabcc821.1554882235.git.baolin.wang@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Apr 2019 15:40:16 +0200
Message-ID: <CACRpkdY5kKRMkTV8-d_CgF75J3cOA+v2Hv2w4K7FqtDy+ABDmg@mail.gmail.com>
Subject: Re: [PATCH] gpio: eic: sprd: Fix incorrect irq type setting for the
 sync EIC
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 9:48 AM Baolin Wang <baolin.wang@linaro.org> wrote:

> When setting sync EIC as IRQ_TYPE_EDGE_BOTH type, we missed to set the
> SPRD_EIC_SYNC_INTMODE register to 0, which means detecting edge signals.
>
> Thus this patch fixes the issue.
>
> Fixes: 25518e024e3a ("gpio: Add Spreadtrum EIC driver support")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Patch applied for fixes.

Yours,
Linus Walleij
