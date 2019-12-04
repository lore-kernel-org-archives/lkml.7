Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76F7C2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73AE2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="De7wqYVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfLDPhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:37:40 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46586 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbfLDPhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:37:40 -0500
Received: by mail-ot1-f67.google.com with SMTP id g18so6644418otj.13;
        Wed, 04 Dec 2019 07:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zsl/NYOHbe+5Z9l4Py0S0UhbStKwiCgjg78sah22X74=;
        b=De7wqYVNK/pvvWk9mSR7jFvEzZsynk6dJccpz3iNh+S9NEfYYXJZ2HgKfjEZv4EQYi
         wDRBS00PBoaVLUU0LiAuBWt5/YvRnLqEfJeH9P6vKapz84FBU72ZuyBN5c/30LTDzDCJ
         1gHb1/lXcIIjFcwApdj6h0OQhhOH6yDfw6AR+6qAYwgpxyz7P2Kmuh7t4o7KDDHqxuOJ
         G93q2q/HVYHQi6donkp56u7EfJlWbI2VVUz8TYV9bQmEggqxfHIaX48UF4xePDzSS9IK
         7Ox4iI5bfFXBmxtzlWtmOWlbZt86qRyYFoVWwqQILxhjR0CGqB3d7+OipTvbaxReczo1
         ftSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zsl/NYOHbe+5Z9l4Py0S0UhbStKwiCgjg78sah22X74=;
        b=t49H8fFTiNwTLQIAC+S42otqp3/3lxdhQxYAtUbKOot9txJmor+AlHq4qK65CzJUtp
         yevNfR/z0ufKres/KRPXhOcaxqf+pA6NXQN61wKSJQ2/IMOMf2ifqRo7R4xVzSm8DmOH
         RWO5sXjuBOCApaDVzCxxPZsfHVJu1xqPJ9ptaeKI/fMAjADw8/gXQjHPN4ikYv+UuN8H
         fNA6A40EUXy7fxStWezjd+fARqr3gL+5wnc7F+PfITtVpC3nIIatJPqFc4PAg3w86nZN
         3xZcIygbbCVBn7n/fLdN16KKLEPFFb5+frKvGri8Kj8XeEzeZQR+X4M98G4zkiEg2+Yt
         DwOA==
X-Gm-Message-State: APjAAAULCtGSBpuJCR1i2ABj/qrUTdiM5n9kWPG3unURL8aICMXp5SHP
        JmriJIDw6wmbM0OmbqMQquWpOLg0LFA+GGIW83A=
X-Google-Smtp-Source: APXvYqwm/x9oQYj+1JqrNdG6tOLzfyWFpbaFv3VoCKTHKug5N7LCh4qvVQbuivSmaCiIIztxUB857mrUsxEcm+vS0oM=
X-Received: by 2002:a9d:624e:: with SMTP id i14mr2972023otk.371.1575473859624;
 Wed, 04 Dec 2019 07:37:39 -0800 (PST)
MIME-Version: 1.0
References: <20190113021719.46457-1-samuel@sholland.org> <20190113021719.46457-2-samuel@sholland.org>
 <472c5450-1b60-6ac7-b242-805c2a2f3272@arm.com> <CA+E=qVfaBcUN5iB3kaK5gHyURpWt7ET6_js=sLiDg4PCDXXTYA@mail.gmail.com>
 <4b922079aeed04f31ff67b3e7fb78022@www.loen.fr>
In-Reply-To: <4b922079aeed04f31ff67b3e7fb78022@www.loen.fr>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Wed, 4 Dec 2019 07:37:13 -0800
Message-ID: <CA+E=qVc-BA_W8O1qpkKgg5pDax-Jbvmpc-TB7gWB7CfYAxXCXQ@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v3 1/2] arm64: arch_timer: Workaround
 for Allwinner A64 timer instability
To:     Marc Zyngier <maz@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <mripard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 4, 2019 at 4:21 AM Marc Zyngier <maz@kernel.org> wrote:
>
> [please note that my email address has changed]
>
> On 2019-12-04 04:18, Vasily Khoruzhick wrote:
>
> [...]
>
> > Unfortunately this patch doesn't completely eliminate the jumps.
> > There
> > have been reports from users who still saw 95y jump even with the
> > patch applied.
> >
> > Personally I've seen it once or twice on my Pine64-LTS.
> >
> > Looks like we need bigger hammer. Does anyone have any idea what it
> > could be?
>
> Which kernel version did you see this happening on?

I've seen it on 5.3

>          M.
> --
> Jazz is not dead. It just smells funny...
