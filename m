Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D1BC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 22:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85CFF20665
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 22:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563229029;
	bh=BlwpHGRzUKug6tnX6UBU925svxeIAUzPx9AZvkYOfuc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=071rs49zXuxIo807k7QC57fTP94GiD0cEpEAW87/evVEdDEOXzO4uxCrqbLRM7yfd
	 AW0hFQIbRKPwBZ0pvvRx0EDYiV0jgYrfLu7o9p72MYm3o4x7Y0Xd54lvnqzJt1s8id
	 b96d772hbnVX/AKMKc5kVV+80Mpfeof2sAAMIDzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733016AbfGOWRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 18:17:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727862AbfGOWRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 18:17:07 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B5182173C;
        Mon, 15 Jul 2019 22:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563229026;
        bh=BlwpHGRzUKug6tnX6UBU925svxeIAUzPx9AZvkYOfuc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qCV88PL5gv6dKBdE4udTyZH0Mew03T4PslZjo7f69A4VS3mujZNQnJukYk1RIBwGe
         7gEEL7cR5AVZbNAcq4HXv9KvoXEIpIWNu0wH6aqqbuiMjFPb/RckAWHyqiLCd2TPQZ
         BCqmABthxE36G96WtYzeEIuNPCaJZmkaYf9CYSaE=
Received: by mail-qk1-f169.google.com with SMTP id r6so13001758qkc.0;
        Mon, 15 Jul 2019 15:17:06 -0700 (PDT)
X-Gm-Message-State: APjAAAVbp7twyf09MoD8YrAx7yFJz46WIdH7kzoFLLZIX4wrTRlbVOLK
        AWKpzAMPxcWzTVxfauS2SPhv9iaefQuGfqLfGA==
X-Google-Smtp-Source: APXvYqx/GbT4uRQgQ84L9Nym4k71tlUcZTQ8jCh8KLZ+3yf2bocUNGFhxoJY/nlG/vS0EgRIW62er26VYHNJB9FTr1c=
X-Received: by 2002:a37:a48e:: with SMTP id n136mr19091615qke.223.1563229025489;
 Mon, 15 Jul 2019 15:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190712033214.24713-1-andrew@aj.id.au> <20190712033214.24713-2-andrew@aj.id.au>
In-Reply-To: <20190712033214.24713-2-andrew@aj.id.au>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 15 Jul 2019 16:16:54 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLkOtsAxj9NvNB=EEkH00k-dtNedNY042uuntSmcjhDhA@mail.gmail.com>
Message-ID: <CAL_JsqLkOtsAxj9NvNB=EEkH00k-dtNedNY042uuntSmcjhDhA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: Document Aspeed SD controller
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Adrian Hunter <adrian.hunter@intel.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ryan Chen <ryanchen.aspeed@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 9:32 PM Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The ASPEED SD/SDIO/eMMC controller exposes two slots implementing the
> SDIO Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit
> data bus if only a single slot is enabled.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
> In v2:
>
> * Rename to aspeed,sdhci.yaml
> * Rename sd-controller compatible
> * Add `maxItems: 1` for reg properties
> * Move sdhci subnode description to patternProperties
> * Drop sdhci compatible requirement
> * #address-cells and #size-cells are required
> * Prevent additional properties
> * Implement explicit ranges in example
> * Remove slot property
>
>  .../devicetree/bindings/mmc/aspeed,sdhci.yaml | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
>
> diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> new file mode 100644
> index 000000000000..67a691c3348c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED SD/SDIO/eMMC Controller
> +
> +maintainers:
> +  - Andrew Jeffery <andrew@aj.id.au>
> +  - Ryan Chen <ryanchen.aspeed@gmail.com>
> +
> +description: |+
> +  The ASPEED SD/SDIO/eMMC controller exposes two slots implementing the SDIO
> +  Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit data bus if
> +  only a single slot is enabled.
> +
> +  The two slots are supported by a common configuration area. As the SDHCIs for
> +  the slots are dependent on the common configuration area, they are described
> +  as child nodes.
> +
> +properties:
> +  compatible:
> +    enum: [ aspeed,ast2400-sd-controller, aspeed,ast2500-sd-controller ]

This is actually a list of 4 strings. Please reformat to 1 per line.

Rob
