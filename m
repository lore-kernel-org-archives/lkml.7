Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416ACC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A887E20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfCGKck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:32:40 -0500
Received: from mga05.intel.com ([192.55.52.43]:26160 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbfCGKck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:32:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2019 02:32:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,451,1544515200"; 
   d="scan'208";a="152852611"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.172])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2019 02:32:37 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Thomas Preston <thomas.preston@codethink.co.uk>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/ddi: Fix default eDP detection on port A
In-Reply-To: <a1434319-daba-756f-34c7-3ea653a9d2eb@codethink.co.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190306200618.17405-1-thomas.preston@codethink.co.uk> <874l8fm72f.fsf@intel.com> <a1434319-daba-756f-34c7-3ea653a9d2eb@codethink.co.uk>
Date:   Thu, 07 Mar 2019 12:34:33 +0200
Message-ID: <87va0vkm6e.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Mar 2019, Thomas Preston <thomas.preston@codethink.co.uk> wrote:
> Hi,
> Thanks for looking at this.
>
> On 07/03/2019 08:18, Jani Nikula wrote:
>> 
>> The subject should probably have "drm/i915/bios" or "drm/i915/vbt".
>> 
>
> Noted
>
>> On Wed, 06 Mar 2019, Thomas Preston <thomas.preston@codethink.co.uk> wrote:
>>> We rely on VBT DDI port info for eDP detection on GEN9 platforms and
>>> above. This breaks GEN9 platforms which don't have VBT because port A
>>> eDP now defaults to false. Fix this by defaulting to true when VBT is
>>> missing.
>> 
>> Please include more details about the machine that doesn't have VBT. Why
>> don't you have VBT?
>> 
>
> We have upgraded from an earlier kernel version (an Intel BSP on v4.1)
> which did not require VBT and so our BIOS isn't set up correctly. The
> BIOS doesn't set ASLS and fails to find ACPI OpRegion:
>
> [    9.368433] [drm:intel_opregion_setup [i915]] graphic opregion physical addr: 0x0
> [    9.368490] [drm:intel_opregion_setup [i915]] ACPI OpRegion not supported!
>
> So now our port A is DP instead of eDP. I was hoping a return to "default"
> values would remedy this, but I think it's pretty clear now that we should
> focus on fixing VBT.

In the long run you'll have better control of what your specific product
does by using a VBT. However, I think we'll probably have to take the
patch anyway.

> I've found a default VBT in the BSP but not sure how to get it into BIOS.
> If you could point me in the right direction here that would be really
> useful!

There are dangers with default VBTs too. They might contain incorrect
information about the specific board you have. You'll also have to set
up the opregion, not just VBT.

I'm afraid I can't help you there. You already know where to look to see
how the kernel side expects things to work.

For testing, the i915.vbt_firmware module parameter is helpful, so you
don't need to change your BIOS to change the VBT.

BR,
Jani.


>
>> Personally I think it was a mistake originally to make guesses about the
>> outputs in absence of VBT on DDI platforms, because we can never get the
>> generic guesses right across all ports and all products. And for the
>> record, that was the result of an easy choice to enable developers way
>> back when, and forgotten.
>> 
>> Certainly eDP is more likely than something else on port A. But this
>> will break any outlier products without VBT that have a non-eDP output
>> on port A. I guess it's a risk we have to take, and handle the fallout
>> later.
>> 
>> Acked-by: Jani Nikula <jani.nikula@intel.com>
>> 
>>> Fixes: commit a98d9c1d7e9b ("drm/i915/ddi: Rely on VBT DDI port info for eDP detection")
>> 
>> The Fixes: format does *not* include "commit" text.
>> 
>
> I got that from scripts/checkpatch.pl but noted, thanks.
>
> Kind regards,
> Tom

-- 
Jani Nikula, Intel Open Source Graphics Center
