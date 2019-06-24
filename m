Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472D5C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 03:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E602073F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 03:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfFXDlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 23:41:18 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40414 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726834AbfFXDlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 23:41:18 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7FB05AA6FE8AC36B0002;
        Mon, 24 Jun 2019 11:41:16 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Mon, 24 Jun 2019
 11:41:11 +0800
Subject: Re: [PATCH -next v2] drm/amdgpu: return 'ret' in amdgpu_pmu_init
To:     Joe Perches <joe@perches.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <David1.Zhou@amd.com>,
        <dan.carpenter@oracle.com>, <julia.lawall@lip6.fr>
References: <20190622104318.GT28859@kadam>
 <20190622130527.182022-1-maowenan@huawei.com>
 <0ab82cdb0bec30e7e431f106f8e0e9d141491555.camel@perches.com>
CC:     <kernel-janitors@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, Jonathan Kim <jonathan.kim@amd.com>
From:   maowenan <maowenan@huawei.com>
Message-ID: <b468d765-bef7-70a8-9a14-bad0e6ed14df@huawei.com>
Date:   Mon, 24 Jun 2019 11:41:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <0ab82cdb0bec30e7e431f106f8e0e9d141491555.camel@perches.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.96.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/6/23 2:13, Joe Perches wrote:
> On Sat, 2019-06-22 at 21:05 +0800, Mao Wenan wrote:
>> There is one warning:
>> drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c: In function ‘amdgpu_pmu_init’:
>> drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:249:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
>>   int ret = 0;
> []
>>  v1->v2: change the subject for this patch; change the indenting when it calls init_pmu_by_type; use the value 'ret' in
>>  amdgpu_pmu_init().
> []
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> []
>> @@ -252,8 +252,8 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
>>  	case CHIP_VEGA20:
>>  		/* init df */
>>  		ret = init_pmu_by_type(adev, df_v3_6_attr_groups,
>> -				       "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
>> -				       DF_V3_6_MAX_COUNTERS);
>> +							   "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
>> +							   DF_V3_6_MAX_COUNTERS);
> 
> trivia:
> 
> The indentation change seems superfluous and
> appears to make the code harder to read.
> 
> You could also cc Jonathan Kim who wrote all of this.
I think this is just display issue in mail format. It is correct that in vi/vim.
The arguments are line up with '(' after my change.


@@ -252,8 +252,8 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)$
 ^Icase CHIP_VEGA20:$
 ^I^I/* init df */$
 ^I^Iret = init_pmu_by_type(adev, df_v3_6_attr_groups,$
-^I^I^I^I       "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,$
-^I^I^I^I       DF_V3_6_MAX_COUNTERS);$
+^I^I^I^I^I^I^I   "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,$
+^I^I^I^I^I^I^I   DF_V3_6_MAX_COUNTERS);$
 $
 ^I^I/* other pmu types go here*/$
 ^I^Ibreak;$





> 
> 
> 
> .
> 

