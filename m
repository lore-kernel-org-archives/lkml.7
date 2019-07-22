Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47336C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 02:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F10E21903
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 02:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbfGVCAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 22:00:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39030 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbfGVCAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 22:00:35 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 06EACAE16D24FE63FEFF;
        Mon, 22 Jul 2019 09:44:07 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Mon, 22 Jul 2019
 09:44:02 +0800
Subject: Re: [PATCH -next] drm/komeda: remove set but not used variable 'old'
To:     <james.qian.wang@arm.com>, <liviu.dudau@arm.com>,
        <brian.starkey@arm.com>, <airlied@linux.ie>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
References: <20190709135808.56388-1-yuehaibing@huawei.com>
 <20190718185150.GC15868@phenom.ffwll.local>
 <20190719130455.GP15868@phenom.ffwll.local>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <5d435034-501c-3d45-a72f-fac34ef12fc5@huawei.com>
Date:   Mon, 22 Jul 2019 09:44:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190719130455.GP15868@phenom.ffwll.local>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/7/19 21:04, Daniel Vetter wrote:
> On Thu, Jul 18, 2019 at 08:51:50PM +0200, Daniel Vetter wrote:
>> On Tue, Jul 09, 2019 at 09:58:08PM +0800, YueHaibing wrote:
>>> Fixes gcc '-Wunused-but-set-variable' warning:
>>>
>>> drivers/gpu/drm/arm/display/komeda/komeda_plane.c:
>>>  In function komeda_plane_atomic_duplicate_state:
>>> drivers/gpu/drm/arm/display/komeda/komeda_plane.c:161:35:
>>>  warning: variable old set but not used [-Wunused-but-set-variable
>>>
>>> It is not used since commit 990dee3aa456 ("drm/komeda:
>>> Computing image enhancer internally")
>>>
>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>
>> Queued for 5.3, thanks for your patch.
> 
> Correction, this doesn't even compile. Please compile-test patches before
> submitting.
> 

Oops, sorry for this, I'll be more carefully.

> Thanks, Daniel
> 
>> -Daniel
>>
>>> ---
>>>  drivers/gpu/drm/arm/display/komeda/komeda_plane.c | 4 ----
>>>  1 file changed, 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
>>> index c095af1..c1381ac 100644
>>> --- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
>>> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
>>> @@ -158,8 +158,6 @@ static void komeda_plane_reset(struct drm_plane *plane)
>>>  static struct drm_plane_state *
>>>  komeda_plane_atomic_duplicate_state(struct drm_plane *plane)
>>>  {
>>> -	struct komeda_plane_state *new, *old;
>>> -
>>>  	if (WARN_ON(!plane->state))
>>>  		return NULL;
>>>  
>>> @@ -169,8 +167,6 @@ komeda_plane_atomic_duplicate_state(struct drm_plane *plane)
>>>  
>>>  	__drm_atomic_helper_plane_duplicate_state(plane, &new->base);
>>>  
>>> -	old = to_kplane_st(plane->state);
>>> -
>>>  	return &new->base;
>>>  }
>>>  
>>> -- 
>>> 2.7.4
>>>
>>>
>>
>> -- 
>> Daniel Vetter
>> Software Engineer, Intel Corporation
>> http://blog.ffwll.ch
> 

