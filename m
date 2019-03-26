Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B408DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0EC206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="aHqQWegy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732570AbfCZSkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:40:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38612 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732387AbfCZSkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:40:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id j26so6656670pgl.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OebS67tbjuWqFy3t0xAyZDQg7pK9l7HQQXFcKoVXBUI=;
        b=aHqQWegyBv3YF3tGsHCmvf7tz2aaW/j8NnMEprAH3TvslM9hlswSY84IQ47i0dt3mv
         JfylL/ggyXsteKWhOvAXR9TV/Q4Y0p63ZMDiaHhArtCNYHQANCpYoGZFJeDTmxivbbR9
         svPLasom7c8zV//Bvc2QVI/8KfMFOGZ2LpDB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OebS67tbjuWqFy3t0xAyZDQg7pK9l7HQQXFcKoVXBUI=;
        b=mXxbDTgtVXgtGTpONJnSigSwMTgbaXOuiEwRwkhWRu4hG6EvnLoXRTZamSchjCX/tN
         DesqfB80W6aaWkuJ9sIRSzGD653/i463dL2Ck8afa3efjtwlR4FUgY6dGqIjE7CzJ721
         uHnc8GF+adln+47HMn8XIFc4Qaj/pdH0xmmRR8gRxKP0ug/tWDaC7VGFV+xyGdaAnd66
         Td4entpab762hjdHf54vio7L2+EV1yJACb5c3csk7Uv/QlkWfdE69/lRDAylPhxI4vr4
         KfA0IjJXhkGrF5kHGqIw5gh6h0xa6vRFCU+GEDfb9j1Gsbpge+wO6mbhHkE6RkE8WovM
         chrg==
X-Gm-Message-State: APjAAAX476Iv0keTN0sZJf/017AD5yUjoZXBaTZNtQAwe8tMGNYRBpqi
        4SsTTEGgM5F3lXgaB5LEJP5YwQ==
X-Google-Smtp-Source: APXvYqxU6oX8DyqVN9JeaIgQ8f+xY9HWwWfFeiU1yBW4UniboQYiSfOADODCXGOlk3Yw0Wcdc6PKkw==
X-Received: by 2002:a63:6985:: with SMTP id e127mr30769030pgc.101.1553625615665;
        Tue, 26 Mar 2019 11:40:15 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id s6sm26930308pfe.37.2019.03.26.11.40.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 11:40:14 -0700 (PDT)
Date:   Tue, 26 Mar 2019 14:40:13 -0400
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
Message-ID: <20190326184013.GA114492@google.com>
References: <20190323034619.15792-1-joel@joelfernandes.org>
 <20190325150133.GA4102@linux.ibm.com>
 <CAEXW_YRDfOEr-hdbKGDC6amRaaqTCCBsowRhVwDqJd-1BoO17g@mail.gmail.com>
 <20190325164253.GE4102@linux.ibm.com>
 <CAEXW_YT8dS--pBrQoBO=G_d+4Ffi7o2++PQukh6dyNHqX-TLBg@mail.gmail.com>
 <20190326160140.GP4102@linux.ibm.com>
 <20190326183549.GA162738@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190326183549.GA162738@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 02:35:49PM -0400, Joel Fernandes wrote:
> On Tue, Mar 26, 2019 at 09:01:40AM -0700, Paul E. McKenney wrote:
> > On Mon, Mar 25, 2019 at 06:40:17PM -0400, Joel Fernandes wrote:
> > > On Mon, Mar 25, 2019 at 12:42 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> > > >
> > > > On Mon, Mar 25, 2019 at 12:33:37PM -0400, Joel Fernandes wrote:
> > > > > On Mon, Mar 25, 2019 at 11:02 AM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> > > > > >
> > > > > > On Fri, Mar 22, 2019 at 11:46:19PM -0400, Joel Fernandes (Google) wrote:
> > > > > > > The rcutorture jitter.sh script selects a random CPU but does not check
> > > > > > > if it is offline or online. This leads to taskset errors many times. On
> > > > > > > my machine, hyper threading is disabled so half the cores are offline
> > > > > > > causing taskset errors a lot of times. Let us fix this by checking from
> > > > > > > only the online CPUs on the system.
> > > > > > >
> > > > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > >
> > > > > > Good catch!
> > > > > >
> > > > > > Please see below for one suggestion for simplification.
> > > > > >
> > > > > >                                                         Thanx, Paul
> > > > > >
> > > > > > > ---
> > > > > > >  tools/testing/selftests/rcutorture/bin/jitter.sh | 11 ++++++++++-
> > > > > > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/tools/testing/selftests/rcutorture/bin/jitter.sh b/tools/testing/selftests/rcutorture/bin/jitter.sh
> > > > > > > index 3633828375e3..53bf9d99b5cd 100755
> > > > > > > --- a/tools/testing/selftests/rcutorture/bin/jitter.sh
> > > > > > > +++ b/tools/testing/selftests/rcutorture/bin/jitter.sh
> > > > > > > @@ -47,10 +47,19 @@ do
> > > > > > >               exit 0;
> > > > > > >       fi
> > > > > > >
> > > > > > > -     # Set affinity to randomly selected CPU
> > > > > > > +     # Set affinity to randomly selected online CPU
> > > > > > >       cpus=`ls /sys/devices/system/cpu/*/online |
> > > > > >
> > > > > >         cpus=`grep 1 /sys/devices/system/cpu/*/online |
> > > > >
> > > > > Yes, this is better. Lets do it this way :)
> > > > >
> > > > > > >               sed -e 's,/[^/]*$,,' -e 's/^[^0-9]*//' |
> > > > > > >               grep -v '^0*$'`
> > > > > >
> > > > > > Of course, now I have no idea why I excluded CPU 0...  :-/
> > > > >
> > > > > Yes, I was wondering as well about that :-)
> > > >
> > > > Please feel free to try including CPU 0 and running the set of single-CPU
> > > > rcutorture scenarios.  ;-)
> > > 
> > > Will do and then will update the patch by adding the CPU back, if all
> > > is well. Thanks.
> > 
> > And rcutorture doesn't like the rcu_is_cpu_rrupt_from_idle() patch on
> > scenarios SRCU-P, TASKS01, and TREE05, which are the Tree RCU scenarios
> > that enable CONFIG_PROVE_RCU.  The compiler error is:
> > 
> > kernel/rcu/tree.c:391:2: error: implicit declaration of function ‘_this_cpu_read’ [-Werror=implicit-function-declaration]
> > 
> > My guess is that the initial underscore needs to go.  I will drop
> > these two patches in favor of an update from you.  ;-)
> 
> Sorry, I fixed that up and running tests now.
> 
> By the way, may be you decided to not run the jitter on CPU0 just because on
> some systems, CPU0 does not have an 'online' file? In this case, the grep may
> throw errors I guess which troubles the script.
> 
> From the old cpu hotplug docs, I found that if CONFIG_BOOTPARAM_HOTPLUG_CPU0
> or cpu0_hotplug boot command line option is not passed, then cpu0 cannot be
> offlined in which case, presumably the 'online' file will be missing, like
> some systems I am testing on.

Never mind, the "*" in your path search would take care of not erroring out :-)

The other reason you may have done it is for making the jitter be
consistent across systems that can offline CPU0, and the others that can't :-).
I am just guessing.

Any way, I will just add back CPU0 forcefully to the cpus list in my testing,
without checking for the online file existence, and see what happens :-) If
there's no smoke, then I'll roll that into a patch and send it out.

thanks.


