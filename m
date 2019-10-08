Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D8AC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A6F206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="QXFzeHuf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730947AbfJHMpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:45:30 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39381 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730249AbfJHMpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:45:30 -0400
Received: by mail-qk1-f195.google.com with SMTP id 4so16557992qki.6;
        Tue, 08 Oct 2019 05:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v98zF1OGy1a9xdf1tcg4rO9aTmICS20KeVZPXiAVZ6g=;
        b=QXFzeHuf81gSpH57PDwEHoXnUMf8/WnURr1eH6LbCgjtzvlECfhgrOaugs8bUyVTa5
         IN2earqrMs23m6T89TNg+NgWHJq+QvdQoc0ufRkTf0lkD8UnzdxXKWXEoHutopPYOV24
         JDbyyAq7Mfk3JRcyLzr7IuC1s9MNUFNiLWH94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v98zF1OGy1a9xdf1tcg4rO9aTmICS20KeVZPXiAVZ6g=;
        b=KDqfgIiXzeizQR2yni5h2PkAkZEEjYT/XaBCkvUklRD5+vXmIjHBORZJ0NfyLZfu4E
         J4jDyF1XgzOZz0E25NyB72IMD7ucUmAZnAj6XWQjYvlviUBTcUzfUCgJhfp38+QlM/Eq
         VnP9K08e61ZEPI22Vq2OAUM9FvmyWljadB9w7MSvMvEPenssISti23/3M+N5SqlEDjTe
         btVgQlvVk98M7d1TlTZ/MN6UdxoECz4AsKm8D9h1t/gZwf5307a1oAtaGN7+OkNEVTyU
         M44YjAvifU1ZU28fHuq8XC5GySTgUMZRk7fkb5MHg2Vy3RmcRgOGWExa+wgYvyb1hwhi
         2uBg==
X-Gm-Message-State: APjAAAVo80a6MJ4QrGlcQopcx+WAK/bvwGDRUDtrkoF53SEpMIxO+Iz+
        2+IWlUGXl1wd/RbRL/zONKdxGYi5pTWqVibryUU=
X-Google-Smtp-Source: APXvYqwbDrpR/sws3f6gujWo90eWmFtcR1qTkid+2DQ9qP9pCJc95MfjkQRPPxEaORjJBbxZSD9h/vhA8oS6KXrRLvY=
X-Received: by 2002:a37:4a54:: with SMTP id x81mr28662696qka.292.1570538729054;
 Tue, 08 Oct 2019 05:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <20191008113553.13662-1-andrew@aj.id.au> <20191008113553.13662-2-andrew@aj.id.au>
In-Reply-To: <20191008113553.13662-2-andrew@aj.id.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 8 Oct 2019 12:45:17 +0000
Message-ID: <CACPK8XcGAN6AF_GqUpCjFL3CEDeY42n0Zsgt5DX1ssOu+GhbDg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: clock: Add AST2600 RMII RCLK gate definitions
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
> The AST2600 has an explicit gate for the RMII RCLK for each of the four
> MACs.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  include/dt-bindings/clock/ast2600-clock.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/dt-bindings/clock/ast2600-clock.h b/include/dt-bindings/clock/ast2600-clock.h
> index 38074a5f7296..ac567fc84a87 100644
> --- a/include/dt-bindings/clock/ast2600-clock.h
> +++ b/include/dt-bindings/clock/ast2600-clock.h
> @@ -84,6 +84,11 @@
>  #define ASPEED_CLK_MAC34               65
>  #define ASPEED_CLK_USBPHY_40M          66
>
> +#define ASPEED_CLK_GATE_MAC1RCLK       67
> +#define ASPEED_CLK_GATE_MAC2RCLK       68
> +#define ASPEED_CLK_GATE_MAC3RCLK       69
> +#define ASPEED_CLK_GATE_MAC4RCLK       70

My comments on the other patch about GATEs should have been on this patch.

> +
>  /* Only list resets here that are not part of a gate */
>  #define ASPEED_RESET_ADC               55
>  #define ASPEED_RESET_JTAG_MASTER2      54
> --
> 2.20.1
>
