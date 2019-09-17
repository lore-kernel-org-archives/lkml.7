Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE85C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC272171F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfIQN5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 09:57:06 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60408 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726151AbfIQN4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 09:56:44 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 640E3BA41774567C9DD2;
        Tue, 17 Sep 2019 21:56:42 +0800 (CST)
Received: from huawei.com (10.175.104.232) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Tue, 17 Sep 2019
 21:56:33 +0800
From:   KeMeng Shi <shikemeng@huawei.com>
To:     <will@kernel.org>, <akpm@linux-foundation.org>,
        <james.morris@microsoft.com>, <gregkh@linuxfoundation.org>,
        <mortonm@chromium.org>, <will.deacon@arm.com>,
        <kristina.martsenko@arm.com>, <yuehaibing@huawei.com>,
        <malat@debian.org>, <j.neuschaefer@gmx.net>
CC:     <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] connector: report comm change event when modifying /proc/pid/task/tid/comm
Date:   Tue, 17 Sep 2019 09:56:28 -0400
Message-ID: <20190917135628.3054-1-shikemeng@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190916211008.ipqe3j7s22aannta@willie-the-truck>
References: <20190916211008.ipqe3j7s22aannta@willie-the-truck>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.232]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

on 2019/9/17 at 5:10, Will Deacon wrote:
>The rough idea looks ok to me but I have two concerns:
>
>  (1) This looks like it will be visible to userspace, and this changes
>      the behaviour after ~8 years of not reporting this event.
This do bother for users who only care the comm change via prctl, but it
also benefits users who want all comm changes. Maybe the best way is add
something like config or switch to meet the both conditions above. In my
opinion, users cares comm change event rather than how it change.

>(2) What prevents proc_comm_connector(p) running concurrently with itself
> via the prctl()? The locking seems to be confined to set_task_comm().
To be honest, I did not consider the concurrence problem at beginning. And
some comm change events may lost or are reported repeatly as follows:
set name via procfs	set name via prctl
set_task_comm
			set_task_comm
proc_comm_connector
			proc_comm_connector
Comm change event belong to procfs losts and the fresh comm change belong
to prctl is reported twice. Actually, there is also concurrence problem
without this update as follows:
set name via procfs	set name via prctl
			set_task_comm
set_task_comm
			proc_comm_connector
Comm change event from procfs is reported instead of prctl, this may
bothers user who only care the comm change via prctl.

There is no matter if user only care the latest comm change otherwise, put
setting name and reporting event in crtical region may be the only answer.

I'm sorry the response to (1) concern is missing in last mail. This is a
full version. Apologize again for my mistake.

Thanks for review.
KeMeng Shi
