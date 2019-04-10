Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9680CC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67AC320674
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Xi32IiVC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KjGcnu5q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfDJTjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:39:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47816 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfDJTjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:39:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A63BF60EA5; Wed, 10 Apr 2019 19:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554925159;
        bh=1CqUlb/pNdeHXthhjIHIfH/EP/L6Rud9NCGiCk6hDgw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Xi32IiVCKNCQksbBa/iiaOnkaet1Xnew1bD2ai5P7Zyzb2KMC1xTq8byc6f9o99Y6
         SSU31c6u+2bS71aT/5erzezZ7cxRTmKgFiASE7J2WgsKrn4Qq4w82ZOdlT6wlYyNw6
         YETEzeWjrzHgZLCcrSnLN3k4s6KM/ZUaMK+omWZk=
Received: from [10.226.58.28] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C3C9E60392;
        Wed, 10 Apr 2019 19:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554925158;
        bh=1CqUlb/pNdeHXthhjIHIfH/EP/L6Rud9NCGiCk6hDgw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KjGcnu5qgVcKOxXuYcRuNGtWsZhgVpSarsFkVhi0WD8VOETcxy3UjNFbOymwHmtqr
         Gyhhi9Ol728oiiKUbSW5uar7eXk4KE5KsgXKReEDgNMhhdTFjhrlSF1Nn52ssweRhM
         Clw7+iTdmBcqiPhrlRpGF42+JrP+iW47f9EQsjfU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C3C9E60392
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v3 3/7] clk: Add of_clk_hw_register() API for early clk
 drivers
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>
References: <20190404215344.6330-1-sboyd@kernel.org>
 <20190404215344.6330-4-sboyd@kernel.org>
 <f989942c-89fc-76cf-af1b-2ac352d6e60c@codeaurora.org>
 <155491520049.20095.15953237372852019635@swboyd.mtv.corp.google.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <c529d12b-5212-7198-4f70-a3f771c0901f@codeaurora.org>
Date:   Wed, 10 Apr 2019 13:39:16 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <155491520049.20095.15953237372852019635@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/2019 10:53 AM, Stephen Boyd wrote:
> Quoting Jeffrey Hugo (2019-04-08 14:46:11)
>> On 4/4/2019 3:53 PM, Stephen Boyd wrote:
>>> In some circumstances drivers register clks early and don't have access
>>> to a struct device because the device model isn't initialized yet. Add
>>> an API to let drivers register clks associated with a struct device_node
>>> so that these drivers can participate in getting parent clks through DT.
>>
>> NACK.  This patch broke boot for me.  I had to pull the below from JTAG.
>>    What do you need to debug this?
>>
> 
> Here's a patch to try to squash in:

No dice.  Same issue.

> 
> ---8<----
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 709492d901a1..040ce083c89e 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3662,7 +3662,7 @@ __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
>    */
>   struct clk *clk_register(struct device *dev, struct clk_hw *hw)
>   {
> -	return __clk_register(dev, dev->of_node, hw);
> +	return __clk_register(dev, dev_of_node(dev), hw);
>   }
>   EXPORT_SYMBOL_GPL(clk_register);
>   
> @@ -3678,7 +3678,7 @@ EXPORT_SYMBOL_GPL(clk_register);
>    */
>   int clk_hw_register(struct device *dev, struct clk_hw *hw)
>   {
> -	return PTR_ERR_OR_ZERO(__clk_register(dev, dev->of_node, hw));
> +	return PTR_ERR_OR_ZERO(__clk_register(dev, dev_of_node(dev), hw));
>   }
>   EXPORT_SYMBOL_GPL(clk_hw_register);
>   
> 


-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
