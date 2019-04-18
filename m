Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48968C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229102183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388927AbfDRMLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:11:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:49986 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727807AbfDRMLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:11:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 665CFB077;
        Thu, 18 Apr 2019 12:11:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id ECB481E15AE; Thu, 18 Apr 2019 14:10:59 +0200 (CEST)
Date:   Thu, 18 Apr 2019 14:10:59 +0200
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 54/62] ext4: make use of ->free_inode()
Message-ID: <20190418121059.GH28541@quack2.suse.cz>
References: <20190416174900.GT2217@ZenIV.linux.org.uk>
 <20190416175340.21068-1-viro@ZenIV.linux.org.uk>
 <20190416175340.21068-54-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416175340.21068-54-viro@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 16-04-19 18:53:32, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> the rest of this ->destroy_inode() instance could probably be folded
> into ext4_evict_inode()
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

You're right about the possibility of moving the check to
ext4_evict_inode() (probably ext4_clear_inode() would be the best). But we
can leave that for later.

								Honza

> ---
>  fs/ext4/super.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 6ed4eb81e674..981f702848e7 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1107,9 +1107,8 @@ static int ext4_drop_inode(struct inode *inode)
>  	return drop;
>  }
>  
> -static void ext4_i_callback(struct rcu_head *head)
> +static void ext4_free_in_core_inode(struct inode *inode)
>  {
> -	struct inode *inode = container_of(head, struct inode, i_rcu);
>  	kmem_cache_free(ext4_inode_cachep, EXT4_I(inode));
>  }
>  
> @@ -1124,7 +1123,6 @@ static void ext4_destroy_inode(struct inode *inode)
>  				true);
>  		dump_stack();
>  	}
> -	call_rcu(&inode->i_rcu, ext4_i_callback);
>  }
>  
>  static void init_once(void *foo)
> @@ -1402,6 +1400,7 @@ static const struct quotactl_ops ext4_qctl_operations = {
>  
>  static const struct super_operations ext4_sops = {
>  	.alloc_inode	= ext4_alloc_inode,
> +	.free_inode	= ext4_free_in_core_inode,
>  	.destroy_inode	= ext4_destroy_inode,
>  	.write_inode	= ext4_write_inode,
>  	.dirty_inode	= ext4_dirty_inode,
> -- 
> 2.11.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
