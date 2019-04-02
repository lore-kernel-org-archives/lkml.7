Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BD0C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AA120882
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbfDBM0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:26:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:52519 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730585AbfDBM0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:26:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Apr 2019 05:26:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,300,1549958400"; 
   d="scan'208";a="160630016"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.72.79])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2019 05:26:31 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     intel-gfx <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [Intel-gfx] linux-next: Tree for Mar 29 (i915, no ACPI)
In-Reply-To: <a7cf7fb9-c154-77b6-c63d-d71a12a1706b@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190329141831.30fd841f@canb.auug.org.au> <a7cf7fb9-c154-77b6-c63d-d71a12a1706b@infradead.org>
Date:   Tue, 02 Apr 2019 15:29:09 +0300
Message-ID: <87zhp8zj3e.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2019, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 3/28/19 8:18 PM, Stephen Rothwell wrote:
>> Hi all,
>> 
>> Changes since 20190328:
>> 
>> The pidfd tree lost its build failures.
>> 
>
> on x86_64, when # CONFIG_ACPI is not set/enabled:
>
> ld: drivers/gpu/drm/i915/intel_panel.o: in function `intel_backlight_device_register':
> intel_panel.c:(.text+0x2c49): undefined reference to `backlight_device_register'
> ld: drivers/gpu/drm/i915/intel_panel.o: in function `intel_backlight_device_unregister':
> intel_panel.c:(.text+0x2d01): undefined reference to `backlight_device_unregister'
>
>
>
> Full randconfig file is attached.

# CONFIG_ACPI is not set
CONFIG_DRM_I915=y
CONFIG_BACKLIGHT_CLASS_DEVICE=m

drivers/gpu/drm/i915/Kconfig:

config DRM_I915
	# ...
	select BACKLIGHT_CLASS_DEVICE if ACPI

The above pretty much sums it up. It's been reported before, the
earliest I could find was [1].

I've previously suggested patches that would make backlight a dependency
instead of selecting it, in line with [2]. However we can't do that in
i915 alone without recursive dependencies, and changing all backlight
users was met with opposition because "select is convenient".

Maybe I'll look at this one of these days, but don't hold your breath.


BR,
Jani.


[1] http://mid.mail-archive.com/CA+r1ZhhmT4DrWtf6MbRQo5EqXwx+LxCqh15Vsu_d9WpftLhnxw@mail.gmail.com

[2] Documentation/kbuild/kconfig-language.txt "In general use select
    only for non-visible symbols (no prompts anywhere) and for symbols
    with no dependencies."

-- 
Jani Nikula, Intel Open Source Graphics Center
