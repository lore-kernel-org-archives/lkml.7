Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05779C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2B6206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfDLJUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 05:20:12 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43004 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726838AbfDLJUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 05:20:12 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DA1DF5CE4DCAD6EB215F;
        Fri, 12 Apr 2019 17:20:08 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Fri, 12 Apr 2019
 17:20:06 +0800
Subject: Re: [PATCH] scsi: qedf: replace memset/memcpy with safer strscpy
To:     Colin King <colin.king@canonical.com>,
        <QLogic-Storage-Upstream@cavium.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
References: <20190412090552.26925-1-colin.king@canonical.com>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <5ad7aee7-0c0b-5d1d-e40d-39e8bbe5e841@huawei.com>
Date:   Fri, 12 Apr 2019 17:20:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190412090552.26925-1-colin.king@canonical.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I send a similar fix earlier, but it seems not be picked.

https://patchwork.kernel.org/patch/10874565/

On 2019/4/12 17:05, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the qedf_dbg_* family of functions can overrun the end
> of the source string if it is less than the destination buffer
> length because of the use of a fixed sized memcpy. Replace the
> memset/memcpy calls with the safer strscpy as this won't overrun
> the end of the source string and it ensures the destination
> string is always terminated with NUL.
> 
> Addresses-Coverity: ("Out-of-bounds access")
> Fixes: 61d8658b4a43 ("scsi: qedf: Add QLogic FastLinQ offload FCoE driver framework.")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/scsi/qedf/qedf_dbg.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/scsi/qedf/qedf_dbg.c b/drivers/scsi/qedf/qedf_dbg.c
> index f2397ee9ba69..b491bebeaca9 100644
> --- a/drivers/scsi/qedf/qedf_dbg.c
> +++ b/drivers/scsi/qedf/qedf_dbg.c
> @@ -17,8 +17,7 @@ qedf_dbg_err(struct qedf_dbg_ctx *qedf, const char *func, u32 line,
>  	struct va_format vaf;
>  	char nfunc[32];
>  
> -	memset(nfunc, 0, sizeof(nfunc));
> -	memcpy(nfunc, func, sizeof(nfunc) - 1);
> +	strscpy(nfunc, func, sizeof(nfunc));
>  
>  	va_start(va, fmt);
>  
> @@ -42,8 +41,7 @@ qedf_dbg_warn(struct qedf_dbg_ctx *qedf, const char *func, u32 line,
>  	struct va_format vaf;
>  	char nfunc[32];
>  
> -	memset(nfunc, 0, sizeof(nfunc));
> -	memcpy(nfunc, func, sizeof(nfunc) - 1);
> +	strscpy(nfunc, func, sizeof(nfunc));
>  
>  	va_start(va, fmt);
>  
> @@ -71,8 +69,7 @@ qedf_dbg_notice(struct qedf_dbg_ctx *qedf, const char *func, u32 line,
>  	struct va_format vaf;
>  	char nfunc[32];
>  
> -	memset(nfunc, 0, sizeof(nfunc));
> -	memcpy(nfunc, func, sizeof(nfunc) - 1);
> +	strscpy(nfunc, func, sizeof(nfunc));
>  
>  	va_start(va, fmt);
>  
> @@ -101,8 +98,7 @@ qedf_dbg_info(struct qedf_dbg_ctx *qedf, const char *func, u32 line,
>  	struct va_format vaf;
>  	char nfunc[32];
>  
> -	memset(nfunc, 0, sizeof(nfunc));
> -	memcpy(nfunc, func, sizeof(nfunc) - 1);
> +	strscpy(nfunc, func, sizeof(nfunc));
>  
>  	va_start(va, fmt);
>  
> 

