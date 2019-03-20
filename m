Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3A4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F5620857
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Wcz5HeUx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XS8TAzEz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfCTTzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:55:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34030 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfCTTzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:55:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 21111602AE; Wed, 20 Mar 2019 19:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553111743;
        bh=0UfxQXIkfKzYXOQb8jLSIETi1pFXOVFOffboKaohwfE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Wcz5HeUx9q4ubP2MM2IZ6z0SD91z3dYm6s5US43Hwy+GY9przFB2+Z7mr0ErtaDpz
         5tKgqb+hQpSzZyRFPrg8fCs3i1lYuzAHlX1jjEKMpbcfejWbISzTV281iAH6V/I4jF
         xxXir3C2CHpcVAB6kAsbjsucLJMoTk3wFbAK76pA=
Received: from [10.79.162.149] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 41660602AE;
        Wed, 20 Mar 2019 19:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553111742;
        bh=0UfxQXIkfKzYXOQb8jLSIETi1pFXOVFOffboKaohwfE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XS8TAzEzrg6Gqpq8Q9hkg++szH385emtc0XhAZK92FpWCvQ6C5SMZxieF8Q/y8GP0
         qfDElZvMf/2P/DzIAQg76p1ZPbvOsj1gggYQdqi/L44EBxmAPYKs2bj3HSfGAvLz+r
         RkPtXK5nQ1eVT/VtnMG/hEJfOqsC10zW2W2uZDdY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 41660602AE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH -next] proc/kcore: Make kcore_modules static
To:     Yue Haibing <yuehaibing@huawei.com>, adobriyan@gmail.com,
        akpm@linux-foundation.org, osandov@fb.com, james.morse@arm.com,
        sfr@canb.auug.org.au
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20190320135417.13272-1-yuehaibing@huawei.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <6af0854e-b2c4-e5ce-ea2c-082d35f5e96e@codeaurora.org>
Date:   Thu, 21 Mar 2019 01:25:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190320135417.13272-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/20/2019 7:24 PM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
>
> Fix sparse warning:
>
> fs/proc/kcore.c:591:19: warning:
>   symbol 'kcore_modules' was not declared. Should it be static?
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   fs/proc/kcore.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index bbcc185..378f453 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -588,7 +588,7 @@ static void __init proc_kcore_text_init(void)
>   /*
>    * MODULES_VADDR has no intersection with VMALLOC_ADDR.
>    */
> -struct kcore_list kcore_modules;
> +static struct kcore_list kcore_modules;
>   static void __init add_modules_range(void)
>   {
>   	if (MODULES_VADDR != VMALLOC_START && MODULES_END != VMALLOC_END) {


Acked-by: Mukesh Ojha <mojha@codeaurora.org>

