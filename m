Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F6AC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573A92073F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="IlLHgJUt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z+ZFCbM/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfLCWFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:05:55 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:37823 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727416AbfLCWFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:05:54 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 67D758BE;
        Tue,  3 Dec 2019 17:05:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 03 Dec 2019 17:05:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm2; bh=r
        SaF4yFU03eE8gAMdYbBxKkkiTKHBEsZ6xKHZ1B43B4=; b=IlLHgJUtS+R+dU+Zu
        6g5WIl/+R+Kj0QqzLmoM+x+1CkPHN21yMaN+wzLM9ldRG7bW+6O50toyJUQGw15M
        IfL7t73wqB02Lmnuz12lkiC/bMb2BrtsZeo9E+sEmq3Lx5oU2MuZrRXnEffOW7cL
        moAcvNQx1IYUYs+L87FDVn4BIc8UHqdr4ukREQ4HrwaD7y3QrY4xJGKM2VX8+S3h
        Eg1QeXHCnf1LxXdHEojmbbYGoZrQMOzL+hbpAxzMrgSoKNJHnTrdsys7IUCSfMnr
        vTueoEV23mqztCTS5f8DN6/vLuruSDVF24BYcVgPSIPve+uhxOhmNOATf1mIoBgB
        LYSpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=rSaF4yFU03eE8gAMdYbBxKkkiTKHBEsZ6xKHZ1B43
        B4=; b=Z+ZFCbM/KeYc6EEN96Uq50167+wEZnDfdCnM5LgOzOIbRVHnA+Rx5uVzO
        qoDwlNm/ub8koSJnBzM7eyVb71+MIwItXX3fNjAJRAwuQYXdeKZZ1LPKHn3f3KMN
        5H8kA+EDoa+a6vB4vp5bCcr5BvN5PXvlA/7Nc0eqWVeoiwm6WMozfoMG/Ith5/fg
        qzePspewjsH0CnPw+L/pl5Txv0xIq1zgx+1pnPGInnNmFIezY/KVVESyRjOyZ42x
        l4ygHZUh2gGhiyMclkCIb3NB9qDntq11lZmODoiYFKW7FtpwZWM6oHFPjKN41P1D
        GI53hKGFg00EunRRjWcn6vdrC6kLg==
X-ME-Sender: <xms:QNzmXTO44SbmiWxtmmnWtgV-4OQ7XCT-E9BNgiRYAN6Ejzl0Wie-TQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejjedgudehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtugfgjgesth
    ekredttddtjeenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtgho
    mheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkeefrdekiedrkeelrd
    dutdejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhen
    ucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:QNzmXccqAiw6b7_sf7EgX_7L5m1-BRK4Le9mLvyfPREmphvpxlnrDA>
    <xmx:QNzmXYmFRaUlw0scfLl6t64Ky5Bgn5e1efsqEI_33LngOVhClpCqDQ>
    <xmx:QNzmXeQsYAIG0k8ak5S6zglBn48Wih0nOuS_JPNHi84v4ixonXwUwA>
    <xmx:QdzmXVoJDUP2rpXrkj8tVcpJ_0WI108ltahrbUP5Gkcl-_5jaw_jkQ>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id D17CB30600BD;
        Tue,  3 Dec 2019 17:05:51 -0500 (EST)
Date:   Tue, 3 Dec 2019 23:05:48 +0100
From:   Greg KH <greg@kroah.com>
To:     linux-kernel@vger.kernel.org
Cc:     zhengliang6@huawei.com, stable-commits@vger.kernel.org
Subject: Re: Patch "f2fs: fix to data block override node segment by mistake"
 has been added to the 4.19-stable tree
