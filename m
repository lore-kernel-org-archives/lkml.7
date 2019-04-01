Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702F2C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7A32084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbfDAI7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:59:45 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44967 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfDAI7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:59:45 -0400
Received: by mail-vs1-f65.google.com with SMTP id j184so5005872vsd.11;
        Mon, 01 Apr 2019 01:59:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D49yr3gZZboTSYdQC0cV56BtNASxZXIvfMEoEhib5m0=;
        b=p10bJ4onjC+5hYkSSc/QUJFRhuxHL7FlznNXMjei/BvLN9cz3CJeMiscxmG2mKAFc3
         xat/VTK+vAot4aXYFns2c9l8Tm6Vu3fj2p9HFceHEpMk0mef0nuZqN2yP8LpzOTMVgow
         0/Y72eW/kDhicd1oUTePvBYlYB7O83NoLfdH8AFqO2FGUpnelsS641KHXbfRQZyxD/tK
         +xIqOPKDimdlx9ijoZfnZpj3P9G8HAmvCQFWkDLDDk2wa9v4819uYQRv6gc6P+xtCDdI
         ZNWgJDcRBqbQBrYkHKETD1J7UOa1h6tvnYbdO+2HGSrLHrTBZOIMhjc61/mCLlwbD77d
         Xk6A==
X-Gm-Message-State: APjAAAXJ5hMorGSTGhBh8jsHM9RV6ARzea0njsMvBjI5/ivYyrtmgVWB
        rB+dmjSSYObCiuWjH65OeR1l9gK6NPSh0mHsRY9QEw==
X-Google-Smtp-Source: APXvYqxkJl3q+A9OdgkOXc+cbZxHO495tPa2DT9LcuEV7OS8MTUzeR6MW3ydeNuYYNN6YZDCPJN2jXGvj0EUxgiTHuw=
X-Received: by 2002:a67:8546:: with SMTP id h67mr18610848vsd.11.1554109183762;
 Mon, 01 Apr 2019 01:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190321101557.26857-1-alexandre.belloni@bootlin.com> <20190401084143.uqbiktkt2vltgrxa@ninjato>
In-Reply-To: <20190401084143.uqbiktkt2vltgrxa@ninjato>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 1 Apr 2019 10:59:32 +0200
Message-ID: <CAMuHMdW_Gz4qaRXFeW-h7vNxJ5RwjDXDP4oZZcUaYHcqEC75bA@mail.gmail.com>
Subject: Re: [PATCH 1/2] rtc: da9063: set range
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Mon, Apr 1, 2019 at 10:43 AM Wolfram Sang <wsa@the-dreams.de> wrote:
> On Thu, Mar 21, 2019 at 11:15:56AM +0100, Alexandre Belloni wrote:
> > The DA9062 and DA9063 have a year register that can go up to 0x3F.
> >
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>
> Thanks for this patch! Didn't know about the devm_rtc_device_register()
> conversion going on. Glad I learned about it.
>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> I couldn't test the upper limit (DA9063 hooked to a 32bit system here),
> but lower limit works and RTC in general works.

BTW, does the RTC alarm interrupt work for you?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
