Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1237DCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E429221855
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbfKALdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 07:33:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57094 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbfKALdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 07:33:47 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D808A592C0034E188BBA;
        Fri,  1 Nov 2019 19:33:45 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Fri, 1 Nov 2019
 19:33:42 +0800
Subject: Re: [PATCH -next] gpu: host1x: Fix compile test failure
To:     Thierry Reding <thierry.reding@gmail.com>
References: <20191030135458.27960-1-yuehaibing@huawei.com>
 <283304d6-bf23-8107-29b6-9f3e7dda943c@gmail.com>
 <cb0a976a-0148-d554-15ff-5f4059eccd37@huawei.com>
 <20191101094757.GA1167505@ulmo>
CC:     Dmitry Osipenko <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <arnd@arndb.de>, <seanpaul@chromium.org>,
        <dri-devel@lists.freedesktop.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <01997f01-27d7-7468-c331-9b2920ad8193@huawei.com>
Date:   Fri, 1 Nov 2019 19:33:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20191101094757.GA1167505@ulmo>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/11/1 17:47, Thierry Reding wrote:
> On Thu, Oct 31, 2019 at 09:33:38PM +0800, Yuehaibing wrote:
>> On 2019/10/31 6:26, Dmitry Osipenko wrote:
>>> 30.10.2019 16:54, YueHaibing пишет:
>>>> If IOMMU_SUPPORT is not set, but IOMMU_IOVA is m and
>>>> COMPILE_TEST is y, building fails:
>>>>
>>>> drivers/gpu/host1x/dev.o: In function `host1x_remove':
>>>> dev.c:(.text+0x624): undefined reference to `put_iova_domain'
>>>> dev.c:(.text+0x624): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `put_iova_domain'
>>>> dev.c:(.text+0x62c): undefined reference to `iova_cache_put'
>>>> dev.c:(.text+0x62c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `iova_cache_put'
>>>>
>>>> Select IOMMU_IOVA while COMPILE_TEST is set to fix this.
>>>>
>>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>>> Fixes: 52499a6ad2ae ("gpu: host1x: select IOMMU_IOVA")
>>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>>> ---
>>>>  drivers/gpu/host1x/Kconfig | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/host1x/Kconfig b/drivers/gpu/host1x/Kconfig
>>>> index cf987a3..354232d 100644
>>>> --- a/drivers/gpu/host1x/Kconfig
>>>> +++ b/drivers/gpu/host1x/Kconfig
>>>> @@ -2,7 +2,7 @@
>>>>  config TEGRA_HOST1X
>>>>  	tristate "NVIDIA Tegra host1x driver"
>>>>  	depends on ARCH_TEGRA || (ARM && COMPILE_TEST)
>>>> -	select IOMMU_IOVA if IOMMU_SUPPORT
>>>> +	select IOMMU_IOVA if (IOMMU_SUPPORT || COMPILE_TEST)
>>>>  	help
>>>>  	  Driver for the NVIDIA Tegra host1x hardware.
>>>>  
>>>>
>>>
>>> It should be better to unconditionally select IOMMU_IOVA here.
>>>
>>> The same could be done for drivers/staging/media/tegra-vde/ and
>>> drivers/gpu/host1x/, please see [1].
>>
>> Yep, I will repost, thanks!
> 
> No need to resend, I already have patches for that.

Ok, thanks!

> 
> Thierry
> 