Message-ID: <20191203220548.GA3430290@kroah.com>
References: <20191201151520.98C652231B@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191201151520.98C652231B@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 01, 2019 at 10:15:19AM -0500, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     f2fs: fix to data block override node segment by mistake
> 
> to the 4.19-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      f2fs-fix-to-data-block-override-node-segment-by-mist.patch
> and it can be found in the queue-4.19 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 9db064cac1f087e2f67fcd2b60b33a8047fe4294
> Author: zhengliang <zhengliang6@huawei.com>
> Date:   Mon Mar 4 09:32:25 2019 +0800
> 
>     f2fs: fix to data block override node segment by mistake
>     
>     [ Upstream commit a0770e13c8da83bdb64738c0209ab02dd3cfff8b ]
>     
>     v4: Rearrange the previous three versions.
>     
>     The following scenario could lead to data block override by mistake.
>     
>     TASK A            |  TASK kworker                                            |     TASK B                                            |       TASK C
>                       |                                                          |                                                       |
>     open              |                                                          |                                                       |
>     write             |                                                          |                                                       |
>     close             |                                                          |                                                       |
>                       |  f2fs_write_data_pages                                   |                                                       |
>                       |    f2fs_write_cache_pages                                |                                                       |
>                       |      f2fs_outplace_write_data                            |                                                       |
>                       |        f2fs_allocate_data_block (get block in seg S,     |                                                       |
>                       |                                  S is full, and only     |                                                       |
>                       |                                  have this valid data    |                                                       |
>                       |                                  block)                  |                                                       |
>                       |          allocate_segment                                |                                                       |
>                       |          locate_dirty_segment (mark S as PRE)            |                                                       |
>                       |        f2fs_submit_page_write (submit but is not         |                                                       |
>                       |                                written on dev)           |                                                       |
>     unlink            |                                                          |                                                       |
>      iput_final       |                                                          |                                                       |
>       f2fs_drop_inode |                                                          |                                                       |
>         f2fs_truncate |                                                          |                                                       |
>      (not evict)      |                                                          |                                                       |
>                       |                                                          | write_checkpoint                                      |
>                       |                                                          |  flush merged bio but not wait file data writeback    |
>                       |                                                          |  set_prefree_as_free (mark S as FREE)                 |
>                       |                                                          |                                                       | update NODE/DATA
>                       |                                                          |                                                       | allocate_segment (select S)
>                       |     writeback done                                       |                                                       |
>     
>     So we need to guarantee io complete before truncate inode in f2fs_drop_inode.
>     
>     Reviewed-by: Chao Yu <yuchao0@huawei.com>
>     Signed-off-by: Zheng Liang <zhengliang6@huawei.com>
>     Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 7a9cc64f5ca37..b82b7163e0d08 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -890,6 +890,10 @@ static int f2fs_drop_inode(struct inode *inode)
>  			sb_start_intwrite(inode->i_sb);
>  			f2fs_i_size_write(inode, 0);
>  
> +			f2fs_submit_merged_write_cond(F2FS_I_SB(inode),
> +					inode, NULL, 0, DATA);
> +			truncate_inode_pages_final(inode->i_mapping);
> +
>  			if (F2FS_HAS_BLOCKS(inode))
>  				f2fs_truncate(inode);
>  

This adds a build warning, which I think implies that this backport is
not correct:

  CC [M]  fs/f2fs/super.o
In file included from ./include/uapi/linux/posix_types.h:5,
                 from ./include/uapi/linux/types.h:14,
                 from ./include/linux/types.h:6,
                 from ./include/linux/list.h:5,
                 from ./include/linux/module.h:9,
                 from fs/f2fs/super.c:11:
fs/f2fs/super.c: In function ‘f2fs_drop_inode’:
./include/linux/stddef.h:8:14: warning: passing argument 3 of ‘f2fs_submit_merged_write_cond’ makes integer from pointer without a cast [-Wint-conversion]
    8 | #define NULL ((void *)0)
      |              ^~~~~~~~~~~
      |              |
      |              void *
fs/f2fs/super.c:894:13: note: in expansion of macro ‘NULL’
  894 |      inode, NULL, 0, DATA);
      |             ^~~~
In file included from fs/f2fs/super.c:30:
fs/f2fs/f2fs.h:3037:32: note: expected ‘nid_t’ {aka ‘unsigned int’} but argument is of type ‘void *’
 3037 |     struct inode *inode, nid_t ino, pgoff_t idx,
      |                          ~~~~~~^~~

I'm going to drop this patch from the 4.19 tree because of this.

thanks,

greg k-h
