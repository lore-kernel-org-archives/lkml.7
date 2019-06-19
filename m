Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9521CC31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 17:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E8A206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 17:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560965134;
	bh=TTiUY/vLFP8Bac8Lv1syPMlRyagd9kkHrGIMoKgGLvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D471800TXvXR4APOr+SMs5YmjyJ6ovx0zWdQg+s9HZEl3fu8d7Ep/L7XOvCBwijwE
	 UzMO9ZNR8kMWIRj3MBMzDHdTt5XgvRWXZYxTji5pxhUvlPWBfufC6uTwPjW7TE50f0
	 fHLUOk3kqd7eYSbAjscKF9WNFS9cRMRcyJnmOXvw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbfFSRZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 13:25:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbfFSRZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 13:25:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35ED7206E0;
        Wed, 19 Jun 2019 17:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560965131;
        bh=TTiUY/vLFP8Bac8Lv1syPMlRyagd9kkHrGIMoKgGLvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mNJ5/laIzACNVR5tTHqp790C4JXxBxOWnN4N/zwKE6U8xH08q8r9Kc0sJysBA6XI5
         pGGDEuxIxZEU9rWvBg602gozrUm5BhpmCZos4QhAzBxtdwh4aD+UvGLVLYrMz4K9Rq
         Q2Q/7DmOGBmMSUPRqsn2xvs5MpaE9+ZkMQ2H0+mY=
Date:   Wed, 19 Jun 2019 19:25:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] kobject: return -ENOSPC when add_uevent_var() fails
Message-ID: <20190619172529.GA24692@kroah.com>
References: <20190604174412.13324-1-yamada.masahiro@socionext.com>
 <20190610174538.GA10617@kroah.com>
 <CAK7LNAS=Vt__0E_WXzTB76gkJ6bUng9P1_wiWCi5aRLTP=1Www@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAS=Vt__0E_WXzTB76gkJ6bUng9P1_wiWCi5aRLTP=1Www@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 06:09:55AM +0900, Masahiro Yamada wrote:
> On Tue, Jun 11, 2019 at 2:47 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jun 05, 2019 at 02:44:12AM +0900, Masahiro Yamada wrote:
> > > This function never attempts to allocate memory, so returning -ENOMEM
> > > looks weird to me. The reason of the failure is there is no more space
> > > in the given kobj_uevent_env structure.
> > >
> > > No caller of this function relies on this functing returning a specific
> > > error code, so just change it to return -ENOSPC. The intended change,
> > > if any, is the error number displayed in log messages.
> > >
> > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > ---
> > >
> > >  lib/kobject_uevent.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> > > index 7998affa45d4..5ffd44bf4aad 100644
> > > --- a/lib/kobject_uevent.c
> > > +++ b/lib/kobject_uevent.c
> > > @@ -647,7 +647,7 @@ EXPORT_SYMBOL_GPL(kobject_uevent);
> > >   * @env: environment buffer structure
> > >   * @format: printf format for the key=value pair
> > >   *
> > > - * Returns 0 if environment variable was added successfully or -ENOMEM
> > > + * Returns 0 if environment variable was added successfully or -ENOSPC
> > >   * if no space was available.
> > >   */
> > >  int add_uevent_var(struct kobj_uevent_env *env, const char *format, ...)
> > > @@ -657,7 +657,7 @@ int add_uevent_var(struct kobj_uevent_env *env, const char *format, ...)
> > >
> > >       if (env->envp_idx >= ARRAY_SIZE(env->envp)) {
> > >               WARN(1, KERN_ERR "add_uevent_var: too many keys\n");
> > > -             return -ENOMEM;
> > > +             return -ENOSPC;
> >
> > As Rafael says, changing this for no good reason is not a good idea,
> > sorry.  Let's live with it as-is unless you can show some place where
> > this specific error value is causing problems.
> 
> 
> 
> Didn't you see WARN() above the return code?

Yes.

> I rephrased the commit log for clarification in v2.

It still doesn't matter :)

thanks,

greg k-h
