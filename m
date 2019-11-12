Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30658C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F0F2196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfKLKZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 05:25:19 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:46585 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfKLKZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 05:25:19 -0500
Received: from p54ac5726.dip0.t-ipconnect.de ([84.172.87.38] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iUTM2-0003JS-FQ; Tue, 12 Nov 2019 10:24:58 +0000
Date:   Tue, 12 Nov 2019 11:24:56 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Adrian Reber <areber@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Jann Horn <jannh@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v7 1/2] fork: extend clone3() to support setting a PID
Message-ID: <20191112102455.7uzwtahdd5ssoelm@wittgenstein>
References: <20191111131704.656169-1-areber@redhat.com>
 <20191111152514.GA11389@redhat.com>
 <20191111154028.GF514519@dcbz.redhat.com>
 <20191111161458.fjodxyx566dar6ob@wittgenstein>
 <87ftiuau46.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ftiuau46.fsf@x220.int.ebiederm.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 05:08:57PM -0600, Eric W. Biederman wrote:
> Christian Brauner <christian.brauner@ubuntu.com> writes:
> 
> > On Mon, Nov 11, 2019 at 04:40:28PM +0100, Adrian Reber wrote:
> >> On Mon, Nov 11, 2019 at 04:25:15PM +0100, Oleg Nesterov wrote:
> >> > On 11/11, Adrian Reber wrote:
> >> > >
> >> > > v7:
> >> > >  - changed set_tid to be an array to set the PID of a process
> >> > >    in multiple nested PID namespaces at the same time as discussed
> >> > >    at LPC 2019 (container MC)
> >> > 
> >> > cough... iirc you convinced me this is not needed when we discussed
> >> > the previous version ;) Nevermind, probably my memory fools me.
> >> 
> >> You are right. You suggested the same thing and we didn't listen ;)
> >> 
> >> > So far I only have some cosmetic nits,
> >> 
> >> Thanks for the quick review. I will try to apply your suggestions.
> >> 
> >> > > @@ -175,6 +187,18 @@ struct pid *alloc_pid(struct pid_namespace *ns)
> >> > >
> >> > >  	for (i = ns->level; i >= 0; i--) {
> >> > >  		int pid_min = 1;
> >> > > +		int t_pos = 0;
> >> >                     ^^^^^
> >> > 
> >> > I won't insist, but I'd suggest to cache set_tid[t_pos] instead to make
> >> > the code a bit more simple.
> >> > 
> >> > > @@ -186,12 +210,24 @@ struct pid *alloc_pid(struct pid_namespace *ns)
> >> > >  		if (idr_get_cursor(&tmp->idr) > RESERVED_PIDS)
> >> > >  			pid_min = RESERVED_PIDS;
> >> > 
> >> > You can probably move this code into the "else" branch below.
> >> > 
> >> > IOW, something like
> >> > 
> >> > 
> >> > 	for (i = ns->level; i >= 0; i--) {
> >> > 		int xxx = 0;
> >> > 
> >> > 		if (set_tid_size) {
> >> > 			int pos = ns->level - i;
> >> > 
> >> > 			xxx = set_tid[pos];
> >> > 			if (xxx < 1 || xxx >= pid_max)
> >> > 				return ERR_PTR(-EINVAL);
> >> > 			/* Also fail if a PID != 1 is requested and no PID 1 exists */
> >> > 			if (xxx != 1 && !tmp->child_reaper)
> >> > 				return ERR_PTR(-EINVAL);
> >> > 			if (!ns_capable(tmp->user_ns, CAP_SYS_ADMIN))
> >> > 				return ERR_PTR(-EPERM);
> >> > 			set_tid_size--;
> >> > 		}
> >> > 
> >> > 		idr_preload(GFP_KERNEL);
> >> > 		spin_lock_irq(&pidmap_lock);
> >> > 
> >> > 		if (xxx) {
> >> > 			nr = idr_alloc(&tmp->idr, NULL, xxx, xxx + 1,
> >> > 					GFP_ATOMIC);
> >> > 			/*
> >> > 			 * If ENOSPC is returned it means that the PID is
> >> > 			 * alreay in use. Return EEXIST in that case.
> >> > 			 */
> >> > 			if (nr == -ENOSPC)
> >> > 				nr = -EEXIST;
> >> > 		} else {
> >> > 			int pid_min = 1;
> >> > 			/*
> >> > 			 * init really needs pid 1, but after reaching the
> >> > 			 * maximum wrap back to RESERVED_PIDS
> >> > 			 */
> >> > 			if (idr_get_cursor(&tmp->idr) > RESERVED_PIDS)
> >> > 				pid_min = RESERVED_PIDS;
> >> > 			/*
> >> > 			 * Store a null pointer so find_pid_ns does not find
> >> > 			 * a partially initialized PID (see below).
> >> > 			 */
> >> > 			nr = idr_alloc_cyclic(&tmp->idr, NULL, pid_min,
> >> > 					      pid_max, GFP_ATOMIC);
> >> > 		}
> >> > 
> >> > 		...
> >> > 
> >> > This way only the "if (set_tid_size)" block has to play with set_tid_size/set_tid.
> >> > 
> >> > note also that this way we can easily allow set_tid[some_level] == 0, we can
> >> > simply do
> >> > 
> >> > 	-	if (xxx < 1 || xxx >= pid_max)
> >> > 	+	if (xxx < 0 || xxx >= pid_max)
> >> > 
> >> > although I don't think this is really useful.
> >> 
> >> Yes. I explicitly didn't allow 0 as a PID as I didn't thought it would
> >> be useful (or maybe even valid).
> 
> I agree not allowing 0 sounds very reasonable.

Yeah, I think we are all in agreement here.

> 
> > How do you express: I don't care about a specific pid in pidns level
> > <n>, just give me a random one? For example,
> >
> > set_tid[0] = 1234
> > set_tid[1] = 5678
> > set_tid[2] = random_pid()
> > set_tid[3] = 9
> >
> > Wouldn't that be potentially useful?
> 
> I can't imagine how.
> 
> At least in my head the fundamental concept is picking up a container on
> one machine and moving it to another machine.  For that operation you
> will know starting with the most nested pid namespace the pids that you
> want up to some point.  Farther up you don't know.
> 
> I can't imagine in what scenario you would not know a pid at outer level
> but want a specified pid at an ever farther removed outer level.  What
> scenario are you thinking about that could lead to such a situation?
> 
> For the me the question is: Are you restoring what you know or not?

I didn't advocate for making this possible (though I can see how this
would be a neat hacking tool).
Though this whole paragraph highlights one of my concerns with this
whole feature. As it stands it is _only_ useful to CRIU. Which as I said
before is fine but it still makes me queasy when an interface really
just is designed to serve a single use-case; this specific feature even
just a single user.
I'm hopeful that we can find other use-cases for testing. It's probably
already a fun feature for making pid-reuse based kernel exploits way
easier.

Christian
