Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB05C31E4C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 019322133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfFNKH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 06:07:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18606 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726370AbfFNKH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 06:07:28 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AE3FF90E74CC5CDB0953;
        Fri, 14 Jun 2019 18:07:25 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Fri, 14 Jun 2019
 18:07:14 +0800
Subject: Re: [PATCH] bus: hisi_lpc: Don't use devm_kzalloc() to allocate
 logical PIO range
To:     Joe Perches <joe@perches.com>, <xuwei5@huawei.com>
References: <1560505624-39955-1-git-send-email-john.garry@huawei.com>
 <8eacbd27239ec5ce956309278beae9b499499108.camel@perches.com>
CC:     <bhelgaas@google.com>, <linuxarm@huawei.com>, <arm@kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <03b579d3-fa1a-57c8-a585-7b23a52b1f49@huawei.com>
Date:   Fri, 14 Jun 2019 11:07:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <8eacbd27239ec5ce956309278beae9b499499108.camel@perches.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2019 11:04, Joe Perches wrote:
> On Fri, 2019-06-14 at 17:47 +0800, John Garry wrote:
>> If, after registering a logical PIO range, the driver probe later fails,
>> the logical PIO range memory will be released automatically.
>>
>> This causes an issue, in that the logical PIO range is not unregistered
>> (that is not supported) and the released range memory may be later
>> referenced
>>
>> Allocate the logical PIO range with kzalloc() to avoid this potential
>> issue.
>>
>> Fixes: adf38bb0b5956 ("HISI LPC: Support the LPC host on Hip06/Hip07 with DT bindings")
>> Signed-off-by: John Garry <john.garry@huawei.com>
>>
>> diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
> []
>> @@ -599,7 +599,7 @@ static int hisi_lpc_probe(struct platform_device *pdev)
>>  	if (IS_ERR(lpcdev->membase))
>>  		return PTR_ERR(lpcdev->membase);
>>
>> -	range = devm_kzalloc(dev, sizeof(*range), GFP_KERNEL);
>> +	range = kzalloc(sizeof(*range), GFP_KERNEL);
>
> If this is really necessary, it'd be useful to say so in the
> code too with a comment so it doesn't get drive-by 'unfixed'
> by someone well meaning but ill-uninformed.

OK, fine. I can do that.

Cheers,
John

>
>
>
> .
>


