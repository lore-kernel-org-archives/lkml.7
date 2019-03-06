Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A4FC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78B620854
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gLoUYn1X";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BGDW7Rwc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbfCFRoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 12:44:12 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37746 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfCFRoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 12:44:11 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 734A160909; Wed,  6 Mar 2019 17:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551894250;
        bh=RbITpgL7h0Dp8KAyMPyUKF3kb4X2pLqJDvwDItWVtOM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gLoUYn1Xxflf9hnKpzw/i3qiqSU2uLJ4GvKwdLvLHSUUMYZT81jLBOmhur9gkZEG6
         96kXjqMOaideMLjfggf0c6qeuKQ+aBsJCdqWxUFcB3H5AFz4NS3jeXsG9vLTbDz3CA
         eA3viEeaPFulRbRF+NEw2Ot47TitkM5vQhSOQCnU=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id BC98A601FE;
        Wed,  6 Mar 2019 17:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551894249;
        bh=RbITpgL7h0Dp8KAyMPyUKF3kb4X2pLqJDvwDItWVtOM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BGDW7Rwcv1IR5wFb4pkBspUHe4yBDoaPO3LpPw3l8+ZMowmBpzq4QfsRMr7AlSC3X
         QbpeLN0Hc0qrT9MBMTbgIHcTMQXnTk7FPNshs4Q9xOXc3xefJc7dmhdMp4hI8HFKjf
         DRMuBukBanUcnjBL9Oy8MP1TnflMz/PFgFeFRIUo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 06 Mar 2019 23:14:09 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     myungjoo.ham@samsung.com
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        skannan@codeaurora.org, linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v4] PM / devfreq: Restart previous governor if new
 governor fails to start
In-Reply-To: <20190305071808epcms1p89cd924ae1c7fc344b7e554f5f18592d2@epcms1p8>
References: <946aa4e13aec4f84e6ae2d91e772fb1f@codeaurora.org>
 <20181212135313.30268-1-sibis@codeaurora.org>
 <20181214014527epcms1p6c783b4cd1602bbcbcb6e725f840db479@epcms1p6>
 <39d3a906-b734-9bb8-c60a-48948bb21338@codeaurora.org>
 <CGME20181212135338epcas5p12f7a8cd1c7aab5d5c936cbc5c33eee07@epcms1p8>
 <20190305071808epcms1p89cd924ae1c7fc344b7e554f5f18592d2@epcms1p8>
Message-ID: <effa576a5581b866f0f8549a084560d9@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-05 12:48, MyungJoo Ham wrote:
>> Hey MyungJoo, Kyungmin
>> Did you get a chance to think about how you
>> want this fix implemented?
>> 
>> On 2019-02-19 10:42, Sibi Sankar wrote:
>>> Hey MyungJoo,
>>> 
>>> On 12/14/18 7:15 AM, MyungJoo Ham wrote:
>>>>> From: Saravana Kannan <skannan@codeaurora.org>
>>>>> 
>>>>> If the new governor fails to start, switch back to old governor so
>>>>> that the
>>>>> devfreq state is not left in some weird limbo.
>>>>> 
>>>>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>>>>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>>>>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>> 
>>>> Hello,
>>>> 
>>>> In overall, the idea and the implementation looks good.
>>>> 
>>>> However, I have a question:
>>>> 
>>>> What if the following line fails?
>>>> 
>>>> +		df->governor->event_handler(df, DEVFREQ_GOV_START,
>>>> +					    NULL);
>>>> 
>>>> Don't we still need something to handle for such events?
>>> 
>>> The original discussion went as follows:
>>> governor_store is expected to be used only on cases
>>> where devfreq_add_device() succeeded i.e prev->governor
>>> is expected to be present and DEVFREQ_GOV_START is
>>> expected to succeed. Hence falling back to the previous
>>> governor seems like a sensible idea.
>>> 
>>> This would also prevent DEVFREQ_GOV_STOP from being called
>>> on a governor were DEVFREQ_GOV_START had failed which is
>>> ideal.
>>> 
>>> That being said DEVFREQ_GOV_START can still fail for the
>>> prev-governor due to some change in state of the system.
>>> Do you want to handle this case by clearing the state of
>>> governor rather than switching to previous governor?
>>> 
> 
> If moving back to previous governor fails after
> failing for "next" governor, we may assume it's fatal
> and stop the device; we can simply return errors.
> 
> In such a case, df->governor may need to be NULL as well.

Thanks. Will make the necessary changes in the
next re-spin.

> 
> 
> Cheers,
> MyungJoo

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
