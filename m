Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0CEC00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7BD20692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgAHIwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 03:52:42 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9124 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726481AbgAHIwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 03:52:42 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A6AEBACE85B0BE60A8FB;
        Wed,  8 Jan 2020 16:52:39 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 8 Jan 2020
 16:52:36 +0800
Subject: Re: [f2fs-dev] Multidevice f2fs mount after disk rearrangement
To:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <4c6cf8418236145f7124ac61eb2908ad@natalenko.name>
 <2c4cafd35d1595a62134203669d7c244@natalenko.name>
 <20200106183450.GC50058@jaegeuk-macbookpro.roam.corp.google.com>
 <ee2cb1d7a6c1b51e1c8277a8feaafe6d@natalenko.name>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <815fbd14-0fbd-9c44-8d86-4ab13a12dc7f@huawei.com>
Date:   Wed, 8 Jan 2020 16:52:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ee2cb1d7a6c1b51e1c8277a8feaafe6d@natalenko.name>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/1/7 2:40, Oleksandr Natalenko via Linux-f2fs-devel wrote:
> Hi.
> 
> On 06.01.2020 19:34, Jaegeuk Kim wrote:
>> Thank you for investigating this ahead of me. :) Yes, the device list 
>> is stored
>> in superblock, so hacking it manually should work.
>>
>> Let me think about a tool to tune that.
> 
> Thank you both for the replies.
> 
> IIUC, tune.f2fs is not there yet. I saw a submission, but I do not see 
> it as accepted, right?
> 
> Having this in tune.f2fs would be fine (assuming the assertion is 
> replaced with some meaningful hint message), but wouldn't it be more 
> convenient for an ordinary user to have implemented something like:
> 
> # mount -t f2fs /dev/sdb -o nextdev=/dev/sdc /mnt/fs

Hmm... sounds reasonable, however, the risk is obvious, if we mount with wrong
primary device, filesystem can be aware that with metadata sanity check, if we
mount with wrong secondary/... devices by mistake (or intentionally, people
may think filesystem should be aware illegal parameters....), filesystem won't
be aware of that, then metadata/data will be inconsistent...

Although that may also happen when we use tunesb.f2fs, but fsck.f2fs can be
followed to verify the modification of tunesb.f2fs, that would be much safer.

So I suggest we can do that in tools first, maybe implement nextdev mount option
if we have added metadata in secondary/... device.

Thanks,

> 
> Hm?
> 
