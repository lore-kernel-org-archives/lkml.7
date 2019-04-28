Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0D0C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 13:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F7D20843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 13:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556458685;
	bh=QuDBWSOMxeWxn8rm9QLXVNTmqvyLc+6Vw04OqkVXSTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kDLPE7PnAIdFjflWbg+EWQ1Lr7N5YpS+R2McUNjvaRu9L1DMESkfEE9R7C4esw0c+
	 VuGP3SxbCTdsUVmFjszUxFsYyWL+a6M5B56EEk5QmIjI7+Aq9Rcos/whAAh7HaChVl
	 Sk35c53LPHeHoGEPv+U/81wz9+Pygvtroy76nLCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfD1NiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 09:38:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbfD1NiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 09:38:03 -0400
Received: from localhost (c-98-234-77-170.hsd1.ca.comcast.net [98.234.77.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B55FE2075D;
        Sun, 28 Apr 2019 13:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556458682;
        bh=QuDBWSOMxeWxn8rm9QLXVNTmqvyLc+6Vw04OqkVXSTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EFzaStJsh/d6K4YIMFF/XXWluWylVxWpCBUGd9AjZBJenMYywvVYMc/dKqR/mqRM+
         c+v3dF+KonZwRaAM0md88W9LSIhbz0W0rICFme8v7YmsF2hzvtNOJi6e8K/gPwMaDw
         CXFu3vbRCLkI6zTgmWeMmW9lCvQXyqO4wDZ7KcDE=
Date:   Sun, 28 Apr 2019 06:38:02 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH] f2fs: fix to do sanity with enabled features in image
Message-ID: <20190428133802.GB37346@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190424094850.118323-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424094850.118323-1-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/24, Chao Yu wrote:
> This patch fixes to do sanity with enabled features in image, if
> there are features kernel can not recognize, just fail the mount.

We need to figure out per-feature-based rejection, since some of them can
be set without layout change.

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/f2fs.h  | 13 +++++++++++++
>  fs/f2fs/super.c |  9 +++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index f5ffc09705eb..15b640967e12 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -151,6 +151,19 @@ struct f2fs_mount_info {
>  #define F2FS_FEATURE_VERITY		0x0400	/* reserved */
>  #define F2FS_FEATURE_SB_CHKSUM		0x0800
>  
> +#define F2FS_ALL_FEATURES	(F2FS_FEATURE_ENCRYPT |			\
> +				F2FS_FEATURE_BLKZONED |			\
> +				F2FS_FEATURE_ATOMIC_WRITE |		\
> +				F2FS_FEATURE_EXTRA_ATTR |		\
> +				F2FS_FEATURE_PRJQUOTA |			\
> +				F2FS_FEATURE_INODE_CHKSUM |		\
> +				F2FS_FEATURE_FLEXIBLE_INLINE_XATTR |	\
> +				F2FS_FEATURE_QUOTA_INO |		\
> +				F2FS_FEATURE_INODE_CRTIME |		\
> +				F2FS_FEATURE_LOST_FOUND |		\
> +				F2FS_FEATURE_VERITY |			\
> +				F2FS_FEATURE_SB_CHKSUM)
> +
>  #define __F2FS_HAS_FEATURE(raw_super, mask)				\
>  	((raw_super->feature & cpu_to_le32(mask)) != 0)
>  #define F2FS_HAS_FEATURE(sbi, mask)	__F2FS_HAS_FEATURE(sbi->raw_super, mask)
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 4f8e9ab48b26..57f2fc6d14ba 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2573,6 +2573,15 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
>  		return 1;
>  	}
>  
> +	/* check whether kernel supports all features */
> +	if (le32_to_cpu(raw_super->feature) & (~F2FS_ALL_FEATURES)) {
> +		f2fs_msg(sb, KERN_INFO,
> +			"Unsupported feature:%u: supported:%u",
> +			le32_to_cpu(raw_super->feature),
> +			F2FS_ALL_FEATURES);
> +		return 1;
> +	}
> +
>  	/* check CP/SIT/NAT/SSA/MAIN_AREA area boundary */
>  	if (sanity_check_area_boundary(sbi, bh))
>  		return 1;
> -- 
> 2.18.0.rc1
