Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B81C2D0C2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 15:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E135206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 15:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aelIqqsQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfLaPhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 10:37:06 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36658 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfLaPhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 10:37:06 -0500
Received: by mail-pg1-f194.google.com with SMTP id k3so19671373pgc.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Dec 2019 07:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0zI0gfX4kyMk5ybZJW1MIBaMfCVRpcieMViMTdRuHHU=;
        b=aelIqqsQqz8e1Oh73A+P3E1dzERA7atsAp3gmXpIRWY6atThTgc5is5iVbjffudSYf
         kVT4yFnhWcrmbBk/cU2I43bz6/+55DE5sF5opHklS8kiiysK74GdYqGLGlaMzxTQ4FeR
         B/4W4GSEUYCkTGoUMeIQPppHYhe8d/sxCstIaGLziFCfVWxk8deLawp7dnlIuDCUdUCD
         zeq23U8KJxHRGMyFHYd+b5fDnFDbknzrVJwoCB1UabrZBGNmu/VtJzAeUT0qCpdHhAVY
         plKoTi4xbjMfxHnZ5IGYedegyGvlOcQCUm/gUbABffTy36v6j0Z8x7taXgcqM98bN2iS
         mEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0zI0gfX4kyMk5ybZJW1MIBaMfCVRpcieMViMTdRuHHU=;
        b=k0/DttE9r3iUqGDzbe7uCEdFaqvFBc4Y6lC0cC+p9upe4z02J9ZVrx4bOZucoi7ETD
         6Q1vDkmiDa7cRwNkfV194Twz0bAzY9RIWmQyzXzA0p0kmyqHoA57nV21Jljwy5VIKolc
         vENtu5zRk24ug1GAhT7XRNFxXhuzgD/LRdMIZ9oKvONy/umECp3LpkjoA6UWHV6xVmnc
         +p3ZYSWf5LMDShfmkUroGT0gbgmnKCc17K3tK/E1tss4jhNo/AEhgT2Y028eDqzfMyK5
         R0UHgqIhGZwxdAULXY6rylOZZ/lC98rknYysTHH5p2U5DqqmIidZeCjrQA2z/A9tlVG0
         Iz1w==
X-Gm-Message-State: APjAAAWaTqN2bv1/DNflCvgwTfZQM3HskS8QjnDIuZn1QGK1CwXSQdEU
        9VL+LnVUnGurIfJ+jd105ZQ=
X-Google-Smtp-Source: APXvYqz1nAJruoselefeTuSLlMA9yBQydP7F654u4Ya6LKTk2yaP1NtBBWaGzoj4dwB9dWVthE3aBA==
X-Received: by 2002:a63:483:: with SMTP id 125mr77701373pge.217.1577806625492;
        Tue, 31 Dec 2019 07:37:05 -0800 (PST)
Received: from localhost ([49.207.54.121])
        by smtp.gmail.com with ESMTPSA id m101sm4068910pje.13.2019.12.31.07.37.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Dec 2019 07:37:04 -0800 (PST)
Date:   Tue, 31 Dec 2019 21:07:03 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>
Subject: Re: [RFC PATCH 2/2] ARM: !MMU: v7-M: preemption support
Message-ID: <20191231153703.GA15302@afzalpc>
References: <cover.1577705829.git.afzal.mohd.ma@gmail.com>
 <c24f8d1c8e813eef62d642b5e620e0062c52c9a8.1577705829.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c24f8d1c8e813eef62d642b5e620e0062c52c9a8.1577705829.git.afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 30, 2019 at 05:25:27PM +0530, afzal mohammed wrote:

> A. Before this change,
> 
> A.1
> ~ # cat /dev/mymisc
> [   28.099225] mymisc_open
> [   28.101625] mymisc_read: enter
> 
> command prompt is not usable (expected), interrupts do happen during
> this time.

> B. After this change,
> 
> B.1
> ~ # cat /dev/mymisc
> [   27.374821] mymisc_open
> [   27.377349] mymisc_read: enter
> 
> though user will not get control back (as expected as it is fg process),
> entering on prompt causes new line, doesn't know what to make out of
> this behaviour, this doesn't happen in the A.1 case. Interrupts happen
> here as well.

Behaviour B.1 (which is how most of the system behaves) seems due to
serial driver's threaded interrupt handler being able to preempt 'cat'
process, this can't happen in the case of A.1 as preemption doesn't
work.

Also it seems that preemption does happen by tracking __schedule() at
runtime, but issue mentioned in B.2 (below) remains.

So it seems preemption is happening, but is very fragile.

Regards
afzal

> B.2
> ~ # cat /dev/mymisc &
> [1] 41 cat /dev/mymisc
> ~ # [   44.836417] mymisc_open
> [   44.838814] mymisc_read: enter
> 
> though prompt is available under the control of user, upon typing
> anything on the prompt (typed character doesn't get echoed), it crashes
> as follows,
> 
> [   44.838814] mymisc_read: enter
> [   51.710314]
> [   51.710314] Unhandled exception: IPSR = 00000006 LR = fffffffd
> [   51.717576] CPU: 0 PID: 37 Comm: sh Not tainted 5.5.0-rc4-00004-g2328d01dbd85 #105
> [   51.725078] Hardware name: STM32 (Device Tree Support)
> [   51.730206] PC is at 0x90195958
> [   51.733329] LR is at 0x901c4df3
> [   51.736471] pc : [<90195958>]    lr : [<901c4df3>]    psr: 21000000
> [   51.742713] sp : 901e5a58  ip : 00000000  fp : 901d89fc
> [   51.747911] r10: 00000000  r9 : 00000000  r8 : 00000001
> [   51.753143] r7 : 000000a8  r6 : 901e5a58  r5 : 901e5b08  r4 : ffffffff
> [   51.759643] r3 : 000000a8  r2 : ffffffff  r1 : 00000001  r0 : 00000001
> [   51.766122] xPSR: 21000000
> [   51.768866] CPU: 0 PID: 37 Comm: sh Not tainted 5.5.0-rc4-00004-g2328d01dbd85 #105
> [   51.776369] Hardware name: STM32 (Device Tree Support)
> [   51.781594] [<0800c0c9>] (unwind_backtrace) from [<0800b25b>] (show_stack+0xb/0xc)
> [   51.789166] [<0800b25b>] (show_stack) from [<0800b9eb>] (__invalid_entry+0x4b/0x4c)
> 
> It is a Usage Fault happening while in thread(user) mode. PC & LR in the
> dump is strange in the sense that they do not point to text section.
