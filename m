Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A5AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3980520882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fMaHVRyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbfDDP03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:26:29 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44946 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbfDDP02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:26:28 -0400
Received: by mail-lf1-f66.google.com with SMTP id v71so2077541lfa.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 08:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e/kpadB0Xxh95hQwYOBAnWPBRmA3f99lvnpish4ioq4=;
        b=fMaHVRyg/qlqsqe9/uS4CmbJzUZEFuBmuYEpi/1v6QhWZx6bDRr0vH3QnWRe9wyQM3
         YQl6Isv6fxK2/uMXtBzmKjkt4rTcGwDXVbpj4HYWF0kCqJ2OolpfD7wX5SUhsrId1F1u
         h5IIwjSB8gQ5YjIagpt/7H0EjBtRLHrftMGiZY3pE0fYbas4X7yrpxNW78V3d/6m6IWY
         cpMA4JGLJ5pDuTAC+/xkGeH9AWGlfzV4yzP4RCnDfK0Q61hqRrSQjGOx3LQMBxEdtBky
         RlE8/Nm0QTiR1wujIQBVfMqREyvtxhqeerEQ4ulfLw0ZBT5KxFoo3B6zxrwyh1vayk3f
         mTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e/kpadB0Xxh95hQwYOBAnWPBRmA3f99lvnpish4ioq4=;
        b=AhgRdEt81aggmcTZb5scmiViW651xlWney2h8Et9gNnw0MHpsMO+COnat12HHjekS3
         IIhCvApjVYPwJpCCToM6ar1q9HEZHJ40nVpT2DQYWPpctJbVpdnl0lR9mBUsQevJWi8B
         9TmAhDqkVweT2vgjNTTOWp3IeSxjd49aDH5fOUO09Frx71JxcMSaGqStLDA5OxHLMaJm
         KIzyzQXxCQsUqZMy7RU44xUNAY11grOg1eMbt6CBTVyZq/+Bzesnjzh8TIELJmptGHdd
         ejL+oMnjM05FWeXbHRnLiopILllTimN6Z3kSQr76zaf5AoG8K3HDRWqoxXrOZ6boLi0x
         bV0w==
X-Gm-Message-State: APjAAAVNM5FoQnLUEOIKd6UVX4LzV2caCT80gZ6MdiYVqBtO10mBGlXa
        xBLxeTeTIyIKk3VFWw0KMAvfRjvFPMNWe+ZcPy8Mvw==
X-Google-Smtp-Source: APXvYqzNpjtQ7U+kycc8QWzUd79WsYFUxPKIDqgW3bHAPKUlElrjZGK8sZ4XZX67Dma6Nmc14W1YiE3Xpotq+Fck+0A=
X-Received: by 2002:ac2:54b0:: with SMTP id w16mr3776063lfk.138.1554391586387;
 Thu, 04 Apr 2019 08:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190321150909.3576-1-yuehaibing@huawei.com>
In-Reply-To: <20190321150909.3576-1-yuehaibing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Apr 2019 22:26:14 +0700
Message-ID: <CACRpkdYpGF+TqAZjOicoqRuuzbCDFTPAHeE2iT6EkEuF81xFVA@mail.gmail.com>
Subject: Re: [PATCH -next] pinctrl: artpec6: Make two functions static
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm-kernel@axis.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 10:09 PM Yue Haibing <yuehaibing@huawei.com> wrote:

> From: YueHaibing <yuehaibing@huawei.com>
>
> Fix sparse warnings:
>
> drivers/pinctrl/pinctrl-artpec6.c:691:5: warning:
>  symbol 'artpec6_pmx_enable' was not declared. Should it be static?
> drivers/pinctrl/pinctrl-artpec6.c:705:6: warning:
>  symbol 'artpec6_pmx_disable' was not declared. Should it be static?
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch applied with the ACKs.

Yours,
Linus Walleij
