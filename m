Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CBAC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 08:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84975206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 08:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfCJIoE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 04:44:04 -0400
Received: from mondschein.lichtvoll.de ([194.150.191.11]:53289 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfCJIoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 04:44:03 -0400
Authentication-Results: auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id E1DA147ABC7;
        Sun, 10 Mar 2019 09:44:00 +0100 (CET)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: DRM-based Oops viewer
Date:   Sun, 10 Mar 2019 09:44:00 +0100
Message-ID: <2856397.VzoYIXtIs6@merkaba>
In-Reply-To: <20190310013142.GA3376@darwi-home-pc>
References: <20190310013142.GA3376@darwi-home-pc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hell Ahmed.

Ahmed S. Darwish - 10.03.19, 02:31:
> Hello DRM/UEFI maintainers,
> 
> Several years ago, I wrote a set of patches to dump the kernel
> log to disk upon panic -- through BIOS INT 0x13 services. [1]
> 
> The overwhelming response was that it's unsafe to do this in a
> generic manner. Linus proposed a video-based viewer instead: [2]
[…]
> Of course it's 2019 now though, and it's quite known that
> Intel is officially obsoleting the PC/AT BIOS by 2020.. [3]
[…]
> The maximum possible that UEFI can provide is a GOP-provided
> framebuffer that's ready to use by the OS -- even after the UEFI
> boot phase is marked as done through ExitBootServices(). [5]
> 
> Of course, once native drivers like i915 or radeon take over,
> such a framebuffer is toast... [6]
> 
> Thus a possible remaining option, is to display the oops through
> "minimal" DRM drivers provided for each HW variant... Since
> these special drivers will run only and fully under a panic()
> context though, several constraints exist:

Thank you for your idea and willingness to work on something like this.

As a user I'd very much favor a solution that could not only work with 
UEFI but with other firmwares. I still dream to be able to buy a laptop 
with up to date hardware and with Coreboot/Libreboot at some time.

While this would not solve all "I just freeze" kind of crashes, it may 
at least give some information about some of them. When testing rc 
kernels I often enough faced "I just freeze" crashes that just happened 
*sometimes*. On a machine that I also use for production work I find it  
infeasible to debug it as bisecting could take a long, long time. And 
well the machine could just crash every moment… even during doing 
important work with it.

In my ideal world an operating system would never ever crash or hang 
without telling why. Well it would not crash or hang at all… but there 
you go. Maybe some time with a widely usable micro kernel based OS that 
can restart device drivers in a broken state – at least almost. No 
discussion of that micro kernel topic required here. :)

Thanks,
-- 
Martin


