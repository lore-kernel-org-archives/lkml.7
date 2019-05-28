Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78748C04AB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 02:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572E920675
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 02:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfE1Ctl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 22:49:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56464 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727525AbfE1Ctl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 22:49:41 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5BBB52D4EEDAEF075B80;
        Tue, 28 May 2019 10:49:39 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 28 May
 2019 10:49:33 +0800
Subject: Re: [PATCH 1/2] staging: erofs: support statx
To:     Chao Yu <yuchao0@huawei.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
References: <20190528023147.94117-1-gaoxiang25@huawei.com>
 <2f6e75f8-ff82-7472-54ff-8c0648e8f075@huawei.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <86c2307e-f09b-12f8-3ed4-71e8ed6f2299@huawei.com>
Date:   Tue, 28 May 2019 10:49:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <2f6e75f8-ff82-7472-54ff-8c0648e8f075@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On 2019/5/28 10:44, Chao Yu wrote:
> On 2019/5/28 10:31, Gao Xiang wrote:
>> statx() has already been supported in commit a528d35e8bfc
>> ("statx: Add a system call to make enhanced file info available"),
>> user programs can get more useful attributes.
>>
>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>> ---
>>  drivers/staging/erofs/inode.c    | 18 ++++++++++++++++++
>>  drivers/staging/erofs/internal.h |  2 ++
>>  drivers/staging/erofs/namei.c    |  1 +
>>  3 files changed, 21 insertions(+)
>>
>> diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
>> index c7d3b815a798..8da144943ed6 100644
>> --- a/drivers/staging/erofs/inode.c
>> +++ b/drivers/staging/erofs/inode.c
>> @@ -285,7 +285,23 @@ struct inode *erofs_iget(struct super_block *sb,
>>  	return inode;
>>  }
>>  
>> +int erofs_getattr(const struct path *path, struct kstat *stat,
>> +		  u32 request_mask, unsigned int query_flags)
>> +{
>> +	struct inode *const inode = d_inode(path->dentry);
>> +	struct erofs_vnode *const vi = EROFS_V(inode);
>> +
>> +	if (vi->data_mapping_mode == EROFS_INODE_LAYOUT_COMPRESSION)
>> +		stat->attributes |= STATX_ATTR_COMPRESSED;
>> +
>> +	stat->attributes |= STATX_ATTR_IMMUTABLE;
> 
> Xiang,
> 
> Should update stat->attributes_mask as well to indicate all erofs supported
> attributes bits.

opps, my fault... I just verified these patches stability.
Will do in the next version.

Thanks,
Gao Xiang

> 
> Thanks,
> 
>> +
>> +	generic_fillattr(inode, stat);
>> +	return 0;
>> +}
>> +
>>  const struct inode_operations erofs_generic_iops = {
>> +	.getattr = erofs_getattr,
>>  #ifdef CONFIG_EROFS_FS_XATTR
>>  	.listxattr = erofs_listxattr,
>>  #endif
>> @@ -294,6 +310,7 @@ const struct inode_operations erofs_generic_iops = {
>>  
>>  const struct inode_operations erofs_symlink_iops = {
>>  	.get_link = page_get_link,
>> +	.getattr = erofs_getattr,
>>  #ifdef CONFIG_EROFS_FS_XATTR
>>  	.listxattr = erofs_listxattr,
>>  #endif
>> @@ -302,6 +319,7 @@ const struct inode_operations erofs_symlink_iops = {
>>  
>>  const struct inode_operations erofs_fast_symlink_iops = {
>>  	.get_link = simple_get_link,
>> +	.getattr = erofs_getattr,
>>  #ifdef CONFIG_EROFS_FS_XATTR
>>  	.listxattr = erofs_listxattr,
>>  #endif
>> diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
>> index c47778b3fabd..911333cdeef4 100644
>> --- a/drivers/staging/erofs/internal.h
>> +++ b/drivers/staging/erofs/internal.h
>> @@ -556,6 +556,8 @@ static inline bool is_inode_fast_symlink(struct inode *inode)
>>  }
>>  
>>  struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid, bool dir);
>> +int erofs_getattr(const struct path *path, struct kstat *stat,
>> +		  u32 request_mask, unsigned int query_flags);
>>  
>>  /* namei.c */
>>  extern const struct inode_operations erofs_dir_iops;
>> diff --git a/drivers/staging/erofs/namei.c b/drivers/staging/erofs/namei.c
>> index d8d9dc9dab43..fd3ae78d0ba5 100644
>> --- a/drivers/staging/erofs/namei.c
>> +++ b/drivers/staging/erofs/namei.c
>> @@ -247,6 +247,7 @@ static struct dentry *erofs_lookup(struct inode *dir,
>>  
>>  const struct inode_operations erofs_dir_iops = {
>>  	.lookup = erofs_lookup,
>> +	.getattr = erofs_getattr,
>>  #ifdef CONFIG_EROFS_FS_XATTR
>>  	.listxattr = erofs_listxattr,
>>  #endif
>>
