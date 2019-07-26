Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46303C41514
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0CA21880
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Inq66byu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jbyk3SjT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfGZIUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 04:20:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54260 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfGZIUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:20:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D0146602B7; Fri, 26 Jul 2019 08:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564129232;
        bh=65MgSqdz2cwGluQBrWzKC9i2ys2KqHizYGJpxJMlpW4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Inq66byupP164QyjGrEBcnS/t8T29G6gU0pJWkL40Dui5eciw55NAiYmb8beNB95y
         SNDp5LiUjiefVV1BmvePJwEWieNXSqsdnpYYvgo0/w3ur0Ktv6rAmwfR8k/OU+B8Jh
         F3Z/Eec7TSqpxJ5YsuYOOihGblVSjkRExL2YBO6s=
Received: from [10.79.136.27] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E0BED602B7;
        Fri, 26 Jul 2019 08:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564129231;
        bh=65MgSqdz2cwGluQBrWzKC9i2ys2KqHizYGJpxJMlpW4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jbyk3SjTCUTeUB1z3R1MOKw3HJ2oUgr//cWk6BLhbmTq8KRxCRp9MvgtCHtmJ6uuV
         N8XMHgvcLZULTCiBohg9cCjGjWMSd8flQ0rBdJ+T7DqT8oPH0Dmd+eZhbjgD6mReyr
         XHLiFuLIo6TtYBWuESeE2cuRqsHNjiuZSyyAzlv0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E0BED602B7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [Regression] Missing device nodes for ETR, ETF and STM after
 CONFIG_UEVENT_HELPER=n
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cfe09a46-462f-633a-37c2-52f8bfc0ffb2@codeaurora.org>
 <20190726070429.GA15714@kroah.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <165028a7-ff12-dd28-cc4c-57a3961dbb40@codeaurora.org>
Date:   Fri, 26 Jul 2019 13:50:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726070429.GA15714@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/2019 12:34 PM, Greg Kroah-Hartman wrote:
> On Fri, Jul 26, 2019 at 11:49:19AM +0530, Sai Prakash Ranjan wrote:
>> Hi,
>>
>> When trying to test my coresight patches, I found that etr,etf and stm
>> device nodes are missing from /dev.
> 
> I have no idea what those device nodes are.
> 
>> Bisection gives this as the bad commit.
>>
>> 1be01d4a57142ded23bdb9e0c8d9369e693b26cc is the first bad commit
>> commit 1be01d4a57142ded23bdb9e0c8d9369e693b26cc
>> Author: Geert Uytterhoeven <geert+renesas@glider.be>
>> Date:   Thu Mar 14 12:13:50 2019 +0100
>>
>>      driver: base: Disable CONFIG_UEVENT_HELPER by default
>>
>>      Since commit 7934779a69f1184f ("Driver-Core: disable /sbin/hotplug by
>>      default"), the help text for the /sbin/hotplug fork-bomb says
>>      "This should not be used today [...] creates a high system load, or
>>      [...] out-of-memory situations during bootup".  The rationale for this
>>      was that no recent mainstream system used this anymore (in 2010!).
>>
>>      A few years later, the complete uevent helper support was made optional
>>      in commit 86d56134f1b67d0c ("kobject: Make support for uevent_helper
>>      optional.").  However, if was still left enabled by default, to support
>>      ancient userland.
>>
>>      Time passed by, and nothing should use this anymore, so it can be
>>      disabled by default.
>>
>>      Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>      Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>
>>   drivers/base/Kconfig | 1 -
>>   1 file changed, 1 deletion(-)
>>
>>
>> Any idea on this?
> 
> That means that who ever created those device nodes is relying on udev
> to do this, and is not doing the correct thing within the kernel and
> using devtmpfs.
> 
> Any pointers to where in the kernel those devices are trying to be
> created?
> 

Somewhere in drivers/hwtracing/coresight/* probably. I am not sure,
Mathieu/Suzuki would be able to point you to the exact code.

Also just to add on some more details, I am using *initramfs*

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
