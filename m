Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E484C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E5A206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YEhGFQ/3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="anz3SQkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfDAMso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 08:48:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41534 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDAMso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 08:48:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8A8EB607C3; Mon,  1 Apr 2019 12:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554122923;
        bh=Jtw4TZiLvR7Dkhwk9uCAI8XWMIxxfoEZoMXR0/MRUog=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YEhGFQ/3Kz45F7p2x63YldTZXI5BDqlCtLq2xzMcFUruFVwFnfnZrQ6GZaU0+9IIe
         6rig5vZAcjCsxidbpHM4bmYr6xoxdnePs5h6Vuyo21DyZ5y4qWHcYP1UTCDEWaffD2
         CQggibhP9TMbhmo33Wgqgaamp6FgBsQP3SlIPuIg=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 369CF6049C;
        Mon,  1 Apr 2019 12:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554122921;
        bh=Jtw4TZiLvR7Dkhwk9uCAI8XWMIxxfoEZoMXR0/MRUog=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=anz3SQkfQ4ECvZxF8tBufFVKgmODggQ2E6prKW6676Xo6lUjT4yKWrDrqn9MUwjSC
         LVSy4vjgZlqtyM/xjafm/FYTw0ya19KGTYDauoJg49HQPrT8yoo6CXBCVn3WruqPZo
         glZ9NqKYfJx84eM/DphDDEQze2PMfwIF524GvyCQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 369CF6049C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH 01/12] arm-cci: add missing of_node_put after
 of_device_is_available
To:     Julia Lawall <Julia.Lawall@lip6.fr>, linux-kernel@vger.kernel.org,
        linux@arm.linux.org.uk, robin.murphy@arm.com
Cc:     kernel-janitors@vger.kernel.org
References: <1550928043-14889-1-git-send-email-Julia.Lawall@lip6.fr>
 <1550928043-14889-2-git-send-email-Julia.Lawall@lip6.fr>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <2be57c65-f94c-0a64-8fa6-385f60833bb6@codeaurora.org>
Date:   Mon, 1 Apr 2019 18:18:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1550928043-14889-2-git-send-email-Julia.Lawall@lip6.fr>
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
> (http://coccinelle.lip6.fr):
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
> Fixes: 896ddd600ba4 ("drivers: bus: check cci device tree node status")
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

>
> ---
> This file doesn't seem to have a maintainer.
>
>   drivers/bus/arm-cci.c |    4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff -u -p a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> --- a/drivers/bus/arm-cci.c
> +++ b/drivers/bus/arm-cci.c
> @@ -538,8 +538,10 @@ static int cci_probe(void)
>   	struct resource res;
>   
>   	np = of_find_matching_node(NULL, arm_cci_matches);
> -	if (!of_device_is_available(np))
> +	if (!of_device_is_available(np)) {
> +		of_node_put(np);
>   		return -ENODEV;
> +	}
>   
>   	ret = of_address_to_resource(np, 0, &res);
>   	if (!ret) {
>
