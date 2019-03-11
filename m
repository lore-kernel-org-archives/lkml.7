Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54D2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D2C214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8EaIHuB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbfCKWMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:12:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38662 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfCKWMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 18:12:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id a188so646905wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 15:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pRnJWqSbBQ1Y811fmLYGqUT7ML72ma6nsBrkBaOrpQg=;
        b=a8EaIHuBKGYSFLVypjdjAD99DjrC3MY71qU2+W21WwFrt7estOSG13kwDWMZHozUwt
         GTtBOQ+nCQBmWZ3p7mzNBYe0zIFxShJFJY/xlAIWl3BdZQ81cSJcwiLB4xubVoseQ2Qd
         C+QklV14035kJ75GZNRBnEi3iVzuUOBbt9zpM7cajefnD6Hc82aIDnjpQ+xgJFkH+Fdf
         VF79VGmsDQuvP1dtLmyhB8QMog0yp+/z0jGlj4eGvEoAARMNxQKMY/ufE1baZ9gUcSb7
         9/zULnZgLXMmiVfvL8UI46vQ6TwWdtWTST5ulXK3Q1kfdSa8Shu20wPnsmjooDlz9C4c
         r0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pRnJWqSbBQ1Y811fmLYGqUT7ML72ma6nsBrkBaOrpQg=;
        b=K1aX5WtiSIB0JxLiSPDc2BOm9HjWE1AT+1gkA3SlQUSgmihlCAf+ITrRoe/K0cqIDU
         ybXhDboCY2SejAwz+tqnY1Y+ET16P6EibfIOPQ7l7gFjn5vztA56TLORVsO8do2Ahxgs
         SwlWyflO1/SARnxaOPM/9pwMQY5gHJr6zCIobfvN/PzcDNjp/rfB/SswJkxBnEjRuis4
         LXueqLrrGz0h3Sh741ra8zF/N0WClWvajTHxcz8vGJnbUOBL13W8BLFfLSuITXXmhFoU
         lMwvYx7f2ZtKZfRlWpJpXZgyw+EHaqpBHuyWe3bMqL5j2Z8BwiYIHx3CvDlLN4pL6N3+
         YlSg==
X-Gm-Message-State: APjAAAX5p4InFGpx4cIn5j8ONYvwF1iWnKIye9zJGBTo29UWaUMFRcnq
        Xx5PQ6y6jmhxiMZShHuJDQk=
X-Google-Smtp-Source: APXvYqwV4Yh2rYE5zQ/Gtbu4hw1X/+Yeezjjr8+M00jP3gdMFyjZmTnNSeEsxAGlq3wbA5Pk+QmFVg==
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr236339wma.101.1552342354494;
        Mon, 11 Mar 2019 15:12:34 -0700 (PDT)
Received: from darwi-home-pc (ip-109-42-1-116.web.vodafone.de. [109.42.1.116])
        by smtp.gmail.com with ESMTPSA id n130sm332334wma.48.2019.03.11.15.12.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 11 Mar 2019 15:12:33 -0700 (PDT)
Date:   Mon, 11 Mar 2019 23:12:23 +0100
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: DRM-based Oops viewer
Message-ID: <20190311221223.GA3344@darwi-home-pc>
References: <20190310013142.GA3376@darwi-home-pc>
 <87mum1lr3g.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mum1lr3g.fsf@intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jani,

On Mon, Mar 11, 2019 at 11:04:19AM +0200, Jani Nikula wrote:
> On Sun, 10 Mar 2019, "Ahmed S. Darwish" <darwish.07@gmail.com> wrote:
> > Hello DRM/UEFI maintainers,
> >
> > Several years ago, I wrote a set of patches to dump the kernel
> > log to disk upon panic -- through BIOS INT 0x13 services. [1]
> >
> > The overwhelming response was that it's unsafe to do this in a
> > generic manner. Linus proposed a video-based viewer instead: [2]
> >
> >     If you want to do the BIOS services thing, do it for video: copy the
> >     oops to low RAM, return to real mode, re-run the graphics card POST
> >     routines to initialize text-mode, and use the BIOS to print out the
> >     oops.  That is WAY less scary than writing to disk.
> >
> > Of course it's 2019 now though, and it's quite known that
> > Intel is officially obsoleting the PC/AT BIOS by 2020.. [3]
> >
> > Researching whether this can be done from UEFI, it was also clear
> > that UEFI "Runtime Services" do not provide any re-initialization
> > routines. [4]
> >
> > The maximum possible that UEFI can provide is a GOP-provided
> > framebuffer that's ready to use by the OS -- even after the UEFI
> > boot phase is marked as done through ExitBootServices(). [5]
> >
> > Of course, once native drivers like i915 or radeon take over,
> > such a framebuffer is toast... [6]
> >
> > Thus a possible remaining option, is to display the oops through
> > "minimal" DRM drivers provided for each HW variant... Since
> > these special drivers will run only and fully under a panic()
> > context though, several constraints exist:
> >
> >   - The code should be fully synchronous (irqs are disabled)
> >   - It should not allocate any dynamic memory
> >   - It should make minimal assumptions about HW state
> >   - It should not chain into any other kernel subsystem
> >   - It has ample freedom to use delay-based loops and the
> >     like, the kernel is already dead.
> >
> > How feasible is it to have such a special "DRM viewoops"
> > framework + its minimal drivers in the kernel?
>
> Please first better define what you want to achieve.
>

