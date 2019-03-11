Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CE4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430902075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="E8EvaWJr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbfCKRrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:47:45 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:55241 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfCKRrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=ur/8dlgtqOnLVlPjSbxLj+4bgqrBZNzB0TkHTqt8S4M=;
        b=E8EvaWJrIyajjnmiaBFfuwezWNIJMc0SVgFsqrPN9ZZYY54jfMcUGGCGQps+I4pukSEwcO6qrjBwaXyoBV8vtmBonW0g1FRuLxT45R+oOKb4senH4MP/z3yY8lJlfeL49SWlArNOrNMW2OAlf7TiL42AnIJAmKFMr8Ig6+zMVritiMgfxeffxdS3HtW788XaM86EENncvqQoFVYaClF+SoxzXhtaqO2gVKs8n6ZaelcJEsMTXjnWZ87W4tFuSGuNPNI053oQeEwtEwjeXdRCiFFYiQr7Eg3JF6Ud77ldTTHQofqSqEF/ymlZeXgg0xqwONRxQrDbr7XR/Dii2FOFpw==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:50957 helo=[192.168.10.177])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1h3P1Z-0000M3-Np; Mon, 11 Mar 2019 18:47:41 +0100
Subject: Re: DRM-based Oops viewer
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matt Fleming <matt@codeblueprint.co.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        dri-devel@lists.freedesktop.org,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20190310013142.GA3376@darwi-home-pc>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <ae91e388-3fcd-19e7-3a83-9279f294ffd5@tronnes.org>
Date:   Mon, 11 Mar 2019 18:47:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190310013142.GA3376@darwi-home-pc>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 10.03.2019 02.31, skrev Ahmed S. Darwish:
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
> 
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

I just sent out a patchset I had lying around that tries to solve this:
https://patchwork.freedesktop.org/series/57849/

Noralf.

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
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
