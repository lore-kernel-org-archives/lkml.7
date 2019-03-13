Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98860C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F4921019
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfCMSIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:08:19 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37050 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfCMSIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 14:08:19 -0400
Received: from [IPv6:2804:431:9719:798c:6bb0:a97a:4a09:e6d8] (unknown [IPv6:2804:431:9719:798c:6bb0:a97a:4a09:e6d8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: koike)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3372B27E629;
        Wed, 13 Mar 2019 18:08:08 +0000 (GMT)
Subject: Re: [PATCH v2 1/5] drm/rockchip: fix fb references in async update
To:     =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        Tomasz Figa <tfiga@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     =?UTF-8?Q?St=c3=a9phane_Marchesin?= <marcheu@google.com>,
        Sean Paul <seanpaul@google.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        kernel@collabora.com, nicholas.kazlauskas@amd.com,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org
References: <20190312022204.2775-1-helen.koike@collabora.com>
 <20190312022204.2775-2-helen.koike@collabora.com>
 <20190312073438.05ad8173@collabora.com>
 <f888a2d0-c6b1-8995-7254-ba2923dd22f9@collabora.com>
 <20190312165243.5b771e4a@collabora.com>
 <CAAFQd5CCEDaxLbw0E9NJJ-tEcHd8-Lidvcvt8qfPAnKu7uuj8w@mail.gmail.com>
 <05750143-708b-b84e-af67-82ec6815bd89@daenzer.net>
From:   Helen Koike <helen.koike@collabora.com>
Openpgp: preference=signencrypt
Autocrypt: addr=helen.koike@collabora.com; keydata=
 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
Message-ID: <ed44e1f4-07da-b1cb-b5cb-d34d29758502@collabora.com>
Date:   Wed, 13 Mar 2019 15:08:02 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <05750143-708b-b84e-af67-82ec6815bd89@daenzer.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/13/19 6:58 AM, Michel Dänzer wrote:
> On 2019-03-13 4:42 a.m., Tomasz Figa wrote:
>> On Wed, Mar 13, 2019 at 12:52 AM Boris Brezillon
>> <boris.brezillon@collabora.com> wrote:
>>>
>>> On Tue, 12 Mar 2019 12:34:45 -0300
>>> Helen Koike <helen.koike@collabora.com> wrote:
>>>
>>>> On 3/12/19 3:34 AM, Boris Brezillon wrote:
>>>>> On Mon, 11 Mar 2019 23:21:59 -0300
>>>>> Helen Koike <helen.koike@collabora.com> wrote:
>>>>>
>>>>>> In the case of async update, modifications are done in place, i.e. in the
>>>>>> current plane state, so the new_state is prepared and the new_state is
>>>>>> cleanup up (instead of the old_state, diferrently on what happen in a
>>>>>
>>>>>   ^ cleaned up                              ^ differently (but maybe
>>>>> "unlike what happens" is more appropriate here).
>>>>>
>>>>>> normal sync update).
>>>>>> To cleanup the old_fb properly, it needs to be placed in the new_state
>>>>>> in the end of async_update, so cleanup call will unreference the old_fb
>>>>>> correctly.
>>>>>>
>>>>>> Also, the previous code had a:
>>>>>>
>>>>>>    plane_state = plane->funcs->atomic_duplicate_state(plane);
>>>>>>    ...
>>>>>>    swap(plane_state, plane->state);
>>>>>>
>>>>>>    if (plane->state->fb && plane->state->fb != new_state->fb) {
>>>>>>    ...
>>>>>>    }
>>>>>>
>>>>>> Which was wrong, as the fb were just assigned to be equal, so this if
>>>>>> statement nevers evaluates to true.
>>>>>>
>>>>>> Another details is that the function drm_crtc_vblank_get() can only be
>>>>>> called when vop->is_enabled is true, otherwise it has no effect and
>>>>>> trows a WARN_ON().
>>>>>>
>>>>>> Calling drm_atomic_set_fb_for_plane() (which get a referent of the new
>>>>>> fb and pus the old fb) is not required, as it is taken care by
>>>>>> drm_mode_cursor_universal() when calling
>>>>>> drm_atomic_helper_update_plane().
>>>>>>
>>>>>> Signed-off-by: Helen Koike <helen.koike@collabora.com>
>>>>>>
>>>>>> ---
>>>>>> Hello,
>>>>>>
>>>>>> I tested on the rockchip ficus v1.1 using igt plane_cursor_legacy and
>>>>>> kms_cursor_legacy and I didn't see any regressions.
>>>>>>
>>>>>> Changes in v2: None
>>>>>>
>>>>>>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 42 ++++++++++++---------
>>>>>>  1 file changed, 24 insertions(+), 18 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>>>>>> index c7d4c6073ea5..a1ee8c156a7b 100644
>>>>>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>>>>>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>>>>>> @@ -912,30 +912,31 @@ static void vop_plane_atomic_async_update(struct drm_plane *plane,
>>>>>>                                      struct drm_plane_state *new_state)
>>>>>>  {
>>>>>>    struct vop *vop = to_vop(plane->state->crtc);
>>>>>> -  struct drm_plane_state *plane_state;
>>>>>> +  struct drm_framebuffer *old_fb = plane->state->fb;
>>>>>>
>>>>>> -  plane_state = plane->funcs->atomic_duplicate_state(plane);
>>>>>> -  plane_state->crtc_x = new_state->crtc_x;
>>>>>> -  plane_state->crtc_y = new_state->crtc_y;
>>>>>> -  plane_state->crtc_h = new_state->crtc_h;
>>>>>> -  plane_state->crtc_w = new_state->crtc_w;
>>>>>> -  plane_state->src_x = new_state->src_x;
>>>>>> -  plane_state->src_y = new_state->src_y;
>>>>>> -  plane_state->src_h = new_state->src_h;
>>>>>> -  plane_state->src_w = new_state->src_w;
>>>>>> -
>>>>>> -  if (plane_state->fb != new_state->fb)
>>>>>> -          drm_atomic_set_fb_for_plane(plane_state, new_state->fb);
>>>>>> -
>>>>>> -  swap(plane_state, plane->state);
>>>>>> -
>>>>>> -  if (plane->state->fb && plane->state->fb != new_state->fb) {
>>>>>> +  /*
>>>>>> +   * A scanout can still be occurring, so we can't drop the reference to
>>>>>> +   * the old framebuffer. To solve this we get a reference to old_fb and
>>>>>> +   * set a worker to release it later.
>>>>>
>>>>> Hm, doesn't look like an async update to me if we have to wait for the
>>>>> next VBLANK to happen to get the new content on the screen. Maybe we
>>>>> should reject async updates when old_fb != new_fb in the rk
>>>>> ->async_check() hook.
>>>>
>>>> Unless I am misunderstanding this, we don't wait here, we just grab a
>>>> reference to the fb in case it is being still used by the hw, so it
>>>> doesn't get released prematurely.
>>>
>>> I was just reacting to the comment that says the new FB should stay
>>> around until the next VBLANK event happens. If the FB must stay around
>>> that probably means the HW is still using, which made me wonder if this
>>> HW actually supports async update (where async means "update now and
>>> don't care about about tearing"). Or maybe it takes some time to switch
>>> to the new FB and waiting for the next VBLANK to release the old FB was
>>> an easy solution to not wait for the flip to actually happen in
>>> ->async_update() (which is kind of a combination of async+non-blocking).
>>
>> The hardware switches framebuffers on vblank, so whatever framebuffer
>> is currently being scanned out from needs to stay there until the
>> hardware switches to the new one in shadow registers. If that doesn't
>> happen, you get IOMMU faults and the display controller stops working
>> since we don't have any fault handling currently, just printing a
>> message.
> 
> Sounds like your hardware doesn't actually support async flips. It's
> probably better for the driver not to pretend otherwise.
> 
> 

I think wee need to clarify the meaning of the async_update callback
(and we should clarify it in the docs).

The way I understand what the async_update callback should do is: don't
block (i.e. don't wait for the next vblank), and update the hw state at
some point with the latest state from the last call to async_update.

Which means that: any driver can implement the async_update callback,
independently if it supports changing its state right away or not.
If hw supports, async_update can change the hw state right away, if not,
then changes will be applied in the next vblank (it can even amend the
pending commit if there is one).
With this, we can remove all the legacy cursor code to use the
async_update callback, since async_update can be called 100 times before
the next vblank, and the latest state will be set to the hw without
waiting 100 vblanks.

Please, let me know if this is your understanding as well. If not, then
we need to remodel things.

Thanks,
Helen
