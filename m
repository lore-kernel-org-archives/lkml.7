Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976EBC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 15:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E66208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 15:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TkubPT65"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfHNPEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 11:04:34 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39423 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfHNPEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 11:04:34 -0400
Received: by mail-oi1-f195.google.com with SMTP id 16so4152655oiq.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 08:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F/p97iQZnXTuUHhiYplY/Za6YnkQQ3wC/QnPWgUZezo=;
        b=TkubPT652d2A8SsiB1hPYRHsyGm/kX6niHNGd5xmKRw56W6a2s6XAcQdqfkpOc3DGR
         e4BvSHKESFFoD3PxBlSsWr9BtJiAvR0ht4ILGJ86om7Gndkl5Nhz/6Wym/FnNdntfjt7
         qwx02gpi0Si6zC801v/9WxDiu2Zji41tnOzpt2p9WxGxoMQn6Kldu513NwmPkKhZYAmX
         Jguir6tGF6fYseJxmdnIRa26hh8D4K890+QZYxb4G5xMPeeINucTXsRtP9rXkA29Prax
         ETMXaOZQVpiStZRR+wx3aujevygxWl0z/2U2uIV3fWgC4icqbkCeTyzm4iXVSUNLe68E
         iLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F/p97iQZnXTuUHhiYplY/Za6YnkQQ3wC/QnPWgUZezo=;
        b=qJ7BVT8U0JNIv6QQI7fNrBoGYevralO8T3B9J3STypUwkhsNW0NcRvpzZclSn7N9Cp
         zrRHaiGTHPHbXeYLJd2R9MuR09qQFwCNM4MlngY+xBlbIalrAfIea9EXsnfHztDXbswJ
         Bx92yWdhweVqvBFQMMn0UGsBtO94wGoE52XfQinf6LZpSF735W7G81vB6HitMxkM85ZY
         ef9SS90qWYEJExQkOwQONXu+ILggqxArmSat1aYT/aDPiRCC6tELX2YATIQgGfOyCa1Y
         XS27xVN6Ilhje4WSGdwUxXYF1BVEaIWovJwUnpwM6at/h+58lLImdP7D8ukSGCW8z5nY
         bu+A==
X-Gm-Message-State: APjAAAXAu25nmq6LT3zQX9QXmWio75iMjZ1xdiVXQgQGaDzQfHSkt8Ap
        +TeLWp9vM8UN8+xHIrj1YfOwJcYRMmgzq0UugzyBFw==
X-Google-Smtp-Source: APXvYqxIhMfzqtXvkG0y/c9RMdINmaRf8z4zNGwoAjV2RmkBxHjhYmNOpz7ekBDnwSG8BZ9m4sHsOxAugJkNJAbC4zk=
X-Received: by 2002:a02:6914:: with SMTP id e20mr1662340jac.83.1565795072861;
 Wed, 14 Aug 2019 08:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <CANLsYkzH-ZWV3qF4p4Yvfy3EfBvZUYyDH+SDdUyuS3fGw9h_Fw@mail.gmail.com>
 <20190814003557.97004-1-yabinc@google.com>
In-Reply-To: <20190814003557.97004-1-yabinc@google.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 14 Aug 2019 09:04:22 -0600
Message-ID: <CANLsYkyjQ2SfA6_1+FVLPwK1V9iqU31vBwHYK4BGewV5o27G7g@mail.gmail.com>
Subject: Re: [PATCH v3] coresight: Serialize enabling/disabling a link device.
To:     Yabin Cui <yabinc@google.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2019 at 18:36, Yabin Cui <yabinc@google.com> wrote:
>
> > The patch isn't difficult to do but does go deeper in each link
> > drivers (ETF, funnel, replicator).  Let me know if you are not
> > comfortable with the idea and I will see what I can do on my side.
>
> I am comfortable with the idea. I chose to add lock in coresight_enable_link() just because it
> is the smallest change. But a refactor probably is better for maintainance.

Yes, that is  my prime concern.

>
> Feel free to upload a new patch fixing the problem. I can help to test it.

I have a few things on my plate at this time so you might beat me to
the punch.  I'll see how the next few days go.

Mathieu
