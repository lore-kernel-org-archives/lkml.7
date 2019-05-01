Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B623C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 21:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B4A20866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 21:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Vy9II8BK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfEAVsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 17:48:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33422 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfEAVsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 17:48:46 -0400
Received: by mail-pf1-f194.google.com with SMTP id z28so79975pfk.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 14:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Ms2fxJg0/K08tIr8XK+9DVxGHd3odhQsJcruBO9/Gco=;
        b=Vy9II8BKv8i0MlZkEJfie/cJioOIgiZATIL1ybqlRn8+EzResRHKoIsPk5u145Nf6z
         bzinDOGPzxQqU0tQVAPpbTItv2l6RixPo/KlzPxNdl3hauTBb+3yAixk3wVfs+xKBZRq
         OwCVtmDnrCxQ6XNnLmCJ4iEg+46A/ZV80GGbQC0X8NUAQmSsWACfzXAUjud8DUgn7pxi
         ia9xJjFaQ0jizt/VamCChXIXsvxCsa1cyr/NMuDNZJ7OD2bJslDdfzHuxr/E/VzDZbAt
         pAuuZFOEySrqflJhEWm5e4wWsTL7z2hRvWfUQoBwUf6KXlAnlOq0Z1BXTUY/PkDTXhC3
         mceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Ms2fxJg0/K08tIr8XK+9DVxGHd3odhQsJcruBO9/Gco=;
        b=kVYjoHd9ZyAQwTFZu1tghABoh+njDUKCpuJzBmezDDPDkj0EutBzQHiV8h+IHfKmva
         7FiagKHRbdrk981xFs4QXG4y6pgo5MIKfaGqQ3Qd7yyPUFC+c7Eg/ixC0IHZNqVFfm1X
         Bnj2T0lcJnFs/0T3rmgqOzk77ZnKLTlD+01zwgfb8VBKn54gwvoZyl8NugBJfPdMugKr
         1DdH7EfZFioWYTQ0M4Krcq4LT0zkKnMmt348OvA2iIWwDSzlbsMYoHBlSTXLXbf1JI/X
         D5UuruqVRa7FJko+XPxMaBFM6GqJZBHN5yONKxNFk6VvAvos17nXWRMAJLGCSp7H3yCK
         HUBw==
X-Gm-Message-State: APjAAAVK2lE00aOnmXQPBAV5jpu53NwPNikIFInsmqVz2PU19GP7F2Sy
        fk9nly34mwJySPeVbosj9olFYQ==
X-Google-Smtp-Source: APXvYqyDxHWVkwopoxHH6WsGgNv2az6Bj93JI1u7HYgkxfmuROaK2/GOCj0fIKVezJuD3vLJ8PeDSA==
X-Received: by 2002:a62:1d83:: with SMTP id d125mr262533pfd.74.1556747326105;
        Wed, 01 May 2019 14:48:46 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:e50d:c7fa:92aa:c53d])
        by smtp.googlemail.com with ESMTPSA id k14sm24448593pfj.171.2019.05.01.14.48.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 14:48:45 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     "kernelci.org bot" <bot@kernelci.org>, Tejun Heo <tj@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        tomeu.vizoso@collabora.com, guillaume.tucker@collabora.com,
        mgalka@collabora.com, Thomas Gleixner <tglx@linutronix.de>,
        broonie@kernel.org, matthew.hart@linaro.org,
        enric.balletbo@collabora.com, Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "kernelci.org bot" <bot@kernelci.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: next/master boot bisection: next-20190430 on beagle-xm
In-Reply-To: <5cc8b55c.1c69fb81.c3759.1c27@mx.google.com>
References: <5cc8b55c.1c69fb81.c3759.1c27@mx.google.com>
Date:   Wed, 01 May 2019 14:48:44 -0700
Message-ID: <7hy33pn8w3.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"kernelci.org bot" <bot@kernelci.org> writes:

> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>
> next/master boot bisection: next-20190430 on beagle-xm
>
> Summary:
>   Start:      f43b05fd4c17 Add linux-next specific files for 20190430
>   Details:    https://kernelci.org/boot/id/5cc84d7359b514b7ab55847b
>   Plain log:  https://storage.kernelci.org//next/master/next-20190430/arm/multi_v7_defconfig+CONFIG_SMP=n/gcc-7/lab-baylibre/boot-omap3-beagle-xm.txt
>   HTML log:   https://storage.kernelci.org//next/master/next-20190430/arm/multi_v7_defconfig+CONFIG_SMP=n/gcc-7/lab-baylibre/boot-omap3-beagle-xm.html
>   Result:     6d25be5782e4 sched/core, workqueues: Distangle worker accounting from rq lock

I was able to reproduce this in next-20190430, but...

I'm not sure what fixed it, but this is passing again in today's
linux-next (next-20190501)

Kevin
