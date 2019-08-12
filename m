Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45E7C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 18:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783BE2070C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 18:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfHLSLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 14:11:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbfHLSLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 14:11:23 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 284FA2067D;
        Mon, 12 Aug 2019 18:11:21 +0000 (UTC)
Date:   Mon, 12 Aug 2019 14:11:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, rcu@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/3] driver/core: Fix build error when SRCU and lockdep
 disabled
Message-ID: <20190812141119.6ec00a34@gandalf.local.home>
In-Reply-To: <20190812130310.GA27552@google.com>
References: <20190811221111.99401-1-joel@joelfernandes.org>
        <20190811221111.99401-3-joel@joelfernandes.org>
        <20190812050256.GC5834@kroah.com>
        <20190812130310.GA27552@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2019 09:03:10 -0400
Joel Fernandes <joel@joelfernandes.org> wrote:

  
> > >  drivers/base/core.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > index 32cf83d1c744..fe25cf690562 100644
> > > --- a/drivers/base/core.c
> > > +++ b/drivers/base/core.c
> > > @@ -99,7 +99,11 @@ void device_links_read_unlock(int not_used)
> > >  
> > >  int device_links_read_lock_held(void)
> > >  {
> > > -	return lock_is_held(&device_links_lock);
> > > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > > +	return lock_is_held(&(device_links_lock.dep_map));
> > > +#else
> > > +	return 1;
> > > +#endif  
> > 
> > return 1?  So the lock is always held?  

I was thinking the exact same thing.

> 
> This is just the pattern of an assert that is disabled, so that
> false-positives don't happen if lockdep is disabled.
> 
> So say someone writes a statement like:
> WARN_ON_ONCE(!device_links_read_lock_held());
> 
> Since lockdep is disabled, we cannot check whether lock is held or not. Yet,
> we don't want false positives by reporting that the lock is not held. In this
> case, it is better to report that the lock is held to suppress
> false-positives.  srcu_read_lock_held() also follows the same pattern.
> 

The real answer here is to make that WARN_ON_ONCE() dependent on
lockdep. Something like:


some/header/file.h:

#ifdef CONFIG_DEBUG_LOCK_ALLOC
# define CHECK_DEVICE_LINKS_READ_LOCK_HELD() WARN_ON_ONCE(!defice_links_read_lock_held())
#else
# define CHECK_DEVICE_LINKS_READ_LOCK_HELD() do { } while (0)
#endif

And just use CHECK_DEVICE_LINK_READ_LOCK_HELD() in those places. I
agree with Greg. "device_links_read_lock_heald()" should *never*
blindly return 1. It's confusing.

-- Steve


