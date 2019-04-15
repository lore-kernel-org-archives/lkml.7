Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A4AC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B786218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cK2xQfhl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iKiOAPmB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfDOSGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:06:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52450 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfDOSGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:06:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 34B11619C7; Mon, 15 Apr 2019 18:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555351562;
        bh=RbEGLvx6PixpimFTy6lztMRh+o94+kQDSZx1j7kCmj8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cK2xQfhlifExa5Y6jsyudVVJXKC1GZDx+EYKzBvuLjmPJ65wNxOMWWFif/W5FRKVQ
         EH4BZ2hV6wNOA3v/L40nmma0brj2XOjcpWsLvGLq7mbPq8jhZH1XhicPYrd0sJ4kKM
         e/vtqu7QboA9GMPrmZcm9Olq7LPksmw+BEEaVFko=
Received: from [10.226.58.28] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A438860FEB;
        Mon, 15 Apr 2019 18:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555351559;
        bh=RbEGLvx6PixpimFTy6lztMRh+o94+kQDSZx1j7kCmj8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iKiOAPmB0Ce9doZkFM4fxycgOZ9tI+4wX58uzA1WEWDaNt1yYNYLekqYpJfxJnKYY
         cZeDhMoW4UTmxV+BAlLIbWzwthoWLM+jpMfhro/j6fwY5ua6c6epmpFZIXA79kEhEz
         IALuQcO9cP6pB/MORlMvSf6wALJlsWeJfKJxMc1g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A438860FEB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v4 0/9] Rewrite clk parent handling
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>
References: <20190412183150.102131-1-sboyd@kernel.org>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <d7164804-7bee-de79-42b0-22b10cf96eaa@codeaurora.org>
Date:   Mon, 15 Apr 2019 12:05:56 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190412183150.102131-1-sboyd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/2019 12:31 PM, Stephen Boyd wrote:
> There are a couple warts with clk parent handling in the common clk
> framework. This patch series addresses one of those warts, parent-child
> linkages. We use strings for all parent-child linkages, and this leads
> to poorly written code that extracts clk names from struct clk pointers
> and makes clk provider drivers use clk consumer APIs. I've converted the
> fixed factor clk and I'm looking at converting users of other "basic"
> clk types in follow-up patches so we can start moving drivers away from
> string matching in the clk namespace.
> 
> Changes from v3:
>   * Split clkdev patch into two
>   * New patch to let dev_of_node() accept NULL
>   * Use dev_of_node() in of_clk_hw_register() to avoid NULL deref
> 
> Changes from v2:
>   * Dropped patches that got merged into v5.1-rc1
>   * Introduced a new function of_clk_hw_register()
>   * Introduced 'index' into clk_parent_data structure
>   * Converted fixed-factor basic type to new design
>   * Fixed some bugs in a recent patch to clkdev, leading to
>     an essential API for clkdev based lookups working
> 
> Changes from v1:
>   * Dropped new get_parent_hw, we'll pick it up in a later series
>   * Rebased to v5.0-rc6 to avoid conflicts with clk-fixes
>   * Renamed 'fallback' to 'name' and 'name' to 'fw_name' in parent map
>   * Made sure that clk_hw_get_parent_by_index() never sees an error pointer
>     so that we don't mistakenly try to defer an error pointer
>   * Fixed index passing mistake on of_clk_get_hw_from_clkspec()
>   * Copy over all the data from parent maps and free it correctly too
> 
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jeffrey Hugo <jhugo@codeaurora.org>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> 
> Stephen Boyd (9):
>    clkdev: Hold clocks_mutex while iterating clocks list
>    clkdev: Move clk creation outside of 'clocks_mutex'
>    clk: Prepare for clk registration API that uses DT nodes
>    driver core: Let dev_of_node() accept a NULL dev
>    clk: Add of_clk_hw_register() API for early clk drivers
>    clk: Allow parents to be specified without string names
>    clk: Look for parents with clkdev based clk_lookups
>    clk: Allow parents to be specified via clkspec index
>    clk: fixed-factor: Let clk framework find parent
> 
>   drivers/clk/clk-fixed-factor.c |  53 ++++--
>   drivers/clk/clk.c              | 326 +++++++++++++++++++++++++--------
>   drivers/clk/clk.h              |   2 +
>   drivers/clk/clkdev.c           |  30 +--
>   include/linux/clk-provider.h   |  22 +++
>   include/linux/device.h         |   2 +-
>   6 files changed, 327 insertions(+), 108 deletions(-)
> 
> 
> base-commit: 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b
> 

Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
