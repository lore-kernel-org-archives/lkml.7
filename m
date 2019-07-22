Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8EDC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 14:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C2C21951
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 14:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbfGVOOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 10:14:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2696 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727880AbfGVOOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 10:14:44 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B550494DBD9CAC0C381D;
        Mon, 22 Jul 2019 22:14:37 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Mon, 22 Jul 2019
 22:14:31 +0800
From:   John Garry <john.garry@huawei.com>
Subject: About threaded interrupt handler CPU affinity
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <bigeasy@linutronix.de>, <maz@kernel.org>,
        chenxiang <chenxiang66@hisilicon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <e0e9478e-62a5-ca24-3b12-58f7d056383e@huawei.com>
Date:   Mon, 22 Jul 2019 15:14:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

I have a question on commit cbf8699996a6 ("genirq: Let irq thread follow 
the effective hard irq affinity"), if you could kindly check:

Here we set the thread affinity to be the same as the hard interrupt 
affinity. For an arm64 system with GIC ITS, this will be a single CPU, 
the lowest in the interrupt affinity mask. So, in this case, effectively 
the thread will be bound to a single CPU. I think APIC is the same for this.

The commit message describes the problem that we solve here is that the 
thread may become affine to a different CPU to the hard interrupt - does 
it mean that the thread CPU mask could not cover that of the hard 
interrupt? I couldn't follow the reason.

We have experimented with fixing the thread mask to be the same as the 
interrupt mask (we're using managed interrupts), like before, and get a 
significant performance boost at high IO datarates on our storage 
controller - like ~11%.

Thanks in advance,
John

