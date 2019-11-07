Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53595C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 07:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249F121D79
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 07:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A3aUeypH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733128AbfKGHtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 02:49:01 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35842 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfKGHtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 02:49:01 -0500
Received: by mail-lj1-f196.google.com with SMTP id k15so1134130lja.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 23:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ShPclsm9wNkguXhY/kITDe1JSSlg/MseBi87gM5UJKo=;
        b=A3aUeypHsz/9ckLm+t55HsyhXqAaIExjxWSz8uAx9RbfpCSSIa/dVQHvyFME/F1y3b
         cjwuorK0ZuySNvMdCc/p1tn/5VRABSDchR/mVNf6ghjDsddVL4I9JvLRmkliBw/HoM6q
         gouLsVgnhAJD7ykGs04H3OkxdC/rgWJJbwFF20gffEQRtgZdkQtPclcMaf3m0FzRy6sS
         yTsj2bmtYrn9pv678XFtPbZ1Q0FskcX0g16V4VcYWGKcUYv8VXLxGbRbXZZu/uc/MGTx
         e1cYcR+BdBd1YyuC87pel6dMiRAaVGa8c7Wcwdd0RfD7BSvEmzfXLz33yDmA5vgWw6lB
         v8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ShPclsm9wNkguXhY/kITDe1JSSlg/MseBi87gM5UJKo=;
        b=CNj79KY0ZHXph6Zv3hOIeYBizOEYfOAYWdfYXWg2GV23gnAzlSdXIiM+oay4BLBooJ
         yevRs8alJt5a5HeoMs/jxUlgGE0gE0+ip8orfm3umvmy1kKxFfA8P0yrTWXWbb4X/u60
         Wrsbig3w1wh0VIimQvykMub6rVUV6MZcxzPtfrEvBcKN8Zhq8LzcyTUSsCxvNfNa/jYU
         JsvNHRoTC0Fw6yjn6om4r9kLBZ1sKXYw4e8dgg5VgkMq7wbbf+fIHTiyrSVFm8l8XU11
         5iTwabjVZIIgc150IgfZ2jGwf5DSCkKCsyThhl1rN8xAggFItzrCGGVskAtHvfD/OY7P
         vJFA==
X-Gm-Message-State: APjAAAV6y+gQklC0pzvnSzm+I2EGpiOZydXqD8VjYCuxfftW6MXju/JG
        BHM52OsHSFppXo0W+1PM9LcHFmFWiT9LHZAGkWig1Q==
X-Google-Smtp-Source: APXvYqwUh2O0/Dijv6YknCg4fr4ezNaQXK4eE+1OY3XayGTb3mFeiVW9Mfng5Pe4DzuBPCwLlVkYMxHfC8VJPmvXJ/g=
X-Received: by 2002:a2e:90b:: with SMTP id 11mr1219439ljj.233.1573112939354;
 Wed, 06 Nov 2019 23:48:59 -0800 (PST)
MIME-Version: 1.0
References: <20191106060301.17408-1-joel@jms.id.au> <20191106060301.17408-3-joel@jms.id.au>
In-Reply-To: <20191106060301.17408-3-joel@jms.id.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Nov 2019 08:48:48 +0100
Message-ID: <CACRpkdbwtf68seNW_qx2neCExfSZE7hy2kBw9eN5ObEw0_pxow@mail.gmail.com>
Subject: Re: [PATCH 2/4] clocksource: fttmr010: Set interrupt and shutdown
To:     Joel Stanley <joel@jms.id.au>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 7:03 AM Joel Stanley <joel@jms.id.au> wrote:

> In preparation for supporting the ast2600, pass the shutdown and
> interrupt functions to the common init callback.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Provided the latter patches making use of it are OKed;
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
