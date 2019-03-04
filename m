Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2669C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 06:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7274B2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 06:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfCDGnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 01:43:12 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:4207 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725981AbfCDGnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 01:43:12 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0FAD222A58EE7FEF500F;
        Mon,  4 Mar 2019 14:43:10 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Mon, 4 Mar 2019
 14:43:07 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to do sanity check with
 inode.i_inline_xattr_size
To:     Sahitya Tummala <stummala@codeaurora.org>
CC:     <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190301073805.413-1-yuchao0@huawei.com>
 <20190304035909.GA8377@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <0ec69bbf-80d6-d7e6-2739-c18c2a0cb676@huawei.com>
Date:   Mon, 4 Mar 2019 14:43:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190304035909.GA8377@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sahitya,

On 2019/3/4 11:59, Sahitya Tummala wrote:
> On Fri, Mar 01, 2019 at 03:38:05PM +0800, Chao Yu wrote:
>> As Paul Bandha reported in bugzilla:
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=202709
>>
>> When I run the poc on the mounted f2fs img I get a buffer overflow in
>> read_inline_xattr due to there being no sanity check on the value of
>> i_inline_xattr_size.
>>
>> I created the img by just modifying the value of i_inline_xattr_size
>> in the inode:
>>
>> i_name                        		[test1.txt]
>> i_ext: fofs:0 blkaddr:0 len:0
>> i_extra_isize                 		[0x      18 : 24]
>> i_inline_xattr_size           		[0x    ffff : 65535]
>> i_addr[ofs]                   		[0x       0 : 0]
>>
>> mkdir /mnt/f2fs
>> mount ./f2fs1.img /mnt/f2fs
>> gcc poc.c -o poc
>> ./poc
>>
>> int main() {
>> 	int y = syscall(SYS_listxattr, "/mnt/f2fs/test1.txt", NULL, 0);
>> 	printf("ret %d", y);
>> 	printf("errno: %d\n", errno);
>>
>> }
>>
>>  BUG: KASAN: slab-out-of-bounds in read_inline_xattr+0x18f/0x260
>>  Read of size 262140 at addr ffff88011035efd8 by task f2fs1poc/3263
>>
>>  CPU: 0 PID: 3263 Comm: f2fs1poc Not tainted 4.18.0-custom #1
>>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.11.1-0-g0551a4be2c-prebuilt.qemu-project.org 04/01/2014
>>  Call Trace:
>>   dump_stack+0x71/0xab
>>   print_address_description+0x83/0x250
>>   kasan_report+0x213/0x350
>>   memcpy+0x1f/0x50
>>   read_inline_xattr+0x18f/0x260
>>   read_all_xattrs+0xba/0x190
>>   f2fs_listxattr+0x9d/0x3f0
>>   listxattr+0xb2/0xd0
>>   path_listxattr+0x93/0xe0
>>   do_syscall_64+0x9d/0x220
>>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> Let's add sanity check for inode.i_inline_xattr_size during f2fs_iget()
>> to avoid this issue.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/inode.c | 14 ++++++++++++++
>>  fs/f2fs/super.c |  7 ++-----
>>  fs/f2fs/xattr.h |  9 +++++++++
>>  3 files changed, 25 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>> index bec52961630b..b132fe2ff779 100644
>> --- a/fs/f2fs/inode.c
>> +++ b/fs/f2fs/inode.c
>> @@ -14,6 +14,7 @@
>>  #include "f2fs.h"
>>  #include "node.h"
>>  #include "segment.h"
>> +#include "xattr.h"
>>  
>>  #include <trace/events/f2fs.h>
>>  
>> @@ -248,6 +249,19 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
>>  		return false;
>>  	}
>>  
>> +	if (f2fs_has_extra_attr(inode) &&
>> +		f2fs_sb_has_flexible_inline_xattr(sbi) &&
>> +		(fi->i_inline_xattr_size < MIN_INLINE_XATTR_SIZE ||
>> +		fi->i_inline_xattr_size > MAX_INLINE_XATTR_SIZE)) {
>> +		set_sbi_flag(sbi, SBI_NEED_FSCK);
>> +		f2fs_msg(sbi->sb, KERN_WARNING,
>> +			"%s: inode (ino=%lx) has corrupted "
>> +			"i_inline_xattr_size: %d, min: %zu, max: %zu",
>> +			__func__, inode->i_ino, fi->i_inline_xattr_size,
>> +			MIN_INLINE_XATTR_SIZE, MAX_INLINE_XATTR_SIZE);
>> +		return false;
>> +	}
>> +
>>  	if (F2FS_I(inode)->extent_tree) {
>>  		struct extent_info *ei = &F2FS_I(inode)->extent_tree->largest;
>>  
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 42eb5c86330a..9184b7524c03 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -835,12 +835,9 @@ static int parse_options(struct super_block *sb, char *options)
>>  			return -EINVAL;
>>  		}
>>  		if (F2FS_OPTION(sbi).inline_xattr_size <
>> -			sizeof(struct f2fs_xattr_header) / sizeof(__le32) ||
>> +			MIN_INLINE_XATTR_SIZE ||
>>  			F2FS_OPTION(sbi).inline_xattr_size >
>> -			DEF_ADDRS_PER_INODE -
>> -			F2FS_TOTAL_EXTRA_ATTR_SIZE / sizeof(__le32) -
>> -			DEF_INLINE_RESERVED_SIZE -
>> -			MIN_INLINE_DENTRY_SIZE / sizeof(__le32)) {
>> +			MAX_INLINE_XATTR_SIZE) {
>>  			f2fs_msg(sb, KERN_ERR,
>>  					"inline xattr size is out of range");
>>  			return -EINVAL;
>> diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
>> index 67db134da0f5..94e8a5eeaae1 100644
>> --- a/fs/f2fs/xattr.h
>> +++ b/fs/f2fs/xattr.h
>> @@ -55,6 +55,8 @@ struct f2fs_xattr_entry {
>>  #define XATTR_FIRST_ENTRY(ptr)	(XATTR_ENTRY(XATTR_HDR(ptr) + 1))
>>  #define XATTR_ROUND		(3)
>>  
>> +#define XATTR_HDR_SIZE		(sizeof(struct f2fs_xattr_header))
>> +
>>  #define XATTR_ALIGN(size)	(((size) + XATTR_ROUND) & ~XATTR_ROUND)
>>  
>>  #define ENTRY_SIZE(entry) (XATTR_ALIGN(sizeof(struct f2fs_xattr_entry) + \
>> @@ -78,6 +80,13 @@ struct f2fs_xattr_entry {
>>  				sizeof(struct f2fs_xattr_header) -	\
>>  				sizeof(struct f2fs_xattr_entry))
>>  
>> +#define MAX_INLINE_XATTR_SIZE	(XATTR_HDR_SIZE / sizeof(__le32))
> 
> I think this should be MIN_INLINE_XATTR_SIZE.
> 
>> +#define MIN_INLINE_XATTR_SIZE						\
>> +			(DEF_ADDRS_PER_INODE -				\
>> +			F2FS_TOTAL_EXTRA_ATTR_SIZE / sizeof(__le32) -	\
>> +			DEF_INLINE_RESERVED_SIZE -			\
>> +			MIN_INLINE_DENTRY_SIZE / sizeof(__le32))
>> +
> 
> And this should be MAX_INLINE_XATTR_SIZE.

Thanks for your reminding. :)

I should have missed to check something during testing this patch with
original corrupted image from bugzilla, sorry.

BTW, MIN_INLINE_XATTR_SIZE may be not necessary...

Thanks,

> 
> Thanks,
> Sahitya.
> 
>>  /*
>>   * On-disk structure of f2fs_xattr
>>   * We use inline xattrs space + 1 block for xattr.
>> -- 
>> 2.18.0.rc1
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 

