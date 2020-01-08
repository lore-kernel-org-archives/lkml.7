Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A56C33C9B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8482077B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgAHJkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 04:40:46 -0500
Received: from mga17.intel.com ([192.55.52.151]:42310 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbgAHJkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 04:40:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 01:40:46 -0800
X-IronPort-AV: E=Sophos;i="5.69,409,1571727600"; 
   d="scan'208";a="222891061"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 01:40:43 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Wambui Karuga <wambui.karugax@gmail.com>, airlied@linux.ie,
        daniel@ffwll.ch, rodrigo.vivi@intel.com
Cc:     seanpaul@chromium.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] drm/i915: convert to using the drm_dbg_kms() macro.
In-Reply-To: <157847199686.4725.87481257304852182@jlahtine-desk.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1578409433.git.wambui.karugax@gmail.com> <b79ee0f6efbf8358cbb4f2e163fa6b5bb04db794.1578409433.git.wambui.karugax@gmail.com> <157847199686.4725.87481257304852182@jlahtine-desk.ger.corp.intel.com>
Date:   Wed, 08 Jan 2020 11:40:40 +0200
Message-ID: <8736cqs2uf.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Jan 2020, Joonas Lahtinen <joonas.lahtinen@linux.intel.com> wrote:
> Quoting Wambui Karuga (2020-01-07 17:13:29)
>> Convert the use of the DRM_DEBUG_KMS() logging macro to the new struct
>> drm_device based drm_dbg_kms() logging macro in i915/intel_pch.c.
>> 
>> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
>> ---
>>  drivers/gpu/drm/i915/intel_pch.c | 46 +++++++++++++++++---------------
>>  1 file changed, 24 insertions(+), 22 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/i915/intel_pch.c b/drivers/gpu/drm/i915/intel_pch.c
>> index 43b68b5fc562..4ed60e1f01db 100644
>> --- a/drivers/gpu/drm/i915/intel_pch.c
>> +++ b/drivers/gpu/drm/i915/intel_pch.c
>> @@ -12,90 +12,91 @@ intel_pch_type(const struct drm_i915_private *dev_priv, unsigned short id)
>>  {
>>         switch (id) {
>>         case INTEL_PCH_IBX_DEVICE_ID_TYPE:
>> -               DRM_DEBUG_KMS("Found Ibex Peak PCH\n");
>> +               drm_dbg_kms(&dev_priv->drm, "Found Ibex Peak PCH\n");
>
> Did we at some point consider i915_dbg_kms alias? That would just take
> dev_priv (or i915, as it's called in newer code). It would shorten many
> of the statements.
>
> i915_dbg_kms(dev_priv, ...) or i915_dbg_kms(i915, ...)

I'd rather use the common drm logging macros. I thought about adding
i915 specific ones only if the drm device specific logging macros
weren't going to be merged.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
