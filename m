Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053C1C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D457D206DA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgAHIh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 03:37:59 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8240 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726313AbgAHIh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 03:37:57 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8F768DF273F778ADA5C4;
        Wed,  8 Jan 2020 16:37:54 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 8 Jan 2020
 16:37:53 +0800
Subject: Re: [f2fs-dev] Multidevice f2fs mount after disk rearrangement
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <4c6cf8418236145f7124ac61eb2908ad@natalenko.name>
 <2c4cafd35d1595a62134203669d7c244@natalenko.name>
 <e773d576-9458-48d7-bad4-dd4f8c61ebd3@huawei.com>
 <20200106184017.GD50058@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <7cf85056-ef3f-b78c-e7cf-8cce5d5ef1ee@huawei.com>
Date:   Wed, 8 Jan 2020 16:37:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200106184017.GD50058@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/1/7 2:40, Jaegeuk Kim wrote:
> On 01/06, Chao Yu wrote:
>> Hello,
>>
>> Thanks for the report. :)
>>
>> On 2020/1/5 5:52, Oleksandr Natalenko via Linux-f2fs-devel wrote:
>>> Hi.
>>>
>>> On 04.01.2020 17:29, Oleksandr Natalenko wrote:
>>>> I was brave enough to create f2fs filesystem spanning through 2
>>>> physical device using this command:
>>>>
>>>> # mkfs.f2fs -t 0 /dev/sdc -c /dev/sdd
>>>>
>>>> It worked fine until I removed /dev/sdb from my system, so f2fs devices 
>>>> became:
>>>>
>>>> /dev/sdc -> /dev/sdb
>>>> /dev/sdd -> /dev/sdc
>>>>
>>>> Now, when I try to mount it, I get the following:
>>>>
>>>> # mount -t f2fs /dev/sdb /mnt/fs
>>>> mount: /mnt/fs: mount(2) system call failed: No such file or directory.
>>>>
>>>> In dmesg:
>>>>
>>>> [Jan 4 17:25] F2FS-fs (sdb): Mount Device [ 0]:             /dev/sdc,
>>>>   59063,        0 -  1cd6fff
>>>> [  +0,000024] F2FS-fs (sdb): Failed to find devices
>>>>
>>>> fsck also fails with the following assertion:
>>>>
>>>> [ASSERT] (init_sb_info: 908) !strcmp((char *)sb->devs[i].path, (char
>>>> *)c.devices[i].path)
>>>>
>>>> Am I doing something obviously stupid, and the device path can be
>>>> (somehow) changed so that the mount succeeds, or this is unfixable,
>>>> and f2fs relies on persistent device naming?
>>>>
>>>> Please suggest.
>>>>
>>>> Thank you.
>>>
>>> Erm, fine. I studied f2fs-tools code a little bit and discovered that 
>>> superblock indeed had /dev/sdX paths saved as strings. So I fired up 
>>> hexedit and just changed the superblock directly on the first device, 
>>> substituting sdc with sdb and sdd with sdc (I did it twice; I guess 
>>> there are 2 copies of superblock), and after this the mount worked.
>>
>> Alright, it works if superblock checksum feature is off...
>>
>>>
>>> Am I really supposed to do this manually ;)?
>>
>> We'd better add that ability in tune.f2fs. And I guess we need to let
>> kernel/fsck to notice that case, and give hint to run tune.f2fs to
>> reconfigure primary/secondary/... device paths.
> 
> I'm thinking to add tunesb.f2fs to edit superblock explicitly, since it has
> to edit it without getting superblock/checkpoint and other f2fs metadata.
> 
> For example,
> # tunesb.f2fs -c /dev/sdb -c /dev/sdc /dev/sda
> .. superblock info ..
> .. device list ..
> .. hot/cold extensions ..
> 
> Will modify the device list, if it's different from parameter.

Looks good to me.

Thanks,

> 
>>
>> Thanks,
>>
>>>
> .
> 
