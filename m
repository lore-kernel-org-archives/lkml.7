Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06550C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 03:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D6C20663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 03:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfFXDQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 23:16:50 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:19062 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726307AbfFXDQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 23:16:50 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9FB2A91CF8408B57CC70;
        Mon, 24 Jun 2019 11:16:47 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Mon, 24 Jun 2019
 11:16:45 +0800
Subject: Re: [PATCH -next v2] drm/amdgpu: return 'ret' in amdgpu_pmu_init
To:     Julia Lawall <julia.lawall@lip6.fr>
References: <20190622104318.GT28859@kadam>
 <20190622130527.182022-1-maowenan@huawei.com>
 <alpine.DEB.2.21.1906221504110.3253@hadrien>
 <063c9726-8f16-f9b7-2d16-bc87a99085bb@huawei.com>
 <alpine.DEB.2.21.1906221559060.3253@hadrien>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <David1.Zhou@amd.com>,
        <dan.carpenter@oracle.com>, <kernel-janitors@vger.kernel.org>,
        <amd-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
From:   maowenan <maowenan@huawei.com>
Message-ID: <fced7783-1216-ff3f-039f-d7c3a70b4916@huawei.com>
Date:   Mon, 24 Jun 2019 11:16:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906221559060.3253@hadrien>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.96.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/6/22 22:00, Julia Lawall wrote:
> 
> 
> On Sat, 22 Jun 2019, maowenan wrote:
> 
>>
>>
>> On 2019/6/22 21:06, Julia Lawall wrote:
>>>
>>>
>>> On Sat, 22 Jun 2019, Mao Wenan wrote:
>>>
>>>> There is one warning:
>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c: In function ‘amdgpu_pmu_init’:
>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:249:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
>>>>   int ret = 0;
>>>>       ^
>>>> amdgpu_pmu_init() is called by amdgpu_device_init() in drivers/gpu/drm/amd/amdgpu/amdgpu_device.c,
>>>> which will use the return value. So it returns 'ret' for caller.
>>>> amdgpu_device_init()
>>>> 	r = amdgpu_pmu_init(adev);
>>>>
>>>> Fixes: 9c7c85f7ea1f ("drm/amdgpu: add pmu counters")
>>>>
>>>> Signed-off-by: Mao Wenan <maowenan@huawei.com>
>>>> ---
>>>>  v1->v2: change the subject for this patch; change the indenting when it calls init_pmu_by_type; use the value 'ret' in
>>>>  amdgpu_pmu_init().
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 6 +++---
>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
>>>> index 0e6dba9..145e720 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
>>>> @@ -252,8 +252,8 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
>>>>  	case CHIP_VEGA20:
>>>>  		/* init df */
>>>>  		ret = init_pmu_by_type(adev, df_v3_6_attr_groups,
>>>> -				       "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
>>>> -				       DF_V3_6_MAX_COUNTERS);
>>>> +							   "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
>>>> +							   DF_V3_6_MAX_COUNTERS);
>>>>
>>>>  		/* other pmu types go here*/
>>>
>>> I don't know what is the impact of the other pmu types that are planned
>>> for the future.  Perhaps it would be better to abort the function
>>> immediately in the case of a failure.
>>

OK, v3 will be sent.

>> I guess it would be better to use new function or new switch case clause to process different PMU types
>> in future.
> 
> I don't know.  But normally when an error may occur it is checked for
> immediately, rather than just letting it go until the end of the function.
> But maybe the developer know what is planned for the future for this
> function.
> 
> julia
> 
>>
>>>
>>> julia
>>>
>>>>  		break;
>>>> @@ -261,7 +261,7 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
>>>>  		return 0;
>>>>  	}
>>>>
>>>> -	return 0;
>>>> +	return ret;
>>>>  }
>>>>
>>>>
>>>> --
>>>> 2.7.4
>>>>
>>>>
>>>
>>
>>
> 

