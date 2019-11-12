Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7870DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C7C21872
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfKLHvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 02:51:47 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6639 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725847AbfKLHvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 02:51:46 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1DA92BC29FDA6D619B61;
        Tue, 12 Nov 2019 15:51:43 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Tue, 12 Nov 2019
 15:51:38 +0800
Subject: Re: [PATCH -next] drm/amd/display: Fix old-style declaration
To:     Joe Perches <joe@perches.com>, <harry.wentland@amd.com>,
        <sunpeng.li@amd.com>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <David1.Zhou@amd.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <Bhawanpreet.Lakha@amd.com>,
        <Jun.Lei@amd.com>, <David.Francis@amd.com>,
        <Dmytro.Laktyushkin@amd.com>, <nicholas.kazlauskas@amd.com>,
        <martin.leung@amd.com>, <Chris.Park@amd.com>
References: <20191111122801.18584-1-yuehaibing@huawei.com>
 <01c630e6d4c58b3f6184603e158f53fb9aaeae7d.camel@perches.com>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <3361b760-fe4f-87e8-b0a4-ebda390aa492@huawei.com>
Date:   Tue, 12 Nov 2019 15:51:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <01c630e6d4c58b3f6184603e158f53fb9aaeae7d.camel@perches.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/11/12 10:39, Joe Perches wrote:
> On Mon, 2019-11-11 at 20:28 +0800, YueHaibing wrote:
>> Fix a build warning:
>>
>> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:75:1:
>>  warning: 'static' is not at beginning of declaration [-Wold-style-declaration]
> []
>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> []
>> @@ -69,7 +69,7 @@
>>  #define DC_LOGGER \
>>  	dc->ctx->logger
>>  
>> -const static char DC_BUILD_ID[] = "production-build";
>> +static const char DC_BUILD_ID[] = "production-build";
> 
> DC_BUILD_ID is used exactly once.
> Maybe just use it directly and remove DC_BUILD_ID instead?

commit be61df574256ae8c0dbd45ac148ca7260a0483c0
Author: Jun Lei <Jun.Lei@amd.com>
Date:   Thu Sep 13 09:32:26 2018 -0400

    drm/amd/display: Add DC build_id to determine build type

    [why]
    Sometimes there are indications that the incorrect driver is being
    loaded in automated tests. This change adds the ability for builds to
    be tagged with a string, and picked up by the test infrastructure.

    [how]
    dc.c will allocate const for build id, which is init-ed with default
    value, indicating production build. For test builds, build server will
    find/replace this value. The test machine will then verify this value.

It seems DC_BUILD_ID is used by the build server, so maybe we should keep it.

> 
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 1fdba13..803dc14 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -69,8 +69,6 @@
>  #define DC_LOGGER \
>  	dc->ctx->logger
>  
> -const static char DC_BUILD_ID[] = "production-build";
> -
>  /**
>   * DOC: Overview
>   *
> @@ -815,7 +813,7 @@ struct dc *dc_create(const struct dc_init_data *init_params)
>  	if (dc->res_pool->dmcu != NULL)
>  		dc->versions.dmcu_version = dc->res_pool->dmcu->dmcu_version;
>  
> -	dc->build_id = DC_BUILD_ID;
> +	dc->build_id = "production-build";
>  
>  	DC_LOG_DC("Display Core initialized\n");
>  
> 
> 
> 
> .
> 

