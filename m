Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCEFC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74ED520815
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570538309;
	bh=0172FbZMwE+uHkpHQaDTjmrpy7r6UVMZViKRxp2jAkE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zS2GhgPh9KCNKVeIdstMKgXvtS9DoWPHj44hYgsBUDovvX+qjqWN8zXlT3XV/KPEj
	 gKyH0e/nZTcpp69sY5r8/FUjDzMu1crlDR1an1eHU9WkmJ6Jl6z4rMuuuJxMq2tQ9Y
	 tHmhtW84lcCArj+ZgkwDLz9igRyYDmPwbsejJImQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbfJHMi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:38:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730705AbfJHMi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:38:28 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27E3F20815;
        Tue,  8 Oct 2019 12:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570538307;
        bh=0172FbZMwE+uHkpHQaDTjmrpy7r6UVMZViKRxp2jAkE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Fj0cjOYfJqhfG7IwXrmsg43ZvERQ73aD0HiD62uK8K0QAnuFy4VbETrnvYSymrBqN
         xM7+aR53XRnXLF/IMVEBQZral9XGk3sgp1dp0oYVgvM71fmByrgK0ow2kcUo6seEJK
         WtzTvf6j2ztu57+zCR9T41ITyxFFnOHtYtMF77Dg=
Received: by mail-qt1-f178.google.com with SMTP id 3so25036855qta.1;
        Tue, 08 Oct 2019 05:38:27 -0700 (PDT)
X-Gm-Message-State: APjAAAWy7yPA/NtOvpSA6JR3NprGx8Az19d2KJ7yNuGjuPzyDXqjvnis
        K4kBX5jtWvt8+jEEf+4j0OI9GPFAKm8BTMhU1w==
X-Google-Smtp-Source: APXvYqzxC6rl6FMV1ScqL2fgXOVZv3hYhSzySpUPq3nsKaUzT0TVTrLa+50ZC/gUauiPJFRY9Nd2MNSIBGFt1IYYeV8=
X-Received: by 2002:ac8:6982:: with SMTP id o2mr35571093qtq.143.1570538306332;
 Tue, 08 Oct 2019 05:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <20191004151414.8458-1-krzk@kernel.org>
In-Reply-To: <20191004151414.8458-1-krzk@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 8 Oct 2019 07:38:14 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJDTcHu5oXG6zszGHCBhTE6EW94AANUjyMV78SkKcn5yA@mail.gmail.com>
Message-ID: <CAL_JsqJDTcHu5oXG6zszGHCBhTE6EW94AANUjyMV78SkKcn5yA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: arm: samsung: Force clkoutN names to be
 unique in PMU
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 10:14 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The clkoutN names of clocks must be unique because they represent
> unique inputs of clock multiplexer.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/samsung/pmu.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.yaml b/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
> index 73b56fc5bf58..d8e03716f5d2 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
> +++ b/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
> @@ -53,8 +53,10 @@ properties:
>        List of clock names for particular CLKOUT mux inputs
>      minItems: 1
>      maxItems: 32
> -    items:
> -      pattern: '^clkout([0-9]|[12][0-9]|3[0-1])$'
> +    allOf:
> +      - items:
> +          pattern: '^clkout([0-9]|[12][0-9]|3[0-1])$'
> +      - uniqueItems: true

You shouldn't need the 'allOf', just add uniqueItems at the same level as items.

Rob
