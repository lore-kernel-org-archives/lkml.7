Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7A3C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 02:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344B823711
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 02:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfHaCQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 22:16:07 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5258 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728271AbfHaCQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 22:16:07 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AE9B3C599C90EDFDA3D8;
        Sat, 31 Aug 2019 10:16:04 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Sat, 31 Aug
 2019 10:16:02 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: convert inline_data in prior to
 i_size_write
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190830153453.24684-1-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <d441bdaa-5155-3144-cdfe-01e8dcc7eff2@huawei.com>
Date:   Sat, 31 Aug 2019 10:16:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190830153453.24684-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/8/30 23:34, Jaegeuk Kim wrote:
> This can guarantee inline_data has smaller i_size.

So I guess "f2fs: fix to avoid corruption during inline conversion" didn't fix
such corruption right, I guess checkpoint & SPO before i_size recovery will
cause this issue?

	err = f2fs_convert_inline_inode(inode);
	if (err) {

-->

		/* recover old i_size */
		i_size_write(inode, old_size);
		return err;

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

> ---
>  fs/f2fs/file.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 08caaead6f16..a43193dd27cb 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -815,14 +815,20 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
>  
>  	if (attr->ia_valid & ATTR_SIZE) {
>  		loff_t old_size = i_size_read(inode);
> -		bool to_smaller = (attr->ia_size <= old_size);
> +
> +		if (attr->ia_size > MAX_INLINE_DATA(inode)) {
> +			/* should convert inline inode here */

Would it be better:

/* should convert inline inode here in piror to i_size_write to avoid
inconsistent status in between inline flag and i_size */

Thanks,

> +			err = f2fs_convert_inline_inode(inode);
> +			if (err)
> +				return err;
> +		}
>  
>  		down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>  		down_write(&F2FS_I(inode)->i_mmap_sem);
>  
>  		truncate_setsize(inode, attr->ia_size);
>  
> -		if (to_smaller)
> +		if (attr->ia_size <= old_size)
>  			err = f2fs_truncate(inode);
>  		/*
>  		 * do not trim all blocks after i_size if target size is
> @@ -830,24 +836,11 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
>  		 */
>  		up_write(&F2FS_I(inode)->i_mmap_sem);
>  		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> -
>  		if (err)
>  			return err;
>  
> -		if (!to_smaller) {
> -			/* should convert inline inode here */
> -			if (!f2fs_may_inline_data(inode)) {
> -				err = f2fs_convert_inline_inode(inode);
> -				if (err) {
> -					/* recover old i_size */
> -					i_size_write(inode, old_size);
> -					return err;
> -				}
> -			}
> -			inode->i_mtime = inode->i_ctime = current_time(inode);
> -		}
> -
>  		down_write(&F2FS_I(inode)->i_sem);
> +		inode->i_mtime = inode->i_ctime = current_time(inode);
>  		F2FS_I(inode)->last_disk_size = i_size_read(inode);
>  		up_write(&F2FS_I(inode)->i_sem);
>  	}
> 
