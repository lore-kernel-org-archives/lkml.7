Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82055C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C1520675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfCGJjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:39:37 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:40124 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfCGJjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 04:39:36 -0500
Received: by mail-vk1-f195.google.com with SMTP id d84so3547222vke.7;
        Thu, 07 Mar 2019 01:39:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d4+VprPDJEzEhmtGEvPgsb6lf60i3/fCoOU7mG6GuUs=;
        b=BP/IbROSjQxMZnxExlv7pFuealp7Id6NKXGeeCTNn2W9Cn86/AWEFl2v0frW1LUxS6
         GpBlCSJ7E7bbGV70pUbKDt3X49eBKqrNW1RsH0DILPqP1pVTQRpSmocMFNmoUtblVHXX
         jkhf2SJyJDCAQHyN271r0PWlecCa113AYomGc1iBM8rjWG33GWqu0kbBNScuAGurmFvf
         TJ5NtHdy1ke7RduBBzFSF/+lYln/6STdJfWtNjkF8ybF0G0CPH3KqVqNTnrM7dkmbEW/
         g872gIi2RBByvrlco3NipYGYecpr4XFIjIzXi88fdC51shjAHk9Pr8+G/taPC7cbLmK6
         q03w==
X-Gm-Message-State: APjAAAWZ5jIX153bSrYvaCQe/krFWpR2/g66j1nODuXA1diEXu3JnEVJ
        UQD7yZqkddY2NM5/ydIs3oasjI2UlwvVjDgXK3A=
X-Google-Smtp-Source: APXvYqwjcl94kDc1TBKBsE4/NUtEwQ8z3kBlmb20++mFzQXpOtEJ6laSvXtEn3yXJYRO6VTwu+N36nWLpIfd892EawY=
X-Received: by 2002:a1f:be81:: with SMTP id o123mr5834879vkf.83.1551951575281;
 Thu, 07 Mar 2019 01:39:35 -0800 (PST)
MIME-Version: 1.0
References: <20190307051641.GA7012@localhost.localdomain> <871s3jm532.fsf@intel.com>
In-Reply-To: <871s3jm532.fsf@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 7 Mar 2019 10:39:23 +0100
Message-ID: <CAMuHMdU_+4_T4B67Z-Y-wgHQs6o1yuh9H4m82Lym+_Jno5Mgzg@mail.gmail.com>
Subject: Re: Is it possible to reset graphics controller on reboot in a
 framebuffer driver?
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Yifeng Li <tomli@tomli.me>,
        Teddy Wang <teddy.wang@siliconmotion.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jani,

On Thu, Mar 7, 2019 at 10:00 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Thu, 07 Mar 2019, Tom Li <tomli@tomli.me> wrote:
> > As you may have noticed, recently I've been working on a reworked version
> > of sm712fb, and planned to convert it to a DRM/KMS driver. Besides using
> > it on embedded/non-x86 systems, I thought it would be a good idea to support
> > histrocial x86 laptops with this VGA chipset as well, so I've acquired a
> > machine for testing.
> >
> > However, soon I found a nasty problem. The BIOS does not reset the chip
> > on boot! Like most graphics controller of that era, sm712 chipset has a
> > VGA compatible mode and a 2D framebuffer mode. The power-on default is
> > VGA. The BIOS writer just assumed this, and does nothing to reinitialize
> > it. If one uses the framebuffer driver under Linux, once the machine reboots,
> > the entire LCD panel becomes a piece of garbage.
> >
> > AFAIK, the framebuffer driver would be running throughout the kernel's life-
> > cycle, is it really possible to workaround this issue by restoring on VGA
> > state upon reboot?
>
> It's possible to do this using a reboot notifier. I am not sure if there
> are better ways to achieve the same, but there's at least one example of
> using reboot notifiers to achieve the exact same goal.
>
> See drivers/video/fbdev/aty/atyfb_base.c, look for
> register_reboot_notifier().

Or a shutdown handler, which is more device-centric?
(cfr. "[3/4] fbdev: atafb: Fix broken frame buffer after kexec",
 https://patchwork.kernel.org/patch/10814381/).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
