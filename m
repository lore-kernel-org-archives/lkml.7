Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB17DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 09:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885E2218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 09:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="e4pSODDu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BbWp/vi5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730585AbfC3JoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 05:44:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51892 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730453AbfC3JoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 05:44:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F03C560A05; Sat, 30 Mar 2019 09:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553939063;
        bh=TjGv+aiL37/BKi0d8iCmd4zoi3/v0/JT63TWhrlt8qo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=e4pSODDuK5ag7Opjt0JHzT6ayHmQnJLrRPwkczDvr3YKAaZPL371YJehXlzlqp6ZA
         qKWtmh/A2SGMrLT6m0OeWGJf0foWm7j7Umt5KpI1nlj42H3bS8PXrPzQPJP6m/8Ah/
         AiXGc76cY4dYMvXj4oSJnNPpxT/hxQhI4yxeoPtI=
Received: from [10.79.174.164] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 78A516087D;
        Sat, 30 Mar 2019 09:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553939060;
        bh=TjGv+aiL37/BKi0d8iCmd4zoi3/v0/JT63TWhrlt8qo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BbWp/vi5X436olsYp2pQzOjnnOpjGGFxK0fgBXJqYrsG8queFZWBu0UVGld9Idl0S
         8+Ma517Xe9dBUvZkOZiz+lytn2qDqpE4WUI16TumKVMr/M3GsaMMmqOrogb52yM3wv
         r7TjhsS7SP8x5IQSUNj+wV0vACB6OgA4PrAzQYb4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 78A516087D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v2 1/2] clk:Fix divide-by-zero in
 divider_ro_round_rate_parent
To:     nixiaoming <nixiaoming@huawei.com>, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@codeaurora.org,
        soren.brinkmann@xilinx.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1553913085-51237-1-git-send-email-nixiaoming@huawei.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <fcbcceb2-e59b-465a-ec36-cde354425898@codeaurora.org>
Date:   Sat, 30 Mar 2019 15:14:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1553913085-51237-1-git-send-email-nixiaoming@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/30/2019 8:01 AM, nixiaoming wrote:
> In the function divider_recalc_rate() The judgment of the return value of
> _get_div() indicates that the return value of _get_div() may be 0.

s/may be/can be


> In order to avoid the divide-by-zero error, add check the return values.
s/add check the/add check for

> of _get_div() in the divider_ro_round_rate_parent()
>
> Signed-off-by: nixiaoming <nixiaoming@huawei.com>


Please fix the commit text.
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/clk/clk-divider.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index e5a1726..f4bf7a4 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -347,6 +347,9 @@ long divider_ro_round_rate_parent(struct clk_hw *hw, struct clk_hw *parent,
>   	int div;
>   
>   	div = _get_div(table, val, flags, width);
> +	/* avoid divide-by-zero */
> +	if (!div)
> +		return -EINVAL;
>   
>   	/* Even a read-only clock can propagate a rate change */
>   	if (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) {
