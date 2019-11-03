Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC21ECA9EBB
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 22:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17F421655
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 22:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RW20B4Hi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfKCWfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 17:35:55 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40295 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbfKCWfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 17:35:55 -0500
Received: by mail-lf1-f65.google.com with SMTP id f4so10794777lfk.7
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 14:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EHtdTbqBxd9JTKBkMBRWhQaNOyW/MKSbbKYTSzXac2s=;
        b=RW20B4HiwisBi+QgKxV78+/7ahWabvD2Ujxzw9C0QLTzC4lFBaXW/aDjyAQ4YzYlJm
         f3LfHiRVzK5cZLHWD9MeQlwlfdoZAjS0ICQyJePB3LKjdzNjnECwfLNrAWcp5S+jkwtA
         WPDyoXQ9ItnxCrxoSpzzcO5bYucDWQQTO87rEgzoli2PkRZMdJK111r8tuZVp0oFLzQK
         DftFukh3yFDXJqncuJ8LLANgiTMpNxAgOfEBLnDayf5GlGhIxOjJZGUaRg2AW3zSvU5V
         2xdXlUKsIfdOzrVQ1iVZG87Be66/5/OwWDKbuMP0yL9EO+wmE6Qz/J/7Ur7JDRTiaP9v
         RHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EHtdTbqBxd9JTKBkMBRWhQaNOyW/MKSbbKYTSzXac2s=;
        b=PrwFM7xw6riKoow977XMNrLEYSmda5D4gO10kVVrzS5yaNv8x1I16lT+mzH/RET4yg
         GxUQUIpalGkDNfNMGjHuPPBHnLSRH0LfUg4v/5kNLcOcMkIb8XntgQ+Cqs1GYPX1dTlQ
         gi/cgwiPYJGz99ACoMC3wrA5PhveTSCwWXVsBCOMqsuNFv37kEXSVvTJiD/oK0lRGieo
         gV96wPiRpeZdCNg4pE+w0YoKfqxO/c+nfvVm9zrhIo1gwsF2qdl5aKjt4iTJdqD3Ym3B
         TOaVoL3UjMuxHmZbco9OTwhd6W4xvyYAL2LJSeNgNxVOIuYfnRwli8Hr8CjagOLvqgRt
         IW3g==
X-Gm-Message-State: APjAAAXEZLniBpsYrUK40ZOHRHAtK827o3pSbAdipZHyA1nABfJlAjYm
        6A8gS1y/0TUwRAbLuMTbx/GUc35NNAPUgYqCakq+dQ==
X-Google-Smtp-Source: APXvYqzgwn2ea3wgkeAplcvs+z5xFC8B7B9ZgEIYnEjFBzdQK4niVCmNaMSjFFIdFzKBhXKld0V8HRZoBmyNEWVxAhg=
X-Received: by 2002:a19:651b:: with SMTP id z27mr14242065lfb.117.1572820553199;
 Sun, 03 Nov 2019 14:35:53 -0800 (PST)
MIME-Version: 1.0
References: <20191101092031.24896-1-codrin.ciubotariu@microchip.com>
In-Reply-To: <20191101092031.24896-1-codrin.ciubotariu@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 3 Nov 2019 23:35:41 +0100
Message-ID: <CACRpkdZh-gV8T6cN2R9DrLE32EPGk9g07z_K00W9n+kbiSW7Wg@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: at91: Enable slewrate by default on SAM9X60
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 1, 2019 at 10:20 AM Codrin Ciubotariu
<codrin.ciubotariu@microchip.com> wrote:

> On SAM9X60, slewrate should be enabled on pins with a switching frequency
> below 50Mhz. Since most of our pins do not exceed this value, we enable
> slewrate by default. Pins with a switching value that exceeds 50Mhz will
> have to explicitly disable slewrate.
>
> This patch changes the ABI. However, the slewrate macros are only used
> by SAM9X60 and, at this moment, there are no device-tree files available
> for this platform.
>
> Suggested-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---
>
> Changes in v2:
>  - updated commit message to reflect the ABI change

Patch applied with the ACKs.

Yours,
Linus Walleij
