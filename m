Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B8EC49ED7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 07:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A637020673
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 07:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731092AbfIUH0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 03:26:53 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45204 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731071AbfIUH0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 03:26:53 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2127DC7C5191A21989DE;
        Sat, 21 Sep 2019 15:26:46 +0800 (CST)
Received: from [127.0.0.1] (10.57.88.168) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Sat, 21 Sep 2019
 15:26:39 +0800
Subject: Re: [PATCH] tty:vt: Add check the return value of kzalloc to avoid
 oops
To:     Greg KH <gregkh@linuxfoundation.org>,
        Nicolas Pitre <nico@fluxnic.net>
CC:     <penberg@cs.helsinki.fi>, <jslaby@suse.com>,
        <textshell@uchuujin.de>, <sam@ravnborg.org>,
        <daniel.vetter@ffwll.ch>, <mpatocka@redhat.com>,
        <ghalat@redhat.com>, <linux-kernel@vger.kernel.org>,
        <yangyingliang@huawei.com>, <yuehaibing@huawei.com>,
        <zengweilin@huawei.com>
References: <1568884695-56789-1-git-send-email-nixiaoming@huawei.com>
 <20190919092933.GA2684163@kroah.com>
 <nycvar.YSQ.7.76.1909192251210.24536@knanqh.ubzr>
 <20190920060426.GA473496@kroah.com>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <bee63793-e9f4-ecc4-7966-765207009c75@huawei.com>
Date:   Sat, 21 Sep 2019 15:26:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190920060426.GA473496@kroah.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.88.168]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/9/20 14:04, Greg KH wrote:
> On Thu, Sep 19, 2019 at 10:56:15PM -0400, Nicolas Pitre wrote:
>> On Thu, 19 Sep 2019, Greg KH wrote:
>>
>>> On Thu, Sep 19, 2019 at 05:18:15PM +0800, Xiaoming Ni wrote:
>>>> Using kzalloc() to allocate memory in function con_init(), but not
>>>> checking the return value, there is a risk of null pointer references
>>>> oops.
>>>>
>>>> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
>>>
>>> We keep having this be "reported" :(
>>
>> Something probably needs to be "communicated" about that.
> 
> I know, but it's also kind of fun to see what these "automated" checkers
> find, sometimes the resulting patches almost work properly :)
> 
> This one is really close, I think if the likely/unlikely gets cleaned
> up, it is viable.
> 
>>>>  		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
>>>> +		if (unlikely(!vc)) {
>>>> +			pr_warn("%s:failed to allocate memory for the %u vc\n",
>>>> +					__func__, currcons);
>>>> +			break;
>>>> +		}
>>>
>>> At init, this really can not happen.  Have you see it ever happen?
>>
>> This is maybe too subtle a fact. The "communication" could be done with 
>> some GFP_WONTFAIL flag, and have the allocator simply pannic() if it 
>> ever fails.
> 
> That's a good idea to do as well.
> 
> thanks,
> 
> greg k-h
> 
> .
> 
Thank you for your advice.

@ Nicolas Pitre
Can I make a v2 patch based on your advice ?
Or you will submit a patch for "GFP_WONTFAIL" yourself ?

thanks
Xiaoming Ni


