Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA947C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827C620855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="D0YTJdMS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OGGHmYpy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfDDHXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:23:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49280 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbfDDHXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:23:48 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5627F60FED; Thu,  4 Apr 2019 07:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554362628;
        bh=obGkrUehF/h9hNDdMsTlI39/H2wgylWR9nuY2DmDsX0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=D0YTJdMS0P32AuARlavhH70J9ZeyFuVvK9ezvJkZK/V71mT6KiJbD9gduxdjUTF5Q
         Ja/ot1P/YE9ldWu3Qc1TuwM2yJYpku2+220J5FyJ4O9G0hDTX4EIF/KMH4rbhltVF5
         K6hHzx4dEvRclFr3I0DHSZ6qKc3dImMaQf+gvgyo=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E47F4619B4;
        Thu,  4 Apr 2019 07:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554362627;
        bh=obGkrUehF/h9hNDdMsTlI39/H2wgylWR9nuY2DmDsX0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OGGHmYpyFBb5ZbWLBPfpiXIf6cIWB1GTdJ878iqG76UKJZcHWm5Ij1iUh1K4pcR/K
         VBEhQFUZB7Szsy178jGmBWPWXlSIjf278CwaG/MjT7BSGJkvi/1OAs5O6g6gxJj4oO
         MSb/fVeUG30XUaeQVlo+1iOnt0PhXnIdfxsMeSqQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E47F4619B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH -next] ehea: Fix a copy-paste err in ehea_init_port_res
To:     Yue Haibing <yuehaibing@huawei.com>, davem@davemloft.net,
        dougmill@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20190403074759.13496-1-yuehaibing@huawei.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <ed410447-3ee4-72d4-81cd-406c07a4d18c@codeaurora.org>
Date:   Thu, 4 Apr 2019 12:53:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403074759.13496-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/3/2019 1:17 PM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
>
> pr->tx_bytes should be assigned to tx_bytes other than
> rx_bytes.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: ce45b873028f ("ehea: Fixing statistics")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   drivers/net/ethernet/ibm/ehea/ehea_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/ibm/ehea/ehea_main.c b/drivers/net/ethernet/ibm/ehea/ehea_main.c
> index 90b62c1..707c8ba 100644
> --- a/drivers/net/ethernet/ibm/ehea/ehea_main.c
> +++ b/drivers/net/ethernet/ibm/ehea/ehea_main.c
> @@ -1463,7 +1463,7 @@ static int ehea_init_port_res(struct ehea_port *port, struct ehea_port_res *pr,
>   
>   	memset(pr, 0, sizeof(struct ehea_port_res));
>   
> -	pr->tx_bytes = rx_bytes;
> +	pr->tx_bytes = tx_bytes;
>   	pr->tx_packets = tx_packets;
>   	pr->rx_bytes = rx_bytes;
>   	pr->rx_packets = rx_packets;
