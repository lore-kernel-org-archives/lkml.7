Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1372AC2D0CE
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 00:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3046206E4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 00:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbgAAAy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 19:54:58 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:40944 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgAAAy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 19:54:58 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1imSHe-0004Zd-1d; Wed, 01 Jan 2020 00:54:46 +0000
Date:   Wed, 1 Jan 2020 00:54:46 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stable@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Serge Hallyn <serge@hallyn.com>, dev@opencontainers.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/1] mount: universally disallow mounting over
 symlinks
Message-ID: <20200101005446.GH4203@ZenIV.linux.org.uk>
References: <20191230052036.8765-1-cyphar@cyphar.com>
 <20191230054413.GX4203@ZenIV.linux.org.uk>
 <20191230054913.c5avdjqbygtur2l7@yavin.dot.cyphar.com>
 <20191230072959.62kcojxpthhdwmfa@yavin.dot.cyphar.com>
 <20200101004324.GA11269@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200101004324.GA11269@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 01, 2020 at 12:43:24AM +0000, Al Viro wrote:
> I'm not sure if you have caught anything else, but we really, really should *NOT*
> consider the LAST_BIND as "maybe we should follow the result" material.  So
> at least the following is needed; could you check if anything else remains
> with that applied?
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index d6c91d1e88cb..d4fbbda8a7ff 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2656,10 +2656,7 @@ mountpoint_last(struct nameidata *nd)
>  	nd->flags &= ~LOOKUP_PARENT;
>  
>  	if (unlikely(nd->last_type != LAST_NORM)) {
> -		error = handle_dots(nd, nd->last_type);
> -		if (error)
> -			return error;
> -		path.dentry = dget(nd->path.dentry);
> +		return handle_dots(nd, nd->last_type);
>  	} else {
>  		path.dentry = d_lookup(dir, &nd->last);
>  		if (!path.dentry) {

Note, BTW, that lookup_last() (aka walk_component()) does just
that - we only hit step_into() on LAST_NORM.  The same goes
for do_last().  mountpoint_last() not doing the same is _not_
intentional - it's definitely a bug.

Consider your testcase; link points to . here.  So the only
thing you could expect from trying to follow it would be
the directory 'link' lives in.  And you don't have it
when you reach the fscker via /proc/self/fd/3; what happens
instead is nd->path set to ./link (by nd_jump_link()) *AND*
step_into() called, pushing the same ./link onto stack.
It violates all kinds of assumptions made by fs/namei.c -
when pushing a symlink onto stack nd->path is expected to
contain the base directory for resolving it.

I'm fairly sure that this is the cause of at least some
of the insanity you've caught; there always could be
something else, of course, but this hole needs to be
closed in any case.
