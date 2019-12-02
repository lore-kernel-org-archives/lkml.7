Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DE7C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 10:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF948214AF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 10:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfLBKr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 05:47:27 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:54290 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726276AbfLBKr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 05:47:26 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1FDA555B4F6FC4535465;
        Mon,  2 Dec 2019 18:47:23 +0800 (CST)
Received: from [127.0.0.1] (10.177.246.209) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Mon, 2 Dec 2019
 18:47:12 +0800
Subject: Re: vfio_pin_map_dma cause synchronize_sched wait too long
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>
CC:     <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Longpeng(Mike)" <longpeng.mike@gmail.com>,
        Gonglei <arei.gonglei@huawei.com>,
        Huangzhichao <huangzhichao@huawei.com>
References: <2e53a9f0-3225-d416-98ff-55bd337330bc@huawei.com>
 <34c53520-4144-fe71-528a-8df53e7f4dd1@redhat.com>
 <561fb205-16be-ae87-9cfe-61e6a3b04dc5@huawei.com>
 <42c907fd-6c09-fbb6-d166-60e6827edff5@redhat.com>
From:   "Longpeng (Mike)" <longpeng2@huawei.com>
Message-ID: <8a14a25d-61ce-5fb3-edc2-2c69b18f8e36@huawei.com>
Date:   Mon, 2 Dec 2019 18:47:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <42c907fd-6c09-fbb6-d166-60e6827edff5@redhat.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.246.209]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2019/12/2 18:06, Paolo Bonzini Ð´µÀ:
> On 02/12/19 10:42, Longpeng (Mike) wrote:
>>> cond_resched in vfio_iommu_map.  Perhaps you could add one to 
>>> vfio_pin_pages_remote and/or use vfio_pgsize_bitmap to cap the
>>> number of pages that it returns.
>> Um ... There's only one running task (qemu-kvm of the VM1) on that
>> CPU, so maybe the cond_resched() is ineffective ?
> 
> Note that synchronize_sched() these days is just a synonym of
> synchronize_rcu, so this makes me wonder if you're running on an older
> kernel and whether you are missing this commit:
> 

Yep. I'm running on an older kernel and I've missed this patchset. Thanks a lot :)

> 
> commit 92aa39e9dc77481b90cbef25e547d66cab901496
> Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Date:   Mon Jul 9 13:47:30 2018 -0700
> 
>     rcu: Make need_resched() respond to urgent RCU-QS needs
> 
>     The per-CPU rcu_dynticks.rcu_urgent_qs variable communicates an urgent
>     need for an RCU quiescent state from the force-quiescent-state
> processing
>     within the grace-period kthread to context switches and to
> cond_resched().
>     Unfortunately, such urgent needs are not communicated to need_resched(),
>     which is sometimes used to decide when to invoke cond_resched(), for
>     but one example, within the KVM vcpu_run() function.  As of v4.15, this
>     can result in synchronize_sched() being delayed by up to ten seconds,
>     which can be problematic, to say nothing of annoying.
> 
>     This commit therefore checks rcu_dynticks.rcu_urgent_qs from within
>     rcu_check_callbacks(), which is invoked from the scheduling-clock
>     interrupt handler.  If the current task is not an idle task and is
>     not executing in usermode, a context switch is forced, and either way,
>     the rcu_dynticks.rcu_urgent_qs variable is set to false.  If the current
>     task is an idle task, then RCU's dyntick-idle code will detect the
>     quiescent state, so no further action is required.  Similarly, if the
>     task is executing in usermode, other code in rcu_check_callbacks() and
>     its called functions will report the corresponding quiescent state.
> 
>     Reported-by: Marius Hillenbrand <mhillenb@amazon.de>
>     Reported-by: David Woodhouse <dwmw2@infradead.org>
>     Suggested-by: Peter Zijlstra <peterz@infradead.org>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> 
> Thanks,
> 
> Paolo
> 
> 
> .
> 


-- 
Regards,
Longpeng(Mike)

