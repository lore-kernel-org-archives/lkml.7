Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50556C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DFD322CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566241578;
	bh=U2Nk8SjazRvtA6qJtd4/WFVsvVICrDmtDKqfB/oakMU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oTwK4RpYsyZ867fqKTPox4TchWuKAjc9V1io6Sl/bkj+f8IDdNfuuUY5mZUNRwV5E
	 zQ3OlIrCRILNQKeaj2UKdjlIPB5IDXU68WlVbcAFUY3r5CbuGNNcG72WWxnz6hsBBH
	 sQc4UU++m5QXcR4k45h+zpSfv2JBnPN42sq2QfSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbfHSTGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:06:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727965AbfHSTGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 15:06:17 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE56922CEB;
        Mon, 19 Aug 2019 19:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566241575;
        bh=U2Nk8SjazRvtA6qJtd4/WFVsvVICrDmtDKqfB/oakMU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=z30n64I1ybSsDgNp7Sm/tmUI88SriuZlp+co5g3PVLQYSYmWUziTHOkiCw2NwkIwW
         ikeyRUHxAyncVx3ZadxjGD5UK8+Nt8d/eeRZPX/L7wci8lnho61vRCTUc+5sV2+Kx3
         gHouyC8vq+9nmqmpGkC6eymls4vevEj44r8vAGR0=
Received: by mail-qk1-f182.google.com with SMTP id m2so2355502qkd.10;
        Mon, 19 Aug 2019 12:06:15 -0700 (PDT)
X-Gm-Message-State: APjAAAUm8HYZ6339IIvI9PPJse980poB+xxh/OJ8by8UyVre+9SmiPIl
        qVafdPRb5X6/FmSKEvX81C0smValm21Xmv9Nvw==
X-Google-Smtp-Source: APXvYqzfzVyi2fwu520h4u9KLrCEutmcKpSatt/kv6lrxMdq0xYytFoYD73hFunEhVIaphJSdOw+ddGB6mJQxXmimCg=
X-Received: by 2002:a37:a010:: with SMTP id j16mr23023013qke.152.1566241574987;
 Mon, 19 Aug 2019 12:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190819182039.24892-1-mripard@kernel.org> <20190819182039.24892-2-mripard@kernel.org>
In-Reply-To: <20190819182039.24892-2-mripard@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 19 Aug 2019 14:06:03 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKKFfSifovSSfdtMh_buxnZ3ZPS5NGfi1eU8P0FE6S+zA@mail.gmail.com>
Message-ID: <CAL_JsqKKFfSifovSSfdtMh_buxnZ3ZPS5NGfi1eU8P0FE6S+zA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] dt-bindings: watchdog: Convert Allwinner watchdog
 to a schema
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 1:20 PM Maxime Ripard <mripard@kernel.org> wrote:
>
> From: Maxime Ripard <maxime.ripard@bootlin.com>
>
> The Allwinner SoCs have a watchdog supported in Linux, with a matching
> Device Tree binding.
>
> Now that we have the DT validation in place, let's convert the device tree
> bindings for that controller over to a YAML schemas.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> ---
>
> Changes from v1:
>   - Use generic watchdog schema
>   - Use unevaluatedProperties instead of additionalProperties
> ---
>  .../watchdog/allwinner,sun4i-a10-wdt.yaml     | 48 +++++++++++++++++++
>  .../bindings/watchdog/sunxi-wdt.txt           | 22 ---------
>  2 files changed, 48 insertions(+), 22 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt

Reviewed-by: Rob Herring <robh@kernel.org>
