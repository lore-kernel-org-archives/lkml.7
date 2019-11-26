Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30974C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 10:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1575F2073F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 10:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfKZKZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 05:25:01 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:30462 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727726AbfKZKZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 05:25:00 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Tj8hI5Z_1574763887;
Received: from IT-C02W23QPG8WN.local(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0Tj8hI5Z_1574763887)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 Nov 2019 18:24:48 +0800
Subject: Re: [PATCH] firmware: arm_scmi: avoid double free in error flow
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191125155409.9948-1-wenyang@linux.alibaba.com>
 <20191125161313.GA1157@bogus>
From:   Wen Yang <wenyang@linux.alibaba.com>
Message-ID: <21f4f7d6-9085-382d-42d3-a63484aca8a2@linux.alibaba.com>
Date:   Tue, 26 Nov 2019 18:24:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191125161313.GA1157@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/11/26 12:13 上午, Sudeep Holla wrote:
> On Mon, Nov 25, 2019 at 11:54:09PM +0800, Wen Yang wrote:
>> If device_register() fails, both put_device() and kfree()
>> are called, ending with a double free of the scmi_dev.
>>
> 
> Correct.
> 
>> Calling kfree() is needed only when a failure happens between the
>> allocation of the scmi_dev and its registration, so move it to
>> there and remove it from the error flow.
>>
> 
> kstrdup_const can fail and in that case device is not yet registered,
> so we need to free. Since device_register() calls put_device() on failure
> too, I would just drop it as it's unnecessary, not sure why I have added
> it in the first place. Can you re-spin the patch dropping put_device
> and renaming put_dev label to something like free_const.
> 
> --
> Regards,
> Sudeep
> 

Hi Sudeep,
Thanks for your comments.
Let's check the code like this:

int device_register(struct device *dev)
{
         device_initialize(dev);   --> Initialize kobj-> kref to 1
         return device_add(dev);
}

int device_add(struct device *dev)
{
...
         dev = get_device(dev);  --> kobj-> kref increases by 1
...
done:
         put_device(dev);  --> kobj-> kref decreases by 1 and is now 1
         return error;
...
}

So we also need to call put_device (),
and the original patch should be fine.
Please kindly help to check again, thank you.

--
Regards,
Wen








