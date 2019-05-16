Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58358C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 17:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DCB82070D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 17:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jb1d/6dT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbfEPRjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 13:39:37 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:47056 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfEPRjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 13:39:37 -0400
Received: by mail-vs1-f65.google.com with SMTP id e2so2834632vsc.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 10:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=btkYXyszYOl4enkQNj6rF85Z8K5s124rQC98XbJLKTg=;
        b=Jb1d/6dTS1pvv/Mc3sngMU2XidRneSla0eokNz7UyBI0yOzrq5vCgombW1gG1LdKUz
         Z5kTaogiXfzaxz4CCpB/AezBDqTNpXyLbqEZlHFmcTaBm69PYrg8A59ElJe/LJnc4gz6
         GygFEMTkuX9hdSY7oSVpDZbJJBD05Vgp574Ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=btkYXyszYOl4enkQNj6rF85Z8K5s124rQC98XbJLKTg=;
        b=CgDIIexo5BmxYRYrQFsTjKsOdVGlMp7CxRqO1grCu7nEm6fNTaknWA7K1HAsNZxWdp
         WxHYABun2jpUA5MXOnlLionJI6HeYdeztwjmpxPDHfpVkr7vVUUBEgryebzFutFDHwkI
         w84+LYMu2Be/wLAKpO4JYfCRC/2iTFqFDK8NdQetYlzKG8fIXpj7p1A6g/EHe93ToImg
         iXlmKTVzRtL8dMY8bZ1ZN0f+XwyvMt4DAmkangl8JJkq7zc7qLS6j6O7kLseHQmRKvb5
         DkBHm1LYHcS6cxNz7z55cLY7y4BQyWN2h/yYF4gIj4oa17jwGw8ZelceW7Y9adBUzLCM
         wccA==
X-Gm-Message-State: APjAAAWLdy3E2nOOAcd3ZRyg497Z2XV3/X4KeMBDrm+09dgLZHQ3RcM8
        fYETrFXIl1D/9/5VhK5oaUH3ftVP9l0=
X-Google-Smtp-Source: APXvYqxTX0J5J3z50IEEbeXXJ2rjN4lAHJJwUc1gY1vtnQ76kGcQjwP56GcEKr8FjuzQWR7GgOxSGQ==
X-Received: by 2002:a67:f049:: with SMTP id q9mr24045065vsm.93.1558028375711;
        Thu, 16 May 2019 10:39:35 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id 2sm6802874vke.27.2019.05.16.10.39.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 10:39:34 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id r23so1250358vkd.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 10:39:32 -0700 (PDT)
X-Received: by 2002:a1f:1e48:: with SMTP id e69mr23173110vke.16.1558028371386;
 Thu, 16 May 2019 10:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190516172510.181473-1-mka@chromium.org> <20190516172510.181473-3-mka@chromium.org>
In-Reply-To: <20190516172510.181473-3-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 16 May 2019 10:39:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wk0EFO2+c=KAfemo0_w+QEA8==KzOdN-niD0mA_myh=Q@mail.gmail.com>
Message-ID: <CAD=FV=Wk0EFO2+c=KAfemo0_w+QEA8==KzOdN-niD0mA_myh=Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ARM: dts: rockchip: Use GPU as cooling device for
 the GPU thermal zone of the rk3288
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 16, 2019 at 10:25 AM Matthias Kaehlcke <mka@chromium.org> wrote:

> Currently the CPUs are used as cooling devices of the rk3288 GPU
> thermal zone. The CPUs are also configured as cooling devices in the
> CPU thermal zone, which indirectly helps with cooling the GPU thermal
> zone, since the CPU and GPU temperatures are correlated on the rk3288.
>
> Configure the ARM Mali Midgard GPU as cooling device for the GPU
> thermal zone instead of the CPUs.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v2:
> - patch added to the series
> ---
>  arch/arm/boot/dts/rk3288.dtsi | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

This makes sense to me unless there is some better way to model the
intertwined nature of the CPU and GPU temperature.  It's my
understanding that the original device tree snippet was there because
it was added before the gpu node existed in the device tree so the
best we could do is to suggest that the cpu could cool things down.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
