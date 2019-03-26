Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE06C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B3D2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbfCZBCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 21:02:22 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:48364 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727099AbfCZBCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 21:02:22 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 52A38B2B96DC57BF1DA8;
        Tue, 26 Mar 2019 09:02:20 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 26 Mar 2019 09:02:19 +0800
Received: from [10.134.22.195] (10.134.22.195) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 26 Mar 2019 09:02:18 +0800
Subject: Re: [PATCH] fs: fix warning about Using plain integer as NULL pointer
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
References: <20190322221021.GA24814@hari-Inspiron-1545>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <6fc256d1-b85e-2021-57dd-f8154bdce7a1@huawei.com>
Date:   Tue, 26 Mar 2019 09:02:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190322221021.GA24814@hari-Inspiron-1545>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-ClientProxiedBy: dggeme715-chm.china.huawei.com (10.1.199.111) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/3/23 6:10, Hariprasad Kelam wrote:
> Sparse warning below:
> 
> sudo make C=2 CF=-D__CHECK_ENDIAN__ M=fs
> 
> CHECK   fs/f2fs/data.c
> fs/f2fs/data.c:426:47: warning: Using plain integer as NULL pointer
> CHECK   fs/notify/fdinfo.c
> fs/notify/fdinfo.c:53:87: warning: Using plain integer as NULL pointer
>  CHECK   fs/ubifs/xattr.c
> fs/ubifs/xattr.c:615:58: warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>

f2fs part looks good to me.

Acked-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/data.c     | 2 +-
>  fs/notify/fdinfo.c | 2 +-
>  fs/ubifs/xattr.c   | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 97279441..15a2381 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -423,7 +423,7 @@ static void __submit_merged_write_cond(struct f2fs_sb_info *sbi,
>  
>  void f2fs_submit_merged_write(struct f2fs_sb_info *sbi, enum page_type type)
>  {
> -	__submit_merged_write_cond(sbi, NULL, 0, 0, type, true);
> +	__submit_merged_write_cond(sbi, NULL, NULL, 0, type, true);
>  }
>  
>  void f2fs_submit_merged_write_cond(struct f2fs_sb_info *sbi,
> diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
> index 1e2bfd2..ef83f40 100644
> --- a/fs/notify/fdinfo.c
> +++ b/fs/notify/fdinfo.c
> @@ -50,7 +50,7 @@ static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
>  	f.handle.handle_bytes = sizeof(f.pad);
>  	size = f.handle.handle_bytes >> 2;
>  
> -	ret = exportfs_encode_inode_fh(inode, (struct fid *)f.handle.f_handle, &size, 0);
> +	ret = exportfs_encode_inode_fh(inode, (struct fid *)f.handle.f_handle, &size, NULL);
>  	if ((ret == FILEID_INVALID) || (ret < 0)) {
>  		WARN_ONCE(1, "Can't encode file handler for inotify: %d\n", ret);
>  		return;
> diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
> index f5ad1ed..066a566 100644
> --- a/fs/ubifs/xattr.c
> +++ b/fs/ubifs/xattr.c
> @@ -612,7 +612,7 @@ int ubifs_init_security(struct inode *dentry, struct inode *inode,
>  	int err;
>  
>  	err = security_inode_init_security(inode, dentry, qstr,
> -					   &init_xattrs, 0);
> +					   &init_xattrs, NULL);
>  	if (err) {
>  		struct ubifs_info *c = dentry->i_sb->s_fs_info;
>  		ubifs_err(c, "cannot initialize security for inode %lu, error %d",
> 
