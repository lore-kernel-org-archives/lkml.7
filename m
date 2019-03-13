Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF087C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB972087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfCMKET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 06:04:19 -0400
Received: from mail.netline.ch ([148.251.143.178]:41416 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfCMKES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 06:04:18 -0400
X-Greylist: delayed 348 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Mar 2019 06:04:16 EDT
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id DC22F2A6054;
        Wed, 13 Mar 2019 10:58:26 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id CTL4TqMlkKav; Wed, 13 Mar 2019 10:58:26 +0100 (CET)
Received: from thor (116.245.63.188.dynamic.wline.res.cust.swisscom.ch [188.63.245.116])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id D64F42A6053;
        Wed, 13 Mar 2019 10:58:25 +0100 (CET)
Received: from [::1]
        by thor with esmtp (Exim 4.92)
        (envelope-from <michel@daenzer.net>)
        id 1h40eX-0008OC-Fa; Wed, 13 Mar 2019 10:58:25 +0100
Subject: Re: [PATCH v2 1/5] drm/rockchip: fix fb references in async update
To:     Tomasz Figa <tfiga@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     =?UTF-8?Q?St=c3=a9phane_Marchesin?= <marcheu@google.com>,
        Sean Paul <seanpaul@google.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Helen Koike <helen.koike@collabora.com>, kernel@collabora.com,
        nicholas.kazlauskas@amd.com,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org
References: <20190312022204.2775-1-helen.koike@collabora.com>
 <20190312022204.2775-2-helen.koike@collabora.com>
 <20190312073438.05ad8173@collabora.com>
 <f888a2d0-c6b1-8995-7254-ba2923dd22f9@collabora.com>
 <20190312165243.5b771e4a@collabora.com>
 <CAAFQd5CCEDaxLbw0E9NJJ-tEcHd8-Lidvcvt8qfPAnKu7uuj8w@mail.gmail.com>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Openpgp: preference=signencrypt
Autocrypt: addr=michel@daenzer.net; prefer-encrypt=mutual; keydata=
 mQGiBDsehS8RBACbsIQEX31aYSIuEKxEnEX82ezMR8z3LG8ktv1KjyNErUX9Pt7AUC7W3W0b
 LUhu8Le8S2va6hi7GfSAifl0ih3k6Bv1Itzgnd+7ZmSrvCN8yGJaHNQfAevAuEboIb+MaVHo
 9EMJj4ikOcRZCmQWw7evu/D9uQdtkCnRY9iJiAGxbwCguBHtpoGMxDOINCr5UU6qt+m4O+UD
 /355ohBBzzyh49lTj0kTFKr0Ozd20G2FbcqHgfFL1dc1MPyigej2gLga2osu2QY0ObvAGkOu
 WBi3LTY8Zs8uqFGDC4ZAwMPoFy3yzu3ne6T7d/68rJil0QcdQjzzHi6ekqHuhst4a+/+D23h
 Za8MJBEcdOhRhsaDVGAJSFEQB1qLBACOs0xN+XblejO35gsDSVVk8s+FUUw3TSWJBfZa3Imp
 V2U2tBO4qck+wqbHNfdnU/crrsHahjzBjvk8Up7VoY8oT+z03sal2vXEonS279xN2B92Tttr
 AgwosujguFO/7tvzymWC76rDEwue8TsADE11ErjwaBTs8ZXfnN/uAANgPLQjTWljaGVsIERh
 ZW56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD6IXgQTEQIAHgUCQFXxJgIbAwYLCQgHAwIDFQID
 AxYCAQIeAQIXgAAKCRBaga+OatuyAIrPAJ9ykonXI3oQcX83N2qzCEStLNW47gCeLWm/QiPY
 jqtGUnnSbyuTQfIySkK5AQ0EOx6FRRAEAJZkcvklPwJCgNiw37p0GShKmFGGqf/a3xZZEpjI
 qNxzshFRFneZze4f5LhzbX1/vIm5+ZXsEWympJfZzyCmYPw86QcFxyZflkAxHx9LeD+89Elx
 bw6wT0CcLvSv8ROfU1m8YhGbV6g2zWyLD0/naQGVb8e4FhVKGNY2EEbHgFBrAAMGA/0VktFO
 CxFBdzLQ17RCTwCJ3xpyP4qsLJH0yCoA26rH2zE2RzByhrTFTYZzbFEid3ddGiHOBEL+bO+2
 GNtfiYKmbTkj1tMZJ8L6huKONaVrASFzLvZa2dlc2zja9ZSksKmge5BOTKWgbyepEc5qxSju
 YsYrX5xfLgTZC5abhhztpYhGBBgRAgAGBQI7HoVFAAoJEFqBr45q27IAlscAn2Ufk2d6/3p4
 Cuyz/NX7KpL2dQ8WAJ9UD5JEakhfofed8PSqOM7jOO3LCA==
Message-ID: <05750143-708b-b84e-af67-82ec6815bd89@daenzer.net>
Date:   Wed, 13 Mar 2019 10:58:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAAFQd5CCEDaxLbw0E9NJJ-tEcHd8-Lidvcvt8qfPAnKu7uuj8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-13 4:42 a.m., Tomasz Figa wrote:
> On Wed, Mar 13, 2019 at 12:52 AM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
>>
>> On Tue, 12 Mar 2019 12:34:45 -0300
>> Helen Koike <helen.koike@collabora.com> wrote:
>>
>>> On 3/12/19 3:34 AM, Boris Brezillon wrote:
>>>> On Mon, 11 Mar 2019 23:21:59 -0300
>>>> Helen Koike <helen.koike@collabora.com> wrote:
>>>>
>>>>> In the case of async update, modifications are done in place, i.e. in the
>>>>> current plane state, so the new_state is prepared and the new_state is
>>>>> cleanup up (instead of the old_state, diferrently on what happen in a
>>>>
>>>>   ^ cleaned up                              ^ differently (but maybe
>>>> "unlike what happens" is more appropriate here).
>>>>
>>>>> normal sync update).
>>>>> To cleanup the old_fb properly, it needs to be placed in the new_state
>>>>> in the end of async_update, so cleanup call will unreference the old_fb
>>>>> correctly.
>>>>>
>>>>> Also, the previous code had a:
>>>>>
>>>>>    plane_state = plane->funcs->atomic_duplicate_state(plane);
>>>>>    ...
>>>>>    swap(plane_state, plane->state);
>>>>>
>>>>>    if (plane->state->fb && plane->state->fb != new_state->fb) {
>>>>>    ...
>>>>>    }
>>>>>
>>>>> Which was wrong, as the fb were just assigned to be equal, so this if
>>>>> statement nevers evaluates to true.
>>>>>
>>>>> Another details is that the function drm_crtc_vblank_get() can only be
>>>>> called when vop->is_enabled is true, otherwise it has no effect and
>>>>> trows a WARN_ON().
>>>>>
>>>>> Calling drm_atomic_set_fb_for_plane() (which get a referent of the new
>>>>> fb and pus the old fb) is not required, as it is taken care by
>>>>> drm_mode_cursor_universal() when calling
>>>>> drm_atomic_helper_update_plane().
>>>>>
>>>>> Signed-off-by: Helen Koike <helen.koike@collabora.com>
>>>>>
>>>>> ---
>>>>> Hello,
>>>>>
>>>>> I tested on the rockchip ficus v1.1 using igt plane_cursor_legacy and
>>>>> kms_cursor_legacy and I didn't see any regressions.
>>>>>
>>>>> Changes in v2: None
>>>>>
>>>>>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 42 ++++++++++++---------
>>>>>  1 file changed, 24 insertions(+), 18 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>>>>> index c7d4c6073ea5..a1ee8c156a7b 100644
>>>>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>>>>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>>>>> @@ -912,30 +912,31 @@ static void vop_plane_atomic_async_update(struct drm_plane *plane,
>>>>>                                      struct drm_plane_state *new_state)
>>>>>  {
>>>>>    struct vop *vop = to_vop(plane->state->crtc);
>>>>> -  struct drm_plane_state *plane_state;
>>>>> +  struct drm_framebuffer *old_fb = plane->state->fb;
>>>>>
>>>>> -  plane_state = plane->funcs->atomic_duplicate_state(plane);
>>>>> -  plane_state->crtc_x = new_state->crtc_x;
>>>>> -  plane_state->crtc_y = new_state->crtc_y;
>>>>> -  plane_state->crtc_h = new_state->crtc_h;
>>>>> -  plane_state->crtc_w = new_state->crtc_w;
>>>>> -  plane_state->src_x = new_state->src_x;
>>>>> -  plane_state->src_y = new_state->src_y;
>>>>> -  plane_state->src_h = new_state->src_h;
>>>>> -  plane_state->src_w = new_state->src_w;
>>>>> -
>>>>> -  if (plane_state->fb != new_state->fb)
>>>>> -          drm_atomic_set_fb_for_plane(plane_state, new_state->fb);
>>>>> -
>>>>> -  swap(plane_state, plane->state);
>>>>> -
>>>>> -  if (plane->state->fb && plane->state->fb != new_state->fb) {
>>>>> +  /*
>>>>> +   * A scanout can still be occurring, so we can't drop the reference to
>>>>> +   * the old framebuffer. To solve this we get a reference to old_fb and
>>>>> +   * set a worker to release it later.
>>>>
>>>> Hm, doesn't look like an async update to me if we have to wait for the
>>>> next VBLANK to happen to get the new content on the screen. Maybe we
>>>> should reject async updates when old_fb != new_fb in the rk
>>>> ->async_check() hook.
>>>
>>> Unless I am misunderstanding this, we don't wait here, we just grab a
>>> reference to the fb in case it is being still used by the hw, so it
>>> doesn't get released prematurely.
>>
>> I was just reacting to the comment that says the new FB should stay
>> around until the next VBLANK event happens. If the FB must stay around
>> that probably means the HW is still using, which made me wonder if this
>> HW actually supports async update (where async means "update now and
>> don't care about about tearing"). Or maybe it takes some time to switch
>> to the new FB and waiting for the next VBLANK to release the old FB was
>> an easy solution to not wait for the flip to actually happen in
>> ->async_update() (which is kind of a combination of async+non-blocking).
> 
> The hardware switches framebuffers on vblank, so whatever framebuffer
> is currently being scanned out from needs to stay there until the
> hardware switches to the new one in shadow registers. If that doesn't
> happen, you get IOMMU faults and the display controller stops working
> since we don't have any fault handling currently, just printing a
> message.

Sounds like your hardware doesn't actually support async flips. It's
probably better for the driver not to pretend otherwise.


-- 
Earthling Michel Dänzer               |              https://www.amd.com
Libre software enthusiast             |             Mesa and X developer
