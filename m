Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B012C00454
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD52207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575914758;
	bh=4Tiwn+vOanX6VoEEg918KRKbn6cy8IHjhRhssNZygkE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uKm4FH9EN96U+luqkycUvBNO0sqKKrE7mQEknMu34Tm7RODBrHtRJQh+MbW2aU79z
	 0QGiez0J+Y4ek70AhTdcG7QsUN20TJYJ95ItWY0K6IjoDP/WeLptM2XAcUytfz/8x2
	 EkcBuTK/bjQjq6NArMHG/aUrXzXh2dGVEqsOB4yo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfLISF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:05:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:51782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbfLISF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 13:05:56 -0500
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F813207FF;
        Mon,  9 Dec 2019 18:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575914755;
        bh=4Tiwn+vOanX6VoEEg918KRKbn6cy8IHjhRhssNZygkE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SFdINz0ynQImL0tk9EB5fi8ytIGSUuDqOOYuA7Rs3thOooTVfWMMD92r6kYTm+141
         9mprDm7Hsz9E04D52FrYRii1lJwQeEZ8XHKT/VTbtNfXkdgv+1t51MwmnqYK1vz15H
         az+0Axd0XwXhTOFq3CEFcupSeMesdBc7Z3Otx3eU=
Received: by mail-lj1-f174.google.com with SMTP id r19so16741793ljg.3;
        Mon, 09 Dec 2019 10:05:55 -0800 (PST)
X-Gm-Message-State: APjAAAVJ/qTUXnInh2PUgN2FXhYK+oLrSWPcZZSzKX+a4+lf/ZOAJrmU
        qTx7PqQ8fgz1pYtat3LW3WGrfmJHqxTuNWTM5oA=
X-Google-Smtp-Source: APXvYqw83XhliSCNEUuMHvHHzMeUdnvH5X4suB7IaLFNC3HKulskeEunmRve/1IH26yOI6m30Pg4bLtY3IujXGJlf0U=
X-Received: by 2002:a2e:9d9a:: with SMTP id c26mr294597ljj.225.1575914753603;
 Mon, 09 Dec 2019 10:05:53 -0800 (PST)
MIME-Version: 1.0
References: <CGME20191206125123eucas1p1c1652484cbccef8d8df37e09affe4e25@eucas1p1.samsung.com>
 <20191206125112.11006-1-m.szyprowski@samsung.com> <CAMuHMdUsRa2QTDw4oM8SGUqfmsGt3-Mc=AnZoPV8RSqehUxyrg@mail.gmail.com>
 <CAOesGMiC+_ouDdFecV-2DvVzmBkeE=JjrwNyTgcr81=cBhhoAw@mail.gmail.com>
In-Reply-To: <CAOesGMiC+_ouDdFecV-2DvVzmBkeE=JjrwNyTgcr81=cBhhoAw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 9 Dec 2019 19:05:42 +0100
X-Gmail-Original-Message-ID: <CAJKOXPccvtbmvZKdR3OJu4ZVkgBmKhqt1jR36DCZvxWcmt46yQ@mail.gmail.com>
Message-ID: <CAJKOXPccvtbmvZKdR3OJu4ZVkgBmKhqt1jR36DCZvxWcmt46yQ@mail.gmail.com>
Subject: Re: [PATCH] arm: multi_v7_config: Restore debugfs support
To:     Olof Johansson <olof@lixom.net>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kusanagi Kouichi <slash@ac.auone-net.jp>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kevin Hilman <khilman@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Dec 2019 at 18:45, Olof Johansson <olof@lixom.net> wrote:
>
> +Kevin, since this seems like something ideally we would see some
> coverage of from Kernel CI at some point.
>
>
> On Mon, Dec 9, 2019 at 1:29 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Hi Marek,
> >
> > On Fri, Dec 6, 2019 at 1:51 PM Marek Szyprowski
> > <m.szyprowski@samsung.com> wrote:
> > > Commit fd7d58f0dbc3 ("ARM: multi_v7_defconfig: renormalize based on recent
> > > additions") removed explicit enable line for CONFIG_DEBUG_FS, because
> > > that feature has been selected by other enabled options: CONFIG_TRACING,
> > > which were enabled by CONFIG_PERF_EVENTS.
> > >
> > > In meantime, commit 0e4a459f56c3 ("tracing: Remove unnecessary DEBUG_FS
> > > dependency") removed the dependency between CONFIG_DEBUG_FS and
> > > CONFIG_TRACING, so CONFIG_DEBUG_FS is no longer enabled in default builds.
> > >
> > > Enable it again explicitly, as debugfs support is essential for various
> > > automated testing tools.
> >
> > ... and for systemd :-(
> >
> > E.g. with Debian 9 nfsroot:
> >
> >     [FAILED] Failed to mount /sys/kernel/debug.
> >     See 'systemctl status sys-kernel-debug.mount' for details.
> >     [DEPEND] Dependency failed for Local File Systems.
> >     ...
> >     You are in emergGive root password for maintenance
> >     (or press Control-D to continue):
> >
> > > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >
> > Thank you!
> >
> > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > This is gonna bite lots of people (and defconfigs)...
>
> Looks like the in-tree affected defconfigs are:
>
> olof@quad:~/work/arm-soc/arch/arm/configs (for-next) $ fgrep -L
> CONFIG_DEBUG_FS $(fgrep -l CONFIG_PERF_EVENTS *)
> aspeed_g4_defconfig
> aspeed_g5_defconfig
> exynos_defconfig

I picked up already Marek's patch for exynos_defconfig.

Best regards,
Krzysztof
