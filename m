Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D092FC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 03:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB838206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 03:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfKNDUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 22:20:53 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:37344 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726491AbfKNDUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 22:20:53 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D98FDDE2C75E30DAFDA9;
        Thu, 14 Nov 2019 11:20:51 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Thu, 14 Nov 2019
 11:20:42 +0800
Subject: Re: [PATCH] debugfs: fix potential infinite loop in
 debugfs_remove_recursive
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <oleg@redhat.com>, <jack@suse.cz>, <linux-kernel@vger.kernel.org>,
        <zhengbin13@huawei.com>, <yi.zhang@huawei.com>,
        <chenxiang66@hisilicon.com>, <xiexiuqi@huawei.com>
References: <1572528884-67565-1-git-send-email-yukuai3@huawei.com>
 <20191113151755.7125e914@gandalf.local.home>
 <a399ae58-a467-3ff9-5a01-a4a2cdcf4fd6@huawei.com>
 <20191113214307.29a8d001@oasis.local.home>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <a5189922-de5f-2f56-6192-9ce160da8666@huawei.com>
Date:   Thu, 14 Nov 2019 11:20:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191113214307.29a8d001@oasis.local.home>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/11/14 10:43, Steven Rostedt wrote:
> On Thu, 14 Nov 2019 10:01:23 +0800
> "yukuai (C)" <yukuai3@huawei.com> wrote:
> 
> 
>> Do you agree with that list_empty(&chile->d_subdirs) here is not
>> appropriate? Since it can't skip the subdirs that is not
>> simple_positive(simple_positive() will return false), which is the
>> reason of infinite loop.
> 
> I do agree that simple_empty() is wrong, for the reasons you pointed out.
> 
>>>> +		if (!simple_empty(child)) {
>>>
>>> Have you tried this with lockdep enabled? I'm thinking that you might
>>> get a splat with holding parent->d_lock and simple_empty(child) taking
>>> the child->d_lock.
>> The locks are taken and released in the right order:
>> take parent->d_lock
>> 	take child->d_lock
>> 		list_for_each_entry(c, &child->d_sundirs, d_child)
>> 			take c->d_lock
>> 			release c->d_lock
>> 	release child->d_lock
>> release parent->d_lock
>> I don't see anything wrong, am I missing something?
> 
> It should be fine, my worry is that we may be missing a lockdep
> annotation, that might confuse lockdep, as lockdep may see this as the
> same type of lock being taken, and wont know the order.
> 
> Have you tried this patch with lockdep enabled and tried to hit this
> code path?
I haven't tried yet. I'll try soon and show the result.
Thanks
Yu Kuai
> 
> -- Steve
> 
> .
> 

