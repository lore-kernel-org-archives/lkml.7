Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E464C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54BFB217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560359431;
	bh=pR3lImaJcFV2m+YhE4MeLz9MG23pccWXMxksWRjf92Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NxcV/DZum0HXngxdlJMfDnproJwbQeYXqsYL1AZOUlRA3U0bRyCU/mVE/bPWbKmoN
	 9ut5o1x/6Ta/Qk7XNxGJ+hR8BGcYK0eciaNPL2Ch6pbJaJYm0r87o8mTLRHZAvlviQ
	 Rc5GzgZ6WqxYdZaqIXzS8yIP8Sm1Jaw5mCg1wHTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438318AbfFLRKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 13:10:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:50900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfFLRK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:10:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B732921019;
        Wed, 12 Jun 2019 17:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560359429;
        bh=pR3lImaJcFV2m+YhE4MeLz9MG23pccWXMxksWRjf92Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XUO24YX2cpqrqgDpiQshwO9BAcXpAB5dG2reIhSLVLWJNwcB9sExTw2I/cRUvCuvl
         V02bxNO10PPMGI1b+LS+aUji9o7FP5JzMdRWh/HyOQAn/+RexTtBBNlmY77vNfHqf/
         DVmSTjKqoiPUtjwJYNbx8isDVTljlm7Cv74RtWu0=
Date:   Wed, 12 Jun 2019 19:10:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Qian Cai <cai@gmx.us>, Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Zhong Jiang <zhongjiang@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib: debugobjects: no need to check return value of
 debugfs_create functions
Message-ID: <20190612171026.GB6986@kroah.com>
References: <20190612153513.GA21082@kroah.com>
 <20190612165819.GA123863@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612165819.GA123863@google.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 12:58:19PM -0400, Joel Fernandes wrote:
> On Wed, Jun 12, 2019 at 05:35:13PM +0200, Greg Kroah-Hartman wrote:
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> > 
> > Cc: Qian Cai <cai@gmx.us>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Waiman Long <longman@redhat.com>
> > Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > Cc: Zhong Jiang <zhongjiang@huawei.com>
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  lib/debugobjects.c | 14 ++------------
> >  1 file changed, 2 insertions(+), 12 deletions(-)
> > 
> > diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> > index 55437fd5128b..2ac42286cd08 100644
> > --- a/lib/debugobjects.c
> > +++ b/lib/debugobjects.c
> > @@ -850,26 +850,16 @@ static const struct file_operations debug_stats_fops = {
> >  
> >  static int __init debug_objects_init_debugfs(void)
> >  {
> > -	struct dentry *dbgdir, *dbgstats;
> > +	struct dentry *dbgdir;
> >  
> >  	if (!debug_objects_enabled)
> >  		return 0;
> >  
> >  	dbgdir = debugfs_create_dir("debug_objects", NULL);
> > -	if (!dbgdir)
> > -		return -ENOMEM;
> >  
> > -	dbgstats = debugfs_create_file("stats", 0444, dbgdir, NULL,
> > -				       &debug_stats_fops);
> > -	if (!dbgstats)
> > -		goto err;
> > +	debugfs_create_file("stats", 0444, dbgdir, NULL, &debug_stats_fops);
> 
> 
> One weirdness is, if dbgdir is ever NULL, then debugfs_create_file() may end
> up creating the stats file in the root.

Yes, but dbgdir can not be NULL.

> In debugfs_create_file():
>         /* If the parent is not specified, we create it in the root.
>          * We need the root dentry to do this, which is in the super
>          * block. A pointer to that is in the struct vfsmount that we
>          * have around.
>          */
>         if (!parent)
>                 parent = debugfs_mount->mnt_root;

Yes, but debugfs_create_dir() will never return NULL.

> But I guess that's not a major issue since its debugfs :-) So LGTM,

Yup!

> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks for the review.

greg k-h
