Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A62C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E0321871
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PziBWv9+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PziBWv9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731218AbfDEOez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:34:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57364 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfDEOez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:34:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7E51C60159; Fri,  5 Apr 2019 14:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554474894;
        bh=VIsPEdtxk39u4KfwGH468mcKyXqkrGIDNNiAHYHYGxI=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=PziBWv9+fnznGMfsNkaLjZT4jp1uS3d1N75byVLGWvDfiOm09LkGmr705pLh2LLKx
         EJbzP4lDLiyseT7dY5rvVt5ruOfmavoxkGCJnPX3Yi/Rwk0DYFivyCJdB+Q2eO2Fon
         6Jrdo/nXm8IE/hwBIEaeHd8keybPbppvQ6j8a6Q8=
Received: from [10.226.58.28] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4A6526030E;
        Fri,  5 Apr 2019 14:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554474894;
        bh=VIsPEdtxk39u4KfwGH468mcKyXqkrGIDNNiAHYHYGxI=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=PziBWv9+fnznGMfsNkaLjZT4jp1uS3d1N75byVLGWvDfiOm09LkGmr705pLh2LLKx
         EJbzP4lDLiyseT7dY5rvVt5ruOfmavoxkGCJnPX3Yi/Rwk0DYFivyCJdB+Q2eO2Fon
         6Jrdo/nXm8IE/hwBIEaeHd8keybPbppvQ6j8a6Q8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4A6526030E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v1] clk: Probe defer clk_get() on orphans
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>, mturquette@baylibre.com
Cc:     bjorn.andersson@linaro.org, georgi.djakov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1549911467-2465-1-git-send-email-jhugo@codeaurora.org>
 <873279a6-0755-2094-ec99-d9e5f6c963dd@codeaurora.org>
 <155191438574.20095.6161802248500300707@swboyd.mtv.corp.google.com>
 <29112c43-790e-e7e4-9e4b-9eda8f5bdb78@codeaurora.org>
Message-ID: <5eaebfd5-6c46-62ac-e04a-bf68a5bccefc@codeaurora.org>
Date:   Fri, 5 Apr 2019 08:34:51 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <29112c43-790e-e7e4-9e4b-9eda8f5bdb78@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/2019 8:50 AM, Jeffrey Hugo wrote:
> On 3/6/2019 4:19 PM, Stephen Boyd wrote:
>> Quoting Jeffrey Hugo (2019-03-06 13:48:13)
>>> Ping?
>>>
>>> Stephen, I know as this depends on your clock parent handling series
>>> (happens to apply just fine to v2), its not going to be accepted until
>>> that gets sorted out, but do you have any thoughts on if this seems like
>>> an appropriate thing to do, or if you'd like to see a different 
>>> solution?
>>
>> Please don't ping during the merge window. I'll probably look at this
>> patch next week.
>>
> 
> Sorry about pinging during the merge window.  At the time, I just 
> realized the patch has been on list for several weeks with no response, 
> but hadn't connected the dots that it happened to be the merge window at 
> that particular moment.
> 
> Any update on when you think you might get around to having a look at this?
> 

Ping? (again)

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
