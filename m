Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D87C33CA1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2B52087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bp/ha09p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgAGKHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:07:47 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36740 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbgAGKHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:07:47 -0500
Received: by mail-lf1-f66.google.com with SMTP id n12so38458175lfe.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 02:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tnOEaQ6thA4ioA5fxD6hDNCp7KpKg8s6CWqPnu7C3t0=;
        b=bp/ha09pbJrjB7BfANNxqqk3vHg3IP21d2kXPcv77A4mSWqgk2ke/gOOZTBXAlz/gb
         pTAhLv3rOCvPTejETypGgKa+/QP4wgruXTfVLzOMi01tl/2YgPFPRYXAnW88esB17cpy
         K5x9/macduUx3QzXsw8okSc7l3uRlhCmkzwXhyPUyhpI+7CLbRPsex6jxMVjyXpQhYud
         IJ0lO8Ynk2602TZYwaJvJQjE+CVslg7mINTxtzl9IxpbFpYuxMsll8VqCq6btmEMv5nu
         3PLKJCk01mCMtkN++X4bQ3pP3Zj8KY/d44XHSLpoSuQ6J64ay46C+Pff3DyVWYLOHZtc
         oB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tnOEaQ6thA4ioA5fxD6hDNCp7KpKg8s6CWqPnu7C3t0=;
        b=dVZHa8gd5EE8x2YFZ1vvJk3P7Jw2Ik/gbMe8RgSYu2e23jx8bH8PbfZJPEUzz4nvbJ
         aWXF90KD8MLkZrhdyGEV4Sv3boOoOsTsfKYO5EAPMdfnsfaHFaKKBpR+g1sYR1ftMQt2
         4k5VCqbBOYCvD5yUld29qUE3I5i4e0+Wy1PGU0mzI9Murp//oU2kNvQFkstTW5mMcOwl
         +7a2GTFfYxaw4NgvW0RCIoIzi1habG2b/OQFMVQJWaIu7UcvXCDY8EmlGsytfX71bFbG
         VGL8gXYI8VVz+HPJJ11bxvNLzdrfsq3w7ytxJgrxU8Ap2zUkLFK9qVoKVR61tobXQZaF
         Rq0Q==
X-Gm-Message-State: APjAAAWzguEe9R0+q/Ix5icC0b/wqLIEEzpg/jibeFWESBTWQA9IPBub
        mVlEsxJaITUAf8JBk5v9neU0AAD8Y0DPF8GUsWNvsA==
X-Google-Smtp-Source: APXvYqzdeOAXksQUt5Y17xj72qs0uTE490uWOGE17jXJDnVJYINdeEKt+rQpU3ji82kT6R4BsNfbCCFK/SErQF9ux+I=
X-Received: by 2002:ac2:4945:: with SMTP id o5mr58202112lfi.93.1578391665090;
 Tue, 07 Jan 2020 02:07:45 -0800 (PST)
MIME-Version: 1.0
References: <20191224120709.18247-1-brgl@bgdev.pl>
In-Reply-To: <20191224120709.18247-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jan 2020 11:07:34 +0100
Message-ID: <CACRpkdZ_TroKCAnDWiY-jPbe0NL+ingm1pMLQLPxT1Uh78kx8g@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] gpiolib: add an ioctl() for monitoring line
 status changes
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2019 at 1:07 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> When discussing the recent user-space changes with Kent and while working
> on dbus API for libgpiod I noticed that we really don't have any way of
> keeping the line info synchronized between the kernel and user-space
> processes. We can of course periodically re-read the line information or
> even do it every time we want to read a property but this isn't optimal.
>
> This series adds a new ioctl() that allows user-space to set up a watch on
> the GPIO chardev file-descriptor which can then be polled for events
> emitted by the kernel when the line is requested, released or its status
> changed. This of course doesn't require the line to be requested. Multiple
> user-space processes can watch the same lines.
>
> This series also includes a variety of minor tweaks & fixes for problems
> discovered during development. For instance it addresses a race-condition
> in current line event fifo.

The patch set overall looks good to me, I don't understand the kfifo
parts but I trust you on this, though we need review from a FIFO
maintainer.

Could you send me a pull request of the first patches before the
FIFO changes start, they are good cleanups on their own, also
it brings down the size of your patch stack.

Yours,
Linus Walleij
