Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A24C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9865C207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U3w+OKyB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbfIKNvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 09:51:08 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32783 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbfIKNvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 09:51:05 -0400
Received: by mail-lj1-f193.google.com with SMTP id a22so20110558ljd.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 06:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NoMqRKmSHDNSonXcVU6fMQXm+z8bwoc4kZBnKFdCowk=;
        b=U3w+OKyBdOmsh6TvHMeNg2QShNoGWJKQGgwwHt3oI+sJpfMGXbMmZAW4xPIAm37vUf
         eHS2BZ9FeUkb+xCURTh9+1atnbXo8i0O4a0ONkSg9pFunDi8U2UOmSKJo1csyqw42lFA
         Mtkq+qxIiq+2bjH3m880tHaH0bAkOzrbgg0bCQxQuUQHe6UfpQX4gtCSowLb48kYe9H8
         UDScj59r1OpzGwKEUTtY0PSMfA669A1lqJPtmTOGCnfVHZP26XqHbb0caZ6Vh8TRf0Xv
         FKUWnGmrKvVL/6XJ5Hq/UgLcW9DyKpOfdnw39veCqa1inGv0zjOMM6xtfSIokn3qL7oh
         WaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NoMqRKmSHDNSonXcVU6fMQXm+z8bwoc4kZBnKFdCowk=;
        b=ug6X3KHECSrwhXGo6Dj9cxgimqDMc4HcJTiI01qapyFJV/gcs3GNS+/hilh2bgwwrs
         G214tK/ZJowvKbhQwmztS+OhRqCj/NdiQpuhf+szf0KHu70VzCr7WpReVlJovyAnL5LI
         lCIxHiEOu0pljLQMTPIGtvhbqgtstp2cgMF+T2S4BiVYu0bN26sV0ydWHfBrlUwhvlCI
         S+/5JxJpNDXemRx30vmdP0cuEgKhTk6Jj/53FA3eXf+yWgdQYPYFzWO4btOKFMVc669N
         GeNIEKLUQ0AUjixOtINt/DTPPw1VfG9PMWRt4OwKWksRkYxAYEsL3Mv5DEPor7k21GVj
         OQNg==
X-Gm-Message-State: APjAAAXHGf7FNEaiXAumSpUuNXTI/ByD3ZTHRJU8Dsve7V1K6hSJRsaH
        YzdHCc3HrqXAfC8f6K7vJK0q1CE9z0jeOYgCjqv7oA==
X-Google-Smtp-Source: APXvYqwfZnw3PjgDOxtmmaDanHc/yotTXP96wDhdzPOnMRhDpWyM2WFlorifP/kb36RfTEmUgCFHL3JnFqi8Mce9Hw8=
X-Received: by 2002:a2e:884d:: with SMTP id z13mr22437077ljj.62.1568209863184;
 Wed, 11 Sep 2019 06:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190906131032.22148-1-yuehaibing@huawei.com>
In-Reply-To: <20190906131032.22148-1-yuehaibing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Sep 2019 14:50:51 +0100
Message-ID: <CACRpkdZgH9Q9OMUV4C6zADPj_NN+QrxQOLUDcOqJ_oYCxWP7vg@mail.gmail.com>
Subject: Re: [PATCH -next] gpio: creg-snps: use devm_platform_ioremap_resource()
 to simplify code
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Eugeniy.Paltsev@synopsys.com,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 2:48 PM YueHaibing <yuehaibing@huawei.com> wrote:

> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch applied with Eugeniy's ACK!

Yours,
Linus Walleij
