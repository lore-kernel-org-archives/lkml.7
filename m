Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017AAC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D974D2073B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfKOJ7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 04:59:12 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41416 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbfKOJ7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 04:59:11 -0500
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iVYNU-0003Ej-4T; Fri, 15 Nov 2019 09:58:56 +0000
Date:   Fri, 15 Nov 2019 10:58:55 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrei Vagin <avagin@gmail.com>, Adrian Reber <areber@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Jann Horn <jannh@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v10 1/2] fork: extend clone3() to support setting a PID
Message-ID: <20191115095854.4vr6bgfz6ny5zbpd@wittgenstein>
References: <20191114142707.1608679-1-areber@redhat.com>
 <20191114191538.GC171963@gmail.com>
 <20191115093419.GA25528@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191115093419.GA25528@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 10:34:20AM +0100, Oleg Nesterov wrote:
> On 11/14, Andrei Vagin wrote:
> >
> > On Thu, Nov 14, 2019 at 03:27:06PM +0100, Adrian Reber wrote:
> > ...
> > > diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> > > index 1d500ed03c63..2e649cfa07f4 100644
> > > --- a/include/uapi/linux/sched.h
> > > +++ b/include/uapi/linux/sched.h
> > ...
> > > @@ -174,24 +186,51 @@ struct pid *alloc_pid(struct pid_namespace *ns)
> > >  	pid->level = ns->level;
> > >
> > >  	for (i = ns->level; i >= 0; i--) {
> > > -		int pid_min = 1;
> > > +		int tid = 0;
> > > +
> > > +		if (set_tid_size) {
> > > +			tid = set_tid[ns->level - i];
> > > +			if (tid < 1 || tid >= pid_max)
> > > +				return ERR_PTR(-EINVAL);
> >
> > do we need to release pids what have been allocated on previous levels?
> 
> Heh ;) it is really amazing that nobody noticed this! Thanks Andrei.
> 
> > nr = -EINVAL;
> 
> retval = -EINVAL;
> 
> > goto out_free;

How do we feel about moving this into a separate helper like below?
Keeps the ugliness out of alloc_pid() itself.

Christian

diff --git a/kernel/pid.c b/kernel/pid.c
index eb32668997c6..d3dfd1bbebaf 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -157,6 +157,31 @@ void free_pid(struct pid *pid)
 	call_rcu(&pid->rcu, delayed_put_pid);
 }
 
+static int set_tid_next(pid_t *set_tid, size_t *size, int idx)
+{
+	int tid = 0;
+
+	if (*size) {
+		tid = set_tid[idx];
+		if (tid < 1 || tid >= pid_max)
+			return -EINVAL;
+
+		/*
+		 * Also fail if a PID != 1 is requested and
+		 * no PID 1 exists.
+		 */
+		if (tid != 1 && !tmp->child_reaper)
+			return -EINVAL;
+
+		if (!ns_capable(tmp->user_ns, CAP_SYS_ADMIN))
+			return -EPERM;
+
+		(*size)--;
+	}
+
+	return tid;
+}
+
 struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 		      size_t set_tid_size)
 {
@@ -188,20 +213,10 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 	for (i = ns->level; i >= 0; i--) {
 		int tid = 0;
 
-		if (set_tid_size) {
-			tid = set_tid[ns->level - i];
-			if (tid < 1 || tid >= pid_max)
-				return ERR_PTR(-EINVAL);
-			/*
-			 * Also fail if a PID != 1 is requested and
-			 * no PID 1 exists.
-			 */
-			if (tid != 1 && !tmp->child_reaper)
-				return ERR_PTR(-EINVAL);
-			if (!ns_capable(tmp->user_ns, CAP_SYS_ADMIN))
-				return ERR_PTR(-EPERM);
-			set_tid_size--;
-		}
+		retval = set_tid_next(set_tid, &set_tid_size, ns->level - i);
+		if (retval < 0)
+			goto out_free;
+		tid = retval;
 
 		idr_preload(GFP_KERNEL);
 		spin_lock_irq(&pidmap_lock);
