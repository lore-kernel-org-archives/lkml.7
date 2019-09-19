Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32C7C4CEC9
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 02:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB92218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 02:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388392AbfISCnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 22:43:35 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2676 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388339AbfISCnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 22:43:35 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 49F46466824EFB1C211D;
        Thu, 19 Sep 2019 10:43:33 +0800 (CST)
Received: from huawei.com (10.175.104.232) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Thu, 19 Sep 2019
 10:43:27 +0800
From:   KeMeng Shi <shikemeng@huawei.com>
To:     <will@kernel.org>
CC:     <akpm@linux-foundation.org>, <james.morris@microsoft.com>,
        <gregkh@linuxfoundation.org>, <mortonm@chromium.org>,
        <will.deacon@arm.com>, <kristina.martsenko@arm.com>,
        <yuehaibing@huawei.com>, <malat@debian.org>,
        <j.neuschaefer@gmx.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Re: Re: [PATCH] connector: report comm change event when modifying /proc/pid/task/tid/comm
Date:   Wed, 18 Sep 2019 22:43:21 -0400
Message-ID: <20190919024321.2675-1-shikemeng@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190917170737.dpchgliux4qi2qef@willie-the-truck>
References: <20190917170737.dpchgliux4qi2qef@willie-the-truck>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.232]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/18 at 1:08, Will Deacon wrote:
>On Tue, Sep 17, 2019 at 09:56:28AM -0400, KeMeng Shi wrote:
>>on 2019/9/17 at 5:10, Will Deacon wrote:
>>>The rough idea looks ok to me but I have two concerns:
>>>
>>>  (1) This looks like it will be visible to userspace, and this changes
>>>      the behaviour after ~8 years of not reporting this event.
>>This do bother for users who only care the comm change via prctl, but 
>>it also benefits users who want all comm changes. Maybe the best way 
>>is add something like config or switch to meet the both conditions 
>>above. In my opinion, users cares comm change event rather than how it
>>change.
>
>I was really just looking for some intuition as to how this event is currently
>used and why extending it like this is unlikely to break those existing users.

By listening these comm change events, user is able to monitor and control
specific threads that they are interested. For instance, a process control
daemon listening to proc connector and following comm value policies can
place specific threads to assigned cgroup partitions (quota from commit
 f786ecba415888 ("connector: add comm change event report to proc
 connector")).  It's harmless as user ignore the threads with names that
they are not interested.

>>>(2) What prevents proc_comm_connector(p) running concurrently with 
>>>itself  via the prctl()? The locking seems to be confined to set_task_comm().
>>To be honest, I did not consider the concurrence problem at beginning. 
>>And some comm change events may lost or are reported repeatly as follows:
>>set name via procfs	set name via prctl
>>set_task_comm
>>			set_task_comm
>>proc_comm_connector
>>			proc_comm_connector
>>Comm change event belong to procfs losts and the fresh comm change 
>>belong to prctl is reported twice. Actually, there is also concurrence 
>>problem without this update as follows:
>>set name via procfs	set name via prctl
>>			set_task_comm
>>set_task_comm
>>			proc_comm_connector
>>Comm change event from procfs is reported instead of prctl, this may 
>>bothers user who only care the comm change via prctl.
>
>Perhaps, although given that proc_comm_connector() is currently only
>called on the prctl() path, then it does at least provide the comm
>from the most recent prctl() invocation. With your path, the calls
>can go out of order, so I think that probably needs fixing.

It's indeed necessary to fix the concurrence problem. I will submit
a v2 patch when I fix this.

Thanks for your review and advise.
KeMeng Shi
