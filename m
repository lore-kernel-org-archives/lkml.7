Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E23DC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 10:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD7D280E4
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 10:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MNMZwoki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfFCK6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 06:58:17 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45825 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfFCK6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 06:58:17 -0400
Received: by mail-lj1-f194.google.com with SMTP id r76so15707442lja.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 03:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Hkb6ZGh0otQQtsG7EyeKc0XPVB1qeyVKCVz7z7GAK4=;
        b=MNMZwokibxUU6+0ryf7ELuQ9C9y6uLdFUZOlzwg8shXKvhfYvV5rRTTzeh41/lQAZ0
         1LQYdLODDWtYRXLksN6sfVGsFKWNE/4H3RgIXGAVjS1WA+aSNz/WyaO88z1qtMbacZYi
         uQLRyzQiUXprUBV1rwhQdLbRxTqLq5tncp1K/DcF5kuGm15RXfZlVbfkTKQSq2t+AA7A
         huj8SnqIzDRgQgjB36zFWJgjWu+yJQIQhFigor+UBthANFKjAT+aJXi3GcdwzFWW10EI
         eRIotdz3v5wpob/mQOhREKzUz3fvttn9KQVGTI0T/TaHwb3rwmpTMjPzsCjP0iPCVqn7
         OlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Hkb6ZGh0otQQtsG7EyeKc0XPVB1qeyVKCVz7z7GAK4=;
        b=TJzUft6d5Ok0uNq9ra0o4ksmlBUPq75yx6BQq9TD9sBu6UAXoxDwt0uWrkaLQapImg
         iFF5aPaQDAgXUUMxAcN8R9zgIN/ko/l3YMSxHfuziDgy6Y4wYQh+PCcnWMhUkdA9XDeR
         GF6TxeLuhxujfP9cctHdsLnEwB0FwX47EqpQM0aaHymgFge+nKViNq+6uSYeInEZWnCl
         mD0HVHqz31rb/sftT0v7CNshE5MWDQdOcw9edvywaemSOPhMx7E6vyer77WJzuRepE/w
         MhXnYJQu8iS/PxNTISzbwxo+qaF346N/THYifi9BzZIz+HgfO/XxXTV3Qn2ljCACQzw9
         KpUQ==
X-Gm-Message-State: APjAAAVAuD3fdy0q58uLp5TlZ9Mn0Y/iS+fzi1byMeCwrC9S0mlcwKT6
        P8dCF5Yp6bqznNGi2HKM94AAVz/EQuMRH4hdAKHrxA==
X-Google-Smtp-Source: APXvYqxo/ADke86oscEtkWdOZe3GDp/cLqsLQ6zE2mLLJbDnU81g0eCO5QoeN9mSyfQkx4QxgcHARZqrEYTDhPchXJA=
X-Received: by 2002:a2e:9018:: with SMTP id h24mr6376615ljg.165.1559559494919;
 Mon, 03 Jun 2019 03:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190529145322.20630-1-thierry.reding@gmail.com>
 <20190529145322.20630-2-thierry.reding@gmail.com> <CACRpkdb5vB6OwcAxtjsKLzHt9V27juEOEEDqqQczKT-3r+7X-g@mail.gmail.com>
 <20190603075324.GA27753@ulmo>
In-Reply-To: <20190603075324.GA27753@ulmo>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 3 Jun 2019 12:58:02 +0200
Message-ID: <CACRpkda47EX981Dw=jLrU=PHn50+AQhJmpVRWJ9uJEQdcAsrTw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] gpio: Add support for hierarchical IRQ domains
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Lina Iyer <ilina@codeaurora.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Bitan Biswas <bbiswas@nvidia.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 9:53 AM Thierry Reding <thierry.reding@gmail.com> wrote:
> Me

> > Please drop this. The default .to_irq() should be good for everyone.
> > Also patch 2/2 now contains a identical copy of the gpiolib
> > .to_irq() which I suspect you indended to drop, actually.
>
> It's not actually identical to the gpiolib implementation. There's still
> the conversion to the non-linear DT representation for GPIO specifiers
> from the linear GPIO number space, which is not taken care of by the
> gpiolib variant. That's precisely the point why this patch makes it
> possible to let the driver override things.

OK something is off here, because the purpose of the irqdomain
is exactly to translate between different number spaces, so it should
not happen in the .to_irq() function at all.

Irqdomain uses .map() in the old variant and .translate() in the
hierarchical variant to do this, so something is skewed.

All .to_irq() should ever do is just call the irqdomain to do the
translation, no other logic (unless I am mistaken) so we should
be able to keep the simple .to_irq() logic inside gpiolib.

Yours,
Linus Walleij
