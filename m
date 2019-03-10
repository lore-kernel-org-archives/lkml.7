Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F651C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 01:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA4B20657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 01:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDK00HHl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfCJBby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 20:31:54 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40796 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfCJBby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 20:31:54 -0500
Received: by mail-wr1-f67.google.com with SMTP id t6so1314649wrw.7
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 17:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=MeHX5aKYuZoGS7XrVhdAnETrAHw6BjbFCXO1z3UFY6M=;
        b=VDK00HHl7lo7XMeOKUbR4qxJx61RO36v7KOEZL/Fzzdmbw24XUqVagtyXYDOCQyEUL
         5DXUBXl3hrEVWQBhqEij4+S7huiQquTVpR0W+52ezxqfdX/sJUu3lH9L/NOHqL0VCCWO
         QOjlV+ImrYL1INdIXWxBbxjNSrIfHKPd2AcPmZIy55ET3CecBnDcZPEaIIQ4ZipcFchu
         epMFZ1q+8sMkBsXbNRC0aGGFiXT/KNZS/VrZCnx59788/nbi6CEtz/0IyPCGFcdveaOk
         gT0s/ZrdEvyL1Zq9XXYomJQ1XjfG8nl2xuXDpKJ0yfiKVOEfDCLw9+YkNGQ1OocCywyC
         q33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=MeHX5aKYuZoGS7XrVhdAnETrAHw6BjbFCXO1z3UFY6M=;
        b=YNPu+yftnKnraRKPnDKz0mM+9DGopV2mh0k46JP6l7nh2UJCTgRKoWZ5/Q8XDoMrkY
         AeKMNACVnTvRhxgBVFKc3w7OI+BGXnOYGkHAzcLSdMQG6jr1gXHKQew5zjkXJUHmSAdp
         in9M5b8OgTFxRerr2Q/GnkNKfa0jUTAre0s5FCA4J5Sldm1rY161Tn1qjqwxRM1a3e74
         ORo7bmd3YltDXnxDRJl/uH/Qjma5+UgAltJR1/0IDVhe0HtMbHHv2frTH4nMFb8rdbVg
         EagcfpM1ATNo/eUWYNW7+k6yY530o5dMoy7sXk3gTRfOvLi9qVuHCfd12Fp388Vaogo5
         9Gqg==
X-Gm-Message-State: APjAAAX//BjAjHzm+y5Lf1uYZ1VwpmT5dcjdlqWlzHjiT9cSC/omAeDy
        qjreD6Ut2NFAZZqc2i4cjQY=
X-Google-Smtp-Source: APXvYqzFNd4Gm+G8WSgsC9YWOG1UbwsHpeNO9vTx4DSCjXLhqsecAe26IXmri51qT4iHhqCt8tIm6g==
X-Received: by 2002:adf:ed48:: with SMTP id u8mr7840919wro.185.1552181511528;
        Sat, 09 Mar 2019 17:31:51 -0800 (PST)
Received: from darwi-home-pc (ip-109-42-3-226.web.vodafone.de. [109.42.3.226])
        by smtp.gmail.com with ESMTPSA id u4sm17151586wmb.25.2019.03.09.17.31.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 09 Mar 2019 17:31:50 -0800 (PST)
Date:   Sun, 10 Mar 2019 02:31:42 +0100
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matt Fleming <matt@codeblueprint.co.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: DRM-based Oops viewer
Message-ID: <20190310013142.GA3376@darwi-home-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello DRM/UEFI maintainers,

Several years ago, I wrote a set of patches to dump the kernel
log to disk upon panic -- through BIOS INT 0x13 services. [1]

The overwhelming response was that it's unsafe to do this in a
generic manner. Linus proposed a video-based viewer instead: [2]

    If you want to do the BIOS services thing, do it for video: copy the
    oops to low RAM, return to real mode, re-run the graphics card POST
    routines to initialize text-mode, and use the BIOS to print out the
    oops.  That is WAY less scary than writing to disk.

Of course it's 2019 now though, and it's quite known that
Intel is officially obsoleting the PC/AT BIOS by 2020.. [3]

Researching whether this can be done from UEFI, it was also clear
that UEFI "Runtime Services" do not provide any re-initialization
routines. [4]

The maximum possible that UEFI can provide is a GOP-provided
framebuffer that's ready to use by the OS -- even after the UEFI
boot phase is marked as done through ExitBootServices(). [5]

Of course, once native drivers like i915 or radeon take over,
such a framebuffer is toast... [6]

Thus a possible remaining option, is to display the oops through
"minimal" DRM drivers provided for each HW variant... Since
these special drivers will run only and fully under a panic()
context though, several constraints exist:

  - The code should be fully synchronous (irqs are disabled)
  - It should not allocate any dynamic memory
  - It should make minimal assumptions about HW state
  - It should not chain into any other kernel subsystem
  - It has ample freedom to use delay-based loops and the
    like, the kernel is already dead.

How feasible is it to have such a special "DRM viewoops"
framework + its minimal drivers in the kernel?

The target is to start from i915, since that's what in my
laptop now, and work from there..

Some final notes:

  - The NT kernel has a similar concept, but for storage instead.
    They're used to dump core under kernel panic() situations,
    and are called "Minoport storage drivers". [7]

  - Since Windows 7+, a very fancy Blue Screen of Death is
    displayed, with Unicode and whatnot, implying GPU drivers
    involvement. [8]

  - Mac OS X also does something similar [9]

  - On Linux laptops, the current situation is _really_ bad.

    In any graphical session, type "echo c > /proc/sysrq-trigger";
    the screen will just completely freeze...

    Desired first goal: just print the panic() log

Thanks a lot,

[1] https://lore.kernel.org/lkml/20110125134748.GA10051@laptop
[2] https://lore.kernel.org/lkml/AANLkTinU0KYiCd4p=z+=ojbkeEoT2G+CAYvdRU02KJEn@mail.gmail.com

[3] https://uefi.org/sites/default/files/resources/Brian_Richardson_Intel_Final.pdf

[4] UEFI v2.7 spec, Chapter 8, "Services — Runtime Services"
[5] UEFI v2.7 spec, Section 12.9, "Graphics Output Protocol"
    "The Graphics Output Protocol supports this capability by
     providing the EFI OS loader access to a hardware frame buffer
     and enough information to allow the OS to draw directly to
     the graphics output device."

[6] linux/drivers/gpu/drm/i915/i915_drv.c::i915_kick_out_firmware_fb()
    linux/drivers/gpu/drm/radeon/radeon_drv.c::radeon_pci_probe()

[7] https://docs.microsoft.com/en-us/windows-hardware/drivers/storage/restrictions-on-miniport-drivers-that-manage-the-boot-drive

[8] https://upload.wikimedia.org/wikipedia/commons/archive/5/56/20181019151937%21Bsodwindows10.png
[9] https://upload.wikimedia.org/wikipedia/commons/4/4a/Mac_OS_X_10.2_Kernel_Panic.jpg

--darwi
http://darwish.chasingpointers.com
