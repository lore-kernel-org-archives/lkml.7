Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4362C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 07:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C252082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 07:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jkz2T8eZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iOaTkHDb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732511AbfC0HRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 03:17:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33940 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfC0HRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 03:17:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 37C5460850; Wed, 27 Mar 2019 07:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553671055;
        bh=s16dO/mFdpcqcD93rsQqOFOpTGE0w+7QTRLLkPbNsIQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jkz2T8eZtvMNgQU7rwpsxUe4hnArzBZccJUTVh/W5+N8dniBUsuzgMQ3J/bTSJlWL
         vIMjPKpv/dHV7DDKRsy3ymqeHvzBVOmb55Vq6RzQbLNHLr1yBKiMs0+kt19fV2GKrM
         0z7K+m2osZWiC1OzbBTZG8s/afGwlb3AnjukPn9s=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0799360850;
        Wed, 27 Mar 2019 07:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553671054;
        bh=s16dO/mFdpcqcD93rsQqOFOpTGE0w+7QTRLLkPbNsIQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iOaTkHDb45vLyK1vFJMv8+vXtyjpcjCRe8iKSvdWMFLiiyOMEqAbFSi2oLpMpVZxP
         exDvbe60PAT3pQILhjBOGNrAhF0FpvCsUYYDrBW36b7LXzBXV15ZYjz1avbTOkkBQ0
         KPc72sU4Wj9MlyNhkJhzKFiKxUZjZ4Otf3JNW8Ok=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0799360850
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] ARM: socfpga: Fix object reference leaks in
 socfpga_setup_ocram_self_refresh
To:     Huang Zijiang <huang.zijiang@zte.com.cn>, dinguyen@kernel.org
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn
References: <1553644422-42950-1-git-send-email-huang.zijiang@zte.com.cn>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <36c310f4-e22d-42bb-4d8d-c1e41306ede2@codeaurora.org>
Date:   Wed, 27 Mar 2019 12:47:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <1553644422-42950-1-git-send-email-huang.zijiang@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/27/2019 5:23 AM, Huang Zijiang wrote:
> The of_find_device_by_node() takes a reference to the underlying device
> structure, we should release that reference.
>
> Signed-off-by: Huang Zijiang <huang.zijiang@zte.com.cn>
> ---
>   arch/arm/mach-socfpga/pm.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-socfpga/pm.c b/arch/arm/mach-socfpga/pm.c
> index d486678..8d7ca14 100644
> --- a/arch/arm/mach-socfpga/pm.c
> +++ b/arch/arm/mach-socfpga/pm.c
> @@ -53,7 +53,7 @@ static int socfpga_setup_ocram_self_refresh(void)
>   	if (!pdev) {
>   		pr_warn("%s: failed to find ocram device!\n", __func__);
>   		ret = -ENODEV;
> -		goto put_node;
> +		goto fail;
>   	}
>   
>   	ocram_pool = gen_pool_get(&pdev->dev, NULL);
> @@ -94,6 +94,9 @@ static int socfpga_setup_ocram_self_refresh(void)
>   
>   put_node:
>   	of_node_put(np);
> +	put_device(&np->dev);
> +fail:
> +	of_node_put(np);


of_node_put is called twice for put_node label.

Thanks,
Mukesh


>   
>   	return ret;
>   }
