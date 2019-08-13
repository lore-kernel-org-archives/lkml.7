Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBEEC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624E520844
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565709962;
	bh=SucDibVqB1Y6XJo22ADJTrZr/i/5Mo/9zkyEYvRtiyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xXmrNbssEN7+5m4A9b5KcPwkOylm7SRAuB0Ds02rhJVy8S5tN5pj6F+TWcxUmBxvm
	 VuEMH57WSzjspO9VOdu4CZ0ZdA6tGrVTFR/rHys1pFueE/Gy3xuCTPmuelCTa9d6rg
	 /txyXxTyAQOjUtYtci/0X+ptSiSofQaJQK7vSrZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfHMP0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 11:26:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbfHMP0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:26:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F20FA20663;
        Tue, 13 Aug 2019 15:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565709959;
        bh=SucDibVqB1Y6XJo22ADJTrZr/i/5Mo/9zkyEYvRtiyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WDUzqsDwCUvJpPnUro5nrw2rYkWOE7CzVwQ6FTy1etS8EF51sHnkhLMPEqq0ROv4s
         zElsbAeuayJ7FJRXjRLsTGwhN3xN60ua/oV5CdMCYcFDyCPSZzAY+LdX2vCNO2Ooxf
         CYV16DXHVpzI/PVCFeMioa0zcbPqdhPHd9ogqzfo=
Date:   Tue, 13 Aug 2019 17:25:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        kbuild test robot <lkp@intel.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] driver/core: Fix build error when SRCU and lockdep
 disabled
Message-ID: <20190813152556.GA26138@kroah.com>
References: <20190812214918.101756-1-joel@joelfernandes.org>
 <20190813060540.GE6670@kroah.com>
 <20190813133905.GA258732@google.com>
 <20190813134014.GB258732@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813134014.GB258732@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 09:40:14AM -0400, Joel Fernandes wrote:
> On Tue, Aug 13, 2019 at 09:39:05AM -0400, Joel Fernandes wrote:
> [snip] 
> > > >  drivers/base/core.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > index 32cf83d1c744..c22271577c84 100644
> > > > --- a/drivers/base/core.c
> > > > +++ b/drivers/base/core.c
> > > > @@ -97,10 +97,12 @@ void device_links_read_unlock(int not_used)
> > > >  	up_read(&device_links_lock);
> > > >  }
> > > >  
> > > > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > > >  int device_links_read_lock_held(void)
> > > >  {
> > > > -	return lock_is_held(&device_links_lock);
> > > > +	return lock_is_held(&(device_links_lock.dep_map));
> > > >  }
> > > > +#endif
> > > 
> > > I don't know what the original code looks like here, but I'm guessing
> > > that some .h file will need to be fixed up as you are just preventing
> > > this function from ever being present without that option enabled?
> > 
> > No, it doesn't. I already thought about that and it is not an issue. I know
> > this may be confusing because the patch I am fixing is not yet in mainline
> > but in -rcu dev branch, however I did CC you on that RCU patch before but
> > understandably it is not in the series so it was harder to review.
> > 
> > Let me explain, the lock checking facility that this patch uses is here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?h=dev&id=28875945ba98d1b47a8a706812b6494d165bb0a0
> > 
> > If you see, the CONFIG_PROVE_RCU_LIST defines an alternate __list_check_rcu()
> > which is just a NOOP if CONFIG_PROVE_RCU_LIST=n.
> > 
> > CONFIG_PROVE_RCU_LIST depends on CONFIG_PROVE_RCU which is def_bool on
> > CONFIG_PROVE_LOCKING which selects CONFIG_DEBUG_LOCK_ALLOC.
> > 
> > So there cannot be a scenario where CONFIG_PROVE_RCU_LIST is enabled but
> > CONFIG_DEBUG_LOCK_ALLOC is disabled.
> > 
> > To verify this, one could clone the RCU tree's dev branch and do this:
> > 
> > Initially PROVE_RCU_LIST is not in config:
> > 
> > joelaf@joelaf:~/repo/linux-master$ grep -i prove_rcu .config
> > 
> > Neither is DEBUG_LOCK_ALLOC:
> > 
> > joelaf@joelaf:~/repo/linux-master$ grep -i debug_lock .config
> > # CONFIG_DEBUG_LOCK_ALLOC is not set
> > 
> > Enable all configs:
> > joelaf@joelaf:~/repo/linux-master$ ./scripts/config -e CONFIG_RCU_EXPERT
> > joelaf@joelaf:~/repo/linux-master$ ./scripts/config -e CONFIG_PROVE_LOCKING
> > joelaf@joelaf:~/repo/linux-master$ ./scripts/config -e CONFIG_PROVE_RCU
> > joelaf@joelaf:~/repo/linux-master$ ./scripts/config -e CONFIG_PROVE_RCU_LIST
> > joelaf@joelaf:~/repo/linux-master$ make olddefconfig
> > 
> > DEBUG_LOCK_ALLOC shows up:
> > 
> > joelaf@joelaf:~/repo/linux-master$ grep -i debug_lock_all .config
> > CONFIG_DEBUG_LOCK_ALLOC=y
> > 
> > So does PROVE_RCU options:
> > joelaf@joelaf:~/repo/linux-master$ grep -i prove_rcu .config
> > CONFIG_PROVE_RCU=y
> > CONFIG_PROVE_RCU_LIST=y
> > 
> > Now, force disable DEBUG_LOCK_ALLOC:
> > 
> > joelaf@joelaf:~/repo/linux-master$ ./scripts/config -d CONFIG_DEBUG_LOCK_ALLOC
> > 
> > joelaf@joelaf:~/repo/linux-master$ make olddefconfig
> > 
> > Options are still enabled:
> > 
> > joelaf@joelaf:~/repo/linux-master$ grep -i debug_lock .config
> > CONFIG_DEBUG_LOCK_ALLOC=y
> > joelaf@joelaf:~/repo/linux-master$ grep -i prove_rcu .config
> > CONFIG_PROVE_RCU=y
> > CONFIG_PROVE_RCU_LIST=y
> 
> Also, appreciate if you could Ack the fix ;-)  (assuming the newlines in
> commit message are fixed).

I don't know enough here to ack it, given that I can't even remember the
original patch...

If you think it's ok, that's fine with me, you can deal with the fallout
if it fails later :)


thanks,

greg k-h
