Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FCCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 12:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260F220700
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 12:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hCPtFVms";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hCPtFVms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbfC2Mlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 08:41:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48812 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729483AbfC2Mln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 08:41:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BCD4E6053B; Fri, 29 Mar 2019 12:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553863302;
        bh=svoyHdsfknhYZkHlh1dpyQziKSCvrtzLyfMm1dSAI2M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hCPtFVmsJr3GfqDWDDdB8jsX7Mega+vFMkNMukDVFtRXTRooKksZzdKPCwd6zpNDv
         2N7M7iQXwSuhZeAdTluxH7wnlkbe5bWRuBnztXEBLLaFfDACXSWRpvSeSHJ5Ig+dIG
         WLe08ovqgQvy1ClmAvqvxI2BTVgeT5e5x37J3b8o=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C3F0A6053B;
        Fri, 29 Mar 2019 12:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553863302;
        bh=svoyHdsfknhYZkHlh1dpyQziKSCvrtzLyfMm1dSAI2M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hCPtFVmsJr3GfqDWDDdB8jsX7Mega+vFMkNMukDVFtRXTRooKksZzdKPCwd6zpNDv
         2N7M7iQXwSuhZeAdTluxH7wnlkbe5bWRuBnztXEBLLaFfDACXSWRpvSeSHJ5Ig+dIG
         WLe08ovqgQvy1ClmAvqvxI2BTVgeT5e5x37J3b8o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C3F0A6053B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] clk:mmp: clk-mix.c fix divide-by-zero
To:     nixiaoming <nixiaoming@huawei.com>, mturquette@baylibre.com,
        sboyd@kernel.org, chao.xie@marvell.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1553859960-31501-1-git-send-email-nixiaoming@huawei.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <2882780e-ac45-c5e7-26fd-a1882a67113a@codeaurora.org>
Date:   Fri, 29 Mar 2019 18:11:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1553859960-31501-1-git-send-email-nixiaoming@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/29/2019 5:16 PM, nixiaoming wrote:
> The _get_div function has a branch with a return value of 0
> Add a check on the return value of _get_div to avoid divide-by-zero
>
> Signed-off-by: nixiaoming <nixiaoming@huawei.com>

Fix the below minor comments..
Otherwise things look good..you can take mine
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

after fixing it.


Cheers,
-Mukesh


> ---
>   drivers/clk/mmp/clk-mix.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/clk/mmp/clk-mix.c b/drivers/clk/mmp/clk-mix.c
> index 90814b2..9d152c2 100644
> --- a/drivers/clk/mmp/clk-mix.c
> +++ b/drivers/clk/mmp/clk-mix.c
> @@ -245,6 +245,8 @@ static int mmp_clk_mix_determine_rate(struct clk_hw *hw,
>   			div_val_max = _get_maxdiv(mix);
>   			for (j = 0; j < div_val_max; j++) {
>   				div = _get_div(mix, j);
> +				if (!div) /* avoid divide-by-zero */

Please move this comment at the top of the check.


> +					continue;
>   				mix_rate = parent_rate / div;
>   				gap = abs(mix_rate - req->rate);
>   				if (!parent_best || gap < gap_best) {
> @@ -341,6 +343,8 @@ static unsigned long mmp_clk_mix_recalc_rate(struct clk_hw *hw,
>   	shift = mix->reg_info.shift_div;
>   
>   	div = _get_div(mix, MMP_CLK_BITS_GET_VAL(mux_div, width, shift));
> +	if (!div) /* avoid divide-by-zero */
ditto
> +		return -EINVAL;
>   
>   	return parent_rate / div;
>   }
