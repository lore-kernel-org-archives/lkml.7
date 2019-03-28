Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E92C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4137B20823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XMrZJx91";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JavZqeKw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfC1NuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:50:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51914 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbfC1NuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:50:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2FDAD61573; Thu, 28 Mar 2019 13:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553781023;
        bh=XcrDMM4bOmmE2TYXs5boZFTOgkL0WO5tjmpd1fkzrcc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XMrZJx91niauS6AxU20czhddnI/IbUn+xzdsoMAJuIg0M6cgKKJYbJPpiZpADpoZk
         23BLW3frHdUxy1WJt0S+9mPIuGUPIjjQDGlduGyydJY2P12g6nyBV3aWjYet/sPfHz
         117UJwNIrCCavr1omaNrcretDYxQao0/NmIUcCEw=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4ECA860AA3;
        Thu, 28 Mar 2019 13:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553781021;
        bh=XcrDMM4bOmmE2TYXs5boZFTOgkL0WO5tjmpd1fkzrcc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JavZqeKwa46wYRFY+G/8agcmTtWHSCS5ThDMTAl1DKdndrYib7C0LvtaeZR77YYl0
         ohSclnGffUEd2s8xKkfIQN2QKHqunL9QApmeWtoJHzPBlVy617rHZtrbCIkf79JbpP
         1lkH9wb0fB+nkx8kKqvjWCEIzk6Y/rGOleGP/0KA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4ECA860AA3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [RESEND PATCH] scsi: qedi: Fix global-out-of-bounds bug in qedi
 dbg function
To:     Yue Haibing <yuehaibing@huawei.com>, qla2xxx-upstream@qlogic.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        mrangankar@marvell.com, nilesh.javali@cavium.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20190328075428.25432-1-yuehaibing@huawei.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <de12f110-48c1-8d31-4001-5e3e95858d21@codeaurora.org>
Date:   Thu, 28 Mar 2019 19:20:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190328075428.25432-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/28/2019 1:24 PM, Yue Haibing wrote:
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
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0xfa/0x1ce lib/dump_stack.c:113
>   print_address_description+0x1c4/0x270 mm/kasan/report.c:187
>   kasan_report+0x149/0x18d mm/kasan/report.c:317
>   memcpy+0x1f/0x50 mm/kasan/common.c:130
>   qedi_dbg_err+0xda/0x330 [qedi]
>   ? 0xffffffffc12d0000
>   qedi_init+0x118/0x1000 [qedi]
>   ? 0xffffffffc12d0000
>   ? 0xffffffffc12d0000
>   ? 0xffffffffc12d0000
>   do_one_initcall+0xfa/0x5ca init/main.c:887
>   do_init_module+0x204/0x5f6 kernel/module.c:3460
>   load_module+0x66b2/0x8570 kernel/module.c:3808
>   __do_sys_finit_module+0x238/0x2a0 kernel/module.c:3902
>   do_syscall_64+0x147/0x600 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
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
>   __func__.67584+0x0/0xffffffffffffd520 [qedi]
>
> Memory state around the buggy address:
>   ffffffffc12b0980: fa fa fa fa 00 04 fa fa fa fa fa fa 00 00 05 fa
>   ffffffffc12b0a00: fa fa fa fa 00 00 04 fa fa fa fa fa 00 05 fa fa
>> ffffffffc12b0a80: fa fa fa fa 00 06 fa fa fa fa fa fa 00 02 fa fa
>                                                            ^
>   ffffffffc12b0b00: fa fa fa fa 00 00 04 fa fa fa fa fa 00 00 03 fa
>   ffffffffc12b0b80: fa fa fa fa 00 00 02 fa fa fa fa fa 00 00 04 fa
>
> qedi_dbg_err function does not check the length of caller's name,
> blindly copy 31 characters to array 'nfunc', then print it to log,
> which trigger global-out-of-bounds bug and may leak kernel info.
> Also other qedi dbg function may have the same issue, this patch
> fix this.
>
> Fixes: ace7f46ba5fd ("scsi: qedi: Add QLogic FastLinQ offload iSCSI driver framework.")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh
> ---
>   drivers/scsi/qedi/qedi_dbg.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/scsi/qedi/qedi_dbg.c b/drivers/scsi/qedi/qedi_dbg.c
> index 8fd28b0..cce44b9 100644
> --- a/drivers/scsi/qedi/qedi_dbg.c
> +++ b/drivers/scsi/qedi/qedi_dbg.c
> @@ -18,8 +18,7 @@ qedi_dbg_err(struct qedi_dbg_ctx *qedi, const char *func, u32 line,
>   	struct va_format vaf;
>   	char nfunc[32];
>   
> -	memset(nfunc, 0, sizeof(nfunc));
> -	memcpy(nfunc, func, sizeof(nfunc) - 1);
> +	snprintf(nfunc, sizeof(nfunc), "%s", func);
>   
>   	va_start(va, fmt);
>   
> @@ -43,8 +42,7 @@ qedi_dbg_warn(struct qedi_dbg_ctx *qedi, const char *func, u32 line,
>   	struct va_format vaf;
>   	char nfunc[32];
>   
> -	memset(nfunc, 0, sizeof(nfunc));
> -	memcpy(nfunc, func, sizeof(nfunc) - 1);
> +	snprintf(nfunc, sizeof(nfunc), "%s", func);
>   
>   	va_start(va, fmt);
>   
> @@ -72,8 +70,7 @@ qedi_dbg_notice(struct qedi_dbg_ctx *qedi, const char *func, u32 line,
>   	struct va_format vaf;
>   	char nfunc[32];
>   
> -	memset(nfunc, 0, sizeof(nfunc));
> -	memcpy(nfunc, func, sizeof(nfunc) - 1);
> +	snprintf(nfunc, sizeof(nfunc), "%s", func);
>   
>   	va_start(va, fmt);
>   
> @@ -102,8 +99,7 @@ qedi_dbg_info(struct qedi_dbg_ctx *qedi, const char *func, u32 line,
>   	struct va_format vaf;
>   	char nfunc[32];
>   
> -	memset(nfunc, 0, sizeof(nfunc));
> -	memcpy(nfunc, func, sizeof(nfunc) - 1);
> +	snprintf(nfunc, sizeof(nfunc), "%s", func);
>   
>   	va_start(va, fmt);
>   
