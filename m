Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7F6C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 00:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7253A21555
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 00:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QshOovUW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfK1Ad1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 19:33:27 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43841 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfK1Ad1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 19:33:27 -0500
Received: by mail-ot1-f66.google.com with SMTP id l14so20714179oti.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 16:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eBgl7IWFbAHYtCfwdXLuSMLWEguEG/dbDeqB2MJbK2k=;
        b=QshOovUWthIqNFsT2YJCKBP1tF4y12XbFarYrmSV5KFvwfrFOuDNEtU8X8hBqyTNjM
         0n0LvpLgeSOsBnCxR8XVYTKjgd63lj/QiW03wklwb9Pi4TOOFvNB0SsBxUZ9G+ojVFcZ
         hK3qWu71xk2BupXpLm52soK9NB2g7aYzM5fcRXSQ5vEGDGhqP8mRvDjSrc6YXeDOlNkH
         5pcy2RduEYp4s36tG389w6+pUTxt5eEanyGqbkwjULEZecaU+vJBe4Dz8YOfC3Df088c
         i91EhfO8HyJtOxhL8xTfPVBt8N1zpWbf0olehu+oBSYqy8kvOxf7l0d42Cvd+Ita7y1t
         Lg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eBgl7IWFbAHYtCfwdXLuSMLWEguEG/dbDeqB2MJbK2k=;
        b=NEPtzImJahsuuBCHBCsXQx9fcRVLqvq9MKp3f3hrgzaXMCwn0zT4hOMXq8AfDmJ8+P
         ujm9QBudelzos7dR81EYbhP4w/lvdcd5Kyb+0+Hz1g8mgD5urw3swPhFDMXjH7YfzZIV
         8j1LeKuP4e/iBPw9MJ3cyJcMJCSEJGCvrRCBQpzVdF74608vuaR+5xb+UcFNEpxxOMVO
         BoO2I5CC230pZ5UrdJCFw+3PwPBgBO9pAwCZHLo7Gh3UqXZ0JAkYL5NYcTgaRs4efJa8
         gVJ7ow6oJOL7wVTrhRJl1Q5E38oqHuNUKUzinhFpXC7VTsTOwsNC2mSZu/+WnqtAYejD
         7VlA==
X-Gm-Message-State: APjAAAXM9dvdEMf/lQrFhtFQLn3r98G8025h9AaLvr8TRelv+V8KQqVl
        4JZ4ifbczBp13d8Jg2mJ8aaFSBiD
X-Google-Smtp-Source: APXvYqwIwse1AEa5mB3eWdhNqyckjWvBVpEw65GBmrefSM/TMsbMwE+58pTe87YUUD6+vjPVh5nkKg==
X-Received: by 2002:a9d:739a:: with SMTP id j26mr5713049otk.40.1574901205522;
        Wed, 27 Nov 2019 16:33:25 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 94sm5475523otx.3.2019.11.27.16.33.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 16:33:24 -0800 (PST)
Subject: Re: [PATCH] driver core: Fix test_async_driver_probe if NUMA is
 disabled
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20191127202453.28087-1-linux@roeck-us.net>
 <4a2aa8554933c2d004761d5f3e8132018be5ea27.camel@linux.intel.com>
 <377feb00-9288-e03c-b8a7-26ba87e24927@roeck-us.net>
 <b5826338cd4479b724835ea5469c5a8318e88e2c.camel@linux.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <dfc50096-d95f-8e57-4ba2-3fc122626af8@roeck-us.net>
Date:   Wed, 27 Nov 2019 16:33:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b5826338cd4479b724835ea5469c5a8318e88e2c.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/19 3:13 PM, Alexander Duyck wrote:
> On Wed, 2019-11-27 at 14:42 -0800, Guenter Roeck wrote:
>> On 11/27/19 1:24 PM, Alexander Duyck wrote:
>>> On Wed, 2019-11-27 at 12:24 -0800, Guenter Roeck wrote:
>>>> Since commit 57ea974fb871 ("driver core: Rewrite test_async_driver_probe
>>>> to cover serialization and NUMA affinity"), running the test with NUMA
>>>> disabled results in warning messages similar to the following.
>>>>
>>>> test_async_driver test_async_driver.12: NUMA node mismatch -1 != 0
>>>>
>>>> If CONFIG_NUMA=n, dev_to_node(dev) returns -1, and numa_node_id()
>>>> returns 0. Both are widely used, so it appears risky to change return
>>>> values. Augment the check with IS_ENABLED(CONFIG_NUMA) instead
>>>> to fix the problem.
>>>>
>>>> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>> Fixes: 57ea974fb871 ("driver core: Rewrite test_async_driver_probe to cover serialization and NUMA affinity")
>>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>>> ---
>>>>    drivers/base/test/test_async_driver_probe.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/base/test/test_async_driver_probe.c b/drivers/base/test/test_async_driver_probe.c
>>>> index f4b1d8e54daf..3bb7beb127a9 100644
>>>> --- a/drivers/base/test/test_async_driver_probe.c
>>>> +++ b/drivers/base/test/test_async_driver_probe.c
>>>> @@ -44,7 +44,8 @@ static int test_probe(struct platform_device *pdev)
>>>>    	 * performing an async init on that node.
>>>>    	 */
>>>>    	if (dev->driver->probe_type == PROBE_PREFER_ASYNCHRONOUS) {
>>>> -		if (dev_to_node(dev) != numa_node_id()) {
>>>> +		if (IS_ENABLED(CONFIG_NUMA) &&
>>>> +		    dev_to_node(dev) != numa_node_id()) {
>>>>    			dev_warn(dev, "NUMA node mismatch %d != %d\n",
>>>>    				 dev_to_node(dev), numa_node_id());
>>>>    			atomic_inc(&warnings);
>>>
>>> I'm not sure that is really the correct fix. It might be better to test it
>>> against NUMA_NO_NODE and then if it is not that make sure that it matches
>>> the node ID. Adding the check against NUMA_NO_NODE would resolve the issue
>>> for cases where the device might be assigned to multiple NUMA nodes.
>>>
>> I think you are suggesting that dev_to_node(dev) might return NUMA_NO_NODE
>> even on systems with CONFIG_NUMA enabled. I have no idea if that can happen.
>> The code in test_async_probe_init() seems to suggest that the node is set
>> to a valid node id for all asynchronous nodes, so I don't immediately see
>> how that could be the case. I may be missing something, of course.
> 
> Well thinking back to the Nehalem architecture I seem to recall that there
> were devices that were connected to a shared IOH that was accessible
> across both nodes. I thought that they might have a node ID of
> NUMA_NO_NODE since they didn't really belong to either of the two nodes in
> the sytem.
> 
> It would effectively work out the same as your patch compiler wise since
> dev_to_node would be NUMA_NO_NODE in the non-NUMA case so it would compile
> out the warning since it would fail the first check, and in the NUMA case
> it would add an extra check to make sure that dev_to_node is actually
> indicating the device needs a specific node in the NUMA enabled case.
> 

I thought the code is specifically checking devices which it previously
created, which are well defined and understood test devices. After all,
the check is in the test driver's probe function. Guess I really don't
understand the code. Please take my patch as bug report, and submit
whatever fix you think is correct.

Thanks,
Guenter
