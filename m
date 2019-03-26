Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFB1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD46206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="wY3eNHEG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732578AbfCZSfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:35:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38281 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731904AbfCZSfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:35:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id 10so8476343pfo.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kmpk9W0ZCaK/ebb8oPI/qWfBv7rAFiSmONukNUeMwJ0=;
        b=wY3eNHEG/yRmhlsTC6JAnMckrKhYRp2WoomN8dtsf65WeexdV5Ti/q01rQ9mVxbmS6
         n9oMFK3J9wfx7BazdIJnGnoDUlsiIg5bUQHrbSC1sh6xBySDlyOTLGjMIYecBnQBCeTq
         iqcLXW4G5xVIKRxY/KKA8SrVF7DNg2bWgKxh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kmpk9W0ZCaK/ebb8oPI/qWfBv7rAFiSmONukNUeMwJ0=;
        b=tgwtPkL0lhRY+nmPKNph/cjqCJxf5VMxnz6kuXXo9JNpx8XOBuspJb1S1JM2uBWvA5
         5QEgbR+rD1v1Td2Dg0qoQAp5PStbIol3lHWdWLasxwnQ38Qfu9qxGWVPtZ8V0PE0TzHS
         15FM+2lZxXuIopxNsQjHp1uxg2cRs6Php/cdoIzMxflXFHQSn3gVKi3pMPizkW/idjzA
         MSy2bnpXLqlTNPLH1TspS4r9SMnCSQFT47xrQ1HobPZOTeeGfSBKzc9aMctQVZAa12sW
         4gFKT5h0dy9uxK7KfCZHij1iyNRFBTfXrxUe5Bf8x/rCfMRnP/X2cnMCezM92vlqw1OP
         R9hg==
X-Gm-Message-State: APjAAAWZ942tmP+XUSeHVy0fXEH9JMFn4MPOrrSiO5spYXNvmDYuWGGk
        lCmOIvYEfQoyxph94b0Hd1eHAg==
X-Google-Smtp-Source: APXvYqynlqIrW0pnZ449NTyaH8b6pNfmPMqE1byGkyFXSnRoB3CRiSe+m2HBrDcuZwIYXmn5JaD7mw==
X-Received: by 2002:a62:ab14:: with SMTP id p20mr32045961pff.23.1553625351898;
        Tue, 26 Mar 2019 11:35:51 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id s6sm26921416pfe.37.2019.03.26.11.35.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 11:35:50 -0700 (PDT)
Date:   Tue, 26 Mar 2019 14:35:49 -0400
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
Message-ID: <20190326183549.GA162738@google.com>
References: <20190323034619.15792-1-joel@joelfernandes.org>
 <20190325150133.GA4102@linux.ibm.com>
 <CAEXW_YRDfOEr-hdbKGDC6amRaaqTCCBsowRhVwDqJd-1BoO17g@mail.gmail.com>
 <20190325164253.GE4102@linux.ibm.com>
 <CAEXW_YT8dS--pBrQoBO=G_d+4Ffi7o2++PQukh6dyNHqX-TLBg@mail.gmail.com>
 <20190326160140.GP4102@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190326160140.GP4102@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 09:01:40AM -0700, Paul E. McKenney wrote:
> On Mon, Mar 25, 2019 at 06:40:17PM -0400, Joel Fernandes wrote:
> > On Mon, Mar 25, 2019 at 12:42 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> > >
> > > On Mon, Mar 25, 2019 at 12:33:37PM -0400, Joel Fernandes wrote:
> > > > On Mon, Mar 25, 2019 at 11:02 AM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> > > > >
> > > > > On Fri, Mar 22, 2019 at 11:46:19PM -0400, Joel Fernandes (Google) wrote:
> > > > > > The rcutorture jitter.sh script selects a random CPU but does not check
> > > > > > if it is offline or online. This leads to taskset errors many times. On
> > > > > > my machine, hyper threading is disabled so half the cores are offline
> > > > > > causing taskset errors a lot of times. Let us fix this by checking from
> > > > > > only the online CPUs on the system.
> > > > > >
> > > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > >
> > > > > Good catch!
> > > > >
> > > > > Please see below for one suggestion for simplification.
> > > > >
> > > > >                                                         Thanx, Paul
> > > > >
> > > > > > ---
> > > > > >  tools/testing/selftests/rcutorture/bin/jitter.sh | 11 ++++++++++-
> > > > > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/tools/testing/selftests/rcutorture/bin/jitter.sh b/tools/testing/selftests/rcutorture/bin/jitter.sh
> > > > > > index 3633828375e3..53bf9d99b5cd 100755
> > > > > > --- a/tools/testing/selftests/rcutorture/bin/jitter.sh
> > > > > > +++ b/tools/testing/selftests/rcutorture/bin/jitter.sh
> > > > > > @@ -47,10 +47,19 @@ do
> > > > > >               exit 0;
> > > > > >       fi
> > > > > >
> > > > > > -     # Set affinity to randomly selected CPU
> > > > > > +     # Set affinity to randomly selected online CPU
> > > > > >       cpus=`ls /sys/devices/system/cpu/*/online |
> > > > >
> > > > >         cpus=`grep 1 /sys/devices/system/cpu/*/online |
> > > >
> > > > Yes, this is better. Lets do it this way :)
> > > >
> > > > > >               sed -e 's,/[^/]*$,,' -e 's/^[^0-9]*//' |
> > > > > >               grep -v '^0*$'`
> > > > >
> > > > > Of course, now I have no idea why I excluded CPU 0...  :-/
> > > >
> > > > Yes, I was wondering as well about that :-)
> > >
> > > Please feel free to try including CPU 0 and running the set of single-CPU
> > > rcutorture scenarios.  ;-)
> > 
> > Will do and then will update the patch by adding the CPU back, if all
> > is well. Thanks.
> 
> And rcutorture doesn't like the rcu_is_cpu_rrupt_from_idle() patch on
> scenarios SRCU-P, TASKS01, and TREE05, which are the Tree RCU scenarios
> that enable CONFIG_PROVE_RCU.  The compiler error is:
> 
> kernel/rcu/tree.c:391:2: error: implicit declaration of function ‘_this_cpu_read’ [-Werror=implicit-function-declaration]
> 
> My guess is that the initial underscore needs to go.  I will drop
> these two patches in favor of an update from you.  ;-)

Sorry, I fixed that up and running tests now.

By the way, may be you decided to not run the jitter on CPU0 just because on
some systems, CPU0 does not have an 'online' file? In this case, the grep may
throw errors I guess which troubles the script.

From the old cpu hotplug docs, I found that if CONFIG_BOOTPARAM_HOTPLUG_CPU0
or cpu0_hotplug boot command line option is not passed, then cpu0 cannot be
offlined in which case, presumably the 'online' file will be missing, like
some systems I am testing on.

thanks,

 - Joel

