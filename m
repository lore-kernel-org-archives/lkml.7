Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2423CC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 07:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3917214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 07:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731538AbfHVHWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 03:22:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5190 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729213AbfHVHWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 03:22:11 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CE148C189EDC0E632B6D;
        Thu, 22 Aug 2019 15:22:06 +0800 (CST)
Received: from [127.0.0.1] (10.119.195.53) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Thu, 22 Aug 2019
 15:21:58 +0800
Subject: Re: [Question] audit_names use after delete in audit_filter_inodes
To:     Paul Moore <paul@paul-moore.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-audit@redhat.com>,
        Eric Paris <eparis@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <4997df37-4a80-5cf5-effc-0a6f040c4528@huawei.com>
 <CAHC9VhS_DCBRX6kkmiSYBzq+ELN2AYRypRN6vR_J1+JOi2FDvw@mail.gmail.com>
From:   Chen Wandun <chenwandun@huawei.com>
Message-ID: <ce8efa9d-f2b6-5adc-0442-c73e632c6903@huawei.com>
Date:   Thu, 22 Aug 2019 15:22:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhS_DCBRX6kkmiSYBzq+ELN2AYRypRN6vR_J1+JOi2FDvw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.119.195.53]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/8/21 23:36, Paul Moore wrote:
> On Wed, Aug 21, 2019 at 5:31 AM Chen Wandun <chenwandun@huawei.com> wrote:
>>
>> Hi,
>> Recently, I hit a use after delete in audit_filter_inodes,
> 
> ...
> 
>> the call stack is below:
>> [321315.077117] CPU: 6 PID: 8944 Comm: DefSch0100 Tainted: G           OE  ----V-------   3.10.0-327.62.59.83.w75.x86_64 #1
>> [321315.077117] Hardware name: OpenStack Foundation OpenStack Nova, BIOS rel-1.8.1-0-g4adadbd-20170107_142945-9_64_246_229 04/01/2014
> 
> It looks like this is a vendor kernel and not an upstream kernel, yes?

I analysed the upstream kernel about audit, and found there is no significant change
in audit_names add/read/delete since v3.10.

audit_names could be delete in __audit_syscall_exit, do_exit, copy_process
on upstream kernel(same as v3.10).

if we are reading audit_names, such as
	__audit_syscall_exit
		audit_filter_inodes
			read each audit_names ...
			

is there any situation could delete audit_names at the same time?

>   Assuming that is the case I would suggest you contact your distro for
> help/debugging/support; we simply don't know enough about your kernel
> (what patches are included, how was it built/configured/etc.) to
> comment with any certainty.
> 
> Linux Kernels based on v3.10.0 are extremely old from an upstream
> perspective, with a number of fixes and changes to the audit subsystem
> since v3.10.0 was released.  If you see the same problem on a modern
> upstream kernel please let us know, we'll be happy to help.
> 

