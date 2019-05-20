Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24668C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0FEE216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ra1/NDHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfETVVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 17:21:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44894 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfETVVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 17:21:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id n2so700681pgp.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 14:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ancjtzq6elCyj2UruyD0ZmMo8pzIwOlqJRkQDWD0+Q4=;
        b=Ra1/NDHLCkHjBDWAQ/jViNFoVW0b3IxT96gXTCODELWtAKgg1lkNuII+jnLv5j4Teo
         640nloVeyk2sSL3B0cPg5gaPNrgeMGAbytdo8Np/1g/H8h5KBoIZIphwZ4GQcFi9BSlb
         9o3GTLE3vFvoqjaPr2B41+y0m6SfPg5hGYHkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ancjtzq6elCyj2UruyD0ZmMo8pzIwOlqJRkQDWD0+Q4=;
        b=SkCF9zjNz67SoWVwm4ktwYQ/ol3wtmR/zZXRjRRrpsncl+QXoDV7CCXGhLxwSTqE7R
         d/bbpVITCrIc6prl0boBp/EIDumi19v2VOfX278WoN1W8AJFBYXBCXHOSlmWacAY43tG
         KpZezkHXkqi1qVCF9WbGXAJNBS7MCnEv9qsOGzoFeo90R7c6crAkG6N8GQmICjSjAg4m
         FSyxvaDbr7Xtjci85vbyBXEhQZdWQhTOvfrHXLBEp9wGPSpqRo3qgbwhejdztjwpcCnJ
         RCS122Tkx8RT5kMUHIJ/KZjtgghvpDRAVlo3Aj+LMcdGlVc+Y0o21NsfrIaBZaRyvn1n
         +8Dg==
X-Gm-Message-State: APjAAAWF/Q8d/nGjlzcKvJ1dooz7EfwSbFBRNrQCjsdqzY5ExLkaxXHi
        FI07HrAlRzDohwkiVmcLxJ5Xpg==
X-Google-Smtp-Source: APXvYqw9S1yPYrd1SlaEZuoSglSNY/CGY6wMOXe8ZG9S0Iy0ayQfjzKwK/uXFS+P+TQk+jsW4OUzLA==
X-Received: by 2002:a63:6dca:: with SMTP id i193mr75790021pgc.353.1558387263271;
        Mon, 20 May 2019 14:21:03 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id a26sm34931443pfl.177.2019.05.20.14.21.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 14:21:02 -0700 (PDT)
Date:   Mon, 20 May 2019 14:21:02 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ARM: dts: rockchip: Configure the GPU thermal zone
 for mickey
Message-ID: <20190520212102.GH40515@google.com>
References: <20190520170132.91571-1-mka@chromium.org>
 <20190520170132.91571-2-mka@chromium.org>
 <CAD=FV=Vr2thgHYTH_khqka27_SdGcSEShpSRp+u2E=O5eyxLMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=Vr2thgHYTH_khqka27_SdGcSEShpSRp+u2E=O5eyxLMQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 01:21:33PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Mon, May 20, 2019 at 10:01 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > mickey crams a lot of hardware into a tiny package, which requires
> > more aggressive thermal throttling than for devices with a larger
> > footprint. Configure the GPU thermal zone to throttle the GPU
> > progressively at temperatures >= 60°C. Heat dissipated by the
> > CPUs also affects the GPU temperature, hence we cap the CPU
> > frequency to 1.4 GHz for temperatures above 65°C. Further throttling
> > of the CPUs may be performed by the CPU thermal zone.
> >
> > The configuration matches that of the downstram Chrome OS 3.14
> 
> s/downstram/downstream

ack

> 
> > +       cooling-maps {
> > +               /* After 1st level throttle the GPU down to as low as 400 MHz */
> > +               gpu_warmish_limit_gpu {
> > +                       trip = <&gpu_alert_warmish>;
> > +                       cooling-device = <&gpu THERMAL_NO_LIMIT 1>;
> 
> As per my comment in patch #1, you are probably ending up throttling
> to 500 MHz, not 400 MHz.  Below will all have similar problems unless
> we actually delete the 500 MHz operating point.

Thanks for pointing that out. As per disussion on patch #1 we'll
disable the 500 MHz OPP to stay in sync with downstream and avoid
problems in case someone decides to re-purpose NPLL.

> > +               };
> > +
> > +               /*
> > +                * Slightly after we throttle the GPU, we'll also make sure that
> > +                * the CPU can't go faster than 1.4 GHz.  Note that we won't
> > +                * throttle the CPU lower than 1.4 GHz due to GPU heat--we'll
> > +                * let the CPU do the rest itself.
> > +                */
> > +               gpu_warm_limit_cpu {
> > +                       trip = <&gpu_alert_warm>;
> > +                       cooling-device = <&cpu0 4 4>;
> 
> Shouldn't you list cpu1, cpu2, and cpu3 too?  That'd match what
> upstream did elsewhere in this file?

ack, should have noticed, I 'yelled' at others before for not doing this ...
