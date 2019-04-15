Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDBCC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787B920833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfDOLbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:31:52 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2535 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726556AbfDOLbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 07:31:51 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 8CA74AA06D65DEABCD60;
        Mon, 15 Apr 2019 19:31:48 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 15 Apr 2019 19:31:48 +0800
Received: from [10.134.22.195] (10.134.22.195) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 15 Apr 2019 19:31:47 +0800
Subject: Re: [f2fs-dev] [PATCH 13/13] f2fs: don't recovery orphan inode on
 readonly device
To:     Ju Hyung Park <qkrwngud825@gmail.com>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190415073054.2577-1-yuchao0@huawei.com>
 <20190415073054.2577-5-yuchao0@huawei.com>
 <CAD14+f2uV6s6hBfQaQaJPBEAPVOFgEZfueuVPQ_43LpiWS9nZg@mail.gmail.com>
 <a77dc50c-01f0-459b-38de-50f97c129f31@huawei.com>
 <CAD14+f2c7yYbc6hu2gWiHfRUrx0SctMZfc0+9HVk+_0UE+Mkug@mail.gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <dea278b4-4419-c7e4-e73e-84537610cc68@huawei.com>
Date:   Mon, 15 Apr 2019 19:31:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAD14+f2c7yYbc6hu2gWiHfRUrx0SctMZfc0+9HVk+_0UE+Mkug@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-ClientProxiedBy: dggeme702-chm.china.huawei.com (10.1.199.98) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/15 19:04, Ju Hyung Park wrote:
> Thanks for the explanation.
> 
> And yes, this patch fixed it, the kernel log is now clean.

Thanks for the quick test. :)

Thanks,

> 
> Thanks!
> 
> [   22.506553] F2FS-fs (loop0): write access unavailable, skipping
> orphan cleanup
> [   22.506555] F2FS-fs (loop0): recover fsync data on readonly fs
> [   22.506556] F2FS-fs (loop0): quota file may be corrupted, skip loading it
> [   22.507015] F2FS-fs (loop0): Mounted with checkpoint version = 26e7ba3e
> 
> On Mon, Apr 15, 2019 at 5:57 PM Chao Yu <yuchao0@huawei.com> wrote:
>>
>> On 2019/4/15 16:10, Ju Hyung Park wrote:
>>> Hi,
>>>
>>> Thanks for the fix. I'll try this sooner than later.
>>>
>>> One minor request though, can you change
>>> "JuHyung Park <qkrwngud825@gmail.com>"
>>> to
>>> "Park Ju Hyung <qkrwngud825@gmail.com>"?
>>>
>>> That's my preference and I'd like to avoid any inconsistencies.
>>
>> Sure, will update it in next version. :)
>>
>>>
>>> One additional question from reviewing the code surrounding it:
>>> does it really makes sense to cleanup orphan inodes even when the "ro"
>>> mount option is passed?
>>> It's an explicit request from the user not to write to the block device/image.
>>
>> Now, f2fs follows the rule that ext4 kept, you can check codes in
>> ext4_orphan_cleanup()
>>
>>         if (bdev_read_only(sb->s_bdev)) {
>>                 ext4_msg(sb, KERN_ERR, "write access "
>>                         "unavailable, skipping orphan cleanup");
>>                 return;
>>         }
>> ...
>>         if (s_flags & SB_RDONLY) {
>>                 ext4_msg(sb, KERN_INFO, "orphan cleanup on readonly fs");
>>                 sb->s_flags &= ~SB_RDONLY;
>>         }
>>
>> There are two points in above codes:
>> - if block device is readonly, filesystem should not execute any recovery flow
>> which can trigger write IO.
>> - if filesystem was mounted as readonly one, and recovery is needed, it will
>> ignore readonly flag and update data in device for journal recovery during mount.
>>
>> So IMO, readonly mountoption sematics is only try to restrict data/meta update
>> behavior that is triggered by user from mountpoint, but filesystem still can do
>> any updates on a writable device if it needs, mostly like recovery flow.
>>
>> Anyway, if you want to limit any updates on block device, making it readonly
>> will be a good choice. :)
>>
>> Thanks,
>>
>>>
>>> Thanks.
>>>
>>> On Mon, Apr 15, 2019 at 4:31 PM Chao Yu <yuchao0@huawei.com> wrote:
>>>>
>>>> As JuHyung Park reported in mailing list:
>>>>
>>>> https://sourceforge.net/p/linux-f2fs/mailman/message/36639787/
>>>>
>>>> generic_make_request: Trying to write to read-only block-device loop0 (partno 0)
>>>> WARNING: CPU: 0 PID: 23437 at block/blk-core.c:2174 generic_make_request_checks+0x594/0x630
>>>>
>>>>  generic_make_request+0x46/0x3d0
>>>>  submit_bio+0x30/0x110
>>>>  __submit_merged_bio+0x68/0x390
>>>>  f2fs_submit_page_write+0x1bb/0x7f0
>>>>  f2fs_do_write_meta_page+0x7f/0x160
>>>>  __f2fs_write_meta_page+0x70/0x140
>>>>  f2fs_sync_meta_pages+0x140/0x250
>>>>  f2fs_write_checkpoint+0x5c5/0x17b0
>>>>  f2fs_sync_fs+0x9c/0x110
>>>>  sync_filesystem+0x66/0x80
>>>>  f2fs_recover_fsync_data+0x790/0xa30
>>>>  f2fs_fill_super+0xe4e/0x1980
>>>>  mount_bdev+0x518/0x610
>>>>  mount_fs+0x34/0x13f
>>>>  vfs_kern_mount.part.11+0x4f/0x120
>>>>  do_mount+0x2d1/0xe40
>>>>  __x64_sys_mount+0xbf/0xe0
>>>>  do_syscall_64+0x4a/0xf0
>>>>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>>
>>>> print_req_error: I/O error, dev loop0, sector 4096
>>>>
>>>> If block device is readonly, we should never trigger write IO from
>>>> filesystem layer, but previously, orphan recovery didn't consider
>>>> such condition, result in triggering above warning, fix it.
>>>>
>>>> Reported-by: JuHyung Park <qkrwngud825@gmail.com>
>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>> ---
>>>>  fs/f2fs/checkpoint.c | 6 ++++++
>>>>  1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>>> index a7ad1b1e5750..90e1bab86269 100644
>>>> --- a/fs/f2fs/checkpoint.c
>>>> +++ b/fs/f2fs/checkpoint.c
>>>> @@ -674,6 +674,12 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
>>>>         if (!is_set_ckpt_flags(sbi, CP_ORPHAN_PRESENT_FLAG))
>>>>                 return 0;
>>>>
>>>> +       if (bdev_read_only(sbi->sb->s_bdev)) {
>>>> +               f2fs_msg(sbi->sb, KERN_INFO, "write access "
>>>> +                       "unavailable, skipping orphan cleanup");
>>>> +               return 0;
>>>> +       }
>>>> +
>>>>         if (s_flags & SB_RDONLY) {
>>>>                 f2fs_msg(sbi->sb, KERN_INFO, "orphan cleanup on readonly fs");
>>>>                 sbi->sb->s_flags &= ~SB_RDONLY;
>>>> --
>>>> 2.18.0.rc1
>>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> Linux-f2fs-devel mailing list
>>>> Linux-f2fs-devel@lists.sourceforge.net
>>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>> .
>>>
> .
> 
