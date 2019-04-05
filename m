Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1983C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB072186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554463990;
	bh=kZJ2k9ORxr4sGYGd9L1EfSmzMkFaOO6aRI8b6JL2rbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AlHk/bRRhqaDaNj0GAlwYIj84igGuDYecdkyVN9Bh111fsqImEmJVJf5qaHcoDTLX
	 RHgWj1Iw+1N7rTEd9FBD0gfaUSpPrcK6uCUk9Zu1bcuEREvUnwDBDBMNt0hCPDDPk/
	 CS+XvKhWeZhkgdTO+SIqb7YiGsI8zgEfJToyeVc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731077AbfDELdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:33:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730497AbfDELdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:33:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4C702186A;
        Fri,  5 Apr 2019 11:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554463988;
        bh=kZJ2k9ORxr4sGYGd9L1EfSmzMkFaOO6aRI8b6JL2rbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H+PPZMJJiIdDU5jrwKxvBgeL1t/5fIy8Elb2PhlUvabKlzBWqx3/E347B36X7hnbR
         7uT6lKEf8/ca6LmN/0fpzjU/Q7ZZ8fL0Dar1kCYaoDQxnTePUSpYC5q6tIBvHikVI8
         JGcX6GZypzD2lJtpnJt9dS7TpC+afzGtT1SJc+tU=
Date:   Fri, 5 Apr 2019 13:33:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gaurav Kohli <gkohli@codeaurora.org>
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Mukesh Ojha <mojha@codeaurora.org>
Subject: Re: [PATCH v0] kernfs: Skip kernfs_put of parent from child node
Message-ID: <20190405113304.GA28420@kroah.com>
References: <1554463267-30841-1-git-send-email-gkohli@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554463267-30841-1-git-send-email-gkohli@codeaurora.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 04:51:07PM +0530, Gaurav Kohli wrote:
> While adding kernfs node for child to the parent kernfs
> node and when child node founds that parent kn count is
> zero, then below comes like:
> 
> WARNING: fs/kernfs/dir.c:494 kernfs_get+0x64/0x88
> 
> This indicates that parent is in kernfs_put path/ or already
> freed, and if the child node keeps continue to
> make new kernfs node, then there is chance of
> below race for parent node:
> 
> CPU0				         CPU1
> //Parent node			         //child node
> kernfs_put
> atomic_dec_and_test(&kn->count)
> //count is 0, so continue
> 					  kernfs_new_node(child)
> 					  kernfs_get(parent);
> 					  //increment parent count to 1
> 					  //warning come as parent count is 0
> 					  /* link in */
> 					  kernfs_add_one(kn);
> 					  // this should fail as parent is
> 					  //in free path.
> 					  kernfs_put(child)
> kmem_cache_free(parent)
> 					  kmem_cache_free(child)
> 					  kn = parent
> 					  atomic_dec_and_test(&kn->count))
> 					  //this is 0 now, so release will
> 					  continue for parent.
> 					  kmem_cache_free(parent)
> 
> To prevent this race, child simply has to decrement count of parent
> kernfs node and keep continue the free path for itself.
> 
> Signed-off-by: Gaurav Kohli <gkohli@codeaurora.org>
> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
> 
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index b84d635..d5a36e8 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -515,7 +515,6 @@ void kernfs_put(struct kernfs_node *kn)
>  	if (!kn || !atomic_dec_and_test(&kn->count))
>  		return;
>  	root = kernfs_root(kn);
> - repeat:
>  	/*
>  	 * Moving/renaming is always done while holding reference.
>  	 * kn->parent won't change beneath us.
> @@ -545,8 +544,8 @@ void kernfs_put(struct kernfs_node *kn)
>  
>  	kn = parent;
>  	if (kn) {
> -		if (atomic_dec_and_test(&kn->count))
> -			goto repeat;
> +	/* Parent may be on free path, so simply decrement the count */

That's the wrong indentation :(

And how are you hitting this issue?  What user of kernfs is causing
this?

thanks,

greg k-h
