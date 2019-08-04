Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A3EC19759
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 17:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB1E2070D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 17:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="B9RzNCRh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="B9RzNCRh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfHDRtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 13:49:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44472 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfHDRtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 13:49:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AB4B2608BA; Sun,  4 Aug 2019 17:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564940971;
        bh=VN99tiC0U1lR8I+tyALfoR5NMSDvlEA+5ImXh/njDCY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=B9RzNCRhdvUUaci8lKhSdvF7hSO02Mzl2NwqU/GCQkpv+LnEUgnDFHQXQHagvxy+Y
         atK7mLnpQlzrY/2mg6tYfo99srPV0wAQ78BE2nkwSzSL7em2YqGtvhrsksUOHZEbtY
         tNS/khOrgZ5m+2tugY9jE8t+55BTvLLrqtfl3bFs=
Received: from [192.168.225.112] (unknown [49.32.218.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3E81760328;
        Sun,  4 Aug 2019 17:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564940971;
        bh=VN99tiC0U1lR8I+tyALfoR5NMSDvlEA+5ImXh/njDCY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=B9RzNCRhdvUUaci8lKhSdvF7hSO02Mzl2NwqU/GCQkpv+LnEUgnDFHQXQHagvxy+Y
         atK7mLnpQlzrY/2mg6tYfo99srPV0wAQ78BE2nkwSzSL7em2YqGtvhrsksUOHZEbtY
         tNS/khOrgZ5m+2tugY9jE8t+55BTvLLrqtfl3bFs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3E81760328
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH 4/9] clk: qcom: Don't reference clk_init_data after
 registration
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Andy Gross <agross@kernel.org>
References: <20190731193517.237136-1-sboyd@kernel.org>
 <20190731193517.237136-5-sboyd@kernel.org>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <aab96094-a08c-cb13-77f0-51ecd5073512@codeaurora.org>
Date:   Sun, 4 Aug 2019 23:19:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731193517.237136-5-sboyd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/1/2019 1:05 AM, Stephen Boyd wrote:
> A future patch is going to change semantics of clk_register() so that
> clk_hw::init is guaranteed to be NULL after a clk is registered. Avoid
> referencing this member here so that we don't run into NULL pointer
> exceptions.
> 
> Cc: Taniya Das <tdas@codeaurora.org>
> Cc: Andy Gross <agross@kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>


Acked-by: Taniya Das <tdas@codeaurora.org>

> ---
> 
> Please ack so I can take this through clk tree
> 
>   drivers/clk/qcom/clk-rpmh.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> index c3fd632af119..7a8a84dcb70d 100644
> --- a/drivers/clk/qcom/clk-rpmh.c
> +++ b/drivers/clk/qcom/clk-rpmh.c
> @@ -396,6 +396,7 @@ static int clk_rpmh_probe(struct platform_device *pdev)
>   	hw_clks = desc->clks;
>   
>   	for (i = 0; i < desc->num_clks; i++) {
> +		const char *name = hw_clks[i]->init->name;
>   		u32 res_addr;
>   		size_t aux_data_len;
>   		const struct bcm_db *data;
> @@ -426,8 +427,7 @@ static int clk_rpmh_probe(struct platform_device *pdev)
>   
>   		ret = devm_clk_hw_register(&pdev->dev, hw_clks[i]);
>   		if (ret) {
> -			dev_err(&pdev->dev, "failed to register %s\n",
> -				hw_clks[i]->init->name);
> +			dev_err(&pdev->dev, "failed to register %s\n", name);
>   			return ret;
>   		}
>   	}
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
