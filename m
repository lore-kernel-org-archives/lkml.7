Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724DACA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A1620659
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439194AbfJXNsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 09:48:25 -0400
Received: from foss.arm.com ([217.140.110.172]:52040 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393832AbfJXNsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 09:48:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF12B7A7;
        Thu, 24 Oct 2019 06:48:08 -0700 (PDT)
Received: from [10.1.194.37] (unknown [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A65853F6C4;
        Thu, 24 Oct 2019 06:48:07 -0700 (PDT)
Subject: Re: [QUESTION] Hung task warning while running syzkaller test
To:     Zhihao Cheng <chengzhihao1@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, peterz@infradead.org,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        patrick.bellasi@arm.com, tglx@linutronix.de
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>
References: <0d7aa66d-d2b9-775c-56b3-543d132fdb84@huawei.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <1693d19e-56c7-9d6f-8e80-10fe82101cff@arm.com>
Date:   Thu, 24 Oct 2019 14:48:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0d7aa66d-d2b9-775c-56b3-543d132fdb84@huawei.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14/10/2019 08:03, Zhihao Cheng wrote:
> Hi, everyone. We met a hung task problem while running syzkaller test. The stacks of hung tasks vary in net/fs/sched, and we provide a stable reproduce test case in fs. The higher the kernel version, the lower the probability of reproduce. Maybe the mainline has gradually optimized the scheduling and mutex.
> 
> Environment:
> 	A. qemu(x86_64 8-core 16GB-RAM)
> 	B. physical machine (x86_64 8-core 314GB-RAM)
> 
> 	./syz-execprog -executor=/home/abc/syz-executor -repeat=0 -procs=16 -cover=0 repro
> repro is a configuration file containing syzkaller execution instructions, which shown as follows:
> 	syz_execute_func(&(0x7f0000000140)="f2aa984413e80f059532058300000071f32ef30f1b6f002e676666440f381d953b0000009fcc77a7141e8f6978e394db96000000928640c4e2b140da6c4f086447deecf2460fd6c40f49100045660fc462c0f726448047000040df6e32b8417e10bd61796e91565646bc16442ecbb1a978c33537771656c441add398b50000000feb76f7f7210173dddfc421785a6600a32c9f5d04ecc7c764660f600500040000c4035922770063c4217be62e450f8a0163000021f0c4e25dbe044c31e053b3eb53b3eb890f32d393400f383ca8faffec1f8dbf4feeee1e480404fb2e400f1ad30fae746d00ab07c4a2d538cb0ff803461439f5e3480f5140a3c4c4021bf7e8561eeaea0f6c3dce67460ffd1a000fb2430f12f5c423557904e774")
> 	socket(0x1, 0x80000, 0x4)
> 

I did try to run that but kept hitting cgroup config options that aren't
enabled in my defconfig - I gave up after net_cls, net_prio and the freezer.

Could you please share your .config?
 
