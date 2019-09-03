Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FBEC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2836F20674
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ylEZdt5w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbfICPLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 11:11:20 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43326 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729079AbfICPLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:11:20 -0400
Received: by mail-vs1-f65.google.com with SMTP id u21so3215414vsl.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 08:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hFtwKcjhJAcLLvYRWcB0GjH8TlxQpGn6eTjYWs9Yv7Y=;
        b=ylEZdt5wX+4ng+59TTe8Z5AM0jrzsN3AaMEYIMADmVTg11r8Zg8hSdomYSWn5vAtNS
         WdPx+HvtbD0mbkYe04TqreDYO2AwhAlo8DcK5wMufHfP3jzW8OLpbSgh9m2ITtJ/93+C
         IuPbGmZNWPRv2XhykPmlWrr3YsWnKOtgf5nZ/c+/4P8yTxomsVGN95qF4sBUOuGdrlSa
         dUqglLFdIaNNuo1end7siNiC4igj3IxjO3ObKeO6Y+PaKLq7Omf2MD0V81QYibQTHBU3
         romyh0SkZgsXqvo8dIMYuUDydOZSEwQ1DoCBYCk4j5XUpRNtrOV9fAzRqNM5npPZQPj9
         JXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hFtwKcjhJAcLLvYRWcB0GjH8TlxQpGn6eTjYWs9Yv7Y=;
        b=Z9RCvFAmgQUrA2TiXCGAcc4vgM+v7RW8I03XgLYY/LKydWqqa2XG23kWDBfgT09nHD
         ne8dHqWNJYmKmf87HCdu2aJ8TgNOOwtvmxOA5zZagSTWSZk6gZ9vf0t+QW0XLod4Qq3w
         rce9dg4DEmdNXRaa/RvysVN1uIJlhnTI0Mr5c5k7LVoL5ycfYM7/Wie+FWJSDTsdF/38
         +wAnnllP200bFPbvG+oEOTV14ho+tiasQKYJ5lF+Q5DAZ2WXnd5xhKjMsK78e2qOVxex
         t6zxhQ9mkBxENhaKPTUDqFZKuKauQZhzml8QKvpmZXnI5ihHvfXEysQ3DAAYrR441bZP
         zewg==
X-Gm-Message-State: APjAAAUTHPq4KNlNFLgCV8iIwR2K3iFvm86XCO56WOeT8q/DXOoh+2Oh
        UWg02XGTdU7BhGIH1ia6JHNHlWAYO6IcWKxfsyxPSw==
X-Google-Smtp-Source: APXvYqxpIMYeuIve5wcn6H3G3LreaM9TjDByR/E25jlqIh9Wcl9ULuHLdLtj22DL88uDB10bfQJRFWazPxLWyNi4TXU=
X-Received: by 2002:a67:983:: with SMTP id 125mr13702796vsj.191.1567523478905;
 Tue, 03 Sep 2019 08:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190902035842.2747-1-andrew@aj.id.au>
In-Reply-To: <20190902035842.2747-1-andrew@aj.id.au>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 3 Sep 2019 17:10:42 +0200
Message-ID: <CAPDyKFph4C7fCcGYzFp2PwwJsaFvw6a0Do4Vm0uF8mbwD7zUzQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] mmc: sdhci-of-aspeed: Fixes for AST2600 eMMC support
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Joel Stanley <joel@jms.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Sep 2019 at 05:58, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Hello,
>
> I've added a couple of patches since v1 of this series. The horizon has
> broadened slightly with a fix for SPARC builds as well in patch 1/4. Ulf
> suggested a minor cleanup on v1 with respect to handling of the current clock
> value, so that's now patch 2/4. Patches 3/4 and 4/4 are as they were in v1.

Applied patch 2->4 for next, thanks!

Kind regards
Uffe


>
> The v1 series can be found here:
>
> https://patchwork.ozlabs.org/cover/1155757/
>
> Please review!
>
> Andrew
>
> Andrew Jeffery (4):
>   mmc: sdhci-of-aspeed: Fix link failure for SPARC
>   mmc: sdhci-of-aspeed: Drop redundant assignment to host->clock
>   mmc: sdhci-of-aspeed: Uphold clocks-on post-condition of set_clock()
>   mmc: sdhci-of-aspeed: Allow max-frequency limitation of SDCLK
>
>  drivers/mmc/host/sdhci-of-aspeed.c | 62 ++++++++++++++++++++----------
>  1 file changed, 42 insertions(+), 20 deletions(-)
>
> --
> 2.20.1
>
