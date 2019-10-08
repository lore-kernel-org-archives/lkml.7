Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79B5C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9076206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="hdoPfz7i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730904AbfJHMhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:37:14 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33272 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730605AbfJHMhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:37:13 -0400
Received: by mail-qk1-f193.google.com with SMTP id x134so16562807qkb.0;
        Tue, 08 Oct 2019 05:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4v0d+1p/aArXJ2yOJRd5yNu1aMPL1BHOkAquOKCrLz0=;
        b=hdoPfz7i2ZAKAojYg3MCdn1h3u+bC0JsI4n7zh6dL6bVxNYeSc793Pmj5qltJe44fQ
         to9MLzW0F9Q2qJMBxS063xbPKegLPpoWtkY13KtO91GW7ABSL8Ijg3sD3+wEzdn3gUKl
         KdAuBnJ7Q4VRAthQ+JYQcg1M4uXtSRp5ZpLUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4v0d+1p/aArXJ2yOJRd5yNu1aMPL1BHOkAquOKCrLz0=;
        b=LHvGCio9hc5uATawH+wK9itXGHh4btLNhjYg5hYAye4Ny6xvMxr3oWsA9hKdZMmroq
         JD9wuiEjxqBludOOwfllGhB/Lc/RxIjLcwPekD5+AvAJdPhDOI3Pa21gUsNjKHmj9IhH
         OZNjFXIgiIT6xRTs5pwYBZpXorypRKcC7usPo22n06KkgAZa1wJD4kjJhE+atBoPIMKQ
         2MEY/U5DOKLU2rrZEkEeTLZjhKASgx38OseceCoemMMfyQq0FSDnZMq1Vxkq9syXsJ9O
         8vY/eEZ/L28x4Xjc2mp2PJoQWvsRgqx45cyu8EWPlfm+EgKGkBNQIBQAE4z2PXNxXbck
         89EA==
X-Gm-Message-State: APjAAAXXPiUxAYN9T6pmG0Fh8NfIvMYQBoAS2DvkZyZebhe8WXEuHFlL
        NuQwDixU5/BbclgGag58FHVjcWCBcdaLqyCirTI=
X-Google-Smtp-Source: APXvYqwWnZfc72JvmcJyYRX4c70u9XGRpY6zMM0qiDyLh1kU7xYPHgtRMVXxvCmA/MGSrjXZ3fNWualilBMYFbbhMQE=
X-Received: by 2002:a37:4a54:: with SMTP id x81mr28628198qka.292.1570538232484;
 Tue, 08 Oct 2019 05:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <20191008113523.13601-1-andrew@aj.id.au> <20191008113523.13601-2-andrew@aj.id.au>
In-Reply-To: <20191008113523.13601-2-andrew@aj.id.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 8 Oct 2019 12:37:00 +0000
Message-ID: <CACPK8Xf-f-r4S02GoxYdBYOJi5NGYMCOr6XGVza4vEGAsqzR9w@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: clock: Add AST2500 RMII RCLK definitions
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2019 at 11:34, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The AST2500 has an explicit gate for the RMII RCLK for each of the two
> MACs.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  include/dt-bindings/clock/aspeed-clock.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/dt-bindings/clock/aspeed-clock.h b/include/dt-bindings/clock/aspeed-clock.h
> index f43738607d77..64e245fb113f 100644
> --- a/include/dt-bindings/clock/aspeed-clock.h
> +++ b/include/dt-bindings/clock/aspeed-clock.h
> @@ -39,6 +39,8 @@
>  #define ASPEED_CLK_BCLK                        33
>  #define ASPEED_CLK_MPLL                        34
>  #define ASPEED_CLK_24M                 35
> +#define ASPEED_CLK_GATE_MAC1RCLK       36
> +#define ASPEED_CLK_GATE_MAC2RCLK       37

Calling these ASPEED_CLK_GATE breaks the pattern the rest of the
driver has in using that name for the clocks that are registered as
struct aspeed_clk_gate clocks.

Do you think we should drop the GATE_ to match the existing clocks?


>
>  #define ASPEED_RESET_XDMA              0
>  #define ASPEED_RESET_MCTP              1
> --
> 2.20.1
>
