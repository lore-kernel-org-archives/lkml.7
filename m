Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202C4C04AB3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 22:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E430C217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 22:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Ej4E7gbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfEKWLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 18:11:37 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51828 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfEKWLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 18:11:37 -0400
Received: by mail-wm1-f67.google.com with SMTP id o189so10537385wmb.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 15:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d1+FGziLF47L4qrx03aVD+M8jY5l9sq1jNKrZJyhi2o=;
        b=Ej4E7gbnKGYiowwSnWtaTwbeMaxu1nIyXWrwEaork0CeI/aFXbuw4R6MmShvlH/OZ4
         fC5MfKzqE6lg+eUSu+7ClEGLLRY+L/4hU+vlLfCpQZokJksy/FUSAezD1n3yQyBSXfWJ
         5WDCkAW7BK2eq0YLIvZHkl87MGNWpVc+Id3/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d1+FGziLF47L4qrx03aVD+M8jY5l9sq1jNKrZJyhi2o=;
        b=G1rpZx/bR7SrLKY3KBGxcQGvHBhQKxJMxYzUQdG7M9l6/HHV+qQNw3E1pb3JqYNZra
         GvspaCyzNQQn16rpKlUFkiuDq8Ar960MtTNS+wukKHE8OXFCjb4eY6A86nx6mXwN9olu
         lUJ6NMvet+Ww9KVKQIpnbz0JejNgVTI4NdF1/2d4IunDk9yKd+/hGQHL5xkUTvgYCbYs
         dgQub4bS0mUSRnwZi4LIGWI/ESRi7kdzqSvIco6gzrUZJwMrn1HrLiHOpO4xTCjbLSsw
         z9/5uZl+aGbwdt4rRj/UGhIt128C1tKF/dBCKzjN9IgASMTEEK2kQTOiKcVx7XedsD2K
         LREA==
X-Gm-Message-State: APjAAAXinfsh36nK5RW4sDeoXH6ssmzTzE7em3+doS8h+96r01+WTrvs
        ycxISFUnixZNlfcW1A8ipCkOqA==
X-Google-Smtp-Source: APXvYqxOKIy4AHjaZp8FltX2FkddcS0U5ptHUeNcdKRpT68Ku+qiK08plVhUjpP6TiWqvwmGdD4eYw==
X-Received: by 2002:a1c:cc10:: with SMTP id h16mr11462278wmb.39.1557612695128;
        Sat, 11 May 2019 15:11:35 -0700 (PDT)
Received: from andrea ([89.22.71.151])
        by smtp.gmail.com with ESMTPSA id 91sm17491123wrs.43.2019.05.11.15.11.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 15:11:34 -0700 (PDT)
Date:   Sun, 12 May 2019 00:11:26 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc/rcu: Correct field_count field naming in examples
Message-ID: <20190511221126.GA3984@andrea>
References: <20190505020328.165839-1-joel@joelfernandes.org>
 <20190507000453.GB3923@linux.ibm.com>
 <20190508162635.GD187505@google.com>
 <20190508181638.GY3923@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508181638.GY3923@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul, Joel,

> > > On the other hand, would you have ideas for more modern replacement
> > > examples?
> > 
> > There are 3 cases I can see in listRCU.txt:
> >   (1) action taken outside of read_lock (can tolerate stale data), no in-place update.
> >                 this is the best possible usage of RCU.
> >   (2) action taken outside of read_lock, in-place updates
> >                 this is good as long as not too many in-place updates.
> >                 involves copying creating new list node and replacing the
> >                 node being updated with it.
> >   (3) cannot tolerate stale data: here a deleted or obsolete flag can be used
> >                                   protected by a per-entry lock. reader
> > 				  aborts if object is stale.
> > 
> > Any replacement example must make satisfy (3) too?
> 
> It would be OK to have a separate example for (3).  It would of course
> be nicer to have one example for all three, but not all -that- important.
> 
> > The only example for (3) that I know of is sysvipc sempahores which you also
> > mentioned in the paper. Looking through this code, it hasn't changed
> > conceptually and it could be a fit for an example (ipc_valid_object() checks
> > for whether the object is stale).
> 
> That is indeed the classic canonical example.  ;-)
> 
> > The other example could be dentry look up which uses seqlocks for the
> > RCU-walk case? But that could be too complex. This is also something I first
> > learnt from the paper and then the excellent path-lookup.rst document in
> > kernel sources.
> 
> This is a great example, but it would need serious simplification for
> use in the Documentation/RCU directory.  Note that dcache uses it to
> gain very limited and targeted consistency -- only a few types of updates
> acquire the write-side of that seqlock.
> 
> Might be quite worthwhile to have a simplified example, though!
> Perhaps a trivial hash table where write-side sequence lock is acquired
> only when moving an element from one chain to another?

Sorry to take you down here..., but what do you mean by "the paper"?  ;-/

Thanx,
  Andrea
