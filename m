Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D48C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 03:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1733C20665
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 03:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uId4Cc6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfFYD7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 23:59:32 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44266 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfFYD7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 23:59:31 -0400
Received: by mail-lf1-f66.google.com with SMTP id r15so11525575lfm.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 20:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ne8A2cDgNm1H+XBCR1KqEC3IC1t0ovKTdfCojlwi1ao=;
        b=uId4Cc6JusYfOzWPJIQyRNt9AB/zfpsO9gUP1iUtpXZ89/cmzWc7lekj6i8nwz2M0A
         bkV802nW55R0ILIr7vIXoFFlip7GHgYo6ZNlQjiViz5HWzJq4PxZog4vDFA1POQ0lj5U
         rVtOEFngdrWHOcSm3y9vtMsnD9W9K8rDlzl/2uG40E8Jpm+vLiGMewqeLyEiqafgPcTg
         PjrYoSZ2A1xFy78Ya5+GQqIX4OIY0CpYYasoE9JFGUFlP+chhHyNr3m3dX4/ZCtbhdMT
         bgIGjDX56mZndI1QxLfoigpNapdl4i5vp8Mb4w0hyrViVcNIH+aUilzy1h7kXD8j10WC
         xelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ne8A2cDgNm1H+XBCR1KqEC3IC1t0ovKTdfCojlwi1ao=;
        b=r1OAERXTGcsTQhFb1mKCrxBXZY3UzBNJ+bS41OQKUf9svh3O9JBvdDHFy04X+u3OR1
         7cVW5QbxCOPid63keaegQGtsuKuAZPomiaFMH9IWebP1kVH4nj/8qenA4DJ6syPmiQ92
         mgJskbudUjVKvRbzakHGbjj1pfibHW7e/yK5kHCuFWH9kMVSZ4GChJgqLLbhpvft7qh+
         WbjPxlAxFbd+NizlZCSB/x1IZosLEuxffhNt+sXLyYsOUGyTct3M/M76bVwTPNaUQu6r
         naBJ1eZC/P6ytWnTQEgQ0tUwoz47Peey08dcrQM3PX0ibjvRJwmFERxR2ZmV2BhsCj+y
         4MiA==
X-Gm-Message-State: APjAAAULLrw7JiCW1b0iO69PaUmI8dUeGsNBPu0BzJiyhzGlrP/Hp1+j
        K+c1izRsN2jDd1XEPfhY972enj2doexDjxL2V94=
X-Google-Smtp-Source: APXvYqz66C0jiYfrR4IdvROVdrfJ3yjlWkj559yXVop6JDKW+edQk+UMJIr3y6QOSGaTpOV6lwg0OsD6BCsKmnlg4AU=
X-Received: by 2002:ac2:44c5:: with SMTP id d5mr28686575lfm.134.1561435169542;
 Mon, 24 Jun 2019 20:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190618011124.GA67760@archlinux-epyc>
In-Reply-To: <20190618011124.GA67760@archlinux-epyc>
From:   Dave Airlie <airlied@gmail.com>
Date:   Tue, 25 Jun 2019 13:59:17 +1000
Message-ID: <CAPM=9txaQ43GwOzXSE3prTRLbMt+ip=s_ssmFzWsfsTYdLssaw@mail.gmail.com>
Subject: Re: arm32 build failure after abe882a39a9c ("drm/amd/display: fix
 issue with eDP not detected on driver load")
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Anthony Koo <Anthony.Koo@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jun Lei <Jun.Lei@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

please resolve this ASAP, I cannot pull your tree without this fixed
as it breaks my arm builds here.

an 8 second delay there seems pointless and arbitary, an 8 sec delay
there without a comment, seems like a lack of review.

Dave.

On Tue, 18 Jun 2019 at 11:12, Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Hi all,
>
> After commit abe882a39a9c ("drm/amd/display: fix issue with eDP not
> detected on driver load") in -next, arm32 allyesconfig builds start
> failing at link time:
>
> arm-linux-gnueabi-ld: drivers/gpu/drm/amd/display/dc/core/dc_link.o: in
> function `dc_link_detect':
> dc_link.c:(.text+0x260c): undefined reference to `__bad_udelay'
>
> arm32 only allows a udelay value of up to 2000, see
> arch/arm/include/asm/delay.h for more info.
>
> Please look into this when you have a chance!
> Nathan
