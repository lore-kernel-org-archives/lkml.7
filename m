Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74301C32750
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 464AF20673
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="n8o7s9dE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfHLUB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 16:01:29 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46599 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfHLUB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 16:01:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id q139so1944495pfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 13:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t5IMBiad94ViMSwq7y4bsRJRQefPxt/6jC7yShC1dso=;
        b=n8o7s9dEw4INP/Gexmh1KfkKcSDs1JDp64GxVvJ20IPEbhyNxIy6CFH4ehNjOnTIZa
         0Bik+2eI1LoVNTuMoZM4V9FWFce0O+s4zKl11UbxQqloUMKdLQlmcgEasc7M5tKKOUnn
         7yGao+KtB6s+BKLS8Jjqhq2YfQ9JaqCZxQXBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t5IMBiad94ViMSwq7y4bsRJRQefPxt/6jC7yShC1dso=;
        b=gFPIIAllxBRIyAXFGrAKZwDVtXfkXBw4ni0BN1Re+/WNNAm66OIEHVAdt+/R1E4fuD
         bnHumNOZ3BPcDYh5KGtm1pMezIr827RjX1sC8Fm+7b0pcNGeqCiDt6qzbwAlVjp3XLoz
         zq/fScq03HnI7DOhZlvoFy4dcM6QUOVTFQUuwElq55uZhWFLNB9QQO1OYTSPn+exbpsd
         DE/VT6JOgYwdFXrJoNY0SeK+7QHqRDopmWDtgvqOJRM45iz1iJHJkYr3n71MGgEdwooa
         WLzY5r8l0ChKk5cH77obkawUSpAs4EM4cmRU+J5uupazIp/CgoICx7fxDtBh0F0HTH3N
         JVVg==
X-Gm-Message-State: APjAAAVi0w9m5YxZZ01DYosbrWczu/Hy2xfets96oRCPVQNLuavakUPf
        YiOUS4SbsIJkpEfG85pdw6H3Fw==
X-Google-Smtp-Source: APXvYqy8LE1ENBfsQb81cb0YkyW8PySj6pCY4WTueOPLC+/pgJQbLA/2FUi6hEKvzBnBJCvC5WOcjw==
X-Received: by 2002:a62:198d:: with SMTP id 135mr36932026pfz.169.1565640088004;
        Mon, 12 Aug 2019 13:01:28 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id br18sm407214pjb.20.2019.08.12.13.01.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 13:01:27 -0700 (PDT)
Date:   Mon, 12 Aug 2019 16:01:25 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Message-ID: <20190812200125.GA161786@google.com>
References: <20190811221111.99401-1-joel@joelfernandes.org>
 <20190811221111.99401-3-joel@joelfernandes.org>
 <20190812050256.GC5834@kroah.com>
 <20190812130310.GA27552@google.com>
 <20190812141119.6ec00a34@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812141119.6ec00a34@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 02:11:19PM -0400, Steven Rostedt wrote:
> On Mon, 12 Aug 2019 09:03:10 -0400
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
>   
> > > >  drivers/base/core.c | 6 +++++-
> > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > index 32cf83d1c744..fe25cf690562 100644
> > > > --- a/drivers/base/core.c
> > > > +++ b/drivers/base/core.c
> > > > @@ -99,7 +99,11 @@ void device_links_read_unlock(int not_used)
> > > >  
> > > >  int device_links_read_lock_held(void)
> > > >  {
> > > > -	return lock_is_held(&device_links_lock);
> > > > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > > > +	return lock_is_held(&(device_links_lock.dep_map));
> > > > +#else
> > > > +	return 1;
> > > > +#endif  
> > > 
> > > return 1?  So the lock is always held?  
> 
> I was thinking the exact same thing.
> 
> > 
> > This is just the pattern of an assert that is disabled, so that
> > false-positives don't happen if lockdep is disabled.
> > 
> > So say someone writes a statement like:
> > WARN_ON_ONCE(!device_links_read_lock_held());
> > 
> > Since lockdep is disabled, we cannot check whether lock is held or not. Yet,
> > we don't want false positives by reporting that the lock is not held. In this
> > case, it is better to report that the lock is held to suppress
> > false-positives.  srcu_read_lock_held() also follows the same pattern.
> > 
> 
> The real answer here is to make that WARN_ON_ONCE() dependent on
> lockdep. Something like:
> 
> 
> some/header/file.h:
> 
> #ifdef CONFIG_DEBUG_LOCK_ALLOC
> # define CHECK_DEVICE_LINKS_READ_LOCK_HELD() WARN_ON_ONCE(!defice_links_read_lock_held())
> #else
> # define CHECK_DEVICE_LINKS_READ_LOCK_HELD() do { } while (0)
> #endif
> 
> And just use CHECK_DEVICE_LINK_READ_LOCK_HELD() in those places. I
> agree with Greg. "device_links_read_lock_heald()" should *never*
> blindly return 1. It's confusing.

Ok, then I will update the patch to do:

#ifdef CONFIG_DEBUG_LOCK_ALLOC
int device_links_read_lock_held(void)
{
	return lock_is_held(&device_links_lock);
}
#endif  

That will also solve the build error. And callers can follow the above pattern you shared.

thanks,

 - Joel

