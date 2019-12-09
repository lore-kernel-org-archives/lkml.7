Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E02FC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E187E2073D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfLIJ3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 04:29:46 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36224 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbfLIJ3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 04:29:45 -0500
Received: by mail-oi1-f196.google.com with SMTP id c16so5736637oic.3;
        Mon, 09 Dec 2019 01:29:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1gULj/UHb6CAUs/AsGazsmlKOk9MdWHJvdvd6WmLJ/U=;
        b=RUmWU91Gl4BXlW19BUqWB1qmfMsuVBqLS1Zb/4dX6wdD8+0EPoddGwHsL+iOhKQSmT
         xeIVIhxHKdH4CaO4R7nGdIm0nsHXYQR21draJ0+cQO1XyQKZpCQh8yas93fA32BBpaW1
         bCyrGTjIC4Od7M/9UK1friDbBlJxPfSWs7C6D0Nf5Y05xXGL9EdfqfKlPmTm7rmfvwsC
         mV3IG79VzqNpOHrJ1mpiS+TwVm61tB97GBwBloj0lgck9A8ByGR5u1nNIomYH8ODkkjs
         8E9d6NbNSGTGhiVsb3SiEuWeG3OGSyQtvNHCKAHMrRkCMpp3EP68ISE5CsbJHjLHfHWg
         FwVA==
X-Gm-Message-State: APjAAAWOkVvgBuKzUlOvvvMzvjrDaMKWXkkLBKgFi/U3R/cAB669NPkP
        jBojuGGHbYmDqWwhyp5MeUitugNA24UPWmapsTY=
X-Google-Smtp-Source: APXvYqwhw1FYzw4YPddtUo6DIlvGABZ3x2lom006suf84ck1j4ZXpOiChOtD0P3hN28a/6SGLQerqc9J9q3hGAiDOu8=
X-Received: by 2002:aca:4e87:: with SMTP id c129mr22496549oib.153.1575883784546;
 Mon, 09 Dec 2019 01:29:44 -0800 (PST)
MIME-Version: 1.0
References: <CGME20191206125123eucas1p1c1652484cbccef8d8df37e09affe4e25@eucas1p1.samsung.com>
 <20191206125112.11006-1-m.szyprowski@samsung.com>
In-Reply-To: <20191206125112.11006-1-m.szyprowski@samsung.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Dec 2019 10:29:32 +0100
Message-ID: <CAMuHMdUsRa2QTDw4oM8SGUqfmsGt3-Mc=AnZoPV8RSqehUxyrg@mail.gmail.com>
Subject: Re: [PATCH] arm: multi_v7_config: Restore debugfs support
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kusanagi Kouichi <slash@ac.auone-net.jp>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On Fri, Dec 6, 2019 at 1:51 PM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Commit fd7d58f0dbc3 ("ARM: multi_v7_defconfig: renormalize based on recent
> additions") removed explicit enable line for CONFIG_DEBUG_FS, because
> that feature has been selected by other enabled options: CONFIG_TRACING,
> which were enabled by CONFIG_PERF_EVENTS.
>
> In meantime, commit 0e4a459f56c3 ("tracing: Remove unnecessary DEBUG_FS
> dependency") removed the dependency between CONFIG_DEBUG_FS and
> CONFIG_TRACING, so CONFIG_DEBUG_FS is no longer enabled in default builds.
>
> Enable it again explicitly, as debugfs support is essential for various
> automated testing tools.

... and for systemd :-(

E.g. with Debian 9 nfsroot:

    [FAILED] Failed to mount /sys/kernel/debug.
    See 'systemctl status sys-kernel-debug.mount' for details.
    [DEPEND] Dependency failed for Local File Systems.
    ...
    You are in emergGive root password for maintenance
    (or press Control-D to continue):

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thank you!

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

This is gonna bite lots of people (and defconfigs)...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
