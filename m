Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3CAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6A02087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="F8fVPn13";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CfyQG8eH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbfC0OhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:37:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35168 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfC0OhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:37:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A6F68615E3; Wed, 27 Mar 2019 14:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553697438;
        bh=oLVp+S4pX3+Q4X0jaE94zTthIOCjyrOpII1sCoN95go=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=F8fVPn13lin1RXvEQegx61FYIpp1LdKBfWC+JpxJ1rF/PnVx0b3kafzsB1EhlWcRD
         PRxdFPVcvvibvHxc5JQ8hiLxcP8dFvb+IxtqQGR9RDVa0n+b1RFy0fz4/i19HzM0vZ
         QHw/u0NiqMd7oIsFTYeUekakiW2EkZXNct+GruPI=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E562960DA8;
        Wed, 27 Mar 2019 14:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553697394;
        bh=oLVp+S4pX3+Q4X0jaE94zTthIOCjyrOpII1sCoN95go=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CfyQG8eHo+qPpSFVE2wQg7HJY2h9FZKunvUeS+QqVcerf3CEdteD95F75mHHwXUD5
         qi5xez1Peg8swxSmxDpiQrSPY0L2001C3pHR5xeRyOd8Tp1YJFJM2LMFI57HjJa4P7
         L5qwRF+sXgBhYqb6JaSlRPoiW0dEPDUQezSc+w58=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E562960DA8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v3] thunderbolt: Fix to check the return value of kmemdup
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20190325212523.11799-1-pakki001@umn.edu>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <29cec5e8-469d-bb3d-f0e3-bfdaedca8867@codeaurora.org>
Date:   Wed, 27 Mar 2019 20:06:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190325212523.11799-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/26/2019 2:55 AM, Aditya Pakki wrote:
> uuid in add_switch is allocted via kmemdup which can fail. The patch
> logs the error and cleans up the allocated memory for switch.
>
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh

>
> ---
> v2: replace WARN_ONCE with tb_sw_warn, as suggested by Mika
> v1: Change warn_once to return after clean up.
> ---
>   drivers/thunderbolt/icm.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
> index e3fc920af682..8b7f9131e9d1 100644
> --- a/drivers/thunderbolt/icm.c
> +++ b/drivers/thunderbolt/icm.c
> @@ -473,6 +473,11 @@ static void add_switch(struct tb_switch *parent_sw, u64 route,
>   		goto out;
>   
>   	sw->uuid = kmemdup(uuid, sizeof(*uuid), GFP_KERNEL);
> +	if (!sw->uuid) {
> +		tb_sw_warn(sw, "cannot allocate memory for switch\n");
> +		tb_switch_put(sw);
> +		goto out;
> +	}
>   	sw->connection_id = connection_id;
>   	sw->connection_key = connection_key;
>   	sw->link = link;
