Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2787FC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0052920815
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="c2NaqQYh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbfJHMnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:43:04 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38061 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730719AbfJHMnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:43:04 -0400
Received: by mail-qt1-f195.google.com with SMTP id j31so25044978qta.5;
        Tue, 08 Oct 2019 05:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1UppyCbMsWAT7YFPxGZqvx3UTT7ui0zT5iHhMGwW6vU=;
        b=c2NaqQYhTaLYQ+SdhBdPFFyH5v82CBLStq5IcHjVyox/QkA4YRuwcsIhlkpqlXzH/H
         zZ1xgdrYF3AcpmAahz9PfOh2F4Z7UUatDv6rmFC9oYGyN7ob7QUgWNKgXx3rW7c7pX16
         1Mk9AOwen5fcsCVo+nsSXjAT8mYoaG64nEWpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1UppyCbMsWAT7YFPxGZqvx3UTT7ui0zT5iHhMGwW6vU=;
        b=OzWd5+4a7GxhaRloUFP+zPMqw4qJY/JOUgm/oPDxZOloPxDSEsG6Lzopyp8eNOTEhR
         kL+T+9pVPOgKlcUYXvB81Rs9t4YSdy61nkqi31PuyKARpjZouHMhayp+ZjTHYsXqTUGK
         dWQrOG+W4xoP1pXs/bCyzOUa6rq8xgqGy/QqvGvjA3S/x3o5zhPTiwvAga303y7yJjxX
         PYzHtYqorgifMrOgaFsWGexK3reKK/dPqlKC0bcoSa31UPFznKQNEREBXzw7rfLRRNi6
         w0xt59q3eJLP0vjxaFltZTw/v9BW/TmdWEDsZM3ibXzHAS9y6lnfVe2M1xV7D1EUPJJO
         jbEQ==
X-Gm-Message-State: APjAAAWEbsOAM89BLJ6ybM5x/ky7JsYLQ2qK3KPp1CeQnmxIy5pKVJFE
        yssU+3jIL8BYEClwDmJmgiSoVJORB2Nptb6/Obg=
X-Google-Smtp-Source: APXvYqwVGP5UDPlHhVNwIbeMXipPnJtqO4XgNXWCIOwfUk1ZWseBIXlErjwslmqMf19cGZs9SXWwfgtTEcP1O1T/NTY=
X-Received: by 2002:ac8:2f81:: with SMTP id l1mr35912975qta.269.1570538582975;
 Tue, 08 Oct 2019 05:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191008115143.14149-1-andrew@aj.id.au> <20191008115143.14149-3-andrew@aj.id.au>
In-Reply-To: <20191008115143.14149-3-andrew@aj.id.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 8 Oct 2019 12:42:51 +0000
Message-ID: <CACPK8XcWLCGupAF1EX1LB6A=mQY0s9kjgagr3EKEKJhnbt+j0g@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: net: ftgmac100: Describe clock properties
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2019 at 11:50, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Critically, the AST2600 requires ungating the RMII RCLK if e.g. NCSI is
> in use.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  Documentation/devicetree/bindings/net/ftgmac100.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/net/ftgmac100.txt b/Documentation/devicetree/bindings/net/ftgmac100.txt
> index 04cc0191b7dd..c443b0b84be5 100644
> --- a/Documentation/devicetree/bindings/net/ftgmac100.txt
> +++ b/Documentation/devicetree/bindings/net/ftgmac100.txt
> @@ -24,6 +24,12 @@ Optional properties:
>  - no-hw-checksum: Used to disable HW checksum support. Here for backward
>    compatibility as the driver now should have correct defaults based on
>    the SoC.
> +- clocks: In accordance with the generic clock bindings. Must describe the MAC
> +  IP clock, and optionally an RMII RCLK gate for the AST2600.

 or AST2500.

With that fixed you can add my ack.


> +- clock-names:
> +
> +      - "MACCLK": The MAC IP clock
> +      - "RCLK": Clock gate for the RMII RCLK
>
>  Example:
>
> --
> 2.20.1
>
