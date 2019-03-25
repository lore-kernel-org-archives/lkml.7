Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98912C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F59B20828
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbfCYQ2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:28:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:43562 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725788AbfCYQ2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:28:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C2CC9AFDA;
        Mon, 25 Mar 2019 16:28:45 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CA5401E429A; Mon, 25 Mar 2019 17:28:44 +0100 (CET)
Date:   Mon, 25 Mar 2019 17:28:44 +0100
From:   Jan Kara <jack@suse.cz>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH] fs: fix warning about Using plain integer as NULL pointer
Message-ID: <20190325162844.GD8308@quack2.suse.cz>
References: <20190322221021.GA24814@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322221021.GA24814@hari-Inspiron-1545>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 23-03-19 03:40:21, Hariprasad Kelam wrote:
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

fs/notify part looks good to me. Feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza


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
> -- 
> 2.7.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
