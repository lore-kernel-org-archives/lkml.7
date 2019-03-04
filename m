Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04F7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A4320823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jGGtCLan";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZNTSe3s8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfCDIVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:21:55 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41260 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfCDIVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:21:55 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 11BE06087D; Mon,  4 Mar 2019 08:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551687714;
        bh=XZu0XN/gc73B1S7k7lNJOkGYk1wFa69a/kuIxy0IpdI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jGGtCLanDeJyssiSvIP1TR+sQsFHkB/4VZAC0bQJanwDzPvqUiSm4N2yZegyZPjMT
         K6moqOb8N3Xn+RyetW0p5YSYf/+Ddkg4PcGkjxZ0MiD0RXYVcJFs9nOirqlp7rlExv
         6RW2EbWF7VpJhKP+gjQzgUVjyM2oE0JmvVDa5LdM=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 2E64560744;
        Mon,  4 Mar 2019 08:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551687713;
        bh=XZu0XN/gc73B1S7k7lNJOkGYk1wFa69a/kuIxy0IpdI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZNTSe3s8JP4Vj2dH40bGHB6cQppUpgs2ydpGHCjl7VBVvD9MwUwQDAsqbH5jgtCoH
         fe+HExYUejdGRrnf3B2yHsLiIw29FWaGFr5n/6mz2hXCpIgduTRZ/bUnWNaDXWTGuG
         3j1o/T1LXDZmxFLxCaRRIqJW15GmdcEPdKallom8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 04 Mar 2019 13:51:53 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     myungjoo.ham@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        skannan@codeaurora.org
Subject: Re: [PATCH v4] PM / devfreq: Restart previous governor if new
 governor fails to start
In-Reply-To: <39d3a906-b734-9bb8-c60a-48948bb21338@codeaurora.org>
References: <20181212135313.30268-1-sibis@codeaurora.org>
 <CGME20181212135338epcas5p12f7a8cd1c7aab5d5c936cbc5c33eee07@epcms1p6>
 <20181214014527epcms1p6c783b4cd1602bbcbcb6e725f840db479@epcms1p6>
 <39d3a906-b734-9bb8-c60a-48948bb21338@codeaurora.org>
Message-ID: <946aa4e13aec4f84e6ae2d91e772fb1f@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey MyungJoo, Kyungmin
Did you get a chance to think about how you
want this fix implemented?

On 2019-02-19 10:42, Sibi Sankar wrote:
> Hey MyungJoo,
> 
> On 12/14/18 7:15 AM, MyungJoo Ham wrote:
>>> From: Saravana Kannan <skannan@codeaurora.org>
>>> 
>>> If the new governor fails to start, switch back to old governor so 
>>> that the
>>> devfreq state is not left in some weird limbo.
>>> 
>>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>> 
>> Hello,
>> 
>> In overall, the idea and the implementation looks good.
>> 
>> However, I have a question:
>> 
>> What if the following line fails?
>> 
>> +		df->governor->event_handler(df, DEVFREQ_GOV_START,
>> +					    NULL);
>> 
>> Don't we still need something to handle for such events?
> 
> The original discussion went as follows:
> governor_store is expected to be used only on cases
> where devfreq_add_device() succeeded i.e prev->governor
> is expected to be present and DEVFREQ_GOV_START is
> expected to succeed. Hence falling back to the previous
> governor seems like a sensible idea.
> 
> This would also prevent DEVFREQ_GOV_STOP from being called
> on a governor were DEVFREQ_GOV_START had failed which is
> ideal.
> 
> That being said DEVFREQ_GOV_START can still fail for the
> prev-governor due to some change in state of the system.
> Do you want to handle this case by clearing the state of
> governor rather than switching to previous governor?
> 
>> 
>> Cheers,
>> MyungJoo
>> 
>> 

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
