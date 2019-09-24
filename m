Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47889C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 17:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113C920673
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 17:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QKUGJD6k";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VHb6ytHq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439506AbfIXR2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 13:28:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34902 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729883AbfIXR2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 13:28:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A685C6137D; Tue, 24 Sep 2019 17:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569346129;
        bh=m5nRpCCGsAeJVX0FTjg6i2xbJTPmx0BJPve6hoE/kIo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QKUGJD6khFRs5aD7ZiXRqG6r6wNlfHC0AyTatEZ2EqNtvpGWeeTFP9HyZBxk5qpQN
         eRkuETyaNkqJTa5msPsutmeM9Y7o88VVCAOktjhyJHymg+BWcJDS/ii7hSMVjo7j63
         aQE5L2KHMzyvsIBAeRtB5+fXc+6wa8COArEgBI3s=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id B673E61214;
        Tue, 24 Sep 2019 17:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569346128;
        bh=m5nRpCCGsAeJVX0FTjg6i2xbJTPmx0BJPve6hoE/kIo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VHb6ytHqFfkvnGh/XX/YQdEQJVoueT4RPiEaoUqqv9J98u2ecMdvNsEHCwLqIRDxI
         UKFLZtrB3AYTpj6ZBNBsHx+SUztKyBuVksO/2cMZivUfKKY2gzX1G2MeLZOfhCsRDK
         lRW+5dSlmv7JpdOr4fyEKLTi+5I5QFIqbWuTIXNA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 24 Sep 2019 10:28:48 -0700
From:   Jeykumar Sankaran <jsanka@codeaurora.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/meson: fix max mode_config height/width
In-Reply-To: <5dbd6337-7e08-f3f7-6d4a-d6bcaddfd3be@baylibre.com>
References: <1538642563-22465-1-git-send-email-narmstrong@baylibre.com>
 <20181004100958.GI31561@phenom.ffwll.local>
 <0ef7fa13-ce77-f8a5-f5f3-6568be3d6145@baylibre.com>
 <CAKMK7uHxiDF3z19cMBb0o2o4Ev0DFJkhMR7Ny6U2776Ry4oc=A@mail.gmail.com>
 <8e980de4-5a52-8f3d-fba2-734617e40d1b@baylibre.com>
 <CAKMK7uE71OeOdDPb+5-cs9bByD-unYPxBV_R1t+4A0Nb4H6CAw@mail.gmail.com>
 <5dbd6337-7e08-f3f7-6d4a-d6bcaddfd3be@baylibre.com>
Message-ID: <91cd8a2aebefd4ea3e9bcee5a4ef796a@codeaurora.org>
X-Sender: jsanka@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviving this thread from the context of the below conversion:

https://lore.kernel.org/linux-arm-msm/db26145b-3f64-a334-f698-76f972332881@baylibre.com/T/#u