Oh I thought this was clear..

What I want to achieve is:

  - for normal day-to-day x86 laptops users
  - properly inform the user when a kernel panic happens during
    a running graphical session (e.g. wayland/gnome/kde/...).

The current situation is dismal: the screen _just freezes_, and
users are left wondering what the heck has really happened to
their system (?)

Some out-of-the-box notification mechanism, for everyday distros
like Fedora and Ubuntu that can be enabled by default, would
improve the situation considerably..

Yes, there are many _developer_ features that can mitigate the
issue somewhat, but they're not really useful for everyday "normal"
usage:

  - netconsole is definitely not an option. It implies a lab
    setting where two machines are always connected through a
    network.

  - ramoops is _completely irrelevant_ for normal users. It's
    mostly for embedded systems and the like; requires intimate
    knowledge of the hardware by the user translated into DT
    bindings or special platform_data struct..

  - kexec/kdump partially solves the save-to-disk problem, but
    doesn't solve the user notification part..

    Maybe a new "kexec/kview" solution can be useful, but
    distributions don't enable kexec/k* solutions _by default_.

    Maybe they fear the extra burden of maintaining two kernels
    at the same time? or the requirement of reserving memory
    for the crashkernel beforehand?

    Linux should not just "freeze the screen" upon panic, even
    if a crashkernel is not present .. _some_ sane default
    built-in user notification mechanism should be there.

  - efivars are neat, they partially solve the save-to-disk
    problem, but does not solve the user notification problem.

    Moreover, they always carry the risk of bricking laptops..

> Do you want to store the dmesg or oops (like your original series
> suggests) or do you want to display the oops?

The original save-to-disk series was only shown for context.
This is a pure display solution; no disk is invovled at all.

> Do you want the facility to be functioning at all times, or only
> when specifically requested in advance by the user?

At all times, as a basic "sane default" for laptop-oriented
distributions to enable (think ubuntu, fedora, mint, etc.)

> If you want to display the oops, do you want it to
> also work when the display is disabled at the time of the oops?

If the screen is disabled, then this is definitely out of scope.

This only deals with classical laptop usage scenarios, where we
want to notify the user that something went wrong at the kernel
level.

> the display is at attached to a port on a dock?
>

This is a much bigger scope that's not important at this stage.

If I'm attaching my laptop to a projector and the kernel panics,
notifying the user only in the main laptop screen should be
enough.

> There's at least kdump, ramoops, and netconsole that can be used to
> achieve some of what you want. How do they fall short for you?
>

Hopfully my answers above provided more insight of why these
solutions fall short..

> BR,
> Jani.
>

Thanks!
--darwi

>
> >
> > The target is to start from i915, since that's what in my
> > laptop now, and work from there..
> >
> > Some final notes:
> >
> >   - The NT kernel has a similar concept, but for storage instead.
> >     They're used to dump core under kernel panic() situations,
> >     and are called "Minoport storage drivers". [7]
> >
> >   - Since Windows 7+, a very fancy Blue Screen of Death is
> >     displayed, with Unicode and whatnot, implying GPU drivers
> >     involvement. [8]
> >
> >   - Mac OS X also does something similar [9]
> >
> >   - On Linux laptops, the current situation is _really_ bad.
> >
> >     In any graphical session, type "echo c > /proc/sysrq-trigger";
> >     the screen will just completely freeze...
> >
> >     Desired first goal: just print the panic() log
> >
> > Thanks a lot,
> >
> > [1] https://lore.kernel.org/lkml/20110125134748.GA10051@laptop
> > [2] https://lore.kernel.org/lkml/AANLkTinU0KYiCd4p=z+=ojbkeEoT2G+CAYvdRU02KJEn@mail.gmail.com
> >
> > [3] https://uefi.org/sites/default/files/resources/Brian_Richardson_Intel_Final.pdf
> >
> > [4] UEFI v2.7 spec, Chapter 8, "Services — Runtime Services"
> > [5] UEFI v2.7 spec, Section 12.9, "Graphics Output Protocol"
> >     "The Graphics Output Protocol supports this capability by
> >      providing the EFI OS loader access to a hardware frame buffer
> >      and enough information to allow the OS to draw directly to
> >      the graphics output device."
> >
> > [6] linux/drivers/gpu/drm/i915/i915_drv.c::i915_kick_out_firmware_fb()
> >     linux/drivers/gpu/drm/radeon/radeon_drv.c::radeon_pci_probe()
> >
> > [7] https://docs.microsoft.com/en-us/windows-hardware/drivers/storage/restrictions-on-miniport-drivers-that-manage-the-boot-drive
> >
> > [8] https://upload.wikimedia.org/wikipedia/commons/archive/5/56/20181019151937%21Bsodwindows10.png
> > [9] https://upload.wikimedia.org/wikipedia/commons/4/4a/Mac_OS_X_10.2_Kernel_Panic.jpg
> >
> > --darwi
> > http://darwish.chasingpointers.com
>
> --
> Jani Nikula, Intel Open Source Graphics Center
