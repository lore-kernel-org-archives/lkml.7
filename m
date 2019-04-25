Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808F8C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4F8208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbfDYH4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:56:18 -0400
Received: from m97179.mail.qiye.163.com ([220.181.97.179]:3162 "EHLO
        m97179.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbfDYH4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:56:17 -0400
Received: from localhost (unknown [117.48.120.186])
        by m97179.mail.qiye.163.com (Hmail) with ESMTPA id CF953E01716;
        Thu, 25 Apr 2019 15:56:12 +0800 (CST)
Date:   Thu, 25 Apr 2019 15:56:12 +0800
From:   WANG Chao <chao.wang@ucloud.cn>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH 1/3] RAS/CEC: fix __find_elem
Message-ID: <20190425075612.GA10363@WANG-Chaos-MacBook-Pro.local>
References: <20190418034115.75954-1-chao.wang@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418034115.75954-1-chao.wang@ucloud.cn>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-HM-Spam-Status: e1kIGBQJHllBWUtVS1lXWShZQUlCN1dZLVlBSVdZCQ4XHghZQVkyNS06Nz
        I*QUtVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MUk6ARw*Szg#UTUiLz4zIkkr
        UQgwFAhVSlVKTk5NSkxDQkxIS0tLVTMWGhIXVRgTGhRVDBoVHDsOGBcUDh9VGBVFWVdZEgtZQVlK
        SkxVT0NVSklLVUpDTVlXWQgBWUFKTE1ONwY+
X-HM-Tid: 0a6a537eb0bc20bdkuqycf953e01716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/18/19 at 11:41P, WANG Chao wrote:
> A left over pfn (because we don't clear) at ca->array[n] can be a match
> in __find_elem. Later it'd cause a memmove size overflow in del_elem.
> 
> Signed-off-by: WANG Chao <chao.wang@ucloud.cn>
> ---
>  drivers/ras/cec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
> index 2d9ec378a8bc..2e0bf1269c31 100644
> --- a/drivers/ras/cec.c
> +++ b/drivers/ras/cec.c
> @@ -206,7 +206,7 @@ static int __find_elem(struct ce_array *ca, u64 pfn, unsigned int *to)
>  
>  	this_pfn = PFN(ca->array[min]);
>  
> -	if (this_pfn == pfn)
> +	if (this_pfn == pfn && ca->n > min)
>  		return min;
>  
>  	return -ENOKEY;

Any thought on this one?
