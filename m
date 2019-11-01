Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2193CA9ECE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 04:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6C42085B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 04:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="ihRZ8UOW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbfKAEuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 00:50:55 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41100 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfKAEuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 00:50:55 -0400
Received: by mail-qt1-f196.google.com with SMTP id o3so11549690qtj.8;
        Thu, 31 Oct 2019 21:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yA9zmwK+y0+vYb9mhZkiWIdcsL4UA+4k04MjQIXnKfI=;
        b=ihRZ8UOWwqbfVpNv19Ub5/RXorNawHtfnVMhoUjPKbrcr0JblVBgy0itL9CzHUnQgk
         ru4WPZs8/9O0HHeAOCJbw88ElH5RLVqFDb4qfGlBO6aaSqpB8t0L7H2o3kQT/LaEgTdV
         +GuF3oVnw7kqIAaAa8kJzGRCaV60znAMMGaLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yA9zmwK+y0+vYb9mhZkiWIdcsL4UA+4k04MjQIXnKfI=;
        b=mNEw5PEQW82CMeEd6fykvuVWQ488sOw7ZbcQSgLLhEQsaOoMUzIG7Ocr2uQcysOHxW
         RGsK0bUlr+YeqCWugAWO13IAoTLWLP9CF/7goxYhxYBG6roXZgjdZJEjLMqiGsncZRsS
         9ItFBqlUsx+gCZ88gGfQxUmyJUJPhpTAVHuYplrufW9FHQ8g1IhmuBiw8ybCkcValmA9
         zcdQAohBvm89Xn2H3ePXoRw7PeTzbHSLgGgf25BPih8JFRuUPAhUbDxpLEzR0qqUi2Nv
         3dvhONSN7r4j5gRZeg2V6jBVsX1haQIvL5K2LTALln1AvBi5of+aYzAybzkSznSriGra
         IAOA==
X-Gm-Message-State: APjAAAVLJpTUn0znu1S2vh2HCRJ9jXA6chVaP0eVu3dl3meSVAeRDPGz
        /6l63D+UcX+DcZ3gayvlL48fM4MM4xg6M9ZjdXM=
X-Google-Smtp-Source: APXvYqz7qXvpd39WjR1smej7kH/DFLwcwnDkz0IJAQhEJT1fnwfpJP75htsUCUl08Y8XeO+iMg5OtJcPeapplKUfTrE=
X-Received: by 2002:ad4:5446:: with SMTP id h6mr8216660qvt.20.1572583854007;
 Thu, 31 Oct 2019 21:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191010020725.3990-1-andrew@aj.id.au> <20191010020725.3990-2-andrew@aj.id.au>
In-Reply-To: <20191010020725.3990-2-andrew@aj.id.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 1 Nov 2019 04:50:42 +0000
Message-ID: <CACPK8XcGgGsoLNpCccKPb-5bojQS4c5BePewwocc-z29On7Rjg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Add AST2600 RMII RCLK gate definitions
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi clock maintainers,

On Thu, 10 Oct 2019 at 02:06, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The AST2600 has an explicit gate for the RMII RCLK for each of the four
> MACs.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

I needed this patch and the aspeed-clock.h one for the aspeed dts
tree, so I've put them in a branch called "aspeed-clk-for-v5.5" and
merged that into the aspeed tree. Could you merge that into the clock
tree when you get to merging these ones?

https://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git/log/?h=aspeed-clk-for-v5.5

Cheers,

Joel

> ---
>  include/dt-bindings/clock/ast2600-clock.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/dt-bindings/clock/ast2600-clock.h b/include/dt-bindings/clock/ast2600-clock.h
> index 38074a5f7296..62b9520a00fd 100644
> --- a/include/dt-bindings/clock/ast2600-clock.h
> +++ b/include/dt-bindings/clock/ast2600-clock.h
> @@ -83,6 +83,10 @@
>  #define ASPEED_CLK_MAC12               64
>  #define ASPEED_CLK_MAC34               65
>  #define ASPEED_CLK_USBPHY_40M          66
> +#define ASPEED_CLK_MAC1RCLK            67
> +#define ASPEED_CLK_MAC2RCLK            68
> +#define ASPEED_CLK_MAC3RCLK            69
> +#define ASPEED_CLK_MAC4RCLK            70
>
>  /* Only list resets here that are not part of a gate */
>  #define ASPEED_RESET_ADC               55
> --
> 2.20.1
>
