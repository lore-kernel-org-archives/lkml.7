Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F58C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 10:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ECF9217AB
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 10:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LtOv8jPC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfK2KEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 05:04:36 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39568 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfK2KEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 05:04:35 -0500
Received: by mail-lj1-f194.google.com with SMTP id e10so22165346ljj.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 02:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HF4UdVCwi1c1BKIgz/FESLhrgzjX9oNjO8/KjUNWsfk=;
        b=LtOv8jPCyXyB1wKB9sWSvMTFb/tuSMW7v8P5uDbv/o9y8q5F/5Dr9e2DE4jrD3A4vZ
         dAimauptihuec8YSuN8eVIwYruZG/G2wblAhcLl5bfHWDGElLo7ZlJ3jNhkxiqI0Tdl7
         O2o5TSxbMBN8vQN8jlS27uptf5xuVVx3QCR1zPGnR0gHORk6MnRixVGuP8hsb3xN7zAn
         o32WLEO6bm/VKjqRUNpigbmRvDuPvx05Z1o18j2Os2jR4dk7FFWYuSqcTCHvEE++r+Gj
         zqJb47XOrvk2ac3sEKJzh8Vb2VLiin4/KTvuNT0DQpZkD948ZGRPpTRPeygeZY5q55mu
         RvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HF4UdVCwi1c1BKIgz/FESLhrgzjX9oNjO8/KjUNWsfk=;
        b=o+TfW6r6ZGp4vYJY2n6sCrmb5L6O4iE/C/VXQ6fWI3imQRPbLt6u/81fG8Va6IYtGI
         ISiL7yz/Xapm96FaiLFoIVT8lzc9AR89sj/R/IItkHqy2iSxBQY33ChGPNs2955jkmhT
         xjvEVS8K+6T6hvMI76KR/qtsAuPxtK0bQ5gJP1vpoAPvFipXX3m9KzKUENvrL9BOnWFk
         eqiSaFqOvYLrmKNU51Y7tRYxcL2rk1RmIGXw+idS7vhvomTRPlUf5b9+kqI40nm/KW6m
         G6HfCdC4odJnLhcACeCRXoyyNYeOrqmfYbo+dF/szVPj8TB6lVC5YmfPFluqDxgG5CxN
         V9pQ==
X-Gm-Message-State: APjAAAWy3SK+Kv+DT3jI2KTgyo19wlaQ3+furFgZfoSKW2jLNr8puOA7
        N4qRfs031SNNPYP3Qql1vGGSjIdo5yfgL6I9m9Z6k0kH1sk=
X-Google-Smtp-Source: APXvYqyWUPquNS0/lFgTEe0/fd2x2+iJyXgSYa6NuJgsEAJeld4LWgXwroBpwc1JXb3Ppg/6aXesmROTqEJkRma/wbc=
X-Received: by 2002:a2e:9699:: with SMTP id q25mr37212398lji.251.1575021873761;
 Fri, 29 Nov 2019 02:04:33 -0800 (PST)
MIME-Version: 1.0
References: <20191127133510.10614-1-brgl@bgdev.pl>
In-Reply-To: <20191127133510.10614-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Nov 2019 11:04:22 +0100
Message-ID: <CACRpkdZ6e0GaE9KBJ1-E+cS_KnPY-EKLNxJFqjArr28hYMQqOg@mail.gmail.com>
Subject: Re: [PATCH 0/8] gpiolib: add an ioctl() for monitoring line status changes
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 2:35 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> This series adds a new ioctl() that allows user-space to retrieve a
> file-descriptor which can then be polled for events emitted by the kernel
> when the line is requested, released or its status changed. This of course
> doesn't require the line to be requested. Multiple user-space processes
> can watch the same lines.

So if I understand correctly all the series do is expose metadata about
all GPIO lines to userspace?

I think up until now the use case assumptions have been:

- The kernel will pick off some GPIO lines, mostly during boot but
  occasionally at runtime (by users such as kernel modules or
  hotlugged devices).

- Userspace will pick some lines from those that are available,
  after the kernel picked those it wants. If it tries to pick one of
  those that the kernel already picked, the request will be denied.

The assumption (at least in my head) was that the GPIOs the
kernel picks will not be a very dynamic business.

So this appears to be dealing with this very dynamic business.

Is the *main* use case different userspace processes trying
to use the same pins and getting denied? Because in that
case we might be putting a bit too much userspace plumbing
into the kernel and we need to think about that for a while.
(Binder and kdbus etc comes to mind.)

So there is some feature growth happening here and I want
to be aware of the whole picture.

On a side track:

There is a bit about policy that needs to happen here I suppose,
like for example what if the kernel actually wants one of the
lines that userspace has picked? Should userspace be kicked
out and kernel get what it wants? (Arguably yes.)

Yours,
Linus Walleij
