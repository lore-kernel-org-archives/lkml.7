Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19373C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6AE420675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfCGI64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 03:58:56 -0500
Received: from mga14.intel.com ([192.55.52.115]:16908 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbfCGI64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 03:58:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2019 00:58:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,451,1544515200"; 
   d="scan'208";a="152833159"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.172])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2019 00:58:53 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Tom Li <tomli@tomli.me>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Yifeng Li <tomli@tomli.me>,
        Teddy Wang <teddy.wang@siliconmotion.com>
Subject: Re: Is it possible to reset graphics controller on reboot in a framebuffer driver?
In-Reply-To: <20190307051641.GA7012@localhost.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190307051641.GA7012@localhost.localdomain>
Date:   Thu, 07 Mar 2019 11:00:49 +0200
Message-ID: <871s3jm532.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Mar 2019, Tom Li <tomli@tomli.me> wrote:
> Hi all.
>
> As you may have noticed, recently I've been working on a reworked version
> of sm712fb, and planned to convert it to a DRM/KMS driver. Besides using
> it on embedded/non-x86 systems, I thought it would be a good idea to support
> histrocial x86 laptops with this VGA chipset as well, so I've acquired a
> machine for testing.
>
> However, soon I found a nasty problem. The BIOS does not reset the chip
> on boot! Like most graphics controller of that era, sm712 chipset has a
> VGA compatible mode and a 2D framebuffer mode. The power-on default is
> VGA. The BIOS writer just assumed this, and does nothing to reinitialize
> it. If one uses the framebuffer driver under Linux, once the machine reboots,
> the entire LCD panel becomes a piece of garbage.
>
> AFAIK, the framebuffer driver would be running throughout the kernel's life-
> cycle, is it really possible to workaround this issue by restoring on VGA
> state upon reboot?

It's possible to do this using a reboot notifier. I am not sure if there
are better ways to achieve the same, but there's at least one example of
using reboot notifiers to achieve the exact same goal.

See drivers/video/fbdev/aty/atyfb_base.c, look for
register_reboot_notifier().


HTH,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
