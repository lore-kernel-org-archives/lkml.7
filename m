Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4F8C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 20:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F9A206EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 20:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfKMUR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 15:17:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:49038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfKMUR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 15:17:59 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54792206E6;
        Wed, 13 Nov 2019 20:17:58 +0000 (UTC)
Date:   Wed, 13 Nov 2019 15:17:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     yu kuai <yukuai3@huawei.com>
Cc:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <oleg@redhat.com>, <jack@suse.cz>, <linux-kernel@vger.kernel.org>,
        <zhengbin13@huawei.com>, <yi.zhang@huawei.com>,
        <chenxiang66@hisilicon.com>, <xiexiuqi@huawei.com>
Subject: Re: [PATCH] debugfs: fix potential infinite loop in
 debugfs_remove_recursive
Message-ID: <20191113151755.7125e914@gandalf.local.home>
In-Reply-To: <1572528884-67565-1-git-send-email-yukuai3@huawei.com>
References: <1572528884-67565-1-git-send-email-yukuai3@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2019 21:34:44 +0800
yu kuai <yukuai3@huawei.com> wrote:

> debugfs_remove_recursive uses list_empty to judge weather a dentry has
> any subdentry or not. This can lead to infinite loop when any subdir is in
> use.
> 
> The problem was discoverd by the following steps in the console.
> 1. use debugfs_create_dir to create a dir and multiple subdirs(insmod);
> 2. cd to the subdir with depth not less than 2;
> 3. call debugfs_remove_recursive(rmmod).
> 
> After removing the subdir, the infinite loop is triggered bucause

  s/bucause/because/

> debugfs_remove_recursive uses list_empty to judge if the current dir
> doesn't have any subdentry, if so, remove the current dir and which
> will never happen.
> 
> Fix the problem by using simple_empty instead of list_empty.
> 
> Fixes: 776164c1faac ('debugfs: debugfs_remove_recursive() must not rely on list_empty(d_subdirs)')
> Reported-by: chenxiang66@hisilicon.com
> Signed-off-by: yu kuai <yukuai3@huawei.com>
> ---
>  fs/debugfs/inode.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index 7b975db..42b28acc 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -773,8 +773,10 @@ void debugfs_remove_recursive(struct dentry *dentry)
>  		if (!simple_positive(child))
>  			continue;
>  
> -		/* perhaps simple_empty(child) makes more sense */
> -		if (!list_empty(&child->d_subdirs)) {
> +		/* use simple_empty to prevent infinite loop when any
> +		 * subdentry of child is in use
> +		 */

Nit, multi-line comments should be of the form:

	/*
	 * comment line 1
	 * comment line 2
	 */

Not

	/* comment line 1
	 * comment line 2
	 */

It's known that the networking folks like that method, but it's not
acceptable anywhere outside of networking.

> +		if (!simple_empty(child)) {

Have you tried this with lockdep enabled? I'm thinking that you might
get a splat with holding parent->d_lock and simple_empty(child) taking
the child->d_lock.

-- Steve


>  			spin_unlock(&parent->d_lock);
>  			inode_unlock(d_inode(parent));
>  			parent = child;

