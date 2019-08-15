Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B36C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 05:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B68E2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 05:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="So4qbdY5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbfHOFgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 01:36:24 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46905 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfHOFgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 01:36:24 -0400
Received: by mail-qt1-f196.google.com with SMTP id j15so1214269qtl.13;
        Wed, 14 Aug 2019 22:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9+kkJNfz1L/1lNjECte7oZEQ4lUZcKf6TkxAuh4O+hA=;
        b=So4qbdY5UtL+gcLQZ3POxMTyukbRWjWsrvKlowK+8slodSzcQhq2MQ0+Y86qGKH0Qt
         8h59wNj/5KPgsKXwLvUoVmlrIhn1VR96kfux20xYgl9huoZg6TLzXpilT2i2MI0IxeIT
         21Tnzz4VdqdpMRYLlr8/kJCOj1eK5gCWDxinQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9+kkJNfz1L/1lNjECte7oZEQ4lUZcKf6TkxAuh4O+hA=;
        b=C94wUhaL/Q/V/CMSbdt0nMqxV2A2r6pcwOyLfc9KeO1mWjd9ctiH/PU6B7JthukZKK
         ggLt0eh0Zt4EDOmM/7MZ/dk3pvhigz6JVXcA8DW7YNuqRPNChxCy2/+K0XRlQ7mi+Dsw
         w/nK54GO3p9HTdcMXtiqz6bmFcppc9XTa46tuwg3ztC27AZ8X+gDD1CORtAe2IsvH6k9
         vIiGR/akEJyHfHxcZ7U7hZ4TEeQ4boKhSnwG+q22WS4V4suiWzBaXx6rrzm7B/JkAwiF
         FB8dn2W6sYbXRvmybsAXfCC8fIESZ5syEeJfW1inbiLhWVn41oFbPdTDZltqk8G6j5t9
         x0kg==
X-Gm-Message-State: APjAAAWFit/PR6x3Ba5pLytYfc5zKRbovDwlpFN8jB4vXz1VgnNosU6y
        yISy9kPDPcWu0Il3q0kYX2n74flTjhamjUsJmbo=
X-Google-Smtp-Source: APXvYqwol/tQGbguivrqClfvlzTk/yRlLUw/5IIvwxZHdBkwx1bL58BKST0+COtnMS8slC8AVVjNxk55OxxaRQNAaW0=
X-Received: by 2002:a0c:dd83:: with SMTP id v3mr2145001qvk.105.1565847383251;
 Wed, 14 Aug 2019 22:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190807003629.2974-1-andrew@aj.id.au> <20190807003629.2974-2-andrew@aj.id.au>
In-Reply-To: <20190807003629.2974-2-andrew@aj.id.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 15 Aug 2019 05:36:11 +0000
Message-ID: <CACPK8Xe6Zp1uOqEffEc0b6oGa7portEAifGPRqb876HmA+oZeg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: mmc: Document Aspeed SD controller
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, adrian.hunter@intel.com,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ryan Chen <ryanchen.aspeed@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2019 at 00:38, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The ASPEED SD/SDIO/MMC controller exposes two slots implementing the
> SDIO Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit
> data bus if only a single slot is enabled.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Joel Stanley <joel@jms.id.au>

Two minor comments below.

> +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later

No "Copyright IBM" ?

> +%YAML 1.2
> +---

> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/aspeed-clock.h>
> +    sdc@1e740000 {
> +            compatible = "aspeed,ast2500-sd-controller";
> +            reg = <0x1e740000 0x100>;
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +            ranges = <0 0x1e740000 0x10000>;

According to the datasheet this could be 0x20000. It does not matter
though, as there's nothing in it past 0x300.

Cheers,

Joel
