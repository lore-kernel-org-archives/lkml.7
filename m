Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65526C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4142F208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfFXJ3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:29:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34236 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726632AbfFXJ3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:29:50 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0BEF76D46187D21E210D;
        Mon, 24 Jun 2019 17:29:48 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.96) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Mon, 24 Jun 2019
 17:29:46 +0800
Subject: Re: [PATCH -next v3] drm/amdgpu: return 'ret' immediately if failed
 in amdgpu_pmu_init
To:     Dan Carpenter <dan.carpenter@oracle.com>
References: <alpine.DEB.2.21.1906230809400.4961@hadrien>
 <20190624034532.135201-1-maowenan@huawei.com> <20190624083952.GO18776@kadam>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <David1.Zhou@amd.com>,
        <julia.lawall@lip6.fr>, <kernel-janitors@vger.kernel.org>,
        <amd-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <jonathan.kim@amd.com>, Joe Perches <joe@perches.com>
From:   maowenan <maowenan@huawei.com>
Message-ID: <4795ba5c-8e41-e1e0-c96a-47fdda3995e3@huawei.com>
Date:   Mon, 24 Jun 2019 17:29:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190624083952.GO18776@kadam>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.96.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/6/24 16:39, Dan Carpenter wrote:
> On Mon, Jun 24, 2019 at 11:45:32AM +0800, Mao Wenan wrote:
>> There is one warning:
>> drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c: In function ‘amdgpu_pmu_init’:
>> drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:249:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
>>   int ret = 0;
>>       ^
>> amdgpu_pmu_init() is called by amdgpu_device_init() in drivers/gpu/drm/amd/amdgpu/amdgpu_device.c,
>> which will use the return value. So it should return 'ret' immediately if init_pmu_by_type() failed.
>> amdgpu_device_init()
>> 	r = amdgpu_pmu_init(adev);
>>
>> This patch is also to update the indenting on the arguments so they line up with the '('.
>>
>> Fixes: 9c7c85f7ea1f ("drm/amdgpu: add pmu counters")
>>
>> Signed-off-by: Mao Wenan <maowenan@huawei.com>
>> ---
>>  v1->v2: change the subject for this patch; change the indenting when it calls init_pmu_by_type; use the value 'ret' in
>>  amdgpu_pmu_init().
>>  v2->v3: change the subject for this patch; return 'ret' immediately if failed to call init_pmu_by_type(). 
>>
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
>> index 0e6dba9..b702322 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
>> @@ -252,8 +252,11 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
>>  	case CHIP_VEGA20:
>>  		/* init df */
>>  		ret = init_pmu_by_type(adev, df_v3_6_attr_groups,
>> -				       "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
>> -				       DF_V3_6_MAX_COUNTERS);
>> +							   "DF", "amdgpu_df",
>> +							   PERF_TYPE_AMDGPU_DF,
>> +							   DF_V3_6_MAX_COUNTERS);
>> +		if (ret)
>> +			return ret;
> 
> No no.  Sorry, the original indenting was correct and lined up with the
> '(' character in 'init_pmu_by_type(', that's the way it should be.  If
> we were to remove the "ret = " then we'd have to pull the arguments back
> as well.  I think this fix that Julia suggested is really the right so
> leave the indenting alone.
> 

> It looks like you've right aligned the arguments.  That's not the right
> way, the original was correct.
> 
After using 8 character for tab(thanks to Joe), the aligned here is wrong, yes, the original was correct.

so my v4 is only to change ret, don't change the indenting?

> regards,
> dan carpenter
> 
> 
> .
> 

