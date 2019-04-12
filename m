Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602C7C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC0B205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="JsNs80XH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfDLIDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:03:31 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45290 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbfDLIDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:03:30 -0400
Received: by mail-qt1-f196.google.com with SMTP id v20so10177844qtv.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 01:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IA3mZ3nvheNqDR0FWDnnqoP9wxY5UD2M8T0Ec+3Ict8=;
        b=JsNs80XH2gxh0J8qGUD0lWjVDROyJtMIOvBIqovw4O1YRujNKeCvGZTSbm98b2Cmpn
         +PwhVzmu2N0m6u+viv93eFBdPM4xooNJPN/d779ZwP2ExAglyn7J8mi2Nxq93Olc5PrM
         gwljaJm0/aHkNFjxo5TQq70krYCEwNce4tk6yy3UyAiRPpUbKxiH3DAtkDdKkft/lgC/
         wOX3U5fdB9aI5mP5yEVaITl2N/JTbFj3sLUaZjGFb6mKIE0PVY9HB9krnZcU5LwFFb1V
         xdXeBTON8UqDurUBKK8PzRVwDOkykMFOj8bMjFFc/YaNg8npNU1YYpSS9hdv9jVJDXkB
         L4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IA3mZ3nvheNqDR0FWDnnqoP9wxY5UD2M8T0Ec+3Ict8=;
        b=bzmx1sdBeDoVb7a6/NOjD5avlDa5Yrke/TpEXVDi2rvSseQfdlkZQJrdAJboCa+el/
         ZJneoszggjha/fbPrZ4+OatqvtgVceROdchYPrSNht/cZTsE1LiuoP70t6dVRA3XXgRy
         g7Z11yRF6WNmLo0AOWCCwHpwRWBC3wMKkfL/qqtQevdWubT/yjKWUv+RWTtTWnaBTmMe
         V1FnBImdloAC2boPzSL+pkmDjJLgX8x5d+LCqo/1Pfx9hmnx+PnqFduFrc8DogYh68N3
         UkUb7dHMm5ZIO4vZ00ts8OK/wFOAm1ZHflnKho2IgoiMdvop9wZoD5mxEmxc9S65mawT
         C1Zw==
X-Gm-Message-State: APjAAAVEFusQDqd1Ps+FTMBTqY2zcQbopa7rL7cUBmPKdQ/Lpz4V9WRr
        9nOrgwbYcKCt6Hg5c4scZhLG6O8AI+OaLtKqT98ZKA==
X-Google-Smtp-Source: APXvYqzhuQa5rNgGunLO5GTHjRU9NyN1UowoNP9OQ8b+lvtSpZfoXMnrTbDbRJYw46FpQEb2zklsnvCsGdbJF/OG5MY=
X-Received: by 2002:ac8:3789:: with SMTP id d9mr48179356qtc.34.1555056209073;
 Fri, 12 Apr 2019 01:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <a8dd77f3-1e28-6416-5f04-aff44d5bb6d6@gmail.com>
 <72b3e0aa-d53a-8a82-1505-f4f00aa2bb46@gmail.com> <fecb4870-7875-a524-bf6d-3108e25af888@gmail.com>
In-Reply-To: <fecb4870-7875-a524-bf6d-3108e25af888@gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Fri, 12 Apr 2019 16:03:17 +0800
Message-ID: <CAD8Lp45ivFJiW0FZo+ZOyUdpV1JFwPg=o7rx7eyp_YdSAbRRkg@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] platform/x86: asus-wmi: Switch fan boost mode
To:     Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org,
        Endless Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 1:47 PM Yurii Pavlovskyi
<yurii.pavlovskyi@gmail.com> wrote:
> * 0x00 - is normal,
> * 0x01 - is obviously turbo by the amount of noise, might be useful to
> avoid CPU frequency throttling on high load,
> * 0x02 - the meaning is unknown at the time as modes are not named
> in the vendor documentation, but it does look like a quiet mode as CPU
> temperature does increase about 10 degrees on maximum load.

I'm curious which vendor documentation you're working with here.

From the spec,
0 = normal
1 = overboost
2 = silent

Also you can use DSTS on the 0x00110018 device to check the exact
capabilities supported, which you should use to refine which modes can
be cycled through.
Bit 0 = overboost supported
Bit 1 = silent supported

Thanks
Daniel
