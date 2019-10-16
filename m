Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99C4FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CDB22168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rBya5PBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406382AbfJPQjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 12:39:03 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:43188 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406373AbfJPQjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 12:39:03 -0400
Received: by mail-pg1-f171.google.com with SMTP id i32so14599092pgl.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 09:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=uj62At7arnilFOJJbl5N7a5EkMRk8gmjDj29tsswWIE=;
        b=rBya5PBO6sZHChGDQpT99l/deboFxP1XaW8i/9Ff0L5lelkWO7f2RuzRS3/wLiXWVb
         XjdRwrYeSFsiAoPnxaDseJgPW0UZlbFWO5u33OaphuTGKfM2k7rEFGs8wPKGYjYIE49h
         dORi5YyWTorA+d6D6zuQRS+tX15uEph0kH8P5A2mxeJLAIjUm3w6yQJ6yGrHKsH+OVDE
         TlP3iEvahZXKpwACmvuRDomjXkvEREPVhWSABCM+nEe2wRs+zIvkicRGDPQep9OMWLF9
         YI3u2S5W/FmHu/LpjWTcKfjs+P2CCCQ4Hqi4PYUuRYqGerDiMmRFcFHJDVsMeWEGscu6
         C3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=uj62At7arnilFOJJbl5N7a5EkMRk8gmjDj29tsswWIE=;
        b=jSYKdGITQ8K8ZUht5mi9LOIogeDOd7tGc5fLOobiVBwKFLNGZJRvPLVU1IhQiceriq
         TVfnmONB5EQWBxz3NRzeIxhJ2FXJQTICEcw9sq80CYkh+kAt2rtohajxzLxSAu/rcGpC
         OpbQR1bLwaPW1fj2hTo/tWcEgOZrmRRKO6t0ZaQZ4kF1eLtTow52V6IJq3FCE4kt6smL
         4I7CFrScsTID419Y8pi5rn03ZWv9yvsguaTo3Qgy9fj3L+zVqbhTi+U4/XQysSKhqoNm
         miJgS7WJjl+gNvPYhlSH1OEoyGY1xz+C0ZBuok9fGqfokNFgTosoGkI/4HhvbFKCovDQ
         pcWg==
X-Gm-Message-State: APjAAAXWZYUNDJsfRadiJNYgytxW3SBFkOhlCoxmPt0EahHH+7JY2wfH
        BaWlfH13J2gQ9I81n0ymR9Ca9Q==
X-Google-Smtp-Source: APXvYqy7cm/gQHTfBaihNUxg/kpuNUjJHhY1iUPuIbJzt/XJ4Le3qA+lNeFhKinPwgh0xJasS1A49w==
X-Received: by 2002:a17:90a:2ec5:: with SMTP id h5mr6266957pjs.87.1571243941981;
        Wed, 16 Oct 2019 09:39:01 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id z4sm29661708pfn.45.2019.10.16.09.39.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Oct 2019 09:39:01 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     edubezval@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Guillaume La Roque <glaroque@baylibre.com>,
        amit.kucheria@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org
Subject: Re: [PATCH v7 0/7] Add support of New Amlogic temperature sensor for G12 SoCs
In-Reply-To: <20191004090114.30694-1-glaroque@baylibre.com>
References: <20191004090114.30694-1-glaroque@baylibre.com>
Date:   Wed, 16 Oct 2019 09:39:00 -0700
Message-ID: <7hwod4fxwb.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eduardo,

Guillaume La Roque <glaroque@baylibre.com> writes:

> This patchs series add support of New Amlogic temperature sensor and minimal
> thermal zone for SEI510 and ODROID-N2 boards.

[...]

> Guillaume La Roque (7):
>   dt-bindings: thermal: Add DT bindings documentation for Amlogic
>     Thermal
>   thermal: amlogic: Add thermal driver to support G12 SoCs
>   arm64: dts: amlogic: g12: add temperature sensor
>   arm64: dts: meson: g12: Add minimal thermal zone
>   arm64: dts: amlogic: g12a: add cooling properties
>   arm64: dts: amlogic: g12b: add cooling properties
>   MAINTAINERS: add entry for Amlogic Thermal driver

This has now been thorougly reviewed/tested.

I've queued all the "arm64: dts:" patches via my amlogic tree for v5.5.
Can you please queue up the driver, bindings and MAINTAINERS patch?

Thanks,

Kevin
