Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9571AC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5331620663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jmxyu8p/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WPm9Ch4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfCFVpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:45:42 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57668 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfCFVpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:45:41 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9F5A56072E; Wed,  6 Mar 2019 21:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551908740;
        bh=7JRR5fw6AB1tiYyouM+rns2k7PCD/iPYRURf7ekrz1o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jmxyu8p/d6uv/NxKrsLGj7st9qI1Qk0YdhWHmfyYlIAyG6GzOhxC3hsxDf/5sLInS
         d5/VCytwA2wX+I6PdNzYeepqJ/zzC740leYnrH9IkElHc52lnndp+0Nf/upoDAqiz8
         LhnyT09z1EZ67CHPjJ/TUhUC1+E/jfhDO0eVSM/A=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E0821604BE;
        Wed,  6 Mar 2019 21:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551908739;
        bh=7JRR5fw6AB1tiYyouM+rns2k7PCD/iPYRURf7ekrz1o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WPm9Ch4fuV1A2Hv9BGAUv0pnTMuB4QjukQRonLw7mJr05pPtotXvdOG4FxC19LFB6
         grrg8mq6gLRXSefSNKGulWHOJG68WF/msw1LmGp3pdsM8h9beTkc7mPbIskyoU3mii
         a7MpQzf33YsiVJP3ZtT8Jpd3PkTCWcPX8K6ODg+U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E0821604BE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v2 6/8] clk: Allow parents to be specified without string
 names
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Chen-Yu Tsai <wens@csie.org>
References: <20190226223429.193873-1-sboyd@kernel.org>
 <20190226223429.193873-7-sboyd@kernel.org>
 <c5b12b52-0aa0-417b-50cd-b7d6fd9fc992@codeaurora.org>
 <155189453289.20095.9593541968121360874@swboyd.mtv.corp.google.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <576e9531-e3b6-d6d2-d025-66be4773ecc2@codeaurora.org>
Date:   Wed, 6 Mar 2019 14:45:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <155189453289.20095.9593541968121360874@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/2019 10:48 AM, Stephen Boyd wrote:
> Quoting Jeffrey Hugo (2019-03-02 13:25:06)
>> On 2/26/2019 3:34 PM, Stephen Boyd wrote:
>>> The common clk framework is lacking in ability to describe the clk
>>> topology without specifying strings for every possible parent-child
>>> link. There are a few drawbacks to the current approach:
>>>
>>>    1) String comparisons are used for everything, including describing
>>>    topologies that are 'local' to a single clock controller.
>>>
>>>    2) clk providers (e.g. i2c clk drivers) need to create globally unique
>>>    clk names to avoid collisions in the clk namespace, leading to awkward
>>>    name generation code in various clk drivers.
>>>
>>>    3) DT bindings may not fully describe the clk topology and linkages
>>>    between clk controllers because drivers can easily rely on globally unique
>>>    strings to describe connections between clks.
>>>
>>> This leads to confusing DT bindings, complicated clk name generation
>>> code, and inefficient string comparisons during clk registration just so
>>> that the clk framework can detect the topology of the clk tree.
>>> Furthermore, some drivers call clk_get() and then __clk_get_name() to
>>> extract the globally unique clk name just so they can specify the parent
>>> of the clk they're registering. We have of_clk_parent_fill() but that
>>> mostly only works for single clks registered from a DT node, which isn't
>>> the norm. Let's simplify this all by introducing two new ways of
>>> specifying clk parents.
>>>
>>> The first method is an array of pointers to clk_hw structures
>>> corresponding to the parents at that index. This works for clks that are
>>> registered when we have access to all the clk_hw pointers for the
>>> parents.
>>>
>>> The second method is a mix of clk_hw pointers and strings of local and
>>> global parent clk names. If the .name member of the map is set we'll
>>> look for that clk by performing a DT based lookup of the device the clk
>>> is registered with and the .name specified in the map. If that fails,
>>> we'll fallback to the .fallback member and perform a global clk name
>>> lookup like we've always done before.
>>>
>>> Using either one of these new methods is entirely optional. Existing
>>> drivers will continue to work, and they can migrate to this new approach
>>> as they see fit. Eventually, we'll want to get rid of the 'parent_names'
>>> array in struct clk_init_data and use one of these new methods instead.
>>>
>>
>> I don't know exactly what regressed from V1, but this change breaks all
>> clock drivers as far as I can tell.  All clocks from old and new (ie
>> 8998 mmcc rebased onto this) drivers end up as orphans.
>>
>> Is there some data I can provide to help you figure out the issue?
>>
> 
> Can you try this patch? It fixes a pointer blunder that I'm sad about.

That did the trick.  Everything seems to work again.  I haven't 
identified any additional issues.

> 
> ----8<-----
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 37aea7884166..d12afd256dc5 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3297,15 +3297,17 @@ struct clk *clk_hw_create_clk(struct device *dev, struct clk_hw *hw,
>   	return clk;
>   }
>   
> -static int clk_cpy_name(const char *dst, const char *src, bool must_exist)
> +static int clk_cpy_name(const char **dst_p, const char *src, bool must_exist)
>   {
> +	const char *dst;
> +
>   	if (!src) {
>   		if (must_exist)
>   			return -EINVAL;
>   		return 0;
>   	}
>   
> -	dst = kstrdup_const(src, GFP_KERNEL);
> +	*dst_p = dst = kstrdup_const(src, GFP_KERNEL);
>   	if (!dst)
>   		return -ENOMEM;
>   
> @@ -3341,14 +3343,14 @@ static int clk_core_populate_parent_map(struct clk_core *core)
>   			WARN(!parent_names[i],
>   				"%s: invalid NULL in %s's .parent_names\n",
>   				__func__, core->name);
> -			ret = clk_cpy_name(parent->name, parent_names[i],
> +			ret = clk_cpy_name(&parent->name, parent_names[i],
>   					   true);
>   		} else if (parent_data) {
>   			parent->hw = parent_data[i].hw;
> -			ret = clk_cpy_name(parent->fw_name,
> +			ret = clk_cpy_name(&parent->fw_name,
>   					   parent_data[i].fw_name, false);
>   			if (!ret)
> -				ret = clk_cpy_name(parent->name,
> +				ret = clk_cpy_name(&parent->name,
>   						   parent_data[i].name,
>   						   false);
>   		} else if (parent_hws) {
> 


-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
