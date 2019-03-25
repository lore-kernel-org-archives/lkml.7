Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6587C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E51205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="e6cTJJ1h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbfCYWCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:02:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37966 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfCYWCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:02:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id 10so7080094pfo.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w1Z3yOLyzoNaa8lbFmf3r9M0cN5wEcz+ayAGY+V0CZE=;
        b=e6cTJJ1hmHecBiwpNEzYR3yiC0UaiqYUuTyiLysf1rSBhRVE6zqCbJM6NPUg5kYpTg
         mo3AFiYA8FfjDtWCCuxailHCgXZyAnNIzxq/5JR2GxfZoEt9WjfICrX6VND7iBPqElaq
         j9nut6MsU5KJhnsYr/KEaL4rgxRZESQOG6hlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w1Z3yOLyzoNaa8lbFmf3r9M0cN5wEcz+ayAGY+V0CZE=;
        b=iahg27atAAIkytuFUQPAIqba8bHCy2HjaYUPEzQ5ThkC0c18LwaicGgSGT488NicRy
         YyAvva8x6/y++gqelYJsapSGbSKDg1UefgR1nLXAOhpY42OpSYLHw0jzy99wHq+zTBJt
         5AJDEJrmOek6DyaFBCPr+YM07H6krHsyJ3HyVunor/fzFavp0muIUsI2jy8eS/nWomlz
         aEWCRiufPEOVA4cmryCu/8PHBl6Qkf4UJc6f3nPxyPkx7dHX4UQ0dfkNyA3QyKQPkFfY
         7IH0+7XrjAn4Tgm97yR9H6BuLFkBBJlawhWQNnFgadSUohSpbx39nQC2ECLIx052+nl+
         //1Q==
X-Gm-Message-State: APjAAAWbG+vrlwwGxvWxu2OaGzIox4R9ZE81Xp0Ti9d2mDoUSZYGi3NJ
        d4kd4a+SkAqBpzdbwsafRK8PSw==
X-Google-Smtp-Source: APXvYqy3gzwt+pyalFecirWib/srJLKVpjZ9zy4HZriyzC+wLFMIyTdWxpg/7qy2lA2G1e/5yNKNlA==
X-Received: by 2002:a63:3244:: with SMTP id y65mr25457794pgy.417.1553551359901;
        Mon, 25 Mar 2019 15:02:39 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v1sm1738943pff.81.2019.03.25.15.02.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 15:02:38 -0700 (PDT)
Date:   Mon, 25 Mar 2019 18:02:37 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] rcutorture: Select from only online CPUs
Message-ID: <20190325220237.GA22743@google.com>
References: <20190323034619.15792-1-joel@joelfernandes.org>
 <20190325150133.GA4102@linux.ibm.com>
 <CAEXW_YRDfOEr-hdbKGDC6amRaaqTCCBsowRhVwDqJd-1BoO17g@mail.gmail.com>
 <20190325164253.GE4102@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325164253.GE4102@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 09:42:53AM -0700, Paul E. McKenney wrote:
> On Mon, Mar 25, 2019 at 12:33:37PM -0400, Joel Fernandes wrote:
> > On Mon, Mar 25, 2019 at 11:02 AM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> > >
> > > On Fri, Mar 22, 2019 at 11:46:19PM -0400, Joel Fernandes (Google) wrote:
> > > > The rcutorture jitter.sh script selects a random CPU but does not check
> > > > if it is offline or online. This leads to taskset errors many times. On
> > > > my machine, hyper threading is disabled so half the cores are offline
> > > > causing taskset errors a lot of times. Let us fix this by checking from
> > > > only the online CPUs on the system.
> > > >
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > >
> > > Good catch!
> > >
> > > Please see below for one suggestion for simplification.
> > >
> > >                                                         Thanx, Paul
> > >
> > > > ---
> > > >  tools/testing/selftests/rcutorture/bin/jitter.sh | 11 ++++++++++-
> > > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/testing/selftests/rcutorture/bin/jitter.sh b/tools/testing/selftests/rcutorture/bin/jitter.sh
> > > > index 3633828375e3..53bf9d99b5cd 100755
> > > > --- a/tools/testing/selftests/rcutorture/bin/jitter.sh
> > > > +++ b/tools/testing/selftests/rcutorture/bin/jitter.sh
> > > > @@ -47,10 +47,19 @@ do
> > > >               exit 0;
> > > >       fi
> > > >
> > > > -     # Set affinity to randomly selected CPU
> > > > +     # Set affinity to randomly selected online CPU
> > > >       cpus=`ls /sys/devices/system/cpu/*/online |
> > >
> > >         cpus=`grep 1 /sys/devices/system/cpu/*/online |
> > 
> > Yes, this is better. Lets do it this way :)
> > 
> > > >               sed -e 's,/[^/]*$,,' -e 's/^[^0-9]*//' |
> > > >               grep -v '^0*$'`
> > >
> > > Of course, now I have no idea why I excluded CPU 0...  :-/
> > 
> > Yes, I was wondering as well about that :-)
> 
> Please feel free to try including CPU 0 and running the set of single-CPU
> rcutorture scenarios.  ;-)

Sounds good, I will test that out on your latest dev branch. Thanks,

- Joel

