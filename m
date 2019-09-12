Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B972FC5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9063220856
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cuznd0rh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbfILJs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 05:48:29 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37734 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730691AbfILJs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:48:28 -0400
Received: by mail-lj1-f193.google.com with SMTP id y5so12144920lji.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 02:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QoRwKJLy1W+DikJJA6B41nB3PjcCPvyIBPkBfcJxCzc=;
        b=Cuznd0rhs+2Bpf+Ce8uvvn6W7g0tHuGdVqDz+M6rezPQ314uz2L4zC8C2v6ZvxBVuS
         m1zh7rqvNS+6AoWnyITeGINQBJ2IHGD8kfBv7/MvEjrl8K3nZUVhtr1m4jyBXvzreg/L
         PtX04qaB/9HYJyQeHEP2hgzInI+d78uoYKQrA//ysTkk0zZQmGPEE/flX5MrkLwxDDt8
         06DI75legtLS+/EX0qou20un6a4/CJkzTu4ld/M4NSKm9XGsoKkZXHB2Tv9E045ZUf0l
         qTtJAwNKhOs0YUmhOHteMp4mO8RT108BRuYifQMKX8c8gSKcIL6ZxZRIaFrmaLSBAEFj
         mmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QoRwKJLy1W+DikJJA6B41nB3PjcCPvyIBPkBfcJxCzc=;
        b=iopF0XudpjlGb6ZQNfnJ2pyC+CU2yO7sIFvXHFz2FN+8vOppAFedSr+qfZX7znw2hq
         LcBVgTCsdADP3e6p6KNQrbk/H9WYTCiIL+ARj1SGa5JEuXkYIpwuNUqobGLGuMYy7X2A
         EQGtG8Hu5X+2330aLtT2Ao8Kyboel9mtvV8+26OX+DaB0IVaDWX09EPQa/WfA4AslheQ
         Fytoi9DsRh0T8pWR8RdzRoO2QEuB2S7gk6lOjhHplqtnOIOtciVBsOtev/DFhuvH6Gdv
         VUSU5i+d/d5+E5BJ5WXi5dYX0k1BPGE6L/QiLDMptcMPh7agS7/q+uTRE3Kv98IxIPeM
         Zatg==
X-Gm-Message-State: APjAAAU5HZcExt44Bjmg8isdtS4haJHGIwdqjsfDqqvVlZ26MD3B/TFV
        ihA2DGCO3RksPUQYholTym5fTT4Vi/xh4SK+6C7A/g==
X-Google-Smtp-Source: APXvYqzLJRkyHOXp6wUHfpwxVqRYTBiX2V3ZfjuCyIvtvC74NAzznHCOkeWocuWMh1ucpi49WrQr+RZbh85gUs+wC/c=
X-Received: by 2002:a2e:7d15:: with SMTP id y21mr18889969ljc.28.1568281706045;
 Thu, 12 Sep 2019 02:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190911075215.78047-1-dmitry.torokhov@gmail.com> <20190911075215.78047-3-dmitry.torokhov@gmail.com>
In-Reply-To: <20190911075215.78047-3-dmitry.torokhov@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Sep 2019 10:48:13 +0100
Message-ID: <CACRpkdZjZZKQqkN-HC11PJ5SgZbZd1Gnbeh8ApJ7+cS1eOOMbw@mail.gmail.com>
Subject: Re: [PATCH 02/11] gpiolib: introduce devm_fwnode_gpiod_get_index()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 8:52 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> devm_fwnode_get_index_gpiod_from_child() is too long, besides the fwnode
> in question does not have to be a child of device node. Let's rename it
> to devm_fwnode_gpiod_get_index() and keep the old name for compatibility
> for now.
>
> Also let's add a devm_fwnode_gpiod_get() wrapper as majority of the
> callers need a single GPIO.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

The patch is good because this is in line with Rusty Russells API
manifesto:

7. The obvious use is (probably) the correct one.
6. The name tells you how to use it.

It doesn't apply to my "devel" branch as of now:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/log/?h=devel

If you rebase this and the next patch and send them separately I
am willing to apply them already for v5.4 to easy your refactoring
work during the v5.5 cycle here, provided we try to fix up the old users
ASAP and delete the compatibility fallbacks in the near future.

Yours,
Linus Walleij
