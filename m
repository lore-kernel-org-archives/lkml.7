Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F3CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B442075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WfWNfV+d";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GiipJnaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbfC0NxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:53:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58440 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfC0NxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:53:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6A900619B3; Wed, 27 Mar 2019 13:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553694799;
        bh=JmUbfQxsHOj5SXBkCsYMoFaxqHxlEGh95LyB0+AhJwQ=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=WfWNfV+dw476+pknIKEXgTRG8fRae1Ii7kQ5GmU0RQFbGcmcjJfgW2Cjr/PMAvWED
         Gm2wUcii+7JvMUuzMXjXBIj2I5SPK4UkfqP5+MoaQkPpHioyAFHANAsFjx+srUuefO
         V6s0pYLeFwXNLvfzyoDbc2RXH2EwWaSz2BeAUm0U=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4807461A25;
        Wed, 27 Mar 2019 13:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553694797;
        bh=JmUbfQxsHOj5SXBkCsYMoFaxqHxlEGh95LyB0+AhJwQ=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=GiipJnaLqXZAXxB/yqF/KOtYicyHlKQkPn29iHemSZ3Ue9fbREZmcKMoSy+kxbUAS
         q6YIOWyIjYZJmqp0p16qqBufZ1RrTpMrQjFoynxM3LFcDPJc3ORiTCcRdOLh4/UA0j
         kMxB6/XPBZqR5HeWPkkTn+MCwcvngvBAooxyl928=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4807461A25
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] fs: fix warning about Using plain integer as NULL pointer
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mtd@lists.infradead.org
References: <20190322221021.GA24814@hari-Inspiron-1545>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <ac5a9f95-e04a-54bc-e7cb-4103555a79b4@codeaurora.org>
Date:   Wed, 27 Mar 2019 19:23:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190322221021.GA24814@hari-Inspiron-1545>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/23/2019 3:40 AM, Hariprasad Kelam wrote:
> Sparse warning below:
>
> sudo make C=2 CF=-D__CHECK_ENDIAN__ M=fs
>
> CHECK   fs/f2fs/data.c
> fs/f2fs/data.c:426:47: warning: Using plain integer as NULL pointer
> CHECK   fs/notify/fdinfo.c
> fs/notify/fdinfo.c:53:87: warning: Using plain integer as NULL pointer
>   CHECK   fs/ubifs/xattr.c
> fs/ubifs/xattr.c:615:58: warning: Using plain integer as NULL pointer
>
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh

> ---
>   fs/f2fs/data.c     | 2 +-
>   fs/notify/fdinfo.c | 2 +-
>   fs/ubifs/xattr.c   | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 97279441..15a2381 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -423,7 +423,7 @@ static void __submit_merged_write_cond(struct f2fs_sb_info *sbi,
>   
>   void f2fs_submit_merged_write(struct f2fs_sb_info *sbi, enum page_type type)
>   {
> -	__submit_merged_write_cond(sbi, NULL, 0, 0, type, true);
> +	__submit_merged_write_cond(sbi, NULL, NULL, 0, type, true);
>   }
>   
>   void f2fs_submit_merged_write_cond(struct f2fs_sb_info *sbi,
> diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
> index 1e2bfd2..ef83f40 100644
> --- a/fs/notify/fdinfo.c
> +++ b/fs/notify/fdinfo.c
> @@ -50,7 +50,7 @@ static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
>   	f.handle.handle_bytes = sizeof(f.pad);
>   	size = f.handle.handle_bytes >> 2;
>   
> -	ret = exportfs_encode_inode_fh(inode, (struct fid *)f.handle.f_handle, &size, 0);
> +	ret = exportfs_encode_inode_fh(inode, (struct fid *)f.handle.f_handle, &size, NULL);
>   	if ((ret == FILEID_INVALID) || (ret < 0)) {
>   		WARN_ONCE(1, "Can't encode file handler for inotify: %d\n", ret);
>   		return;
> diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
> index f5ad1ed..066a566 100644
> --- a/fs/ubifs/xattr.c
> +++ b/fs/ubifs/xattr.c
> @@ -612,7 +612,7 @@ int ubifs_init_security(struct inode *dentry, struct inode *inode,
>   	int err;
>   
>   	err = security_inode_init_security(inode, dentry, qstr,
> -					   &init_xattrs, 0);
> +					   &init_xattrs, NULL);
>   	if (err) {
>   		struct ubifs_info *c = dentry->i_sb->s_fs_info;
>   		ubifs_err(c, "cannot initialize security for inode %lu, error %d",
