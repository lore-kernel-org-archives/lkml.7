Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC0DC2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C56972072B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfLRJ6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 04:58:47 -0500
Received: from mail.netline.ch ([148.251.143.178]:38015 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfLRJ6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:58:46 -0500
X-Greylist: delayed 384 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Dec 2019 04:58:45 EST
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id E484C2A6046;
        Wed, 18 Dec 2019 10:52:19 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id svgeRHm0o1zt; Wed, 18 Dec 2019 10:52:19 +0100 (CET)
Received: from thor (252.80.76.83.dynamic.wline.res.cust.swisscom.ch [83.76.80.252])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id 03FF42A6045;
        Wed, 18 Dec 2019 10:52:18 +0100 (CET)
Received: from localhost ([::1])
        by thor with esmtp (Exim 4.93)
        (envelope-from <michel@daenzer.net>)
        id 1ihW0A-000x6B-5f; Wed, 18 Dec 2019 10:52:18 +0100
Subject: Re: [PATCH 2/3] gpu: drm: dead code elimination
To:     Pan Zhang <zhangpan26@huawei.com>, hushiyuan@huawei.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        ray.huang@amd.com, irmoy.das@amd.com, sam@ravnborg.org
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <1576641000-14772-1-git-send-email-zhangpan26@huawei.com>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <484b831b-671a-12f4-8259-1cb6b75e93e3@daenzer.net>
Date:   Wed, 18 Dec 2019 10:52:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1576641000-14772-1-git-send-email-zhangpan26@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-18 4:50 a.m., Pan Zhang wrote:
> this set adds support for removal of gpu drm dead code.
> 
> patch2:
> `num_entries` is a data of unsigned type(compilers always treat as unsigned int) and SIZE_MAX == ~0,
> 
> so there is a impossible condition:
> '(num_entries > ((~0) - 56) / 72) => (max(0-u32) > 256204778801521549)'.

While this looks correct for 64-bit, where size_t is unsigned long, on
32-bit it's unsigned int, in which case this isn't dead code.


> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> index 85b0515..10a7f30 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> @@ -71,10 +71,6 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
>  	unsigned i;
>  	int r;
>  
> -	if (num_entries > (SIZE_MAX - sizeof(struct amdgpu_bo_list))
> -				/ sizeof(struct amdgpu_bo_list_entry))
> -		return -EINVAL;
> -
>  	size = sizeof(struct amdgpu_bo_list);
>  	size += num_entries * sizeof(struct amdgpu_bo_list_entry);
>  	list = kvmalloc(size, GFP_KERNEL);
> 


-- 
Earthling Michel Dänzer               |               https://redhat.com
Libre software enthusiast             |             Mesa and X developer
