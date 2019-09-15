Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94176C4CECC
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 18:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575A7214D9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 18:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568573245;
	bh=UOG1cXUpe6DtY0d3ne7xc3aPlj58oh6YiH4haf3Dt18=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=mE4/9fuPiDWeV2Ys61zfvrRXbQd3/jzbHNOYtlSStzPWwF76Djzht9x8LZTHienew
	 1BEIp6ZLTSpANSWiaJBEToYRVu7Y987pq81MG7JOKeZC24XYSb8wtrWg9uc/8h243k
	 FCEyjeSFHh+h5JSKI12Mcg3Yat1hmuWbftA/m7sk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfIOSrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 14:47:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbfIOSrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 14:47:24 -0400
Received: from paulmck-ThinkPad-P72 (96-84-246-146-static.hfc.comcastbusiness.net [96.84.246.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64F5520830;
        Sun, 15 Sep 2019 18:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568573243;
        bh=UOG1cXUpe6DtY0d3ne7xc3aPlj58oh6YiH4haf3Dt18=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dUlUS2DjkDs1hKayspSm5nwRsuIT83cALpgsTPEwXvq4rk3vaNy/jwu8Q9p3WUOaU
         Nmt06KXwUghUpQvmkkJTHJ1yJr1uIDOn4ejtJXx8PWjfoGUeiMKGGbFZ12+/Ctw0QD
         FJY6g4/Ax2fnJpFPi/Wmd8noEzygFm2yhSipxqa0=
Date:   Sun, 15 Sep 2019 11:47:17 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v2 3/4] task: With a grace period after
 finish_task_switch, remove unnecessary code
Message-ID: <20190915184717.GP30224@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
 <87o906wimo.fsf@x220.int.ebiederm.org>
 <20190902134003.GA14770@redhat.com>
 <87tv9uiq9r.fsf@x220.int.ebiederm.org>
 <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
 <87k1aqt23r.fsf_-_@x220.int.ebiederm.org>
 <87muf7f4bf.fsf_-_@x220.int.ebiederm.org>
 <87lfurdpk9.fsf_-_@x220.int.ebiederm.org>
 <20190915143212.GK30224@paulmck-ThinkPad-P72>
 <CAHk-=wjT6LG6sDaZtfeT80B9RaMP-y7RNRM4F5CX2v2Z=o8e=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjT6LG6sDaZtfeT80B9RaMP-y7RNRM4F5CX2v2Z=o8e=A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2019 at 10:07:24AM -0700, Linus Torvalds wrote:
> On Sun, Sep 15, 2019 at 7:32 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > First, what am I looking for?
> >
> > I am looking for something that prevents the following:
> >
> > o       Task A acquires a reference to Task B's task_struct while
> >         protected only by RCU, and is just about to increment ->rcu_users
> >         when it is delayed.  Maybe its vCPU is preempted or something.
> 
> Where exactly do you see "increment ->rcu_users"
> 
> There are _no_ users that can increment rcu_users. The thing is
> initialized to '2' when the process is created, and nobody ever
> increments it. EVER.
> 
> It's only ever decremented, and when it hits zero we know that both
> users are gone, and we start the rcu-delayed free.

Color me blind and apologies for the noise!

							Thanx, Paul
