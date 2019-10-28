Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C72CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9610A21783
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="RLW8aO1J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbfJ1QAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 12:00:38 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37138 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731519AbfJ1QAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:00:38 -0400
Received: by mail-lj1-f195.google.com with SMTP id l21so11946630lje.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 09:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V2usXM1ZvmoH+fXGSNylFf1GNvu1kOuKsgUsmavjuCM=;
        b=RLW8aO1JPi6rKlXfp+KFONs7nDD9p2tzSrGW/I0NAUU+pjsPb1+Nm/qLuY0GVVGqHp
         lg91yonrFepb0PgLj0w3FabP4nDzQEXVJEE60Z5TNvb/CgoqOgyRSZQXgwB/S8RvtwT6
         KeyBiZQNWfPjSaVwOriKv6ypmcWil/TVD2h2djRwkhJ3BQQgHU412mys4RjibLwKFq2v
         blU5URFTiL4WmkqLs3v1dBKpjxc12LPM9MX3srB5u3Xeipw8LvE1hAua5NC1CG7JaMfg
         AkcclfLt6cWUA/39ZB7eAVtlslvCeWsr83JVIUKL65nI9qPWW7FlhvE9kjvrGhZuK1oN
         0QYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V2usXM1ZvmoH+fXGSNylFf1GNvu1kOuKsgUsmavjuCM=;
        b=cPSrkC6eLxlzExATpGgZDRoMf8Uu53kg+q2wjPqyq9MuqKHfbgCz7r9RfiqzPvTPCw
         Hacoav+PS4/WY9tl2t+tz2cnubPc3Vh/z2gDeKT2JYAH/b7FYRTjzPJLcUVXterJLS9z
         DQH9fdv2F6DfpZd4jXyPGZ1sPokzTj4na4NmxP3vXXQp30/hg5b4OoxiamsIPN3tzm7N
         5+8+fAqCLFbhrkFoiAXmJZeRXsw5/r3rIO3qu3ET9mFn/LWaIP9LmUz5I4psuMKfm1wl
         T5YpMEehskfhShV8x8CjgYUp4ARzL7zGJNcF6wj6INttdlPB8oRNFRx5rH6KxNJ36McP
         fLhA==
X-Gm-Message-State: APjAAAWbvA8mKvVF22PDAKQj602LYr5grZRiiZYPQSRL/T3/9dURiX8y
        8xzjTEgryz/l5qfrpk2+I+xVxw==
X-Google-Smtp-Source: APXvYqx4+zk6/ZVaSwL0e0sH6d5sCRcAj5zHuHrFwT07d6fLPhJBWMR1Ovg3/jPbRWfsWcYrbujgVQ==
X-Received: by 2002:a2e:8545:: with SMTP id u5mr12177705ljj.213.1572278434407;
        Mon, 28 Oct 2019 09:00:34 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id d9sm8304120lfj.81.2019.10.28.09.00.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 09:00:32 -0700 (PDT)
Date:   Mon, 28 Oct 2019 08:54:57 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org, arm@kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH v3] mfd: db8500-prcmu: Support U8420-sysclk firmware
Message-ID: <20191028155457.5uae2crf3ygvn3qn@localhost>
References: <20191026214732.17725-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191026214732.17725-1-linus.walleij@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2019 at 11:47:32PM +0200, Linus Walleij wrote:
> There is a distinct version of the Ux500 U8420 variant
> with "sysclk", as can be seen from the vendor code that
> didn't make it upstream, this firmware lacks the
> ULPPLL (ultra-low power phase locked loop) which in
> effect means that the timer clock is instead wired to
> the 32768 Hz always-on clock.
> 
> This has some repercussions when enabling the timer
> clock as the code as it stands will disable the timer
> clock on these platforms (lacking the so-called
> "doze mode") and obtaining the wrong rate of the timer
> clock.
> 
> The timer frequency is of course needed very early in
> the boot, and as a consequence, we need to shuffle
> around the early PRCMU init code: whereas in the past
> we did not need to look up the PRCMU firmware version
> in the early init, but now we need to know the version
> before the core system timers are registered so we
> restructure the platform callbacks to the PRCMU so as
> not to take any arguments and instead look up the
> resources it needs directly from the device tree
> when initializing.
> 
> As we do not yet support any platforms using this
> firmware it is not a regression, but as PostmarketOS
> is starting to support products with this firmware we
> need to fix this up.
> 
> The low rate of 32kHz also makes the MTU timer unsuitable
> as delay timer but this needs to be fixed in a separate
> patch.
> 
> Cc: arm@kernel.org
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>


Fine with me to go through MTD, so:

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
