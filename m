Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E00C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 16:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE6520866
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 16:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IyF45Xxx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbfLTQfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 11:35:06 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43744 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfLTQfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 11:35:06 -0500
Received: by mail-lj1-f193.google.com with SMTP id a13so10613985ljm.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 08:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rFD+CvYm7Gs/8aaJTbwleryPqt5gW339MOqPPhNFq9o=;
        b=IyF45XxxDXiGY6jDbxeu85FHtjr663+33QiXXrgFqCh56VoTspJPrWueAWdfucQvlj
         adUXTWQzzTfKrZVUOfHUuaJcBMnBjVDLsWz2K1l/unH6ddJJ7EuqW3JAdNoWzdoPMibj
         QzQ3vKcFqEWbqysmA5J67Di27QwrtpVVtiIGWjNzuQjmGKOzeCGLO2BFRI+qKVV46lcK
         X6pRsSaIgYWDjzWS+7bKuqxdyFy5WleDV9KDWg3AG//y8LuF686wl/hBKzRXE9UQA1yp
         pdycq3dArRK2mZSElb+4zdDs3T2oSNa3nHnR3n4M7+phtTVVNDP8jrCHtybB50lOQd9t
         Dktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rFD+CvYm7Gs/8aaJTbwleryPqt5gW339MOqPPhNFq9o=;
        b=XWGtvIv4hrcLq1l0kvcRNGCzc9ljJ7yz8fHXlHu6d+pHeLGdI6koIyNxh70JF5GaI5
         S3Ke5ZAsF7TLH3shkrvp8xYgcvdUKtCyylFht3NzI9zZKVXdxIBTh4fwhTRzxyI2L4hE
         2XeZE1YXq1wjwKTyQOzj0W71xGMjYfURJYoECJ2iGdWrkkU/5+yuAdJX2igemvs0awsT
         8uTibUtB6yfuDa2mY//zTobeiFKfki9A2Pi5wYtBQcjPVjHCq7Mb0WupIhH/D5jQW9sR
         5lDg1ckdrrCfm0cowjDfW0en7pbAohNIbvRFSA6Bu5yksiPgLFFMFsoLtWkqxvbb1t7S
         wCYQ==
X-Gm-Message-State: APjAAAUS99hVQWy+qn84mVGxz2Qt3fVCtDaFKLtwkcePkV9X/ag8gluc
        leizDGomrEAQjSvBx+hQBR6JO6MVmUv/pqmswN4zTw==
X-Google-Smtp-Source: APXvYqwnxwRhpuCJTLl02hGFZHqGl/wXHiSfUc5kYi6vlhPqmWMXlT4pYIgRpn7fCDsZAXO5yrdUS+peE9jjnXA5JEE=
X-Received: by 2002:a2e:a490:: with SMTP id h16mr8361295lji.251.1576859704348;
 Fri, 20 Dec 2019 08:35:04 -0800 (PST)
MIME-Version: 1.0
References: <20191220160051.26321-1-dan@dlrobertson.com> <20191220160051.26321-2-dan@dlrobertson.com>
In-Reply-To: <20191220160051.26321-2-dan@dlrobertson.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 20 Dec 2019 17:34:52 +0100
Message-ID: <CACRpkdb07VLWeBbSGs1qvmXfXyLFPFZWxiTKVEfan0cAnrbiLw@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] dt-bindings: iio: accel: bma400: add bindings
To:     Dan Robertson <dan@dlrobertson.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 5:16 PM Dan Robertson <dan@dlrobertson.com> wrote:

> Add devicetree binding for the Bosch BMA400 3-axes ultra-low power
> accelerometer sensor.
>
> Signed-off-by: Dan Robertson <dan@dlrobertson.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
