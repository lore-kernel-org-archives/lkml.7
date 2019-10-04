Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB225C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DD2222C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hboFmV/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbfJDVsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 17:48:01 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36152 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbfJDVsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 17:48:00 -0400
Received: by mail-lj1-f193.google.com with SMTP id v24so7936323ljj.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 14:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=96jk8p/6XP5ut+JBHE0IBsdTmxOUR/fsv3ZcRWDzMOg=;
        b=hboFmV/U4IcPI89MtzDp+OzE5KwsWErja8LOnkuuLwv0fksWiRpqJQZRis7rFIeVPP
         Ooj27rcXns2Y4feoVEtg49n8CryY2RaGyouBUeaqk2ra5EWaVF1b9SJCzpbS0ccPcx6o
         OKGdwKxr435NLGf2rhVWgjPumSWR2SHoXx0hKGzQWcUyTo9N2UXJEk48l4i2HhDZs/lk
         /w5UDGdeyD3/r3JdKqYvjgprnF2+BDf/24afsGx6mveKIokPtaSJGfI7WbyMW88ICvUl
         cpiuvmH0N+uNxhDXRpNNofDROfjzaePmP13ERqR66MmREXUZCh8g2+gPv00qpvzL0Kk7
         +7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=96jk8p/6XP5ut+JBHE0IBsdTmxOUR/fsv3ZcRWDzMOg=;
        b=sOSL9YjctVIX34ZAY9Zrla7NFP9IUePuTpcsB94cpUlM31NOpdbUabUN2ucBPq2Hmr
         sxAp1bEpC1r4YibOMyMwDEviIXwjvJ0W6q5V79VNo3lphaNngdGQUPBniphM7bPp9PGZ
         B0KZTbdKXiWpr9Lg3K6V96k8AiP/NxN4p+6XRcMwe5gVgFTCH75I/zIapIYzXu1Vqu5E
         LShuQk4nLLWBFv2KktZjcqefN/0fmZq/X1x+rEoVtVzSSJuwzxFIpxqPsgiqz1r7YuZx
         W9Wjz4I6+aMLJE40G0Z2lh87TN7iwkDnnPyX4emW0zs4tByUzlqyl3pOQyjwagnpgvcS
         BxLA==
X-Gm-Message-State: APjAAAV5yE2FVpiIuOJmqUfCIHg2WwM7tuMUZE+bOFb0kTq3tyBu0zJc
        qKamhpV1uQmedQanoeO9WukDI4Q55QEOv/Ye1v30sB/A7LI=
X-Google-Smtp-Source: APXvYqxdZOCfwMC4ckXG//o/o4H8hELcsXHe3EoTOHIYVBOebIobkD8VaGs1KQIIBFvGy9ppesFAq6cvMyUvfIsKzS0=
X-Received: by 2002:a2e:6344:: with SMTP id x65mr10670505ljb.59.1570225678386;
 Fri, 04 Oct 2019 14:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20191001125837.4472-1-brgl@bgdev.pl> <20191001125837.4472-2-brgl@bgdev.pl>
In-Reply-To: <20191001125837.4472-2-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Oct 2019 23:47:47 +0200
Message-ID: <CACRpkdbnkMvcSOoLGWi9nSfcpcNT0T28kFX=gyk6jSZ4UWG3gQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] backlight: gpio: remove unneeded include
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 1, 2019 at 2:59 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> We no longer use any symbols from of_gpio.h. Remove this include.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks Bartosz,
Linus Walleij
