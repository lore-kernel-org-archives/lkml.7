Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9F6C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3E120836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732936AbfLKPyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:54:06 -0500
Received: from mail.monom.org ([188.138.9.77]:55848 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730284AbfLKPyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:54:05 -0500
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id EB052500796;
        Wed, 11 Dec 2019 16:54:02 +0100 (CET)
Received: from [192.168.154.174] (b9168f78.cgn.dg-w.de [185.22.143.120])
        by mail.monom.org (Postfix) with ESMTPSA id 76B80500243;
        Wed, 11 Dec 2019 16:54:02 +0100 (CET)
Subject: Re: Patch "mm, vmstat: make quiet_vmstat lighter" has been added to
 the 4.4-stable tree
To:     Greg KH <gregkh@linuxfoundation.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        cl@linux.com, mgalbraith@suse.de, mhocko@suse.com,
        torvalds@linux-foundation.org, umgwanakikbuti@gmail.com,
        stable-commits@vger.kernel.org,
        "Wangkefeng (Maro)" <wangkefeng.wang@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>
References: <156442332854185@kroah.com>
 <e4bd396a-1a10-1387-aa3f-4d61d31ab7b6@huawei.com>
 <20191211144614.GA637714@kroah.com>
From:   Daniel Wagner <wagi@monom.org>
Message-ID: <40460b0c-7fb0-a19d-3684-cb020e226a3f@monom.org>
Date:   Wed, 11 Dec 2019 16:54:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191211144614.GA637714@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2019-12-11 15:46, Greg KH wrote:
> On Wed, Dec 11, 2019 at 10:32:49PM +0800, zhangyi (F) wrote:
>> We find a performance degradation under lmbench af_unix[1] test case after
>> mergeing this patch on my x86 qemu 4.4 machine. The test result is basically
>> stable for each teses.
>>
>> Host machine: CPU: Intel(R) Xeon(R) CPU E5-2690 v3
>>                CPU(s): 48
>>                MEM: 193047 MB
>>
>> Guest machine:  CPU: QEMU Virtual CPU version 2.5+
>>                  CPU(s): 8
>>                  MEM: 26065 MB
>>
>>    Before this patch:
>>    [root@localhost ~]# lmbench-3.0-a9/bin/x86_64-linux-gnu/lat_unix -P 1
>>    AF_UNIX sock stream latency: 133.7073 microseconds
>>
>>    After this patch:
>>    [root@localhost ~]# lmbench-3.0-a9/bin/x86_64-linux-gnu/lat_unix -P 1
>>    AF_UNIX sock stream latency: 156.4722 microseconds
>>
>> If we set task to a constant cpu, the degradation does not appear.
>>
>>    Before this patch:
>>    [root@localhost ~]# lmbench-3.0-a9/bin/x86_64-linux-gnu/lat_unix -P 1
>>    AF_UNIX sock stream latency: 17.9296 microseconds
>>
>>    After this patch:
>>    [root@localhost ~]# lmbench-3.0-a9/bin/x86_64-linux-gnu/lat_unix -P 1
>>    AF_UNIX sock stream latency: 17.7500 microseconds
>>
>> We also test it on the aarch64 hi1215 machine with 8 cpu cores.
>>
>>    Before this patch:
>>    [root@localhost ~]# ./lat_unix -P 1
>>    AF_UNIX sock stream latency: 30.7 microseconds
>>
>>    After this patch:
>>    [root@localhost ~]# ./lat_unix -P 1
>>    AF_UNIX sock stream latency: 37.5 microseconds
>>
>> Accessories included my reproduce config for x86 qemu. Any thoughts?
> 
> This fixes a bug, as reported by Daniel Wagner.  So it's probably better
> to have a stable system instead of a broken one, right?  :)
> 
> Daniel can provide more information if needed.

IIRC, this patch got necessary because  bdf3c006b9a2 ("vmstat: make 
vmstat_updater deferrable again and shut down on idle") was added to 
stable. Without it v4.4-rt is not working at all.

 > What about when you run your tests on a 4.9 or newer kernel that
 > already has this integrated?

That said, I was going through all changes in vmstat.c upstream and we 
backported almost all changes to v4.4 at that point. So if this is a 
really giving you a performance hit, I suspect you would see it upstream 
as well.

Thanks,
Daniel
