Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF680C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7986520684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfCGKCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:02:24 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:58821 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCGKCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:02:23 -0500
Received: from [167.98.27.226] (helo=[10.35.4.91])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1h1pr2-0002Lj-QP; Thu, 07 Mar 2019 10:02:20 +0000
Subject: Re: [PATCH] drm/i915/ddi: Fix default eDP detection on port A
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20190306200618.17405-1-thomas.preston@codethink.co.uk>
 <874l8fm72f.fsf@intel.com>
From:   Thomas Preston <thomas.preston@codethink.co.uk>
Message-ID: <a1434319-daba-756f-34c7-3ea653a9d2eb@codethink.co.uk>
Date:   Thu, 7 Mar 2019 10:02:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <874l8fm72f.fsf@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Thanks for looking at this.

On 07/03/2019 08:18, Jani Nikula wrote:
> 
> The subject should probably have "drm/i915/bios" or "drm/i915/vbt".
> 

Noted

> On Wed, 06 Mar 2019, Thomas Preston <thomas.preston@codethink.co.uk> wrote:
>> We rely on VBT DDI port info for eDP detection on GEN9 platforms and
>> above. This breaks GEN9 platforms which don't have VBT because port A
>> eDP now defaults to false. Fix this by defaulting to true when VBT is
>> missing.
> 
> Please include more details about the machine that doesn't have VBT. Why
> don't you have VBT?
> 

We have upgraded from an earlier kernel version (an Intel BSP on v4.1)
which did not require VBT and so our BIOS isn't set up correctly. The
BIOS doesn't set ASLS and fails to find ACPI OpRegion:

[    9.368433] [drm:intel_opregion_setup [i915]] graphic opregion physical addr: 0x0
[    9.368490] [drm:intel_opregion_setup [i915]] ACPI OpRegion not supported!

So now our port A is DP instead of eDP. I was hoping a return to "default"
values would remedy this, but I think it's pretty clear now that we should
focus on fixing VBT.

I've found a default VBT in the BSP but not sure how to get it into BIOS.
If you could point me in the right direction here that would be really
useful!

> Personally I think it was a mistake originally to make guesses about the
> outputs in absence of VBT on DDI platforms, because we can never get the
> generic guesses right across all ports and all products. And for the
> record, that was the result of an easy choice to enable developers way
> back when, and forgotten.
> 
> Certainly eDP is more likely than something else on port A. But this
> will break any outlier products without VBT that have a non-eDP output
> on port A. I guess it's a risk we have to take, and handle the fallout
> later.
> 
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> 
>> Fixes: commit a98d9c1d7e9b ("drm/i915/ddi: Rely on VBT DDI port info for eDP detection")
> 
> The Fixes: format does *not* include "commit" text.
> 

I got that from scripts/checkpatch.pl but noted, thanks.

Kind regards,
Tom
