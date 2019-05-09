Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E31C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 14:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DAE216C4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 14:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfEIOu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 10:50:57 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48518 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726187AbfEIOu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 10:50:56 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3B676271413EEE816D2A;
        Thu,  9 May 2019 22:50:52 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Thu, 9 May 2019
 22:50:49 +0800
Subject: Re: [PATCH] scsi: qedi: remove memset/memcpy to nfunc and use func
 instead
To:     <QLogic-Storage-Upstream@cavium.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <mojha@codeaurora.org>,
        <skashyap@marvell.com>, <gregkh@linuxfoundation.org>
References: <20190412094829.15868-1-colin.king@canonical.com>
 <20190420040554.41888-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <2907a552-a557-afeb-de56-88c958480f0c@huawei.com>
Date:   Thu, 9 May 2019 22:50:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190420040554.41888-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Friendly ping, could someone review this patch ?

On 2019/4/20 12:05, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> KASAN report this:
> 
> BUG: KASAN: global-out-of-bounds in qedi_dbg_err+0xda/0x330 [qedi]
> Read of size 31 at addr ffffffffc12b0ae0 by task syz-executor.0/2429
> 
> CPU: 0 PID: 2429 Comm: syz-executor.0 Not tainted 5.0.0-rc7+ #45
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0xfa/0x1ce lib/dump_stack.c:113
>  print_address_description+0x1c4/0x270 mm/kasan/report.c:187
>  kasan_report+0x149/0x18d mm/kasan/report.c:317
>  memcpy+0x1f/0x50 mm/kasan/common.c:130
>  qedi_dbg_err+0xda/0x330 [qedi]
>  ? 0xffffffffc12d0000
>  qedi_init+0x118/0x1000 [qedi]
>  ? 0xffffffffc12d0000
>  ? 0xffffffffc12d0000
>  ? 0xffffffffc12d0000
>  do_one_initcall+0xfa/0x5ca init/main.c:887
>  do_init_module+0x204/0x5f6 kernel/module.c:3460
>  load_module+0x66b2/0x8570 kernel/module.c:3808
>  __do_sys_finit_module+0x238/0x2a0 kernel/module.c:3902
>  do_syscall_64+0x147/0x600 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x462e99
> Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f2d57e55c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> RAX: ffffffffffffffda RBX: 000000000073bfa0 RCX: 0000000000462e99
> RDX: 0000000000000000 RSI: 00000000200003c0 RDI: 0000000000000003
> RBP: 00007f2d57e55c70 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2d57e566bc
> R13: 00000000004bcefb R14: 00000000006f7030 R15: 0000000000000004
> 
> The buggy address belongs to the variable:
>  __func__.67584+0x0/0xffffffffffffd520 [qedi]
> 
> Memory state around the buggy address:
>  ffffffffc12b0980: fa fa fa fa 00 04 fa fa fa fa fa fa 00 00 05 fa
>  ffffffffc12b0a00: fa fa fa fa 00 00 04 fa fa fa fa fa 00 05 fa fa
>> ffffffffc12b0a80: fa fa fa fa 00 06 fa fa fa fa fa fa 00 02 fa fa
>                                                           ^
>  ffffffffc12b0b00: fa fa fa fa 00 00 04 fa fa fa fa fa 00 00 03 fa
>  ffffffffc12b0b80: fa fa fa fa 00 00 02 fa fa fa fa fa 00 00 04 fa
> 
> Currently the qedi_dbg_* family of functions can overrun the end
> of the source string if it is less than the destination buffer
> length because of the use of a fixed sized memcpy. Remove the
> memset/memcpy calls to nfunc and just use func instead as it
> is always a null terminated string.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: ace7f46ba5fd ("scsi: qedi: Add QLogic FastLinQ offload iSCSI driver framework.")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/scsi/qedi/qedi_dbg.c | 32 ++++++++------------------------
>  1 file changed, 8 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/scsi/qedi/qedi_dbg.c b/drivers/scsi/qedi/qedi_dbg.c
> index 8fd28b0..3383314 100644
> --- a/drivers/scsi/qedi/qedi_dbg.c
> +++ b/drivers/scsi/qedi/qedi_dbg.c
> @@ -16,10 +16,6 @@ qedi_dbg_err(struct qedi_dbg_ctx *qedi, const char *func, u32 line,
>  {
>  	va_list va;
>  	struct va_format vaf;
> -	char nfunc[32];
> -
> -	memset(nfunc, 0, sizeof(nfunc));
> -	memcpy(nfunc, func, sizeof(nfunc) - 1);
>  
>  	va_start(va, fmt);
>  
> @@ -28,9 +24,9 @@ qedi_dbg_err(struct qedi_dbg_ctx *qedi, const char *func, u32 line,
>  
>  	if (likely(qedi) && likely(qedi->pdev))
>  		pr_err("[%s]:[%s:%d]:%d: %pV", dev_name(&qedi->pdev->dev),
> -		       nfunc, line, qedi->host_no, &vaf);
> +		       func, line, qedi->host_no, &vaf);
>  	else
> -		pr_err("[0000:00:00.0]:[%s:%d]: %pV", nfunc, line, &vaf);
> +		pr_err("[0000:00:00.0]:[%s:%d]: %pV", func, line, &vaf);
>  
>  	va_end(va);
>  }
> @@ -41,10 +37,6 @@ qedi_dbg_warn(struct qedi_dbg_ctx *qedi, const char *func, u32 line,
>  {
>  	va_list va;
>  	struct va_format vaf;
> -	char nfunc[32];
> -
> -	memset(nfunc, 0, sizeof(nfunc));
> -	memcpy(nfunc, func, sizeof(nfunc) - 1);
>  
>  	va_start(va, fmt);
>  
> @@ -56,9 +48,9 @@ qedi_dbg_warn(struct qedi_dbg_ctx *qedi, const char *func, u32 line,
>  
>  	if (likely(qedi) && likely(qedi->pdev))
>  		pr_warn("[%s]:[%s:%d]:%d: %pV", dev_name(&qedi->pdev->dev),
> -			nfunc, line, qedi->host_no, &vaf);
> +			func, line, qedi->host_no, &vaf);
>  	else
> -		pr_warn("[0000:00:00.0]:[%s:%d]: %pV", nfunc, line, &vaf);
> +		pr_warn("[0000:00:00.0]:[%s:%d]: %pV", func, line, &vaf);
>  
>  ret:
>  	va_end(va);
> @@ -70,10 +62,6 @@ qedi_dbg_notice(struct qedi_dbg_ctx *qedi, const char *func, u32 line,
>  {
>  	va_list va;
>  	struct va_format vaf;
> -	char nfunc[32];
> -
> -	memset(nfunc, 0, sizeof(nfunc));
> -	memcpy(nfunc, func, sizeof(nfunc) - 1);
>  
>  	va_start(va, fmt);
>  
> @@ -85,10 +73,10 @@ qedi_dbg_notice(struct qedi_dbg_ctx *qedi, const char *func, u32 line,
>  
>  	if (likely(qedi) && likely(qedi->pdev))
>  		pr_notice("[%s]:[%s:%d]:%d: %pV",
> -			  dev_name(&qedi->pdev->dev), nfunc, line,
> +			  dev_name(&qedi->pdev->dev), func, line,
>  			  qedi->host_no, &vaf);
>  	else
> -		pr_notice("[0000:00:00.0]:[%s:%d]: %pV", nfunc, line, &vaf);
> +		pr_notice("[0000:00:00.0]:[%s:%d]: %pV", func, line, &vaf);
>  
>  ret:
>  	va_end(va);
> @@ -100,10 +88,6 @@ qedi_dbg_info(struct qedi_dbg_ctx *qedi, const char *func, u32 line,
>  {
>  	va_list va;
>  	struct va_format vaf;
> -	char nfunc[32];
> -
> -	memset(nfunc, 0, sizeof(nfunc));
> -	memcpy(nfunc, func, sizeof(nfunc) - 1);
>  
>  	va_start(va, fmt);
>  
> @@ -115,9 +99,9 @@ qedi_dbg_info(struct qedi_dbg_ctx *qedi, const char *func, u32 line,
>  
>  	if (likely(qedi) && likely(qedi->pdev))
>  		pr_info("[%s]:[%s:%d]:%d: %pV", dev_name(&qedi->pdev->dev),
> -			nfunc, line, qedi->host_no, &vaf);
> +			func, line, qedi->host_no, &vaf);
>  	else
> -		pr_info("[0000:00:00.0]:[%s:%d]: %pV", nfunc, line, &vaf);
> +		pr_info("[0000:00:00.0]:[%s:%d]: %pV", func, line, &vaf);
>  
>  ret:
>  	va_end(va);
> 

