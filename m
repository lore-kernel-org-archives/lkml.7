Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6D0C2D0C3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 01:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0EA720722
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 01:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfLaB0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 20:26:05 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8650 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727804AbfLaB0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 20:26:05 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 971E09AEA5D8655BBE85;
        Tue, 31 Dec 2019 09:26:02 +0800 (CST)
Received: from [127.0.0.1] (10.57.60.129) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 31 Dec 2019
 09:25:55 +0800
Subject: Re: [PATCH] drm/hisilicon: Added three new resolutions and changed
 the alignment to 128 Bytes
To:     Daniel Stone <daniel@fooishbar.org>,
        Tian Tao <tiantao6@hisilicon.com>
CC:     Chen Feng <puck.chen@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>, <tglx@linutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Xinliang Liu" <xinliang.liu@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1577495680-28766-1-git-send-email-tiantao6@hisilicon.com>
 <CAPj87rO-ZrCCJCza0Eeyp-JAJ6Qp8RdhJQh_1Yh_QSeK2o8_hw@mail.gmail.com>
From:   "tiantao (H)" <tiantao6@huawei.com>
Message-ID: <45055b17-041c-f726-6c5d-5769c96b92d9@huawei.com>
Date:   Tue, 31 Dec 2019 09:25:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPj87rO-ZrCCJCza0Eeyp-JAJ6Qp8RdhJQh_1Yh_QSeK2o8_hw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.57.60.129]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Daniel:

Thanks you very much ,I will follow your suggestion to split this to 
three patches.

Best
在 2019/12/30 18:23, Daniel Stone 写道:
> Hi Tian,
> 
> On Sat, 28 Dec 2019 at 01:14, Tian Tao <tiantao6@hisilicon.com> wrote:
>> @@ -118,11 +119,9 @@ static void hibmc_plane_atomic_update(struct drm_plane *plane,
>>          writel(gpu_addr, priv->mmio + HIBMC_CRT_FB_ADDRESS);
>>
>>          reg = state->fb->width * (state->fb->format->cpp[0]);
>> -       /* now line_pad is 16 */
>> -       reg = PADDING(16, reg);
>>
>>          line_l = state->fb->width * state->fb->format->cpp[0];
>> -       line_l = PADDING(16, line_l);
>> +       line_l = PADDING(128, line_l);
> 
> The 'line length' here is the 'stride' field of the FB. Stride is set
> by userspace when allocating the buffer, and the kernel must not
> attempt to guess what userspace set.
> 
> You should use state->fb->strides[0] directly here, and in your
> atomic_check() function, make sure that the framebuffer stride is
> correctly aligned.
> 
> Please split this into a separate change. Your commit has three
> changes in it, which should all be separate commits:
>    * enforce 128-byte stride alignment (is this a hardware limit?)
>    * get the BO from drm_fb rather than hibmc_fb (can hibmc_fb->obj
> just be removed now?)
>    * add new clock/resolution configurations
> 
> Cheers,
> Daniel
> 
> .
> 

