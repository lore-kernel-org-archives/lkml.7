Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5AAC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 01:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA8D21019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 01:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PUOdCk/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbfEWBVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 21:21:25 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43182 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728352AbfEWBVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 21:21:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id c6so2258427pfa.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 18:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=aZA+MNZ2gy6tyuVfxVa4+g2Ok6wQVnYjHxlUytPK634=;
        b=PUOdCk/UEJMFygnW4qCafnKIOUDF9MkSj5dza7t9Rj1736a5ouarchneF9tOUqj8/z
         SwjwewLHDFiwc3/ab4+IUd6mSSbU3wGjHT55wHa0aIKC1NBiPkwHIDEbMwsD2hEcB4Ln
         QF8G7EF8TV+3fes/dMKH9cXzQXwp1u7XFF2Z+TinznOq3GXu9qtm1Bny5T7RiZw8XzNE
         Cxh4wMPEVxaRVCYDbo6IjJEEZzAhqXOME50oAR82x8GVyzLbA7wTLFKB//3urtelO0qw
         BdP2z8abMTXZd7YPnMcb5AUSc4Ao/ie6Fl/4q52kn16qfHT0MciIDBn+BG+YVnjcAlf+
         bBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=aZA+MNZ2gy6tyuVfxVa4+g2Ok6wQVnYjHxlUytPK634=;
        b=Z1V6mU/XQwtEp3/n+rAVXaGUlBciwUKHCQOcKDAG2Vq4jXudF2zNTom5w2/hrOcj1i
         SUD8Os63S6wNIcoY39HM93x6Fs6Y8ZLRNTpfYoH2NVtEKOW08/+Dzws/DXh2N3Q0aBRy
         roWusTr5uajFsCiIv7FwmvOmzjtRGLn3pChkvXNUfm5Tb3Qtj07L4bbrVGmryv5FPn2p
         rDRrCqxVcTamYAM7DMFjW+eWcREAsX2Zg91l4VsQF4rlPAb48/sFlmhPgB+Mcx1lt24T
         +MrvzUWUijHZJQTYYTD1kL+PWs4dndBKYo1GfIMCY5JnBz7PM/gXvXRN9v/F4P1QtxAQ
         fDAQ==
X-Gm-Message-State: APjAAAV3+QZCwOHKC+NmWvp+9rmymeyOEC1CAYTylI4Fq7lzxUX0+9IR
        auP0qnpUb1NXEqrkYzOUIEEicg==
X-Google-Smtp-Source: APXvYqwZPRmT7k3u0C+6WYbp7uBd/JRJE1geAcqL1D/11qfWc7DMiFMpRi9UzoUrwq9R8sy64EUUhA==
X-Received: by 2002:a05:6a00:43:: with SMTP id i3mr21282572pfk.113.1558574484468;
        Wed, 22 May 2019 18:21:24 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:ed4f:2717:3604:bb3f])
        by smtp.googlemail.com with ESMTPSA id u1sm40517035pfh.85.2019.05.22.18.21.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 18:21:23 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, mjourdan@baylibre.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 0/5] 32-bit Meson: add the canvas module
In-Reply-To: <20190520194353.24445-1-martin.blumenstingl@googlemail.com>
References: <20190520194353.24445-1-martin.blumenstingl@googlemail.com>
Date:   Wed, 22 May 2019 18:21:23 -0700
Message-ID: <7h1s0q55kc.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> This adds the canvas module on Meson8, Meson8b and Meson8m2. The canvas
> IP is used by the video decoder hardware as well as the VPU (video
> output) hardware.
>
> Neither the VPU nor the video decoder driver support the 32-bit SoCs
> yet. However, we can still add the canvas module to have it available
> once these drivers gain support for the older SoCs.
>
> I have tested this on my Meson8m2 board by hacking the VPU driver to
> not re-initialize the VPU (and to use the configuration set by u-boot).
> With that hack I could get some image out of the CVBS connector. No
> changes to the canvas driver were required.
>
> Due to lack of hardware I could not test Meson8, but I'm following (as
> always) what the Amlogic 3.10 vendor kernel uses.
> Meson8b is also not tested because u-boot of my EC-100 doesn't have
> video output enabled (so I couldn't use the same hack I used on my
> Meson8m2 board).

Queued for v5.3...

> Martin Blumenstingl (5):
>   dt-bindings: soc: amlogic: canvas: document support for Meson8/8b/8m2
>   soc: amlogic: canvas: add support for Meson8, Meson8b and Meson8m2

these two in v5.3/drivers

>   ARM: dts: meson8: add the canvas module
>   ARM: dts: meson8m2: update the offset of the canvas module
>   ARM: dts: meson8b: add the canvas module

and these 3 in v5.3/dt.

Thanks,

Kevin


