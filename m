Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3039C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF7DE20874
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="P28Zg2Bf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbfHMNkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 09:40:17 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37617 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbfHMNkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 09:40:17 -0400
Received: by mail-pl1-f193.google.com with SMTP id bj8so2285756plb.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 06:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nvwUfuq5//4ebBZLqy8pzTLjWpANxsnJdhV5npPEdaA=;
        b=P28Zg2BfRo0qMAM1gw6NfXK6hH/tj6DVAyeF/L5ywYtJE59JIBjSKLOinpKApwhWCj
         Wrs26UlvaPx+nU7EANXAQtcAvdDOtGMyOmm2xVkb05Lu8cHEhXt8GYcXS7T26kgl4++V
         GDvXvJQie7QWH6u+gwmtcM1SELZ8VRYKUx6dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nvwUfuq5//4ebBZLqy8pzTLjWpANxsnJdhV5npPEdaA=;
        b=RVOqL5C4O0khxX1pzK4wkCHU6MbU52QcqyfYPKd8Og4MDLcBL/5mS4XoTeiIwOWCUW
         eK88pQIyoPcA3P9pj65e276X1cFGxPhGiOJedcjuWqz6Cn+8+wQ3Na5c5SwaShpICEsH
         7s0jj79HtjFVPekJHPt9Kq7QA6LffOh1Bhzn787KKAq2bW3R6fKyE6lf0RcWXFVdEF6V
         nTw2w7VyfWTxD7ftFAm+bZqZNQayV0cDorLaG8wiWDFmiJ/IRFBzBh+8J5NWRo/Ls8RD
         bBCXmK09T6J+7PUVLUkpWbsJNw4XIn7BRtQtWMkFoAp6/On8Y6APDvDEc5d2EsNz/AFD
         srfA==
X-Gm-Message-State: APjAAAVOsNfexo1oS9chg2W5bSXT2i7rDzoas1G+FIoPdnYiAOSZHhf8
        8t4pqqR4f7G7rKft0U+QA5rTHg==
X-Google-Smtp-Source: APXvYqwNVVzRpwN9aaDzZMqjJJvauDOHQmNnh0NkjeNSE5Ql4uCF+e48jXXn+sZR4F/vN4VV7WVZbA==
X-Received: by 2002:a17:902:e30b:: with SMTP id cg11mr38434850plb.335.1565703616622;
        Tue, 13 Aug 2019 06:40:16 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id i14sm17981827pfq.77.2019.08.13.06.40.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 06:40:15 -0700 (PDT)
Date:   Tue, 13 Aug 2019 09:40:14 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Message-ID: <20190813134014.GB258732@google.com>
References: <20190812214918.101756-1-joel@joelfernandes.org>
 <20190813060540.GE6670@kroah.com>
 <20190813133905.GA258732@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813133905.GA258732@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 09:39:05AM -0400, Joel Fernandes wrote:
[snip] 
> > >  drivers/base/core.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > index 32cf83d1c744..c22271577c84 100644
> > > --- a/drivers/base/core.c
> > > +++ b/drivers/base/core.c
> > > @@ -97,10 +97,12 @@ void device_links_read_unlock(int not_used)
> > >  	up_read(&device_links_lock);
> > >  }
> > >  
> > > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > >  int device_links_read_lock_held(void)
> > >  {
> > > -	return lock_is_held(&device_links_lock);
> > > +	return lock_is_held(&(device_links_lock.dep_map));
> > >  }
> > > +#endif
> > 
> > I don't know what the original code looks like here, but I'm guessing
> > that some .h file will need to be fixed up as you are just preventing
> > this function from ever being present without that option enabled?
> 
> No, it doesn't. I already thought about that and it is not an issue. I know
> this may be confusing because the patch I am fixing is not yet in mainline
> but in -rcu dev branch, however I did CC you on that RCU patch before but
> understandably it is not in the series so it was harder to review.
> 
> Let me explain, the lock checking facility that this patch uses is here:
> https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?h=dev&id=28875945ba98d1b47a8a706812b6494d165bb0a0
> 
> If you see, the CONFIG_PROVE_RCU_LIST defines an alternate __list_check_rcu()
> which is just a NOOP if CONFIG_PROVE_RCU_LIST=n.
> 
> CONFIG_PROVE_RCU_LIST depends on CONFIG_PROVE_RCU which is def_bool on
> CONFIG_PROVE_LOCKING which selects CONFIG_DEBUG_LOCK_ALLOC.
> 
> So there cannot be a scenario where CONFIG_PROVE_RCU_LIST is enabled but
> CONFIG_DEBUG_LOCK_ALLOC is disabled.
> 
> To verify this, one could clone the RCU tree's dev branch and do this:
> 
> Initially PROVE_RCU_LIST is not in config:
> 
> joelaf@joelaf:~/repo/linux-master$ grep -i prove_rcu .config
> 
> Neither is DEBUG_LOCK_ALLOC:
> 
> joelaf@joelaf:~/repo/linux-master$ grep -i debug_lock .config
> # CONFIG_DEBUG_LOCK_ALLOC is not set
> 
> Enable all configs:
> joelaf@joelaf:~/repo/linux-master$ ./scripts/config -e CONFIG_RCU_EXPERT
> joelaf@joelaf:~/repo/linux-master$ ./scripts/config -e CONFIG_PROVE_LOCKING
> joelaf@joelaf:~/repo/linux-master$ ./scripts/config -e CONFIG_PROVE_RCU
> joelaf@joelaf:~/repo/linux-master$ ./scripts/config -e CONFIG_PROVE_RCU_LIST
> joelaf@joelaf:~/repo/linux-master$ make olddefconfig
> 
> DEBUG_LOCK_ALLOC shows up:
> 
> joelaf@joelaf:~/repo/linux-master$ grep -i debug_lock_all .config
> CONFIG_DEBUG_LOCK_ALLOC=y
> 
> So does PROVE_RCU options:
> joelaf@joelaf:~/repo/linux-master$ grep -i prove_rcu .config
> CONFIG_PROVE_RCU=y
> CONFIG_PROVE_RCU_LIST=y
> 
> Now, force disable DEBUG_LOCK_ALLOC:
> 
> joelaf@joelaf:~/repo/linux-master$ ./scripts/config -d CONFIG_DEBUG_LOCK_ALLOC
> 
> joelaf@joelaf:~/repo/linux-master$ make olddefconfig
> 
> Options are still enabled:
> 
> joelaf@joelaf:~/repo/linux-master$ grep -i debug_lock .config
> CONFIG_DEBUG_LOCK_ALLOC=y
> joelaf@joelaf:~/repo/linux-master$ grep -i prove_rcu .config
> CONFIG_PROVE_RCU=y
> CONFIG_PROVE_RCU_LIST=y

Also, appreciate if you could Ack the fix ;-)  (assuming the newlines in
commit message are fixed).

thanks,

 - Joel

