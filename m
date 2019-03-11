Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856D4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 597D02075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfCKMK4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 08:10:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:6093 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbfCKMKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 08:10:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 05:10:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,467,1544515200"; 
   d="scan'208";a="140971751"
Received: from jlahtine-desk.ger.corp.intel.com (HELO localhost) ([10.252.10.139])
  by orsmga002.jf.intel.com with ESMTP; 11 Mar 2019 05:10:50 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        David Zhou <David1.Zhou@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
From:   Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
In-Reply-To: <20190310013142.GA3376@darwi-home-pc>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20190310013142.GA3376@darwi-home-pc>
Message-ID: <155230624946.5208.5177271872742391668@jlahtine-desk.ger.corp.intel.com>
User-Agent: alot/0.7
Subject: Re: DRM-based Oops viewer
Date:   Mon, 11 Mar 2019 14:10:49 +0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ahmed S. Darwish (2019-03-10 03:31:42)
> Hello DRM/UEFI maintainers,
> 
> Several years ago, I wrote a set of patches to dump the kernel
> log to disk upon panic -- through BIOS INT 0x13 services. [1]
> 
> The overwhelming response was that it's unsafe to do this in a
> generic manner. Linus proposed a video-based viewer instead: [2]
> 
>     If you want to do the BIOS services thing, do it for video: copy the
>     oops to low RAM, return to real mode, re-run the graphics card POST
>     routines to initialize text-mode, and use the BIOS to print out the
>     oops.  That is WAY less scary than writing to disk.
> 
> Of course it's 2019 now though, and it's quite known that
> Intel is officially obsoleting the PC/AT BIOS by 2020.. [3]
> 
> Researching whether this can be done from UEFI, it was also clear
> that UEFI "Runtime Services" do not provide any re-initialization
> routines. [4]
> 
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
> 
>   - The code should be fully synchronous (irqs are disabled)
>   - It should not allocate any dynamic memory
>   - It should make minimal assumptions about HW state
>   - It should not chain into any other kernel subsystem
>   - It has ample freedom to use delay-based loops and the
>     like, the kernel is already dead.
> 
> How feasible is it to have such a special "DRM viewoops"
> framework + its minimal drivers in the kernel?

There is already (efi-)pstore, and I believe it could be already
integrated to distros so that the captured error is displayed on
next boot.

So the user experience difference would only be seeing the error
immediately vs. on boot?

For that gain, it might be bit much work to create failsafe mode
to each driver, but others may disagree.

Regards, Joonas

> The target is to start from i915, since that's what in my
> laptop now, and work from there..
> 
> Some final notes:
> 
>   - The NT kernel has a similar concept, but for storage instead.
>     They're used to dump core under kernel panic() situations,
>     and are called "Minoport storage drivers". [7]
> 
>   - Since Windows 7+, a very fancy Blue Screen of Death is
>     displayed, with Unicode and whatnot, implying GPU drivers
>     involvement. [8]
> 
>   - Mac OS X also does something similar [9]
> 
>   - On Linux laptops, the current situation is _really_ bad.
> 
>     In any graphical session, type "echo c > /proc/sysrq-trigger";
>     the screen will just completely freeze...
> 
>     Desired first goal: just print the panic() log
> 
> Thanks a lot,
> 
> [1] https://lore.kernel.org/lkml/20110125134748.GA10051@laptop
> [2] https://lore.kernel.org/lkml/AANLkTinU0KYiCd4p=z+=ojbkeEoT2G+CAYvdRU02KJEn@mail.gmail.com
> 
> [3] https://uefi.org/sites/default/files/resources/Brian_Richardson_Intel_Final.pdf
> 
> [4] UEFI v2.7 spec, Chapter 8, "Services — Runtime Services"
> [5] UEFI v2.7 spec, Section 12.9, "Graphics Output Protocol"
>     "The Graphics Output Protocol supports this capability by
>      providing the EFI OS loader access to a hardware frame buffer
>      and enough information to allow the OS to draw directly to
>      the graphics output device."
> 
> [6] linux/drivers/gpu/drm/i915/i915_drv.c::i915_kick_out_firmware_fb()
>     linux/drivers/gpu/drm/radeon/radeon_drv.c::radeon_pci_probe()
> 
> [7] https://docs.microsoft.com/en-us/windows-hardware/drivers/storage/restrictions-on-miniport-drivers-that-manage-the-boot-drive
> 
> [8] https://upload.wikimedia.org/wikipedia/commons/archive/5/56/20181019151937%21Bsodwindows10.png
> [9] https://upload.wikimedia.org/wikipedia/commons/4/4a/Mac_OS_X_10.2_Kernel_Panic.jpg
> 
> --darwi
> http://darwish.chasingpointers.com
