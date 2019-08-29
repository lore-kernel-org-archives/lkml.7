Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50895C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2566A2189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SzqqW5aR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfH2Ktr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 06:49:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35221 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfH2Ktq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 06:49:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id g7so2951398wrx.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 03:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jHeD3Kv+tcMAmS4H+Al9j1578BcUWQlA5QOhrftK1uI=;
        b=SzqqW5aRW4Dk4d6Y6jVRNDP+Rh3WbyRh3k50TxR1LeEohULvTL9Bj5hdTjKoTWslIs
         z/W5UBReyHzNQg80Xsmi4rwuXxQBvmYDHFqHTi/hZWkoL9/04zoHnejKiClOG8BrGxH+
         /5UVeX4auI4tiLjKX8ERhmRthajmadmWorm2eKbV/cHck6rq2UQrRZl0pcLIpHq3LaoS
         2V9BqJYyd8+EEbTP9JWGTrdPmHG+OjYTFM7Fq5bkaz8kXWPR1BIzfJgfAxYlnPpNOKW+
         lQ6wdhg4GXen+v34r92oR+rVXG8sZog/5EOUXX7JmCrFw7EBFbzuU2vffUQdZcygASRr
         y4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jHeD3Kv+tcMAmS4H+Al9j1578BcUWQlA5QOhrftK1uI=;
        b=OWbMKSnh7ujfZTT1dZJe3awJaLZo6H3nsdyExXUvXjrMTNXXXw6kSO2xkqq1fr8MsW
         secBoxEOLEFysDZ+CJgzdZ0WZZIo5l4WWZa7bf79cYEIwPGPasWpvGIRAtf/u+yDhBNI
         e1SZ9kOdF2p8FYIkAsICf/TBIGywCFK3vJT6hC02+zX+f25fkO8ogyDafMorH7YxzJDK
         RnQjKqiUOD5yTxUsjpSS3ZzU0wsLOm8lcXeldWY+MryarvyfmNE64T2lDULkv/9nsJCW
         +W5foBvkphEUj5xbPvwg+TkSFtg0gttSOZEBELwGVx3KoztK//0F+AyC2yWRqFOl3JEY
         JMJw==
X-Gm-Message-State: APjAAAV/po3PalRHOVDcDr4NK9APE8L8oza9RoLxNSZWWppiSgeydPxB
        Q9NtIFv9H6DZS/gkXQfcQooT9A==
X-Google-Smtp-Source: APXvYqz2qMe+fh3q/bTnYSOCuAtlMqCAz/KWKJ3lcS/jq5IqYKlKwb73QOH+7q7x/7umHXur6XZItg==
X-Received: by 2002:adf:fc03:: with SMTP id i3mr5602097wrr.48.1567075784823;
        Thu, 29 Aug 2019 03:49:44 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id s1sm4927621wrg.80.2019.08.29.03.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 03:49:44 -0700 (PDT)
Date:   Thu, 29 Aug 2019 11:49:42 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     mpm@selenic.com, herbert@gondor.apana.org.au, arnd@arndb.de,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, avifishman70@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, sumit.garg@linaro.org,
        jens.wiklander@linaro.org, vkoul@kernel.org, tglx@linutronix.de,
        joel@jms.id.au, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH v1 1/2] dt-binding: hwrng: add NPCM RNG documentation
Message-ID: <20190829104942.uyz5ms4m65hcqvmk@holly.lan>
References: <20190828162617.237398-1-tmaimon77@gmail.com>
 <20190828162617.237398-2-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828162617.237398-2-tmaimon77@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 07:26:16PM +0300, Tomer Maimon wrote:
> Added device tree binding documentation for Nuvoton BMC
> NPCM Random Number Generator (RNG).
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../bindings/rng/nuvoton,npcm-rng.txt           | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rng/nuvoton,npcm-rng.txt
> 
> diff --git a/Documentation/devicetree/bindings/rng/nuvoton,npcm-rng.txt b/Documentation/devicetree/bindings/rng/nuvoton,npcm-rng.txt
> new file mode 100644
> index 000000000000..a697b4425fb3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rng/nuvoton,npcm-rng.txt
> @@ -0,0 +1,17 @@
> +NPCM SoC Random Number Generator
> +
> +Required properties:
> +- compatible  : "nuvoton,npcm750-rng" for the NPCM7XX BMC.
> +- reg         : Specifies physical base address and size of the registers.
> +
> +Optional property:
> +- quality : estimated number of bits of true entropy per 1024 bits
> +			read from the rng.
> +			If this property is not defined, it defaults to 1000.

Having a controllable quality implies that the numeric quality of the
peripheral changes when it is stamped out on different SoCs (otherwise
the driver can confidently set the quality without needing any hint
from the DT). Is that really true here?


Daniel.

> +
> +Example:
> +
> +rng: rng@f000b000 {
> +	compatible = "nuvoton,npcm750-rng";
> +	reg = <0xf000b000 0x8>;
> +};
> -- 
> 2.18.0
> 
