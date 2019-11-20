Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57F7C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B205B22506
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731362AbfKTNqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:46:04 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:47412 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727752AbfKTNqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:46:04 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TiePzzo_1574257561;
Received: from IT-C02W23QPG8WN.local(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0TiePzzo_1574257561)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Nov 2019 21:46:01 +0800
Subject: Re: [PATCH] intel_th: avoid double free in error flow
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     zhiche.yy@alibaba-inc.com, xlpang@linux.alibaba.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20191119173447.2454-1-wenyang@linux.alibaba.com>
 <87y2wad7e5.fsf@ashishki-desk.ger.corp.intel.com>
 <7e2a501f-955a-5bd1-f70d-ad69e7223981@linux.alibaba.com>
 <87v9red5x7.fsf@ashishki-desk.ger.corp.intel.com>
From:   Wen Yang <wenyang@linux.alibaba.com>
Message-ID: <08c38d22-196d-a12e-f3e1-bc67f5912cb5@linux.alibaba.com>
Date:   Wed, 20 Nov 2019 21:46:00 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87v9red5x7.fsf@ashishki-desk.ger.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/11/20 9:38 下午, Alexander Shishkin wrote:
> Wen Yang <wenyang@linux.alibaba.com> writes:
>
>> Another example after a few lines lower:
>>
>>           err = device_add(&thdev->dev);
>>
>>           if (err) {
>>                    put_device(&thdev->dev);
>>                    goto fail_free_res;
>>
>>            }
>>
>> device_add() has increased the reference count,
>>
>> so when it returns an error, an additional call to put_device()
>>
>> is needed here to reduce the reference count.
>>
>> So the code in this place is correct.
> No, device_add() drops its own extra reference in case of error (as it
> should), so in "if (err) ..." branch we still only have just one
> reference before it goes free.
>
> Regards,
> --
> Alex



Well, ok, you are right.

We just checked the code and device_add() does release the reference count.

Thank you.


--

Regards,

Wen




