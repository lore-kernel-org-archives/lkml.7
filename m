Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8ED5C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 23:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A138206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 23:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tgMKzYOA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfCIXde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 18:33:34 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41819 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfCIXdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 18:33:33 -0500
Received: by mail-pf1-f195.google.com with SMTP id d25so877582pfn.8;
        Sat, 09 Mar 2019 15:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WQNxpb9gtqL/LcbbNCbnoFF1jIl2o8jDPnEX8J3ZEmA=;
        b=tgMKzYOAc3sCEe41RcN9vf7KbVgB5IxJLZWfSJRUK9q2uHispRxMPzZ2oyO+LawSg+
         FFPafnzW1Y6uVWv9739ydPxDyOA+8MNxR6UtNlUZIv+D0X5fzcw2XVkePsbGwO2jCyMa
         02i0xpns5jWKtNCWtd2uNtowxs89i2csvAOHq5U6en1aysFu7F0j7V30Nc3NdShLlxJe
         qo46OhT8qTb28H9FmboOWKi8o/4G1DUEx3bdkTc0m2vOHA3TfdcpRQhcVeJcXxoOH02C
         8sqZas7Y5yBbOqGOOIprooimoAVD/9vn9iznymKc1LroBKB1WPtbbD0t41aqbLmkqS1q
         Y2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WQNxpb9gtqL/LcbbNCbnoFF1jIl2o8jDPnEX8J3ZEmA=;
        b=pWQC8wDmmAbg7IYc+VzRGOq22QVAbPZVv08/5DuDY59iioyj1QvWfr0fwCSNjxUmSb
         8lxrIOe1KdE7vAd5nR0OeEL0fpQv6gyrbs7MFExg2CreN9Z5DuXeXWMWTNLQyQesEPsS
         Rmn+3T4moHODpdirH6E3+o6aViuR768BLHuHsWpvJWGMIKV/fZmzTrtKuUhgGCIksalp
         ViMyuocLBEENK2LA92iPKOpPijv7/zEP9l7KAxpEn3zP9CbUfNtlz2gy7XC0ut2aa9Q/
         X57PPDFF0U3fHKmWnn20bgq5hQBxepjH/qpBYqFcQxqDYxdGseIeVZ2Cmnxyq0AeI+Pl
         m7eA==
X-Gm-Message-State: APjAAAXUNYfJU+MwohvOHNEmQlWTce2XRacl8T7cX6jLlpI0zXYkSLrd
        S5sQJZAQTtMfpk9asQQlSBSZkQ/P
X-Google-Smtp-Source: APXvYqwOiUAd+aJb/LaaLg9MJlNUhX6q7h07h86X1Gf4jGwnJFf1avDK+0AxNzlmSPA45le5Bcks8A==
X-Received: by 2002:a17:902:2947:: with SMTP id g65mr26249469plb.258.1552174412627;
        Sat, 09 Mar 2019 15:33:32 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id a66sm4907064pfj.153.2019.03.09.15.33.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Mar 2019 15:33:32 -0800 (PST)
Date:   Sat, 9 Mar 2019 15:33:30 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Brian Masney <masneyb@onstation.org>,
        Linux Input <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Input: msm-vibrator: use correct gpio header
Message-ID: <20190309233330.GB13699@dtor-ws>
References: <20190304195734.1070109-1-arnd@arndb.de>
 <CACRpkdaq9YzFSSXp7HSOf+RC2PGxv0N-m+iV99tn-0xTeEZr=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdaq9YzFSSXp7HSOf+RC2PGxv0N-m+iV99tn-0xTeEZr=Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 08:49:01AM +0100, Linus Walleij wrote:
> On Mon, Mar 4, 2019 at 8:57 PM Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > When CONFIG_GPIOLIB is not set, we get a couple of build
> > errors during test building:
> >
> > drivers/input/misc/msm-vibrator.c: In function 'msm_vibrator_start':
> > drivers/input/misc/msm-vibrator.c:79:3: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
> >    gpiod_set_value_cansleep(vibrator->enable_gpio, 1);
> >    ^~~~~~~~~~~~~~~~~~~~~~~~
> >    gpio_set_value_cansleep
> > drivers/input/misc/msm-vibrator.c: In function 'msm_vibrator_probe':
> > drivers/input/misc/msm-vibrator.c:176:26: error: implicit declaration of function 'devm_gpiod_get'; did you mean 'devm_gpio_free'? [-Werror=implicit-function-declaration]
> >   vibrator->enable_gpio = devm_gpiod_get(&pdev->dev, "enable",
> >                           ^~~~~~~~~~~~~~
> >                           devm_gpio_free
> > drivers/input/misc/msm-vibrator.c:177:13: error: 'GPIOD_OUT_LOW' undeclared (first use in this function); did you mean 'GPIOF_INIT_LOW'?
> >              GPIOD_OUT_LOW);
> >              ^~~~~~~~~~~~~
> >              GPIOF_INIT_LOW
> > drivers/input/misc/msm-vibrator.c:177:13: note: each undeclared identifier is reported only once for each function it appears in
> >
> > This is easy to avoid when we use gpio/consumer.h as the documented interface.
> >
> > Fixes: 0f681d09e66e ("Input: add new vibrator driver for various MSM SOCs")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Applied, thank you.

-- 
Dmitry
