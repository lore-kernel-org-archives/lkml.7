Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71278C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 07:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B17E20644
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 07:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfFVHVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 03:21:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18663 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726070AbfFVHVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 03:21:00 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 66B90551CB76559889A1;
        Sat, 22 Jun 2019 15:20:55 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Sat, 22 Jun 2019
 15:20:50 +0800
Subject: Re: [PATCH -next] drm/amdgpu: remove set but not used variables 'ret'
To:     Julia Lawall <julia.lawall@lip6.fr>
References: <20190622030314.169640-1-maowenan@huawei.com>
 <alpine.DEB.2.21.1906220801210.3253@hadrien>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <David1.Zhou@amd.com>,
        <kernel-janitors@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
From:   maowenan <maowenan@huawei.com>
Message-ID: <1a3b6f23-21cb-5931-b8fd-e8dd43e5cf2d@huawei.com>
Date:   Sat, 22 Jun 2019 15:20:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906220801210.3253@hadrien>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.96.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/6/22 14:02, Julia Lawall wrote:
> 
> 
> On Sat, 22 Jun 2019, Mao Wenan wrote:
> 
>> Fixes gcc '-Wunused-but-set-variable' warning:
>>
>> drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c: In function ‘amdgpu_pmu_init’:
>> drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:249:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
>>   int ret = 0;
>>       ^
>>
>> It is never used since introduction in 9c7c85f7ea1f ("drm/amdgpu: add pmu counters")
>>
>> Signed-off-by: Mao Wenan <maowenan@huawei.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
>> index 0e6dba9..0bf4dd9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
>> @@ -246,12 +246,10 @@ static int init_pmu_by_type(struct amdgpu_device *adev,
>>  /* init amdgpu_pmu */
>>  int amdgpu_pmu_init(struct amdgpu_device *adev)
>>  {
>> -	int ret = 0;
>> -
>>  	switch (adev->asic_type) {
>>  	case CHIP_VEGA20:
>>  		/* init df */
>> -		ret = init_pmu_by_type(adev, df_v3_6_attr_groups,
>> +		init_pmu_by_type(adev, df_v3_6_attr_groups,
>>  				       "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
>>  				       DF_V3_6_MAX_COUNTERS);
> 
> Maybe it would be better to use ret?
> 
> If knowing whether the call has failed is really useless, then maybe the
> return type should be void?

right.

amdgpu_pmu_init() is called by amdgpu_device_init() in drivers/gpu/drm/amd/amdgpu/amdgpu_device.c,
which will use the return value.
amdgpu_device_init()
	r = amdgpu_pmu_init(adev);


thanks, I will send v2.
> 
> julia
> 
> 
>>
>> --
>> 2.7.4
>>
>>
> 

