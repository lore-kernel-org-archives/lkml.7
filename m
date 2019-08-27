Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B150AC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87DB92173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bhjl/ew8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbfH0NuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 09:50:16 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38455 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbfH0NuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:50:16 -0400
Received: by mail-vs1-f66.google.com with SMTP id 62so13477722vsl.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 06:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nPR2CQfWmgZTkvcpGyqAZkf0myEhVejsZD6gsIT8RYg=;
        b=bhjl/ew8Pdmkn2py/fJ8FKDq4d1wSwcKFwpAqCni+esZ62NP1wDMuTrPNmksJfOg+Y
         My7X+wD93QUDR0E3hIw3E1A8iE7iMuv3TRRMCS3eIOphYFDZF6fKOzuCq2zdoUxjVHh6
         3+WsdoF0ZGK3YXkZHXokWSPcVEecQW0K0NSoyk88GKCLv84yCim1xpARfVciR67DTXNJ
         KbB7KkvbrM16nS6EQSKVHuZdTISASCfdZ4mJetpH93xPtPxg9o2VfQdTvVIiIslYhgQa
         G0PTMTp7ZX6VsTVAGrRDF/zQd9Z+fdlvN31tSNuTNgvkcvZSwUdXdRF7/PPw9J8ppeB9
         VJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nPR2CQfWmgZTkvcpGyqAZkf0myEhVejsZD6gsIT8RYg=;
        b=bCl1fAL68TX8tJNyj/6037E9SPitu9Jcj9M9LiUmmojySYPgoxytZMupTUNT6uOan4
         aAMhf4SpjfN6ja4ZG0z9bAFYzdTRlsSgLsAVJk3l7u8VmbNUK3HaIgpggeTmyiXUlrDz
         r9JtCblgsgJeT90dGQZZDjOHZIjQnkqwlaQNxa3/1cXH2PcIGghMDtrn3MQzkpeR3nij
         nO5M0dgDc0gJyNcRU2OUqGLAXHRZ6MDtnyFZRl1+K63caumdC+L7zBa232s18UuGYiaS
         bUP4YaeHmdeNw9kd00vrFFoNt5otcs+bdPto99Kfk6+uHaMDUiDCk8Q6Dq1z42GE/G7F
         tQEw==
X-Gm-Message-State: APjAAAXFHugLZIdwTOadztEIkURPAUERHDx87B8Cct2T/IMxLYXgphzC
        DhzjCplm2sNq/6hciibEIUhcydb84RfWjYhzPDtbiQ==
X-Google-Smtp-Source: APXvYqzQ8I7Ep8k3tduFMMa8uUTlPd+Xy5TxZlq8ti8zHd5KPR80iTc/2sx/Oh/nNRZf59jUJo5lhvjPC3uSaxWvRL4=
X-Received: by 2002:a67:fe4e:: with SMTP id m14mr14252340vsr.34.1566913815413;
 Tue, 27 Aug 2019 06:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190826021620.11915-1-andrew@aj.id.au>
In-Reply-To: <20190826021620.11915-1-andrew@aj.id.au>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 27 Aug 2019 15:49:39 +0200
Message-ID: <CAPDyKFroS-Z+4QYitmYrCugPV_f4u1MDJiRkDxGWvVjsU=9RgA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: aspeed: Update example ranges property
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Aug 2019 at 04:15, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The example node in the binding uses the AST2500 compatible string for
> the SD controller with a 64kiB ranges property, but the SD controller is
> allocated 128kiB of MMIO space according to the AST2500 datasheet. Fix
> the example to correctly reflect the hardware in the AST2500, however it
> should be noted that the MMIO region is reduced to 64kiB in the AST2600
> where a second SD controller block has been introduced into the address
> space.
>
> Also add the IBM copyright header that I left out of the initial patch.
>
> Suggested-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Applied for next, thanks!

FYI, I took the liberty to amend all aspeed patches, by putting
"sdhci-of-aspeed" as the prefix of the commit message header.

Kind regards
Uffe


> ---
> Hi Ulf, this is the follow-up fix as discussed here:
>
> http://patchwork.ozlabs.org/patch/1143090/
>
>  Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> index 570f8c72662b..200de9396036 100644
> --- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright 2019 IBM Corp.
>  %YAML 1.2
>  ---
>  $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
> @@ -84,7 +85,7 @@ examples:
>              reg = <0x1e740000 0x100>;
>              #address-cells = <1>;
>              #size-cells = <1>;
> -            ranges = <0 0x1e740000 0x10000>;
> +            ranges = <0 0x1e740000 0x20000>;
>              clocks = <&syscon ASPEED_CLK_GATE_SDCLK>;
>
>              sdhci0: sdhci@100 {
> --
> 2.20.1
>
