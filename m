Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E34C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CAFB2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bfQFn5QW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TayPqBoC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfDJWS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:18:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46980 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfDJWS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:18:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8211C60FF3; Wed, 10 Apr 2019 22:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554934705;
        bh=L+Aguwy+/VoP56+p30M/SP5x+sGXp4ryUdg3EM1eE/M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bfQFn5QWkrEGqMhMqzx/JzFoqaBwOdOZeN0c4e5X7fNPjp1puwEo337UOSk/TXzaA
         /NuNCKyDKxzzeDYcvehfKsf+nMXGtv7q8cEkfk+4pinb0MXcNzPbN9Z0W/UnkqYMeT
         xihAxhE+95+fcBTbMh7Of0+Mbe9jWemartVPWKq4=
Received: from [10.226.58.28] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0A36E6032C;
        Wed, 10 Apr 2019 22:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554934704;
        bh=L+Aguwy+/VoP56+p30M/SP5x+sGXp4ryUdg3EM1eE/M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TayPqBoCGkaBZD6pNglWdOLZ6Q/BvEKpH2sgApK1alWIP7pl1QspvmzzU/GzxBDSY
         bddaYDoQe9sG7p0KljE5R9fRJ0f1lp6Y8HAIBpncTUUKaKzxrL7F2OrSny654X3e61
         xkKFGYhNj5U6kt+HXCEv/U+0JwEG8ve60gBWHN68=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0A36E6032C
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
 <c529d12b-5212-7198-4f70-a3f771c0901f@codeaurora.org>
 <155493274113.20095.6283192313107751284@swboyd.mtv.corp.google.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <bba463e8-c4f6-720d-5a38-ae29d0979a9e@codeaurora.org>
Date:   Wed, 10 Apr 2019 16:18:23 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <155493274113.20095.6283192313107751284@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/2019 3:45 PM, Stephen Boyd wrote:
> Quoting Jeffrey Hugo (2019-04-10 12:39:16)
>> On 4/10/2019 10:53 AM, Stephen Boyd wrote:
>>> Quoting Jeffrey Hugo (2019-04-08 14:46:11)
>>>> On 4/4/2019 3:53 PM, Stephen Boyd wrote:
>>>>> In some circumstances drivers register clks early and don't have access
>>>>> to a struct device because the device model isn't initialized yet. Add
>>>>> an API to let drivers register clks associated with a struct device_node
>>>>> so that these drivers can participate in getting parent clks through DT.
>>>>
>>>> NACK.  This patch broke boot for me.  I had to pull the below from JTAG.
>>>>     What do you need to debug this?
>>>>
>>>
>>> Here's a patch to try to squash in:
>>
>> No dice.  Same issue.
> 
> Argh! dev_of_node() doesn't check for NULL device. :-/ I want to be
> extremely lazy! Let's get this merged too. Thanks for the testing.

Fixed.  Will continue to test the rest of the series and let you know.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
