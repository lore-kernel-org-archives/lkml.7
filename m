Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33BAC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3CA217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388919AbfDRMQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:16:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:51802 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388903AbfDRMQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:16:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 32E41B17A;
        Thu, 18 Apr 2019 12:16:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8A69C1E15AE; Thu, 18 Apr 2019 14:16:20 +0200 (CEST)
Date:   Thu, 18 Apr 2019 14:16:20 +0200
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 49/62] dax: make use of ->free_inode()
Message-ID: <20190418121620.GI28541@quack2.suse.cz>
References: <20190416174900.GT2217@ZenIV.linux.org.uk>
 <20190416175340.21068-1-viro@ZenIV.linux.org.uk>
 <20190416175340.21068-49-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416175340.21068-49-viro@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 16-04-19 18:53:27, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> we might want to drop ->destroy_inode() there - it's used only for
> WARN_ON() now, and AFAICS that could be moved to ->evict_inode()
> if we had one...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  drivers/dax/super.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Added Dan to CC since I'm not sure how closely he follows fsdevel. The
patch looks good to me FWIW so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 0a339b85133e..bbd57ca0634a 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -412,11 +412,9 @@ static struct dax_device *to_dax_dev(struct inode *inode)
>  	return container_of(inode, struct dax_device, inode);
>  }
>  
> -static void dax_i_callback(struct rcu_head *head)
> +static void dax_free_inode(struct inode *inode)
>  {
> -	struct inode *inode = container_of(head, struct inode, i_rcu);
>  	struct dax_device *dax_dev = to_dax_dev(inode);
> -
>  	kfree(dax_dev->host);
>  	dax_dev->host = NULL;
>  	if (inode->i_rdev)
> @@ -427,16 +425,15 @@ static void dax_i_callback(struct rcu_head *head)
>  static void dax_destroy_inode(struct inode *inode)
>  {
>  	struct dax_device *dax_dev = to_dax_dev(inode);
> -
>  	WARN_ONCE(test_bit(DAXDEV_ALIVE, &dax_dev->flags),
>  			"kill_dax() must be called before final iput()\n");
> -	call_rcu(&inode->i_rcu, dax_i_callback);
>  }
>  
>  static const struct super_operations dax_sops = {
>  	.statfs = simple_statfs,
>  	.alloc_inode = dax_alloc_inode,
>  	.destroy_inode = dax_destroy_inode,
> +	.free_inode = dax_free_inode,
>  	.drop_inode = generic_delete_inode,
>  };
>  
> -- 
> 2.11.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
