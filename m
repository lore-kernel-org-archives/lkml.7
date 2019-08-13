Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8383BC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE5C206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="CgzLkOQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbfHMNjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 09:39:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39941 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbfHMNjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 09:39:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so51635723pfp.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 06:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vZ4qRl5GH3pXgJ8QcX2FUPhCShp8z1W2H/JG9jmcgUQ=;
        b=CgzLkOQRxuhEBOUF0+zsdgi+38LK9wvcRjrW6r3lKt70COM2JzjnuDbP5SugUaBvxV
         cMhuuKyfooHJ0nKm40NjAKVd8RDGEmlP2jKzXvGURL/Le3aTWeAt4xQ3EFku39ZEHvha
         Yx/SrOKhRweR9hM+s8WMsC705aD92V/qwTves=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vZ4qRl5GH3pXgJ8QcX2FUPhCShp8z1W2H/JG9jmcgUQ=;
        b=s/Dlq+EIb5RIzq+It6HBsFBpVJKGHOdhHpKFMdjqRfk0JX3sk5d0cHBGFzUG/Nk916
         uT/4o0pILP/KKT6CLon0O+hpHAgol8cMR6Dxs+s8CfN+DuiGsa4E9nd4EIVBvyXIT9ah
         sBbfMtxjfAZHLa8FNvptUpqlgrGrRjbO3Ut/obVQ/kfeFrH1IPtHz43Cr1SB1Sj8429E
         yadwGz4BVdjOVVdNJHjOqAF4WySxBdQEbIE+W/81kPSiH+rEDLqFgHs4RrUkMZ+JR0bx
         D/J72de4/gFFKkpcAqpDS6syLuwSpTwo//3UTUKMQeVhCJXn1N/S2Amhf4I5Df8EC3NN
         W+/w==
X-Gm-Message-State: APjAAAWtOJ6G1kE07JnaIL6alltmnxRQOQ2Mhoovw+HUel/3KCUNMYpc
        WrlUbpHM1HovzTXhZjR8SH6km3/5lIQ=
X-Google-Smtp-Source: APXvYqzjab9ev9BM0e2Bi1vzoZ3eoCT46g1H+Il3bRqI5lOuTV8ZxHTvwHeNJHFk1wFHk6Xp2ta7uA==
X-Received: by 2002:a62:8f91:: with SMTP id n139mr39294103pfd.48.1565703547842;
        Tue, 13 Aug 2019 06:39:07 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j6sm7924175pje.11.2019.08.13.06.39.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 06:39:06 -0700 (PDT)
Date:   Tue, 13 Aug 2019 09:39:05 -0400
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
Message-ID: <20190813133905.GA258732@google.com>
References: <20190812214918.101756-1-joel@joelfernandes.org>
 <20190813060540.GE6670@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813060540.GE6670@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 08:05:40AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Aug 12, 2019 at 05:49:17PM -0400, Joel Fernandes (Google) wrote:
> > Check if lockdep lock checking is disabled. If so, then do not define
> > device_links_read_lock_held(). It is used only from places where lockdep
> > checking is enabled.
> > 
> > Also fix a bug where I was not checking dep_map. Previously, I did not
> > test !SRCU configs so this got missed. Now it is sorted.
> > 
> > Link: https://lore.kernel.org/lkml/201908080026.WSAFx14k%25lkp@intel.com/
> > Fixes: c9e4d3a2fee8 ("acpi: Use built-in RCU list checking for acpi_ioremaps list")
> >  (Based on RCU's dev branch)
> > 
> > Cc: kernel-team@android.com
> > Cc: kbuild test robot <lkp@intel.com>,
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
> > Cc: Josh Triplett <josh@joshtriplett.org>,
> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
> > Cc: linux-doc@vger.kernel.org,
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
> > Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>,
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
> > Cc: rcu@vger.kernel.org,
> > Cc: Steven Rostedt <rostedt@goodmis.org>,
> > 
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Nit, drop those blank lines above, should all be in one big "block">

Ok.

> >  drivers/base/core.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 32cf83d1c744..c22271577c84 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -97,10 +97,12 @@ void device_links_read_unlock(int not_used)
> >  	up_read(&device_links_lock);
> >  }
> >  
> > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> >  int device_links_read_lock_held(void)
> >  {
> > -	return lock_is_held(&device_links_lock);
> > +	return lock_is_held(&(device_links_lock.dep_map));
> >  }
> > +#endif
> 
> I don't know what the original code looks like here, but I'm guessing
> that some .h file will need to be fixed up as you are just preventing
> this function from ever being present without that option enabled?

No, it doesn't. I already thought about that and it is not an issue. I know
this may be confusing because the patch I am fixing is not yet in mainline
but in -rcu dev branch, however I did CC you on that RCU patch before but
understandably it is not in the series so it was harder to review.

Let me explain, the lock checking facility that this patch uses is here:
https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?h=dev&id=28875945ba98d1b47a8a706812b6494d165bb0a0

If you see, the CONFIG_PROVE_RCU_LIST defines an alternate __list_check_rcu()
which is just a NOOP if CONFIG_PROVE_RCU_LIST=n.

CONFIG_PROVE_RCU_LIST depends on CONFIG_PROVE_RCU which is def_bool on
CONFIG_PROVE_LOCKING which selects CONFIG_DEBUG_LOCK_ALLOC.

So there cannot be a scenario where CONFIG_PROVE_RCU_LIST is enabled but
CONFIG_DEBUG_LOCK_ALLOC is disabled.

To verify this, one could clone the RCU tree's dev branch and do this:

Initially PROVE_RCU_LIST is not in config:

joelaf@joelaf:~/repo/linux-master$ grep -i prove_rcu .config

Neither is DEBUG_LOCK_ALLOC:

joelaf@joelaf:~/repo/linux-master$ grep -i debug_lock .config
# CONFIG_DEBUG_LOCK_ALLOC is not set

Enable all configs:
joelaf@joelaf:~/repo/linux-master$ ./scripts/config -e CONFIG_RCU_EXPERT
joelaf@joelaf:~/repo/linux-master$ ./scripts/config -e CONFIG_PROVE_LOCKING
joelaf@joelaf:~/repo/linux-master$ ./scripts/config -e CONFIG_PROVE_RCU
joelaf@joelaf:~/repo/linux-master$ ./scripts/config -e CONFIG_PROVE_RCU_LIST
joelaf@joelaf:~/repo/linux-master$ make olddefconfig

DEBUG_LOCK_ALLOC shows up:

joelaf@joelaf:~/repo/linux-master$ grep -i debug_lock_all .config
CONFIG_DEBUG_LOCK_ALLOC=y

So does PROVE_RCU options:
joelaf@joelaf:~/repo/linux-master$ grep -i prove_rcu .config
CONFIG_PROVE_RCU=y
CONFIG_PROVE_RCU_LIST=y

Now, force disable DEBUG_LOCK_ALLOC:

joelaf@joelaf:~/repo/linux-master$ ./scripts/config -d CONFIG_DEBUG_LOCK_ALLOC

joelaf@joelaf:~/repo/linux-master$ make olddefconfig

Options are still enabled:

joelaf@joelaf:~/repo/linux-master$ grep -i debug_lock .config
CONFIG_DEBUG_LOCK_ALLOC=y
joelaf@joelaf:~/repo/linux-master$ grep -i prove_rcu .config
CONFIG_PROVE_RCU=y
CONFIG_PROVE_RCU_LIST=y

thanks,

 - Joel

