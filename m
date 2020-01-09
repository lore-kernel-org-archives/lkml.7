Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA86C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 05:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E79206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 05:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="huiN23DI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgAIFgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 00:36:35 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:37520 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgAIFge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 00:36:34 -0500
Received: by mail-il1-f194.google.com with SMTP id t8so4723589iln.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 21:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sAHhoFZ0iYCPxYt+rh/Px3+8GOp5DO3V29oeS42DXAM=;
        b=huiN23DIYcPHVv1KglkNFE9hwhktEqKgtWXiSkSJK5LmJDTbV3ps3AzdNKFwbVyRLU
         j6622puSU0EYgKiTBzKbjnldBj6p+SqrQ5IAZDpUi8Mwg/UESiWJuv042WLDon1jb0fb
         eG6eNsVZVo3F6z3ivbqJ842nbgPQHAGVoqVTN2RjedMNDHo32ifXrKlI4YvixtBl7NHU
         2st3DsieNEM8T0b4/zNVLJJWvpkuCbrnmBaRNyYuw+F/Eviulg7v7aA8N2/pQkL2Ybet
         g/9n823BtG2EUxnmgbY6Vzbo5Id0yUpX+Kfy4DlJQVetjj4ZGHYyMnjKI3X+dy7LGIYJ
         LJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sAHhoFZ0iYCPxYt+rh/Px3+8GOp5DO3V29oeS42DXAM=;
        b=JQ5xq110ktuw6PvPQMNBxdTJT26F7SgjiMsSXQ8qqjn0t6UUfGVyN8/TVwgwS+iD5b
         fTnYYfH+yzRKTQlB3+UjkrsbaUyGwHbFo1eO1pXTXw7Ucdb0oxJ+5H1+EvbDp71gCUhx
         7UUN5H5vXud+focbHuX/9i/L5y7QHLG5w5HgND9MfIVulye3x0XSAR1MFn8WMymgy8PD
         v6b0ITMO7h3WKSP4lLq18sc4r9nQtey2gXhI2WfhNDcTjnSsTuA/YcDfp0Wiwl7i5eOM
         VNSCAplLKTOx/ZjU349/JlvQNNQAMunRp/pFyi7O8wydmc7s3SyZ/JkLgYeg4lc/1aDd
         4TdA==
X-Gm-Message-State: APjAAAXtRAYIwmFAsM79gLjYz5VFwu6JKQ01eULp/8813SWZ/VCMH4Uk
        /Xl0DU8E27NQIsWRz8cbXd0j+/H4VqnqmDBsh1Ubqg==
X-Google-Smtp-Source: APXvYqzFc89SrQMcMWBXOOpciBA/UbRyMnmDTvKUFY09Y6diFKdpRQB/cIzzntYu/ZXrqm6Imlk1zgpmom3NbH7Nup8=
X-Received: by 2002:a92:981b:: with SMTP id l27mr7483819ili.118.1578548194052;
 Wed, 08 Jan 2020 21:36:34 -0800 (PST)
MIME-Version: 1.0
References: <CGME20200108115027eucas1p1d3645ba53703780679c662921efbca78@eucas1p1.samsung.com>
 <20200108115007.31095-1-m.szyprowski@samsung.com> <20200108115007.31095-2-m.szyprowski@samsung.com>
In-Reply-To: <20200108115007.31095-2-m.szyprowski@samsung.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Thu, 9 Jan 2020 13:36:22 +0800
Message-ID: <CA+Px+wXkFE5b_8bLz7-c95TvEdqHGD5s-XKRYMVr40xQkqTWxQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: max98090: fix lockdep warning
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     ALSA development <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Dylan Reid <dgreid@google.com>,
        Jimmy Cheng-Yi Chiang <cychiang@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 8, 2020 at 7:50 PM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Fix this by introducing a separate mutex only for serializing the SHDN
> hardware register related operations.

This fix makes less sense to me.  We used dapm_mutex intentionally
because: both DAPM and userspace mixer control would change SHDN bit
at the same time.

> This fixes the following lockdep warning observed on Exynos4412-based
> Odroid U3 board:
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.5.0-rc5-next-20200107 #166 Not tainted
> ------------------------------------------------------
> alsactl/1104 is trying to acquire lock:
> ed0d50f4 (&card->dapm_mutex){+.+.}, at: max98090_shdn_save+0x1c/0x28
>
> but task is already holding lock:
> edb4b49c (&card->controls_rwsem){++++}, at: snd_ctl_ioctl+0xcc/0xbb8
>
> which lock already depends on the new lock.
>
> the existing dependency chain (in reverse order) is:
>
> -> #1 (&card->controls_rwsem){++++}:
>        snd_ctl_add_replace+0x3c/0x84
>        dapm_create_or_share_kcontrol+0x24c/0x2e0
>        snd_soc_dapm_new_widgets+0x308/0x594
>        snd_soc_bind_card+0x80c/0xad4
>        devm_snd_soc_register_card+0x34/0x6c
>        odroid_audio_probe+0x288/0x34c
>        platform_drv_probe+0x6c/0xa4
>        really_probe+0x200/0x490
>        driver_probe_device+0x78/0x1f8
>        bus_for_each_drv+0x74/0xb8
>        __device_attach+0xd4/0x16c
>        bus_probe_device+0x88/0x90
>        deferred_probe_work_func+0x3c/0xd0
>        process_one_work+0x22c/0x7c4
>        worker_thread+0x44/0x524
>        kthread+0x130/0x164
>        ret_from_fork+0x14/0x20
>        0x0
>
> -> #0 (&card->dapm_mutex){+.+.}:
>        lock_acquire+0xe8/0x270
>        __mutex_lock+0x9c/0xb18
>        mutex_lock_nested+0x1c/0x24
>        max98090_shdn_save+0x1c/0x28
>        max98090_put_enum_double+0x20/0x40
>        snd_ctl_ioctl+0x190/0xbb8
>        ksys_ioctl+0x470/0xaf8
>        ret_fast_syscall+0x0/0x28
>        0xbefaa564

As the stack trace suggested: when the card was still registering,
alsactl can see the mixer control and try to change it.

We have a discussion on an older thread
(https://mailman.alsa-project.org/pipermail/alsa-devel/2019-December/160454.html).
It is weird: userspace should not see things (e.g. no controlC0) until
snd_card_register( ).

I would like to spend some time to find the root cause.  It would be a
little challenging though (I have no real runtime to test...).
