Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEFEC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 21:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31A42168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 21:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XngETgFC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ScTLBS4j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfJAVU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 17:20:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52228 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfJAVU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 17:20:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D6A9E602CC; Tue,  1 Oct 2019 21:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569964856;
        bh=w+jS0hrugZUADs46Yt3kI36QvmBAu57QkggIGJ3Zzcg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XngETgFCZ50XD0tTyUCFvvDFcbcTOY9PbEvDMs2pEECOi4kY8moKQCvLuyPo38hx6
         BCEcuVXCybcaLjxytJ9hre60UDVZg6FS1Yvsethbd2VujOW74+wrFT5vban2XPbyI+
         MflOMFE7mUqMGm/k4mHKJcqTWrXvMVfe0r1gnhZ0=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 9C946608CE;
        Tue,  1 Oct 2019 21:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569964855;
        bh=w+jS0hrugZUADs46Yt3kI36QvmBAu57QkggIGJ3Zzcg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ScTLBS4jA/VVSV/lMquq7GY7mIfey+8XcH5U6L+lWBFpEy1O+3RsYRoanjpwA8OL7
         c0SET8Uf7eGiB1bsB+6YYs/maf4YL/1PIXIOiozQrzF3LjteIltl34GaMHslVhv7L9
         vfdi7tRDLt/vzoiuMZ0vA8yGNJh3fAMYshB4cKBw=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 01 Oct 2019 14:20:55 -0700
From:   Jeykumar Sankaran <jsanka@codeaurora.org>
To:     =?UTF-8?Q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, seanpaul@chromium.org,
        narmstrong@baylibre.com
Subject: Re: [PATCH] drm: add fb max width/height fields to drm_mode_config
In-Reply-To: <20190930103931.GZ1208@intel.com>
References: <1569634131-13875-1-git-send-email-jsanka@codeaurora.org>
 <1569634131-13875-2-git-send-email-jsanka@codeaurora.org>
 <20190930103931.GZ1208@intel.com>
Message-ID: <f6d3c2b6ad897ce8b2fdcaab44993eed@codeaurora.org>
X-Sender: jsanka@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-30 03:39, Ville Syrjälä wrote:
> On Fri, Sep 27, 2019 at 06:28:51PM -0700, Jeykumar Sankaran wrote:
>> The mode_config max width/height values determine the maximum
>> resolution the pixel reader can handle.
> 
> Not according to the docs I "fixed" a while ago.
> 
>> But the same values are
>> used to restrict the size of the framebuffer creation. Hardware's
>> with scaling blocks can operate on framebuffers larger/smaller than
>> that of the pixel reader resolutions by scaling them down/up before
>> rendering.
>> 
>> This changes adds a separate framebuffer max width/height fields
>> in drm_mode_config to allow vendors to set if they are different
>> than that of the default max resolution values.
> 
> If you're going to change the meaning of the old values you need
> to fix the drivers too.
> 
> Personally I don't see too much point in this since you most likely
> want to validate all the other timings as well, and so likely need
> some kind of mode_valid implementation anyway. Hence to validate
> modes there's not much benefit of having global min/max values.
> 
https://patchwork.kernel.org/patch/10467155/

I believe you are referring to this patch.

I am primarily interested in the scaling scenario mentioned here. MSM
and a few other hardware have scaling block that are used both ways:

1) Where FB limits are larger than the display limits. Scalar blocks are 
used to
    downscale the framebuffers and render within display limits.

In this scenario, with your patch, are you suggesting the drivers 
maintain the
display limits locally and use those values in fill_modes() / 
mode_valid() to filter
out invalid modes explicitly instead of mode_config.max_width/height?

2) Where FB limits are smaller than display limits. Enforced for 
performance reasons on low tier hardware.
It reduces the fetch bandwidth and uses post blending scalar block to 
scale up the pixel stream
to match the display resolution.

Any suggestions on how this topology can be handled with a single set of 
max/min values?

Thanks and Regards,
Jeykumar S.
>> 
>> Vendors setting these fields should fix their mode_set paths too
>> by filtering and validating the modes against the appropriate max
>> fields in their mode_valid() implementations.
>> 
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> Signed-off-by: Jeykumar Sankaran <jsanka@codeaurora.org>
>> ---
>>  drivers/gpu/drm/drm_framebuffer.c | 15 +++++++++++----
>>  include/drm/drm_mode_config.h     |  3 +++
>>  2 files changed, 14 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/drm_framebuffer.c
> b/drivers/gpu/drm/drm_framebuffer.c
>> index 5756431..2083168 100644
>> --- a/drivers/gpu/drm/drm_framebuffer.c
>> +++ b/drivers/gpu/drm/drm_framebuffer.c
>> @@ -300,14 +300,21 @@ struct drm_framebuffer *
>>  		return ERR_PTR(-EINVAL);
>>  	}
>> 
>> -	if ((config->min_width > r->width) || (r->width >
> config->max_width)) {
>> +	if ((config->min_width > r->width) ||
>> +	    (!config->max_fb_width && r->width > config->max_width) ||
>> +	    (config->max_fb_width && r->width > config->max_fb_width)) {
>>  		DRM_DEBUG_KMS("bad framebuffer width %d, should be >= %d
> && <= %d\n",
>> -			  r->width, config->min_width, config->max_width);
>> +			r->width, config->min_width, config->max_fb_width
> ?
>> +			config->max_fb_width : config->max_width);
>>  		return ERR_PTR(-EINVAL);
>>  	}
>> -	if ((config->min_height > r->height) || (r->height >
> config->max_height)) {
>> +
>> +	if ((config->min_height > r->height) ||
>> +	    (!config->max_fb_height && r->height > config->max_height) ||
>> +	    (config->max_fb_height && r->height > config->max_fb_height))
> {
>>  		DRM_DEBUG_KMS("bad framebuffer height %d, should be >= %d
> && <= %d\n",
>> -			  r->height, config->min_height,
> config->max_height);
>> +			r->height, config->min_height,
> config->max_fb_width ?
>> +			config->max_fb_height : config->max_height);
>>  		return ERR_PTR(-EINVAL);
>>  	}
>> 
>> diff --git a/include/drm/drm_mode_config.h
> b/include/drm/drm_mode_config.h
>> index 3bcbe30..c6394ed 100644
>> --- a/include/drm/drm_mode_config.h
>> +++ b/include/drm/drm_mode_config.h
>> @@ -339,6 +339,8 @@ struct drm_mode_config_funcs {
>>   * @min_height: minimum fb pixel height on this device
>>   * @max_width: maximum fb pixel width on this device
>>   * @max_height: maximum fb pixel height on this device
>> + * @max_fb_width: maximum fb buffer width if differs from max_width
>> + * @max_fb_height: maximum fb buffer height if differs from  
>> max_height
>>   * @funcs: core driver provided mode setting functions
>>   * @fb_base: base address of the framebuffer
>>   * @poll_enabled: track polling support for this device
>> @@ -523,6 +525,7 @@ struct drm_mode_config {
>> 
>>  	int min_width, min_height;
>>  	int max_width, max_height;
>> +	int max_fb_width, max_fb_height;
>>  	const struct drm_mode_config_funcs *funcs;
>>  	resource_size_t fb_base;
>> 
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> Forum,
>> a Linux Foundation Collaborative Project
>> 
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> --
> Ville Syrjälä
> Intel

-- 
Jeykumar S
