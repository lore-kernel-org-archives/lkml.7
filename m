Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3541BC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1100720856
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfKKQPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 11:15:08 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52245 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfKKQPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 11:15:07 -0500
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iUCLE-0006lT-FV; Mon, 11 Nov 2019 16:15:00 +0000
Date:   Mon, 11 Nov 2019 17:14:59 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Jann Horn <jannh@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v7 1/2] fork: extend clone3() to support setting a PID
Message-ID: <20191111161458.fjodxyx566dar6ob@wittgenstein>
References: <20191111131704.656169-1-areber@redhat.com>
 <20191111152514.GA11389@redhat.com>
 <20191111154028.GF514519@dcbz.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191111154028.GF514519@dcbz.redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 04:40:28PM +0100, Adrian Reber wrote:
> On Mon, Nov 11, 2019 at 04:25:15PM +0100, Oleg Nesterov wrote:
> > On 11/11, Adrian Reber wrote:
> > >
> > > v7:
> > >  - changed set_tid to be an array to set the PID of a process
> > >    in multiple nested PID namespaces at the same time as discussed
> > >    at LPC 2019 (container MC)
> > 
> > cough... iirc you convinced me this is not needed when we discussed
> > the previous version ;) Nevermind, probably my memory fools me.
> 
> You are right. You suggested the same thing and we didn't listen ;)
> 
> > So far I only have some cosmetic nits,
> 
> Thanks for the quick review. I will try to apply your suggestions.
> 
> > > @@ -175,6 +187,18 @@ struct pid *alloc_pid(struct pid_namespace *ns)
> > >
> > >  	for (i = ns->level; i >= 0; i--) {
> > >  		int pid_min = 1;
> > > +		int t_pos = 0;
> >                     ^^^^^
> > 
> > I won't insist, but I'd suggest to cache set_tid[t_pos] instead to make
> > the code a bit more simple.
> > 
> > > @@ -186,12 +210,24 @@ struct pid *alloc_pid(struct pid_namespace *ns)
> > >  		if (idr_get_cursor(&tmp->idr) > RESERVED_PIDS)
> > >  			pid_min = RESERVED_PIDS;
> > 
> > You can probably move this code into the "else" branch below.
> > 
> > IOW, something like
> > 
> > 
> > 	for (i = ns->level; i >= 0; i--) {
> > 		int xxx = 0;
> > 
> > 		if (set_tid_size) {
> > 			int pos = ns->level - i;
> > 
> > 			xxx = set_tid[pos];
> > 			if (xxx < 1 || xxx >= pid_max)
> > 				return ERR_PTR(-EINVAL);
> > 			/* Also fail if a PID != 1 is requested and no PID 1 exists */
> > 			if (xxx != 1 && !tmp->child_reaper)
> > 				return ERR_PTR(-EINVAL);
> > 			if (!ns_capable(tmp->user_ns, CAP_SYS_ADMIN))
> > 				return ERR_PTR(-EPERM);
> > 			set_tid_size--;
> > 		}
> > 
> > 		idr_preload(GFP_KERNEL);
> > 		spin_lock_irq(&pidmap_lock);
> > 
> > 		if (xxx) {
> > 			nr = idr_alloc(&tmp->idr, NULL, xxx, xxx + 1,
> > 					GFP_ATOMIC);
> > 			/*
> > 			 * If ENOSPC is returned it means that the PID is
> > 			 * alreay in use. Return EEXIST in that case.
> > 			 */
> > 			if (nr == -ENOSPC)
> > 				nr = -EEXIST;
> > 		} else {
> > 			int pid_min = 1;
> > 			/*
> > 			 * init really needs pid 1, but after reaching the
> > 			 * maximum wrap back to RESERVED_PIDS
> > 			 */
> > 			if (idr_get_cursor(&tmp->idr) > RESERVED_PIDS)
> > 				pid_min = RESERVED_PIDS;
> > 			/*
> > 			 * Store a null pointer so find_pid_ns does not find
> > 			 * a partially initialized PID (see below).
> > 			 */
> > 			nr = idr_alloc_cyclic(&tmp->idr, NULL, pid_min,
> > 					      pid_max, GFP_ATOMIC);
> > 		}
> > 
> > 		...
> > 
> > This way only the "if (set_tid_size)" block has to play with set_tid_size/set_tid.
> > 
> > note also that this way we can easily allow set_tid[some_level] == 0, we can
> > simply do
> > 
> > 	-	if (xxx < 1 || xxx >= pid_max)
> > 	+	if (xxx < 0 || xxx >= pid_max)
> > 
> > although I don't think this is really useful.
> 
> Yes. I explicitly didn't allow 0 as a PID as I didn't thought it would
> be useful (or maybe even valid).

How do you express: I don't care about a specific pid in pidns level
<n>, just give me a random one? For example,

set_tid[0] = 1234
set_tid[1] = 5678
set_tid[2] = random_pid()
set_tid[3] = 9

Wouldn't that be potentially useful?

Christian
