Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4ECC49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C6B2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b5WLEtD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfIKKFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 06:05:01 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35511 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbfIKKFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 06:05:01 -0400
Received: by mail-lf1-f65.google.com with SMTP id w6so15994803lfl.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 03:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aEBAvzyvKwKy4+z0icRgfRVKXYXcNb1iM7EN7yrDUow=;
        b=b5WLEtD03nLPtyVSE+wLZn9h7qijVtAN+cYaeN6IYy+aFGDtEbDuL/gYsMMM/a/5ed
         Bm/8bSgVFY582J67Cdazp0Jc7/0Ip0JtCwnp1Jwa0sBRHurYKd3AFT/MOoX9EgKmv7Wt
         THm606K5uucv2RO6R7HvnwPXo9zNI5/SCpU50YcpK5nYOIZ/jeKlZyT4JwA91pyBCRGY
         76K3WnTq/FQ1cFtQhenLCpIb3UROTl/67IWPqHB+hXeomfMlanRc/zaQHe3r5hBODnQq
         lVYiLeCNz+Ewk8X+yoLY0VvEITQNeFzHI7YN8tMAZaUuIjZtJqEzFplZ9DoSsXHDz63B
         er6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aEBAvzyvKwKy4+z0icRgfRVKXYXcNb1iM7EN7yrDUow=;
        b=DE5r388kuWbkxbCMIUx/p9UDgWcxG1e7LRCp89q2QEA/J3gmTY/SuRRL/Ufijjw68K
         sS9vzF23DSENPj0OaauCa/hhiH+SIn/r8FTv4KAaIJRkCuUf9/ehTsxX7MCX/taq5FC1
         AOG6yspNhBcJaJUm2cgfOJ0eXj56GK9rTOlpjoOmH4AR8Og/PSZ6pMd75AppxU/S3/7P
         RR6fqv7CCGo4fguNqwYaUCx1m9a/OKj1SMn/vEfBHtvZkVlZ27EYqTidt8af4CPY71gT
         2fRMRUIUwE7t6MWtqAA2QpC6z2PB84+QkcnmtpFQ+Hg4QKbOZuMY/cEJsgyDmaGu5jwP
         uqrg==
X-Gm-Message-State: APjAAAX1l+5BC2tAeZDGdkQJ3/OOvvPjR3Qm4JWvZa+bbQg3WDyBlDhY
        hRm1sIeU3qAdAEgnCRW5paqe9pxp0VnmzDrrTiL2aICPLyvXTA==
X-Google-Smtp-Source: APXvYqyC+pv5N0Vcj+RE52xkcBxAzDFKvxknvjpMo7X5lxTEnajzZlDFTx5W6vtzY7meOzprM4Zolus/zI1aT2yhpaQ=
X-Received: by 2002:a19:117:: with SMTP id 23mr23845320lfb.115.1568196299188;
 Wed, 11 Sep 2019 03:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190906062623.13354-1-rashmica.g@gmail.com>
In-Reply-To: <20190906062623.13354-1-rashmica.g@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Sep 2019 11:04:47 +0100
Message-ID: <CACRpkdZvBHk65Vs93YbrTR92-8o0SgtUUWMBXeABQH0PZwpRxQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] gpio/aspeed: Fix incorrect number of banks
To:     Rashmica Gupta <rashmica.g@gmail.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Joel Stanley <joel@jms.id.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 7:26 AM Rashmica Gupta <rashmica.g@gmail.com> wrote:

> The current calculation for the number of GPIO banks is only correct if
> the number of GPIOs is a multiple of 32 (if there were 31 GPIOs we would
> currently say there are 0 banks, which is incorrect).
>
> Fixes: 361b79119a4b7 ('gpio: Add Aspeed driver')
>
> Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

Patch applied.

Yours,
Linus Walleij
