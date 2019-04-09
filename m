Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B907C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 05:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3979720883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 05:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfDIF0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 01:26:47 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:50542 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfDIF0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 01:26:47 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 7EED415CBF6;
        Tue,  9 Apr 2019 14:16:47 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id x395GkAY012463
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 9 Apr 2019 14:16:47 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id x395GkP9008269
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 9 Apr 2019 14:16:46 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id x395GiS2008268;
        Tue, 9 Apr 2019 14:16:44 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Hou Tao <houtao1@huawei.com>
Cc:     <linux-fsdevel@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
        <jack@suse.cz>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] fat: issue flush after the writeback of FAT
References: <20190409030158.136316-1-houtao1@huawei.com>
Date:   Tue, 09 Apr 2019 14:16:44 +0900
In-Reply-To: <20190409030158.136316-1-houtao1@huawei.com> (Hou Tao's message
        of "Tue, 9 Apr 2019 11:01:58 +0800")
Message-ID: <87ef6bbvwj.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hou Tao <houtao1@huawei.com> writes:

> fsync() needs to make sure the data & meta-data of file are persistent
> after the return of fsync(), even when a power-failure occurs later.
> In the case of fat-fs, the FAT belongs to the meta-data of file,
> so we need to issue a flush after the writeback of FAT instead before.
>
> Also bail out early when any stage of fsync fails.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Looks good.

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

> ---
>  fs/fat/file.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/fs/fat/file.c b/fs/fat/file.c
> index b3bed32946b1..0e3ed79fcc3f 100644
> --- a/fs/fat/file.c
> +++ b/fs/fat/file.c
> @@ -193,12 +193,17 @@ static int fat_file_release(struct inode *inode, struct file *filp)
>  int fat_file_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
>  {
>  	struct inode *inode = filp->f_mapping->host;
> -	int res, err;
> +	int err;
> +
> +	err = __generic_file_fsync(filp, start, end, datasync);
> +	if (err)
> +		return err;
>  
> -	res = generic_file_fsync(filp, start, end, datasync);
>  	err = sync_mapping_buffers(MSDOS_SB(inode->i_sb)->fat_inode->i_mapping);
> +	if (err)
> +		return err;
>  
> -	return res ? res : err;
> +	return blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL, NULL);
>  }

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
