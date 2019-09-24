Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2C4C432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E667E2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jx4/I6tm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632816AbfIXQ2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:28:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38986 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfIXQ2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:28:18 -0400
Received: by mail-wm1-f68.google.com with SMTP id v17so743663wml.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 09:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BhiqhiNCyg2iKe2QgHnCVRClKHmtJxSxATbA4G39gTo=;
        b=Jx4/I6tmWFxd9oBqpJwEewoaLfll1xA49kapNwo4K7jIwLNsffD4izYcxn7GxwGEFz
         337SYN9mj2IvQriEMDYZ8ZQmgMDBO16aFo7m2EZ9P6p/nAKssi+7n4uKoDpAGeK43FQo
         fhgYgG4HJ6cKwTzbzeq/8tXruKHfQeZ8EUMcBpnSFm1ojAQvmuapo3ejeyolrmur+2Co
         IVmxX/JQwvrpifOwHYQ8pGJtNAMnUyKCfW3IF11WR+1i9ojYwkwl57YUdgQXa70tNvPk
         NZi4wYu97qdZyzrrHgjtujJNU9nYwCJrgYYzuJQjFGwhuhOdiQUbRT/pGWF4lZp5ZcMb
         qeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BhiqhiNCyg2iKe2QgHnCVRClKHmtJxSxATbA4G39gTo=;
        b=dB480txbFkQN3aFKAhwuu6vrjmRFoKJmvXvVyVMmRa2FgzcOvb9cysSIsFKD7Jrm25
         3peAul0yBrNt0ju1EROg7Wdh4jKJBAx7KSG5yVtcjNO0iSpUeXc4BS+mrlgCzlJeEIri
         TEeyBSLPQ6QXxUs8E5BuBAiMRaDhh5fKbSLHdb8PBINIaygpMBml9ac7z5u5p44VKlOG
         jnoHkNrimp0jXtgtHKo8dH62BJcb4+wnsDgzS8QHA9ohmGqxZt9BwHFSpYu+aUlMOrMc
         k+gedHsveupQADcW1xXjBNGEqf+mcxsDjgsgtO9uhsqWX4lYK5uAzVEEihsfqgUEzga2
         vRaQ==
X-Gm-Message-State: APjAAAX1BS29qLqGkfIQ4FEIT2XC363e53q5i8G6n9i3nzRtrQY0SruI
        hpyygazds5V07XUQw9esd3HED2LvemA2QjPRtpz/Mw==
X-Google-Smtp-Source: APXvYqxZ5pU4lxFJ5tQmF3vfkOLnNi5HezknxSez2JUPr5x+LtPQ4ks1/3HtByssCHPjURAE2yOlGO/+DZjLSQDG9Bo=
X-Received: by 2002:a1c:e0d6:: with SMTP id x205mr506020wmg.1.1569342496892;
 Tue, 24 Sep 2019 09:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190906184712.91980-1-john.stultz@linaro.org>
 <CAO_48GFHx4uK6cWwJ4oGdJ8HNZNZYDzdD=yR3VK0EXQ86ya9-g@mail.gmail.com> <20190924162217.GA12974@arm.com>
In-Reply-To: <20190924162217.GA12974@arm.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 24 Sep 2019 09:28:05 -0700
Message-ID: <CALAqxLXyGeW=GH-FyEyt1KfZk-dcUP7DEdQsd8nMjvBhpSiHbg@mail.gmail.com>
Subject: Re: [RESEND][PATCH v8 0/5] DMA-BUF Heaps (destaging ION)
To:     Ayan Halder <Ayan.Halder@arm.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Chenbo Feng <fengc@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Liam Mark <lmark@codeaurora.org>,
        "Andrew F . Davis" <afd@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alistair Strachan <astrachan@google.com>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Hridya Valsaraju <hridya@google.com>,
        Pratik Patel <pratikp@codeaurora.org>, nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 9:22 AM Ayan Halder <Ayan.Halder@arm.com> wrote:
> I tested these patches using our internal test suite with Arm,komeda
> driver and the following node in dts
>
>         reserved-memory {
>                 #address-cells = <0x2>;
>                 #size-cells = <0x2>;
>                 ranges;
>
>                 framebuffer@60000000 {
>                         compatible = "shared-dma-pool";
>                         linux,cma-default;
>                         reg = <0x0 0x60000000 0x0 0x8000000>;
>                 };
>         }
>
> The tests went fine. Our tests allocates framebuffers of different
> sizes, posts them on screen and the driver writes back to one of the
> framebuffers. I havenot tested for any performance, latency or
> cache management related stuff. So, it that looks appropriate, feel
> free to add:-
> Tested-by:- Ayan Kumar Halder <ayan.halder@arm.com>

Thanks so much for testing! I really appreciate it!

> Are you planning to write some igt tests for it ?

I've not personally as familiar with igt yet, which is why I started
with kselftest, but it's a good idea. I'll take a look and try to take
a swing at it after Sumit queues the patchset (I need to resubmit to
address Brian's feedback).

thanks
-john
