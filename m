Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAA5C2D0DC
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 23:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BE920CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 23:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QftLw47Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfLYXWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 18:22:11 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45894 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfLYXWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 18:22:11 -0500
Received: by mail-lf1-f66.google.com with SMTP id 203so17362370lfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Dec 2019 15:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Gy6dk1JceW57KpSGmAR3pzf0NX9lVcNuOQ3hyF1SQQ=;
        b=QftLw47QATwWJrAK1J1ZkIPFgUbtVl/bijGpTQCZQnEbmlyWXU8+Dc1pLgxt2uazqb
         lepCE2/H22kDC4gA4qcIq/QOQoHLvRUlAB3fYrwilQRWmIs66vJLWx54zSUIdxu19VDz
         j0fBs5fg9aUMldgRX4sJosAL9Qiuc50NSjD50AK946tUKOhHZgRUDVOqlYzKAVBKPaR8
         Ku7SJiSO16CJzFdbcsHM4+/oDtfM2KM2QiKT4NXNCgnEE2sOFu63RSajiRinXumBwsA4
         pOlSidyJrjd9yR32tnhj9/F4+0zQ1oxftC0BgCZWFxhe8tsGhnF8NZERs7t3qNXfto2Z
         n6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Gy6dk1JceW57KpSGmAR3pzf0NX9lVcNuOQ3hyF1SQQ=;
        b=WlDJWmGrKJD9ecHg/w/5cpOhbMF8XZwrvhbuFHH9lzS9Kz2qL+qHqTXD0PjM/HlXGy
         RgGIucwTRSCk6eMQb2cV1IhmHO0Zh2KQJjCgZzzfsQxo5eNhoQweu+Vvkt60g6GRATE7
         0wYyKmPvDOUomadeGgkMEABcrsU20UCS4iJMfNy6nDVZDxi76OKvIDW9NFBVP6pD5Ifo
         RrSWs7Rs2K6fV34Dr+bs0FU+dYeyLyqtYeKls1qZLLZne12ywy/kYZjVZ/wf+tYECqIv
         2wZub4KdY02a0j8YeN8YNAdaKVSDZsyZu5ObLjqsSy7LBGA+KMb1s+5HuhJFuG9Lvf7c
         dElg==
X-Gm-Message-State: APjAAAWCeZygUgJ53SXY2Gn/B4HcSYM7rb8kXq2hWB+Ks/8X9ss75hzB
        y0oRpagzcbctNkpyO5kCVpYxijoyAre82Mnl+Kg3Hg==
X-Google-Smtp-Source: APXvYqxP+4vajSwjPFxjWCJawxrvcwrC5tMG1NUMTBSdIZQPpZe+BN3HpSqOaj2VfoRuz2wvDvieM3+jXWf32Siik2k=
X-Received: by 2002:a19:2389:: with SMTP id j131mr23035440lfj.86.1577316129048;
 Wed, 25 Dec 2019 15:22:09 -0800 (PST)
MIME-Version: 1.0
References: <20191219202052.19039-1-stephan@gerhold.net>
In-Reply-To: <20191219202052.19039-1-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 26 Dec 2019 00:21:57 +0100
Message-ID: <CACRpkdaaK27UNxYkGM=LkeMXN+WzsmxvLgEpWdNd5GroA=4jdg@mail.gmail.com>
Subject: Re: [PATCH 0/9] Add device tree for Samsung Galaxy S III mini (GT-I8190)
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 9:21 PM Stephan Gerhold <stephan@gerhold.net> wrote:

> This patch series adds initial support for booting mainline on
> the Samsung Galaxy S III mini (GT-I8190), codename: "samsung-golden".
> samsung-golden uses the Ux500 SoC, which has great support in mainline.

I queued all the DTS changes in the linux-stericsson tree and will
send a pull request for it soon-ish!

Thanks for your hard work Stephan!

Yours,
Linus Walleij
