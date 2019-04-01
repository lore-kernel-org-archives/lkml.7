Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BB0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F872206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A7zAAj0b";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DXbA+KoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfDAMrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 08:47:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37264 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfDAMrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 08:47:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2780960779; Mon,  1 Apr 2019 12:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554122832;
        bh=iO570D9c/SeXl1+zXFPXhz4P9wddi3r2e2pcW4ldUsQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=A7zAAj0bC+LMghckWbKqUI2Gn2Py0pCurcGfN5Fy4UZhonmXz1PVfkr0wt8Sx9925
         PLYW0Ev0Bpv/kJ+K5fZFW0FhheLG5Gy4UKLH9tUzGfdTfpXe2E6+f25HpiFJL/jpVf
         mpT8IfxwK+S9L2G59f5GPp3iFSYYQEZBM/tKugRQ=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BF77060452;
        Mon,  1 Apr 2019 12:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554122830;
        bh=iO570D9c/SeXl1+zXFPXhz4P9wddi3r2e2pcW4ldUsQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DXbA+KoZKVqVf4fN9kxVMkc7xbJbGs4337+sen+dUy36RLCihgwtbxqoOps3zabhL
         +FUVgUGcdl8dJzBj2oOiyu3RFM6Y6gCXmiCnCF7tna+VT3Aqu2jroWhvLq6FxVUuyJ
         oPsqASovMKYnNgmniKb9hteSjIrDLJz3tvI+L/e4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BF77060452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH 12/12] drivers: firmware: psci: add missing of_node_put
 after of_device_is_available
To:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1550928043-14889-1-git-send-email-Julia.Lawall@lip6.fr>
 <1550928043-14889-13-git-send-email-Julia.Lawall@lip6.fr>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <9b159e80-1ad2-0254-9543-852e1d7f04f9@codeaurora.org>
Date:   Mon, 1 Apr 2019 18:17:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1550928043-14889-13-git-send-email-Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/23/2019 6:50 PM, Julia Lawall wrote:
> Add an of_node_put when a tested device node is not available.
>
> The semantic patch that fixes this problem is as follows
> (http://Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
>
> Cheers,
> -Mukesh.lip6.fr):
>
> // <smpl>
> @@
> identifier f;
> local idexpression e;
> expression x;
> @@
>
> e = f(...);
> ... when != of_node_put(e)
>      when != x = e
>      when != e = x
>      when any
> if (<+...of_device_is_available(e)...+>) {
>    ... when != of_node_put(e)
> (
>    return e;
> |
> + of_node_put(e);
>    return ...;
> )
> }
> // </smpl>
>
> Fixes: d09a0011ec0d5 ("drivers: psci: Allow PSCI node to be disabled")
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
>
> ---
>   drivers/firmware/psci.c |    4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff -u -p a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> --- a/drivers/firmware/psci.c
> +++ b/drivers/firmware/psci.c
> @@ -677,8 +677,10 @@ int __init psci_dt_init(void)
>   
>   	np = of_find_matching_node_and_match(NULL, psci_of_match, &matched_np);
>   
> -	if (!np || !of_device_is_available(np))
> +	if (!np || !of_device_is_available(np)) {
> +		of_node_put(np);
>   		return -ENODEV;
> +	}
>   
>   	init_fn = (psci_initcall_t)matched_np->data;
>   	return init_fn(np);
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
