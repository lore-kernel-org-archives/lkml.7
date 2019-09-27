Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF17C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69120217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569609112;
	bh=UNYxnX4ntOFxEKSdlmc5QQCfq4+Ba7pJxunUt3oMuws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=voIquujDTtOpQlXdS+ZpnRkBn9CSYmcO0QBISLu8qhxWN1Gy9dr85UtrBFCZApVsE
	 vd0nKsAc9qkSynrQCXaBPIQN/nOdzjof1mI1CvCjYWIrLRS+e0zCp8xZfBZ8Dh/RY/
	 bgo2pcCUfy6X4aO3Otw+WOs4rrIV925492CkqSKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbfI0Sbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 14:31:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbfI0Sbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 14:31:51 -0400
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E055C21655;
        Fri, 27 Sep 2019 18:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569609111;
        bh=UNYxnX4ntOFxEKSdlmc5QQCfq4+Ba7pJxunUt3oMuws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kZVr6zCc/phZF094x9qSudrSwmAlQIGe7hgbRWWLe8ydALl1rW/o5ooTk5kAgqY4y
         IL8fqL9nBl9bA7u5n3G5MBTgiSQMYybOB9HVHGnRTHE98uhZ3NLdVyA3c5J7tleQls
         fNGHpQEJBaCAUPR+GzyOlQltbGZ8S9p3jhnAM+n0=
Date:   Fri, 27 Sep 2019 11:31:50 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH] f2fs: fix comment of f2fs_evict_inode
Message-ID: <20190927183150.GA54001@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190925093050.118921-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925093050.118921-1-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On 09/25, Chao Yu wrote:
> evict() should be called once i_count is zero, rather than i_nlinke
> is zero.
> 
> Reported-by: Gao Xiang <gaoxiang25@huawei.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index db4fec30c30d..8262f4a483d3 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -632,7 +632,7 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
>  }
>  
>  /*
> - * Called at the last iput() if i_nlink is zero

I don't think this comment is wrong. You may be able to add on top of this.

> + * Called at the last iput() if i_count is zero
>   */
>  void f2fs_evict_inode(struct inode *inode)
>  {
> -- 
> 2.18.0.rc1
