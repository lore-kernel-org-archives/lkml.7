Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B036C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3E720855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PEBa1Qx/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PEBa1Qx/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfDDH7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:59:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47822 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfDDH7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:59:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DAAF1602BA; Thu,  4 Apr 2019 07:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554364775;
        bh=AVFux6UAOHLZUt7+bphm+9DfmNSrjxYsj+iGKxLNIrk=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=PEBa1Qx/XajjGZG6yWEU72Gc1v1MwBHFkvvUyR4mj2N8/qY2imYxKnwKkGjrCqfFD
         P4d2qtJEgfiqthopvIhiM+CMBJAKbC1T9qbIMhKkDPMU5YS2vU3hn7bVNowCcexR+s
         Lp2ev6N3M/HknGD8OsNVDI3k6Ss5bxG1PtPjKtak=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3E1D5602BA;
        Thu,  4 Apr 2019 07:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554364775;
        bh=AVFux6UAOHLZUt7+bphm+9DfmNSrjxYsj+iGKxLNIrk=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=PEBa1Qx/XajjGZG6yWEU72Gc1v1MwBHFkvvUyR4mj2N8/qY2imYxKnwKkGjrCqfFD
         P4d2qtJEgfiqthopvIhiM+CMBJAKbC1T9qbIMhKkDPMU5YS2vU3hn7bVNowCcexR+s
         Lp2ev6N3M/HknGD8OsNVDI3k6Ss5bxG1PtPjKtak=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3E1D5602BA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] genirq: Fix uninitialized request_mutex
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190404074512.145533-1-wangkefeng.wang@huawei.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <abcf09c2-d20d-8616-bcbb-4aebd4dc5e44@codeaurora.org>
Date:   Thu, 4 Apr 2019 13:29:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404074512.145533-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/4/2019 1:15 PM, Kefeng Wang wrote:
> When !CONFIG_SPARSE_IRQ, request_mutex of struct irq_desc won't
> be initialiezed, it leads to system hung, fix it.
>
> Fixes: 9114014cf4e6 ("genirq: Add mutex to irq desc to serialize request/free_irq()")
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   kernel/irq/irqdesc.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> index 13539e12cd80..9f8a709337cf 100644
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -558,6 +558,7 @@ int __init early_irq_init(void)
>   		alloc_masks(&desc[i], node);
>   		raw_spin_lock_init(&desc[i].lock);
>   		lockdep_set_class(&desc[i].lock, &irq_desc_lock_class);
> +		mutex_init(&desc[i].request_mutex);
>   		desc_set_defaults(i, &desc[i], node, NULL, NULL);
>   	}
>   	return arch_early_irq_init();
