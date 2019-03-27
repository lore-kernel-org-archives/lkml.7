Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC890C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF112146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="crI7Waab";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oyAod51/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbfC0N0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:26:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58974 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfC0N0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:26:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7296A61A10; Wed, 27 Mar 2019 13:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553693203;
        bh=S5+4np9L/K2PvyIjNL087u2hE7CRP77Eg28qqrJol6I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=crI7Waab9LOZHyldHTQpqzOBbGJUc7AKtYrjbNy7sMoIuD+HwcCG6zJkbVGi8Hjya
         RtpiZ89kRfOxYfEzFORP0NH7ob1BA/4xRAy0HhhTSsdu6RGaNk5YR+NO34E6gVqjyE
         KW9k+FzY3idABeqjkO12kdZlmUVCHQGZy4fWpI9Q=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 99389619B1;
        Wed, 27 Mar 2019 13:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553693202;
        bh=S5+4np9L/K2PvyIjNL087u2hE7CRP77Eg28qqrJol6I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oyAod51/XqYRod7+kJCmJv3qdwsEWPejWkTf2mRGyONK3TdN8Gsy4/iBoagQfZKDL
         RA4UjWkzn6JwW0Nw0IbmtdCypirlfI1KdVkYr8+YQTXI8/eLJwZ2J7ej484bMe6JeU
         j05AxCp5bcZ/dysC+WuJM6RfTPhU+vN+9osYuqqY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 27 Mar 2019 18:56:41 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/9] soc: qcom: rpmpd: fixup rpmpd set performance
 state
In-Reply-To: <a224821a-6e28-cea5-9928-440f5e132460@codeaurora.org>
References: <20190324175007.29040-1-sibis@codeaurora.org>
 <20190324175007.29040-2-sibis@codeaurora.org>
 <a224821a-6e28-cea5-9928-440f5e132460@codeaurora.org>
Message-ID: <a60f1fce6b5c9fad465b285e34e05673@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-25 09:33, Rajendra Nayak wrote:
> On 3/24/2019 11:19 PM, Sibi Sankar wrote:
>> Fixup rpmpd state to max if the required state is greater than all the
>> supported states.
> 
> This should also say why, 'so the clients which just want to vote on 
> whatever
> is the max state supported can do so by passing an INT_MAX'?

will add more detail in v3

> 
>> 
>> Fixes: 075d3db8d10d ("Add support for the .set_performace_state() and
>> .opp_to_performance_state()")
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>   drivers/soc/qcom/rpmpd.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
>> index 005326050c23..235d01870dd8 100644
>> --- a/drivers/soc/qcom/rpmpd.c
>> +++ b/drivers/soc/qcom/rpmpd.c
>> @@ -226,7 +226,7 @@ static int rpmpd_set_performance(struct 
>> generic_pm_domain *domain,
>>   	struct rpmpd *pd = domain_to_rpmpd(domain);
>>     	if (state > MAX_RPMPD_STATE)
>> -		goto out;
>> +		state = MAX_RPMPD_STATE;
>>     	mutex_lock(&rpmpd_lock);
>> 

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
