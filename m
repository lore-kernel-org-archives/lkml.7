Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A8FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5A4206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="kTKLVOKl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfCKNtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:49:47 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34802 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbfCKNtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:49:47 -0400
Received: by mail-ed1-f67.google.com with SMTP id a16so4083892edn.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 06:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=yc5GnNF3UJCA+PD429Rx7cq3bcSvf2HLqP1f6pGQYJY=;
        b=kTKLVOKl1gcKioGLtr5+fwI/MlpP0NXmnpGrQuJjjfTfV+H6Jim4QXYIht3To5/fAe
         OaNpsDhS0jnzMAo2x5mw6HWGjyVdDnSrl4SsRkor7GaQNPTAXHwqLcW4fJKTm+VjEwGv
         9sXB60GSDET+JGZMzg5Sr1XWzj4jGAf+Vd4kA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=yc5GnNF3UJCA+PD429Rx7cq3bcSvf2HLqP1f6pGQYJY=;
        b=UlXj3nIN6H7gUKXDaYRt2CFF/dDRB65ZFM7Nc/Hjh5BwcByYd+497+IxMDeAA7srDk
         P0nn7ULb4FMlnTgpkfmq1JnBuffRXjFsmeUYwyOGvRSCbWvob5sA8pKkoOF7AtHGr2Xm
         /AOhdYRRIb1cIweZ/AZcnaQWYjsMiOfpDV3Zm3/hIf+uYdUCCCGlyyvSTTo0WDVwWkHN
         xyWv/s7IMl6Xauyio1E9v/GMCOAMqdV7XGx/bbHCeHqhBqR3iRngoMT6fbjW6y/hQdov
         1v7R2Z+5PWFOHl+TEzbIdGdBMKgNaoTNb4kbMVQ6XFGuFpxQVIXsFbOhVAQ5KgbjtK9r
         d0Ow==
X-Gm-Message-State: APjAAAUOoLEB1N9rredaRuRq0nZQsqKTjLyo0DNz7l7R/loYOUNN5er7
        aI+w09VKR/fm03IN1M+dggW7Vw==
X-Google-Smtp-Source: APXvYqxgXjKBQ8umv4aTp8Hq6+yDhCPksM59heRRmBskYjYoOvrQ2S2nOOraoZTlrG86Ll+k8FqRzg==
X-Received: by 2002:a05:6402:7d6:: with SMTP id u22mr2610429edy.130.1552312184803;
        Mon, 11 Mar 2019 06:49:44 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id f46sm4695918edf.10.2019.03.11.06.49.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 06:49:44 -0700 (PDT)
Date:   Mon, 11 Mar 2019 14:49:41 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
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
Message-ID: <20190311134941.GH2665@phenom.ffwll.local>
Mail-Followup-To: Jani Nikula <jani.nikula@linux.intel.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        David Airlie <airlied@linux.ie>,
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
References: <20190310013142.GA3376@darwi-home-pc>
 <87mum1lr3g.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mum1lr3g.fsf@intel.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
> Do you want to store the dmesg or oops (like your original series
> suggests) or do you want to display the oops? Do you want the facility
> to be functioning at all times, or only when specifically requested in
> advance by the user? If you want to display the oops, do you want it to
> also work when the display is disabled at the time of the oops? What if
> the display is at attached to a port on a dock?
> 
> There's at least kdump, ramoops, and netconsole that can be used to
> achieve some of what you want. How do they fall short for you?

Assuming the use-case is to get an oops to display on a kms driver, we do
have a fairly comprehensive plan of what that's should look like:

https://dri.freedesktop.org/docs/drm/gpu/todo.html#make-panic-handling-work

This takes into account all the failed previous attempts at trying to get
an oops to display. It's conceptually a match with your viewoops framework
I think.
-Daniel
> 
> BR,
> Jani.
> 
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

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
