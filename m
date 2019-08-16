Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74A9C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 03:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95705206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 03:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A3TWWQOM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A3TWWQOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfHPDwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 23:52:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48230 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfHPDwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 23:52:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AF34B60736; Fri, 16 Aug 2019 03:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565927553;
        bh=oU4AJrmtAw4Osv7wuvxRGOwqJRsWDXy9wS8RCFjvW0k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=A3TWWQOMColfWjfHXy0f7uJLXHrva/mQ4osHJViC5MbXJRdCPai4xPY01pwHvnmW7
         GvYajr9wM+nSFUnfK67CiFVZj7Dgp9dmE2sGZwIyo9b8SO08FTQw5X88kcFmIdWyvx
         ldsOMlczhpAEQ0nvooc4bhnKFkeIE0l4fMYGgU8o=
Received: from [10.206.28.9] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F0FE760112;
        Fri, 16 Aug 2019 03:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565927553;
        bh=oU4AJrmtAw4Osv7wuvxRGOwqJRsWDXy9wS8RCFjvW0k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=A3TWWQOMColfWjfHXy0f7uJLXHrva/mQ4osHJViC5MbXJRdCPai4xPY01pwHvnmW7
         GvYajr9wM+nSFUnfK67CiFVZj7Dgp9dmE2sGZwIyo9b8SO08FTQw5X88kcFmIdWyvx
         ldsOMlczhpAEQ0nvooc4bhnKFkeIE0l4fMYGgU8o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F0FE760112
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v2] clk: Fix falling back to legacy parent string matching
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        Chen-Yu Tsai <wens@csie.org>
References: <20190813214147.34394-1-sboyd@kernel.org>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <45962393-0b88-46c3-500f-1eec29d1729c@codeaurora.org>
Date:   Fri, 16 Aug 2019 09:22:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813214147.34394-1-sboyd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

Thanks for the patch, I have tested it on the device.

On 8/14/2019 3:11 AM, Stephen Boyd wrote:
> Calls to clk_core_get() will return ERR_PTR(-EINVAL) if we've started
> migrating a clk driver to use the DT based style of specifying parents
> but we haven't made any DT updates yet. This happens when we pass a
> non-NULL value as the 'name' argument of of_parse_clkspec(). That
> function returns -EINVAL in such a situation, instead of -ENOENT like we
> expected. The return value comes back up to clk_core_fill_parent_index()
> which proceeds to skip calling clk_core_lookup() because the error
> pointer isn't equal to -ENOENT, it's -EINVAL.
> 
> Furthermore, we blindly overwrite the error pointer returned by
> clk_core_get() with NULL when there isn't a legacy .name member
> specified in the parent map. This isn't too bad right now because we
> don't really care to differentiate NULL from an error, but in the future
> we should only try to do a legacy lookup if we know we might find
> something. This way DT lookups that fail don't try to lookup based on
> strings when there isn't any string to match, hiding the error from DT
> parsing.
> 
> Fix both these problems so that clk provider drivers can use the new
> style of parent mapping without having to also update their DT at the
> same time. This patch is based on an earlier patch from Taniya Das which
> checked for -EINVAL in addition to -ENOENT return values from
> clk_core_get().
> 
> Fixes: 601b6e93304a ("clk: Allow parents to be specified via clkspec index")
> Cc: Taniya Das <tdas@codeaurora.org>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Reported-by: Taniya Das <tdas@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
> 

Tested-by: Taniya Das <tdas@codeaurora.org>

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
