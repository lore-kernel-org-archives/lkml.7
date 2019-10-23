Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4801CA9EBC
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 20:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7787920663
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 20:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571860952;
	bh=v70uWcdtUf5tbjPvIOuwXtDBtS7wZt8G/qzfSvjoKDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2Lpw8vfsoKMEaYLEGBK2wwVH1Yhwn9CYvoSud1DrS1IkrDGSqFmpQSMnAG3MWDd6H
	 IYGjPL7nONjoKiV8AiPOnBoz6VsCwqi/u0b2TmkmlJ/osiiCUONcOuN2lAPzkfW5oM
	 J+OY1LYbfit68Xx69F+HUtmejZZkBiOTZYu9R2o8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404787AbfJWUCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 16:02:31 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46237 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733176AbfJWUCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 16:02:31 -0400
Received: by mail-oi1-f195.google.com with SMTP id k25so18472265oiw.13;
        Wed, 23 Oct 2019 13:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oozQkcJW95p1Dv4QaVuryfJ5LQcESPRxHdu7Ak0V1Z4=;
        b=Lnhei2WvMiNQNJYGKx4s4TVS1f1Jpwi+hxk68F9sUn3JU0vLfXJrhtNzMhIDlgSl0U
         93Ap0lCE3O9SiW8uXBzZc9fErOezS/i7jDAM6f0f9OvxQUSV4cExGYOM7U3CgAh0UweY
         ABZJmaTd9Sdgh5/F/k0/Dp3MdQ+sLQbKZXNS/vgUMW9ZvDQ6de7X/uPMa0m6Grvh+UoN
         0FYzO1AGa2CHt58VRHk97pbMZX9LczJz2VD85DfzyZh0h4HmHFrF/l370XvsOW/jtiMp
         iN0Y6H5NvdThzkHVyUoGuRkqLccaiXFRVzSAZ+HmQL3cH/JUhs0RuzcdCPb94luY602S
         qX/g==
X-Gm-Message-State: APjAAAVfFvzarYgaBa1Pu1l6eVTEhMuHbZsxlzmWpcj8VFeEWDnyAEhA
        3Jr/Z7eyZDXFclNbX95AMw==
X-Google-Smtp-Source: APXvYqxFAjzGZNtqdc+1PYTID1AcXDBTvo2ape+7GxX6izU5pTGV6D/uDL/INQ1Bx2cz/ihfg3IHEw==
X-Received: by 2002:aca:c40f:: with SMTP id u15mr1506436oif.67.1571860949970;
        Wed, 23 Oct 2019 13:02:29 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y18sm6342903oto.2.2019.10.23.13.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 13:02:29 -0700 (PDT)
Date:   Wed, 23 Oct 2019 15:02:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     Daniel Palmer <daniel@thingy.jp>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Burton <paul.burton@mips.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Doug Anderson <armlinux@m.disordat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stefan Agner <stefan@agner.ch>,
        Nicolas Pitre <nico@fluxnic.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sugaya Taichi <sugaya.taichi@socionext.com>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: arm: Initial MStar vendor prefixes and
 compatible strings
Message-ID: <20191023200228.GA29675@bogus>
References: <20191014061617.10296-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014061617.10296-1-daniel@0x0f.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 03:15:56PM +0900, Daniel Palmer wrote:
> This adds a prefix for MStar and thingy.jp and then defines compatible
> strings for the first MStar based board.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  .../devicetree/bindings/arm/mstar.yaml        | 22 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  4 ++++
>  MAINTAINERS                                   |  6 +++++
>  3 files changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mstar.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/mstar.yaml b/Documentation/devicetree/bindings/arm/mstar.yaml
> new file mode 100644
> index 000000000000..0ea5b2b9387f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mstar.yaml
> @@ -0,0 +1,22 @@
> +# SPDX-License-Identifier: (GPL-2.0+ OR X11)

(GPL-2.0-only OR BSD-2-Clause) is preferred. Any reason to differ?

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/mstar.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MStar platforms device tree bindings
> +
> +maintainers:
> +  - Daniel Palmer <daniel@thingy.jp>
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +

Drop the blank line.

> +      - description: thingy.jp BreadBee
> +        items:
> +          - const: thingyjp,breadbee
> +          - const: mstar,infinity
> +          - const: mstar,infinity3

infinity vs. infinity3? What's the difference? It's generally sufficient 
to just list a board compatible and a SoC compatible.

> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 967e78c5ec0a..1425468188da 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -617,6 +617,8 @@ patternProperties:
>      description: Microsemi Corporation
>    "^msi,.*":
>      description: Micro-Star International Co. Ltd.
> +  "^mstar,.*":
> +    description: MStar Semiconductor, Inc.
>    "^mti,.*":
>      description: Imagination Technologies Ltd. (formerly MIPS Technologies Inc.)
>    "^multi-inno,.*":
> @@ -943,6 +945,8 @@ patternProperties:
>      description: Three Five Corp
>    "^thine,.*":
>      description: THine Electronics, Inc.
> +  "^thingyjp,.*":
> +    description: thingy.jp
>    "^ti,.*":
>      description: Texas Instruments
>    "^tianma,.*":
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a69e6db80c79..8b7913c13f9a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1981,6 +1981,12 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  F:	arch/arm/mach-pxa/mioa701.c
>  S:	Maintained
>  
> +ARM/MStar SoC support
> +M:	Daniel Palmer <daniel@thingy.jp>
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +F:	Documentation/devicetree/bindings/arm/mstar.yaml
> +S:	Maintained
> +
>  ARM/NEC MOBILEPRO 900/c MACHINE SUPPORT
>  M:	Michael Petchkovsky <mkpetch@internode.on.net>
>  S:	Maintained
> -- 
> 2.23.0
> 
