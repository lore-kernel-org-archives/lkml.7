Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896A8C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 03:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE04206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 03:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573788483;
	bh=mzHXkEiondE/oUwYrxCVLRKS7ykKvBhskkP1l9EDy+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=geQ7YYsiWTZP696FNua1Yt/htMQvCWz2dS5qRUcMNRpu3QpeCxXgt9Wul4ONaiBv0
	 pmbA6UoyNnPH9V4J6bea6+7/LtHieDTnje/McwJ2EQ+bdRIcuB0kPNfD4/XBx6teSf
	 EhmT5IwzgDgRTdpsriRlcWaKiqC88Z4ARyJl7stc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfKOD2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 22:28:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:39136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbfKOD2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 22:28:02 -0500
Received: from localhost (unknown [104.132.150.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16981206EF;
        Fri, 15 Nov 2019 03:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573788481;
        bh=mzHXkEiondE/oUwYrxCVLRKS7ykKvBhskkP1l9EDy+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p9h/JpQMEKVeOVB9MsSE1JGVtB6UhkbYvS0jS4N/TZjRxkg5AbDT5pwPG41RxsLIp
         Nw8NuNCh0t7yMzgb/Z8bZUjDMjSqvhsoS4DrWsg92KE33eiC2/DozDaUp+FI9H2bBB
         YrwzqK10hFcafJTqCDzo96wsvRKZbjJJQJmtPWoQ=
Date:   Fri, 15 Nov 2019 11:27:59 +0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     yu kuai <yukuai3@huawei.com>
Cc:     rafael@kernel.org, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        oleg@redhat.com, mchehab+samsung@kernel.org, corbet@lwn.net,
        tytso@mit.edu, jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, zhengbin13@huawei.com,
        yi.zhang@huawei.com, chenxiang66@hisilicon.com, xiexiuqi@huawei.com
Subject: Re: [PATCH 1/3] dcache: add a new enum type for 'dentry_d_lock_class'
Message-ID: <20191115032759.GA795729@kroah.com>
References: <1573788472-87426-1-git-send-email-yukuai3@huawei.com>
 <1573788472-87426-2-git-send-email-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573788472-87426-2-git-send-email-yukuai3@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 11:27:50AM +0800, yu kuai wrote:
> 'dentry_d_lock_class' can be used for spin_lock_nested in case lockdep
> confused about two different dentry take the 'd_lock'.
> 
> However, a single 'DENTRY_D_LOCK_NESTED' may not be enough if more than
> two dentry are involed. So, and in 'DENTRY_D_LOCK_NESTED_2'
> 
> Signed-off-by: yu kuai <yukuai3@huawei.com>
> ---
>  include/linux/dcache.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 10090f1..8eb84ef 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -129,7 +129,8 @@ struct dentry {
>  enum dentry_d_lock_class
>  {
>  	DENTRY_D_LOCK_NORMAL, /* implicitly used by plain spin_lock() APIs. */
> -	DENTRY_D_LOCK_NESTED
> +	DENTRY_D_LOCK_NESTED,
> +	DENTRY_D_LOCK_NESTED_2

You should document this, as "_2" does not make much sense to anyone
only looking at the code :(

Or rename it better.

thanks,

greg k-h