On 2018-10-05 01:19, Neil Armstrong wrote:
> On 05/10/2018 09:58, Daniel Vetter wrote:
>> On Fri, Oct 5, 2018 at 9:39 AM Neil Armstrong 
>> <narmstrong@baylibre.com> wrote:
>>> 
> 
> [...]
> 
>>> OK, won't this be enough ?
>>> --- a/include/drm/drm_mode_config.h
>>> +++ b/include/drm/drm_mode_config.h
>>> @@ -333,6 +333,8 @@ struct drm_mode_config_funcs {
>>>   * @min_height: minimum fb pixel height on this device
>>>   * @max_width: maximum fb pixel width on this device
>>>   * @max_height: maximum fb pixel height on this device
>>> + * @max_fb_width: maximum fb buffer width if differs from max_width
>>> + * @max_fb_height: maximum fb buffer height if differs from 
>>> max_height
>>>   * @funcs: core driver provided mode setting functions
>>>   * @fb_base: base address of the framebuffer
>>>   * @poll_enabled: track polling support for this device
>>> @@ -508,6 +510,7 @@ struct drm_mode_config {
>>> 
>>>         int min_width, min_height;
>>>         int max_width, max_height;
>>> +       int max_fb_width, max_fb_height;
>>>         const struct drm_mode_config_funcs *funcs;
>>>         resource_size_t fb_base;
>>> 
>>> --- a/drivers/gpu/drm/drm_framebuffer.c
>>> +++ b/drivers/gpu/drm/drm_framebuffer.c
>>> @@ -283,14 +283,20 @@ drm_internal_framebuffer_create(struct 
>>> drm_device *dev,
>>>                 return ERR_PTR(-EINVAL);
>>>         }
>>> 
>>> -       if ((config->min_width > r->width) || (r->width > 
>>> config->max_width)) {
>>> +       if ((config->min_width > r->width) ||
>>> +           (!config->max_fb_width && r->width > config->max_width) 
>>> ||
>>> +           (config->max_fb_width && r->width > 
>>> config->max_fb_width)) {
>>>                 DRM_DEBUG_KMS("bad framebuffer width %d, should be >= 
>>> %d && <= %d\n",
>>> -                         r->width, config->min_width, 
>>> config->max_width);
>>> +                         r->width, config->min_width, 
>>> config->max_fb_width ?
>>> +                         config->max_fb_width : config->max_width);
>>>                 return ERR_PTR(-EINVAL);
>>>         }
>>> -       if ((config->min_height > r->height) || (r->height > 
>>> config->max_height)) {
>>> +       if ((config->min_height > r->height) ||
>>> +           (!config->max_fb_height && r->height > 
>>> config->max_height) ||
>>> +           (config->max_fb_height && r->height > 
>>> config->max_fb_height)) {
>>>                 DRM_DEBUG_KMS("bad framebuffer height %d, should be 
>>> >= %d && <= %d\n",
>>> -                         r->height, config->min_height, 
>>> config->max_height);
>>> +                         r->height, config->min_height, 
>>> config->max_fb_height ?
>>> +                         config->max_fb_height : 
>>> config->max_height);
>>>                 return ERR_PTR(-EINVAL);
>>>         }
>>> 
>>> and in the driver :
>>> 
>>> +       drm->mode_config.max_width = 4096;
>>> +       drm->mode_config.max_height = 3840;
>>> +       drm->mode_config.max_fb_width = 16384;
>>> +       drm->mode_config.max_fb_height = 8192;
>>> 
>>> With this I leave the mode filtering intact.
>> 
>> Not enough. See
>> https://dri.freedesktop.org/docs/drm/gpu/drm-kms-helpers.html#c.drm_connector_helper_funcs
>> and scroll down to mode_valid. You need to filter modes both in the
>> detect paths, and the atomic_check paths.
>> 
>> Detect is explicitly filtered out, but atomic_check was only
>> implicitly filtered, through the max fb size checks. Ok, you could
>> light up a mode that's bigger than max fb, but in practice, no
>> userspace ever did that.

Daniel, MSM and few other vendor hardware have upscale blocks where the 
driver can expose fb sizes smaller than
the mode resolution and use h/w upscaling to fill the screen. This would 
optimize the fetch bandwidth.

But with your code we're missing crucial
>> validation now, and userspace could fall over that. What I think we
>> need is to add mode filter against mode_config.max_width/height in
>> drm_atomic_helper_check_modeset(). Probably best to stuff that into
>> the mode_valid() function.
> 
Agreed! Since the above patch from Niel is taking care of cases where 
max/min fb values
are not set, by checking against the original max/min values, can we 
separate out this
core change from the driver level mode_valid changes? If Niel couldn't 
find the time, I can
repost the above change.

Thanks and Regards,
Jeykumar S.

> Ok I understood now, thanks for pointer, I'll try to add this.
> 
> Neil
> 
>> 
>> Cheers, Daniel
>>> 
>>> Neil
>>> 
>>> 
>>>> -Daniel
>>>> 
>>>>> 
>>>>> Neil
>>>>> 
>>>>>> 
>>>>>> Bunch of igt to make sure we're not missing anything would be 
>>>>>> sweet on
>>>>>> top, e.g. e.g. trying to set a mode over the limit and making sure 
>>>>>> it
>>>>>> fails.
>>>>>> 
>>>>>> Cheers, Daniel
>>>>>> 
>>>>>>> ---
>>>>>>>  drivers/gpu/drm/meson/meson_drv.c | 4 ++--
>>>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>> 
>>>>>>> diff --git a/drivers/gpu/drm/meson/meson_drv.c 
>>>>>>> b/drivers/gpu/drm/meson/meson_drv.c
>>>>>>> index d344312..2e29968 100644
>>>>>>> --- a/drivers/gpu/drm/meson/meson_drv.c
>>>>>>> +++ b/drivers/gpu/drm/meson/meson_drv.c
>>>>>>> @@ -243,8 +243,8 @@ static int meson_drv_bind_master(struct 
>>>>>>> device *dev, bool has_components)
>>>>>>>              goto free_drm;
>>>>>>> 
>>>>>>>      drm_mode_config_init(drm);
>>>>>>> -    drm->mode_config.max_width = 3840;
>>>>>>> -    drm->mode_config.max_height = 2160;
>>>>>>> +    drm->mode_config.max_width = 16384;
>>>>>>> +    drm->mode_config.max_height = 8192;
>>>>>>>      drm->mode_config.funcs = &meson_mode_config_funcs;
>>>>>>> 
>>>>>>>      /* Hardware Initialization */
>>>>>>> --
>>>>>>> 2.7.4
>>>>>>> 
>>>>>>> _______________________________________________
>>>>>>> dri-devel mailing list
>>>>>>> dri-devel@lists.freedesktop.org
>>>>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>>>>> 
>>>>> 
>>>>> _______________________________________________
>>>>> dri-devel mailing list
>>>>> dri-devel@lists.freedesktop.org
>>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>>> 
>>>> 
>>>> 
>>> 
>> 
>> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Jeykumar S
