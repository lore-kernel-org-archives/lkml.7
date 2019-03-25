Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45600C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A462080F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ic/YKzXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbfCYWkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:40:32 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37829 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfCYWkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:40:32 -0400
Received: by mail-lf1-f68.google.com with SMTP id u2so7183390lfd.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xPJVtYHTXvM2orrKqfEZlo9B30GWJZdiCtAzgwEpUz0=;
        b=ic/YKzXzFCdDKWbSifHEyTRsOTY5fUbQZ272MbPEmcdKrGXAEhfYiZKsqFvKv8Jefj
         z3F6tlKvcWdOJmNkeqNP0SAR7OwIp8YX5BNcm+YG6xtwZ/JMPQCbJYfFQGxD7keUbU2j
         ebQTAF7uelNv1wV+0MuprRNnnBNWaPQAvwj4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xPJVtYHTXvM2orrKqfEZlo9B30GWJZdiCtAzgwEpUz0=;
        b=aeD9yMp75NsJzmgD51UPeA+lFVUgKiVSBN+tqIg9rACuCund0Ux+eQH44Rd/6Ei62B
         GAi1Fkle9MbJMsTNi3GfNG+iQSqAxnxfwGO8qgW+C5DLSY0RWodYtjPv04WlH1diwecw
         j0guaoiO8AgQljBYwPAfVRQrkCc8k/n/L2H0xM1ioM43Yuq5qtMevSJAA01sM86jiYnA
         lynF3MbAhasH7T644HkhMmy677N9WCOzOVIVc+3MxcHC5aajOsHJwSgnaHBqjJ6VX6FN
         dPwqwTtl3iw6Kni3gFxl9tp45SGnX1OZmp4k2NGmMVzUIoF5yuiYbA5zAM+3dBX8bvz1
         eShA==
X-Gm-Message-State: APjAAAXJjQF/iAlV+f0rylqkcp6hYSlDGIg6Z6gmGgmTXNd4iKko7rUO
        ecUGBbhnjd3XlDCtAjwOpWoA37wp1/UpuljgUGlJTpxA
X-Google-Smtp-Source: APXvYqyDDCyOM4Dyea66QRIV6wrwf5sKMsRweHzL4U3HmIB1yXtuPPglDiIirFUHeMoY7qHBYT1sPs+Hgtonpju1MDs=
X-Received: by 2002:a19:ee18:: with SMTP id g24mr14225773lfb.158.1553553628911;
 Mon, 25 Mar 2019 15:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190323034619.15792-1-joel@joelfernandes.org>
 <20190325150133.GA4102@linux.ibm.com> <CAEXW_YRDfOEr-hdbKGDC6amRaaqTCCBsowRhVwDqJd-1BoO17g@mail.gmail.com>
 <20190325164253.GE4102@linux.ibm.com>
In-Reply-To: <20190325164253.GE4102@linux.ibm.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 25 Mar 2019 18:40:17 -0400
Message-ID: <CAEXW_YT8dS--pBrQoBO=G_d+4Ffi7o2++PQukh6dyNHqX-TLBg@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Select from only online CPUs
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 12:42 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
>
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

Will do and then will update the patch by adding the CPU back, if all
is well. Thanks.
