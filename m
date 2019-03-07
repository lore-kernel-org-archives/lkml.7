Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C25C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CD620652
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfCGQDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:03:49 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:39679 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfCGQDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 11:03:49 -0500
Received: from [167.98.27.226] (helo=[10.35.6.196])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1h1vUo-0003NK-0K; Thu, 07 Mar 2019 16:03:46 +0000
Subject: Re: [PATCH] drm/i915/ddi: Fix default eDP detection on port A
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20190306200618.17405-1-thomas.preston@codethink.co.uk>
 <874l8fm72f.fsf@intel.com>
 <a1434319-daba-756f-34c7-3ea653a9d2eb@codethink.co.uk>
 <87va0vkm6e.fsf@intel.com>
From:   Thomas Preston <thomas.preston@codethink.co.uk>
Message-ID: <6f2fc1d7-544c-da3b-d374-633b6bf8a9da@codethink.co.uk>
Date:   Thu, 7 Mar 2019 16:03:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <87va0vkm6e.fsf@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2019 10:34, Jani Nikula wrote:
> There are dangers with default VBTs too. They might contain incorrect
> information about the specific board you have. You'll also have to set
> up the opregion, not just VBT.
> 
> I'm afraid I can't help you there. You already know where to look to see
> how the kernel side expects things to work.
> 
> For testing, the i915.vbt_firmware module parameter is helpful, so you
> don't need to change your BIOS to change the VBT.

Just to clarify, I couldn't get i915.vbt_firmware working with a broken
ACPI OpRegion as intel_opregion_setup() bails out before it reaches
intel_load_vbt_firmware(). I worked around it by moving the fw load but
this isn't a long-term solution.

I need to fix ACPI OpRegion / my BIOS before any of this will work.

diff --git a/drivers/gpu/drm/i915/intel_opregion.c b/drivers/gpu/drm/i915/intel_opregion.c
index 1d946240e55f..128a285a5337 100644
--- a/drivers/gpu/drm/i915/intel_opregion.c
+++ b/drivers/gpu/drm/i915/intel_opregion.c
@@ -971,6 +971,9 @@ int intel_opregion_setup(struct drm_i915_private *dev_priv)
         BUILD_BUG_ON(sizeof(struct opregion_asle) != 0x100);
         BUILD_BUG_ON(sizeof(struct opregion_asle_ext) != 0x400);

+       if (intel_load_vbt_firmware(dev_priv) == 0)
+               goto out;
+
         pci_read_config_dword(pdev, ASLS, &asls);
         DRM_DEBUG_DRIVER("graphic opregion physical addr: 0x%x\n", asls);
         if (asls == 0) {
@@ -1016,9 +1019,6 @@ int intel_opregion_setup(struct drm_i915_private *dev_priv)
         if (mboxes & MBOX_ASLE_EXT)
                 DRM_DEBUG_DRIVER("ASLE extension supported\n");

-       if (intel_load_vbt_firmware(dev_priv) == 0)
-               goto out;
-
         if (dmi_check_system(intel_no_opregion_vbt))
                 goto out;



