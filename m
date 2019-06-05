Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4568EC282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 10:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14CAE20866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 10:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfFEKXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 06:23:50 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:34689 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727055AbfFEKXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 06:23:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TTUFliu_1559730220;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TTUFliu_1559730220)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 05 Jun 2019 18:23:41 +0800
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        x86@kernel.org, Nadav Amit <namit@vmware.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Caspar Zhang <caspar@linux.alibaba.com>,
        jiufei Xue <jiufei.xue@linux.alibaba.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [bug report][stable] kernel tried to execute NX-protected page -
 exploit attempt? (uid: 0)
Message-ID: <5817eaac-29cc-6331-af3b-b9d85a7c1cd7@linux.alibaba.com>
Date:   Wed, 5 Jun 2019 18:23:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have encountered a kernel BUG when running ltp ftrace-stress-test
on 4.19.48.

[  209.704855] LTP: starting ftrace-stress-test (ftrace_stress_test.sh 90)
[  209.739412] Scheduler tracepoints stat_sleep, stat_iowait, stat_blocked and stat_runtime require the kernel parameter schedstats=enable or kernel.sched_schedstats=1
[  212.054506] kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
[  212.055595] BUG: unable to handle kernel paging request at ffffffffc0349000
[  212.056589] PGD d00c067 P4D d00c067 PUD d00e067 PMD 23673e067 PTE 800000023457f061
[  212.057759] Oops: 0011 [#1] SMP PTI
[  212.058303] CPU: 0 PID: 0 Comm: swapper/0 Kdump: loaded Not tainted 4.19.48 #112

After some investigation I have found that it is introduced by commit
8715ce033eb3 ("x86/modules: Avoid breaking W^X while loading modules"),
and then revert this commit the issue is gone.

I have also tested the same case on 5.2-rc3 as well as right at
upstream commit f2c65fb3221a ("x86/modules: Avoid breaking W^X while
loading modules"), which has been merged in 5.2-rc1, it doesn't
happen.

So I don't know why only stable has this issue while upstream doesn't.

Thanks,
Joseph
