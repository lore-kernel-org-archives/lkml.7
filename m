Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B3EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD652184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FntXEGzf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="W4qbIMwC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfCTRvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:51:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51808 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfCTRvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:51:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 760DD613A6; Wed, 20 Mar 2019 17:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553104265;
        bh=PHNM6bheDeYTYw6yVXCWWJXVJOBrCq9mHZwunwKQbB8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FntXEGzfrCDnynFGONDw/bdW5vp+yjNhDC+zJoHwRZ+P0Q5740JwQw3p1npKANMpM
         vzFgBY07+MpfGgXba2jGzbJusvQDCxEPByCHCe6vXhI+2SA+8vxS2rvgsrbqoqpOQE
         OaQ+G5ShYxBFOxZ2DxVGNmc1ofbRYwqhjNIuBFn8=
Received: from [192.168.1.4] (unknown [122.175.119.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: gkohli@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 745C960EA5;
        Wed, 20 Mar 2019 17:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553104264;
        bh=PHNM6bheDeYTYw6yVXCWWJXVJOBrCq9mHZwunwKQbB8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=W4qbIMwCsq0L/NojacFvSLpU0cHR0NW2FGW2/gNqQpF7+xOCOP/h9Ijdi7j5cgBCl
         zk/e/HUa/7qENGW/p/mg6aD7KN8/yZDdVfgEA9n0pLUDBJIGPWUY5X8Y8tLkDaJEi5
         bZ/cvOq+ojvlNH+yBbwCOb8ghOb6+ewB+6FA6Waw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 745C960EA5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=gkohli@codeaurora.org
Subject: Re: [PATCH v2] nvmem: core: Set no-read-write provider to avoid
 userspace read/write
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org
References: <1552831940-7327-1-git-send-email-gkohli@codeaurora.org>
 <48a71861-c60b-7fe7-d4af-5269cd7c20eb@linaro.org>
 <5f11070f-bf9b-c313-9a78-e412a2fb2908@codeaurora.org>
 <865519b5-62c9-3eb3-3855-eebf98bded85@linaro.org>
From:   Gaurav Kohli <gkohli@codeaurora.org>
Message-ID: <68755fdb-b2c6-ac25-a786-7593a692a173@codeaurora.org>
Date:   Wed, 20 Mar 2019 23:20:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <865519b5-62c9-3eb3-3855-eebf98bded85@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/20/2019 9:56 PM, Srinivas Kandagatla wrote:
>
>
> On 20/03/2019 15:50, Gaurav Kohli wrote:
>>
>> On 3/20/2019 8:04 PM, Srinivas Kandagatla wrote:
>>>
>>>
>>> On 17/03/2019 14:12, Gaurav Kohli wrote:
>>>> Current nvmem framework allows user space to read all register space
>>>> populated by nvmem binary file, In case we don't want to expose value
>>>> of registers to userspace and only want kernel space to read cell
>>>> value from nvmem_cell_read_u32.
>>>>
>>>> To protect the same, Add no-read-write property to prevent read
>>>> from userspace.
>>>>
>>>
>>> Can you explain the real need of this?
>>> Is there any issue you are noticing while reading nvmem content from 
>>> userspace?
>>>
>> Hi Srinivas,
>>
>>
>> No, We are not observing any issue, nvmem is dumping the data properly.
>>
>> But there are certain register, which we don't want to expose to user 
>> space and want kernel space can only read via nvmem_cell_read.
> Am guessing these are some kind of keys or something that you do not 
> want user to see.
>
Hi Srinivas,

Thanks.

Yes exactly, there are certain keys or even certain bit that we don't 
want to expose to user.


> Is root only option not helping you in this case?
Yes we want to protect at root level as well, i mean it is better if we 
can avoid exposing to userspace at all.
>
> We could go down the route of adding new config option something like 
> CONFIG_NVMEM_NO_SYSFS_ENTRY to prevent adding nvmem entry in userspace.
>
> Let me know if you are happy to create a patch for this change?

I am happy with either way config option or dt binding(seems easy), 
please let me know we will post new patch for the same.

In config option, do i have to remove all binary creation code of nvmem 
, correct? or simply put a check like dt binding option

so user cannot read it.

Thanks

Gaurav

>
> Thanks,
> srini
>
>>
>> In existing design, even if we read cell from kernel space, nvmem 
>> binary files is still populated to user space unconditionally.
>>
>> Regards
>>
>> Gaurav

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

