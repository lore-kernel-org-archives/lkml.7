Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7893DC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D1920675
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730982AbfETJVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 05:21:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47338 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729598AbfETJVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:21:54 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0EEAD27CBFAFCBE3E065;
        Mon, 20 May 2019 17:21:52 +0800 (CST)
Received: from [127.0.0.1] (10.177.19.180) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Mon, 20 May 2019
 17:21:41 +0800
Subject: Re: [PATCH 1/2] hwtracing: stm: fix vfree() nonexistent vm_area
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>
CC:     Hulk Robot <hulkci@huawei.com>
References: <20190520091315.27898-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <57ffbd01-2624-e7b4-bd27-d93cd49fbc9f@huawei.com>
Date:   Mon, 20 May 2019 17:19:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190520091315.27898-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.177.19.180]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sorry, send wrong version,  please ignore.

On 2019/5/20 17:13, Kefeng Wang wrote:
> If device_add() in stm_register_device() fails, stm_device_release()
> is called to free stm, free stm again on err_device path will trigger
> following warning,
>
>   Trying to vfree() nonexistent vm area (0000000054b5e7bc)
>   WARNING: CPU: 0 PID: 6004 at mm/vmalloc.c:1595 __vunmap+0x72/0x480 mm/vmalloc.c:1594
>   Kernel panic - not syncing: panic_on_warn set ...
>   CPU: 0 PID: 6004 Comm: syz-executor.0 Tainted: G         C 5.1.0+ #28
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
>   Call Trace:
>    __vfree+0x2a/0x80 mm/vmalloc.c:1658
>    _vfree+0x49/0x70 mm/vmalloc.c:1688
>    stm_register_device+0x295/0x330 [stm_core]
>    dummy_stm_init+0xfe/0x1e0 [dummy_stm]
>    do_one_initcall+0xb9/0x3b5 init/main.c:914
>    do_init_module+0xe0/0x330 kernel/module.c:3468
>    load_module+0x38eb/0x4270 kernel/module.c:3819
>    __do_sys_finit_module+0x162/0x190 kernel/module.c:3909
>    do_syscall_64+0x72/0x2a0 arch/x86/entry/common.c:298
>    entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> Only free stm once if device_add() fails to fix it.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/hwtracing/stm/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
> index e55b902560de..7b2ab7b2cc4d 100644
> --- a/drivers/hwtracing/stm/core.c
> +++ b/drivers/hwtracing/stm/core.c
> @@ -864,6 +864,7 @@ static void stm_device_release(struct device *dev)
>  	struct stm_device *stm = to_stm_device(dev);
>  
>  	vfree(stm);
> +	stm->data->stm = NULL;
>  }
>  
>  int stm_register_device(struct device *parent, struct stm_data *stm_data,
> @@ -933,7 +934,8 @@ int stm_register_device(struct device *parent, struct stm_data *stm_data,
>  	/* matches device_initialize() above */
>  	put_device(&stm->dev);
>  err_free:
> -	vfree(stm);
> +	if (stm->data->stm)
> +		vfree(stm);
>  
>  	return err;
>  }

