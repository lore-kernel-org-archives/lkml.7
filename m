Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8D1C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 07:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D952068D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 07:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfKRHQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 02:16:58 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:40730 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726551AbfKRHQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 02:16:57 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F2F5518BF4F6297890BF;
        Mon, 18 Nov 2019 15:16:53 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.225) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Mon, 18 Nov 2019
 15:16:49 +0800
Subject: Re: [PATCH] drm/amd/powerplay: remove variable 'result' set but not
 used
To:     "Quan, Evan" <Evan.Quan@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1573875799-83572-1-git-send-email-chenwandun@huawei.com>
 <MN2PR12MB3344A9DA952F41ADDAD6142AE44D0@MN2PR12MB3344.namprd12.prod.outlook.com>
From:   Chen Wandun <chenwandun@huawei.com>
Message-ID: <71d72dc4-5dae-2ae4-9f10-89cca72458da@huawei.com>
Date:   Mon, 18 Nov 2019 15:16:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <MN2PR12MB3344A9DA952F41ADDAD6142AE44D0@MN2PR12MB3344.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.221.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK, it indeed should return the 'result' to caller,
I will make a modification and repost the patch.

Thanks
Chen Wandun

On 2019/11/18 14:50, Quan, Evan wrote:
> Thanks. But it's better to return the 'result' out on 'result != 0'.
> 
> Regards,
> Evan
> -----Original Message-----
> From: Chen Wandun <chenwandun@huawei.com>
> Sent: Saturday, November 16, 2019 11:43 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org
> Cc: chenwandun@huawei.com
> Subject: [PATCH] drm/amd/powerplay: remove variable 'result' set but not used
> 
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/vegam_smumgr.c: In function vegam_populate_smc_boot_level:
> drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/vegam_smumgr.c:1364:6: warning: variable result set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
> ---
>   drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
> index 2068eb0..fad78bf 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
> @@ -1361,20 +1361,19 @@ static int vegam_populate_smc_uvd_level(struct pp_hwmgr *hwmgr,
>   static int vegam_populate_smc_boot_level(struct pp_hwmgr *hwmgr,
>   		struct SMU75_Discrete_DpmTable *table)
>   {
> -	int result = 0;
>   	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
>   
>   	table->GraphicsBootLevel = 0;
>   	table->MemoryBootLevel = 0;
>   
>   	/* find boot level from dpm table */
> -	result = phm_find_boot_level(&(data->dpm_table.sclk_table),
> -			data->vbios_boot_state.sclk_bootup_value,
> -			(uint32_t *)&(table->GraphicsBootLevel));
> +	phm_find_boot_level(&(data->dpm_table.sclk_table),
> +			    data->vbios_boot_state.sclk_bootup_value,
> +			    (uint32_t *)&(table->GraphicsBootLevel));
>   
> -	result = phm_find_boot_level(&(data->dpm_table.mclk_table),
> -			data->vbios_boot_state.mclk_bootup_value,
> -			(uint32_t *)&(table->MemoryBootLevel));
> +	phm_find_boot_level(&(data->dpm_table.mclk_table),
> +			    data->vbios_boot_state.mclk_bootup_value,
> +			    (uint32_t *)&(table->MemoryBootLevel));
>   
>   	table->BootVddc  = data->vbios_boot_state.vddc_bootup_value *
>   			VOLTAGE_SCALE;
> 

