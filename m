Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0231C10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A86BA20700
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732742AbfCZVC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 17:02:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33598 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbfCZVC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 17:02:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CC9B7307B48F;
        Tue, 26 Mar 2019 21:02:28 +0000 (UTC)
Received: from [10.33.36.91] (unknown [10.33.36.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1FAF17DC5;
        Tue, 26 Mar 2019 21:02:26 +0000 (UTC)
Subject: Re: [RFC PATCH 1/4] vfs: Create fs_context-aware mount_bdev()
 replacement
To:     David Howells <dhowells@redhat.com>
Cc:     miklos@szeredi.hu, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <155301260319.7556.1326405089184672936.stgit@warthog.procyon.org.uk>
 <155301261082.7556.2558480789011010142.stgit@warthog.procyon.org.uk>
From:   Andrew Price <anprice@redhat.com>
Message-ID: <ad854f75-6b42-7d8a-2cc6-cbcf528c8458@redhat.com>
Date:   Tue, 26 Mar 2019 21:02:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <155301261082.7556.2558480789011010142.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 26 Mar 2019 21:02:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

I've been testing gfs2 on top of this patch and it seems...

On 19/03/2019 16:23, David Howells wrote:
> Create a function, vfs_get_block_super(), that is fs_context-aware and a
> replacement for mount_bdev().  It caches the block device pointer and file
> open mode in the fs_context struct so that this information can be passed
> into sget_fc()'s test and set functions.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>   fs/fs_context.c            |    2 +
>   fs/super.c                 |  106 ++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/fs_context.h |    6 ++
>   3 files changed, 114 insertions(+)
> 
> diff --git a/fs/fs_context.c b/fs/fs_context.c
> index 87e3546b9a52..ea027762c0b2 100644
> --- a/fs/fs_context.c
> +++ b/fs/fs_context.c
> @@ -425,6 +425,8 @@ void put_fs_context(struct fs_context *fc)
>   
>   	if (fc->need_free && fc->ops && fc->ops->free)
>   		fc->ops->free(fc);
> +	if (fc->bdev)
> +		blkdev_put(fc->bdev, fc->bdev_mode);

doing this means...

>   
>   	security_free_mnt_opts(&fc->security);
>   	put_net(fc->net_ns);
> diff --git a/fs/super.c b/fs/super.c
> index f27ee08fb26f..85851adb0f19 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1211,6 +1211,112 @@ int vfs_get_super(struct fs_context *fc,
>   EXPORT_SYMBOL(vfs_get_super);
>   
>   #ifdef CONFIG_BLOCK
> +static int set_bdev_super_fc(struct super_block *s, struct fs_context *fc)
> +{
> +	s->s_bdev = fc->bdev;
> +	s->s_dev = s->s_bdev->bd_dev;
> +	s->s_bdi = bdi_get(s->s_bdev->bd_bdi);
> +	fc->bdev = NULL;
> +	return 0;
> +}
> +
> +static int test_bdev_super_fc(struct super_block *s, struct fs_context *fc)
> +{
> +	return s->s_bdev == fc->bdev;
> +}
> +
> +/**
> + * vfs_get_block_super - Get a superblock based on a single block device
> + * @fc: The filesystem context holding the parameters
> + * @keying: How to distinguish superblocks
> + * @fill_super: Helper to initialise a new superblock
> + */
> +int vfs_get_block_super(struct fs_context *fc,
> +			int (*fill_super)(struct super_block *,
> +					  struct fs_context *))
> +{
> +	struct block_device *bdev;
> +	struct super_block *s;
> +	int error = 0;
> +
> +	fc->bdev_mode = FMODE_READ | FMODE_EXCL;
> +	if (!(fc->sb_flags & SB_RDONLY))
> +		fc->bdev_mode |= FMODE_WRITE;
> +
> +	if (!fc->source)
> +		return invalf(fc, "No source specified");
> +
> +	bdev = blkdev_get_by_path(fc->source, fc->bdev_mode, fc->fs_type);
> +	if (IS_ERR(bdev)) {
> +		errorf(fc, "%s: Can't open blockdev", fc->source);
> +		return PTR_ERR(bdev);
> +	}
> +
> +	/* Once the superblock is inserted into the list by sget_fc(), s_umount
> +	 * will protect the lockfs code from trying to start a snapshot while
> +	 * we are mounting
> +	 */
> +	mutex_lock(&bdev->bd_fsfreeze_mutex);
> +	if (bdev->bd_fsfreeze_count > 0) {
> +		mutex_unlock(&bdev->bd_fsfreeze_mutex);
> +		warnf(fc, "%pg: Can't mount, blockdev is frozen", bdev);
> +		error = -EBUSY;
> +		goto error_bdev;
> +	}
> +
> +	fc->bdev = bdev;
> +	fc->sb_flags |= SB_NOSEC;
> +	s = sget_fc(fc, test_bdev_super_fc, set_bdev_super_fc);
> +	mutex_unlock(&bdev->bd_fsfreeze_mutex);
> +	if (IS_ERR(s)) {
> +		error = PTR_ERR(s);
> +		goto error_bdev;
> +	}
> +
> +	if (s->s_root) {
> +		/* Don't summarily change the RO/RW state. */
> +		if ((fc->sb_flags ^ s->s_flags) & SB_RDONLY) {
> +			warnf(fc, "%pg: Can't mount, would change RO state", bdev);
> +			error = -EBUSY;
> +			goto error_sb;
> +		}
> +
> +		/* s_umount nests inside bd_mutex during __invalidate_device().
> +		 * blkdev_put() acquires bd_mutex and can't be called under
> +		 * s_umount.  Drop s_umount temporarily.  This is safe as we're
> +		 * holding an active reference.
> +		 */
> +		up_write(&s->s_umount);
> +		blkdev_put(bdev, fc->bdev_mode);
> +		down_write(&s->s_umount);

fc->bdev should be NULLed here (or, on the way out of sget_fc() might be 
more appropriate) otherwise we get a double-blkdev_put() leading to NULL 
pointer derefs later. This happens when I mount a device twice and then 
unmount them, or mount it 3 times.

> +	} else {
> +		s->s_mode = fc->bdev_mode;
> +		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
> +		sb_set_blocksize(s, block_size(bdev));
> +		error = fill_super(s, fc);
> +		if (error)
> +			goto error_sb;
> +
> +		s->s_flags |= SB_ACTIVE;
> +		bdev->bd_super = s;
> +	}
> +
> +	BUG_ON(fc->root);

Maybe BUG_ON(fc->bdev); too?

Cheers,
Andy
